#!/usr/bin/env python3
"""Render a platform-agnostic agent or command definition (agents/agent-definitions/*.md,
agents/command-definitions/*.md) into one target platform's file (frontmatter + body).

No third-party dependencies: stdlib only.

Source file format:

    <!-- frontmatter:claude
    ---
    ...raw Claude frontmatter, verbatim...
    ---
    -->
    <!-- frontmatter:opencode
    ---
    ...raw OpenCode frontmatter, verbatim...
    ---
    -->

    Shared body text.

    <!--only:claude-->Text that appears only in the Claude output.<!--/only-->
    <!--only:opencode-->Text that appears only in the OpenCode output.<!--/only-->

    Body text can also use {{TOKEN}} placeholders for small per-target word
    swaps (e.g. tool-name casing) that recur across many definitions -- see
    VOCAB below. Larger or one-off differences should use <!--only:target-->
    blocks instead of growing VOCAB.

Codex agent definitions render to a whole-file TOML document rather than
frontmatter + markdown body. A `frontmatter:codex` block for an agent is raw
TOML scalar keys (no `---` fencing -- FRONTMATTER_RE only requires text
between the marker and the closing `-->`), and the rendered body is appended
as a `developer_instructions` TOML literal string. This only happens when
the destination file ends in `.toml`; a `--target codex` render to a `.md`
destination (commands) stays plain frontmatter + markdown, like the other
two targets.
"""
import argparse
import re

VOCAB = {
    "claude": {
        "BASH_TOOL": "Bash",
    },
    "opencode": {
        "BASH_TOOL": "bash",
    },
    "codex": {
        "BASH_TOOL": "shell",
    },
}

FRONTMATTER_RE = re.compile(r"<!--\s*frontmatter:(\w+)\s*\n(.*?)\n-->\n?", re.DOTALL)
ONLY_RE = re.compile(r"<!--\s*only:(\w+)\s*-->(.*?)<!--\s*/only\s*-->", re.DOTALL)
TOKEN_RE = re.compile(r"\{\{(\w+)\}\}")


def render(source: str, target: str, toml_body: bool = False) -> str:
    frontmatters = {}

    def collect(m: re.Match) -> str:
        frontmatters[m.group(1)] = m.group(2)
        return ""

    body = FRONTMATTER_RE.sub(collect, source)

    if target not in frontmatters:
        raise SystemExit(f"no frontmatter block for target {target!r}")

    def resolve_only(m: re.Match) -> str:
        return m.group(2) if m.group(1) == target else ""

    body = ONLY_RE.sub(resolve_only, body)

    vocab = VOCAB.get(target, {})

    def resolve_token(m: re.Match) -> str:
        name = m.group(1)
        if name not in vocab:
            raise SystemExit(f"unknown token {{{{{name}}}}} for target {target!r}")
        return vocab[name]

    body = TOKEN_RE.sub(resolve_token, body)
    body = body.strip("\n")

    frontmatter = frontmatters[target].strip("\n")

    if toml_body:
        if "'''" in body:
            raise SystemExit(
                "body contains a literal ''' sequence, which cannot be embedded in a TOML "
                "literal string -- rewrite the source body to avoid it"
            )
        return frontmatter + "\n" + "developer_instructions = '''\n" + body + "\n'''\n"

    return frontmatter + "\n\n" + body + "\n"


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--target", required=True, choices=sorted(VOCAB))
    parser.add_argument("source")
    parser.add_argument("dest")
    args = parser.parse_args()

    with open(args.source, encoding="utf-8") as f:
        source = f.read()

    rendered = render(source, args.target, toml_body=args.target == "codex" and args.dest.endswith(".toml"))

    with open(args.dest, "w", encoding="utf-8") as f:
        f.write(rendered)


if __name__ == "__main__":
    main()
