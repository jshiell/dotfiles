---
name: verify
description: Run the project's verification gate — tests, build, lint — before declaring work done. Use when finishing an increment or a task, when asked to verify/check/validate the work, or when another agent's instructions say to run the verify skill. Runs the gate the repo declares in AGENTS.md and separates new failures from a declared known-failure baseline.
---

# Verify

Run the project's verification gate and report honestly. Two rules govern everything below:

1. **Run the gate the repo declares.** Only sniff the toolchain when nothing is declared.
2. **Never report success on a step that did not run.** A skipped, errored, or unreachable step is not a pass.

## 1. Find the declaration

From the repo root, read in this order and stop at the first that declares a gate:

1. `AGENTS.md`
2. `CLAUDE.md` (project-level, not `~/.claude/CLAUDE.md`)
3. `CONTRIBUTING.md`

The declaration is prose as often as it is a list — these repos record their gate in sentences. Read
for intent, not for a schema: look for the commands to run, the order to run them in, and any
condition attached to a step ("only when X changes").

The canonical form, if a repo wants to be unambiguous, is a section like:

```markdown
## Verification gate

- `./gradlew test` — always
- `./gradlew xTest` — only when `src/csaccess/` changes
- `./gradlew build` — always

### Known failures (baseline)

- `CheckerFactoryCacheTest` — 8 failures. `DependencyValidationManager.getInstance` returns null
  outside a full platform; `ConfigurationLocation`'s constructor hits that path.
```

Honour both forms. If you read the gate out of prose, **say in your report which sentences you read
it from** (`AGENTS.md:64`), so a wrong reading is visible rather than silent.

### Conditional steps

A step gated on a path fires only when that path is in the diff. Determine the diff the same way you
would for review: `git diff --name-only @{upstream}..HEAD` plus `git status --porcelain` for uncommitted
work; fall back to the branch point when there is no upstream.

State the decision explicitly either way: *"`xTest` skipped — no changes under `src/csaccess/`"* is a
required line of the report, not an omission. A conditional step you silently dropped is
indistinguishable from one you forgot.

## 2. Fallback: sniff the toolchain

Only when no file declares a gate. Detect by marker file at the repo root, and say in the report that
you sniffed rather than read a declaration:

| Marker | Gate |
|---|---|
| `gradlew` / `build.gradle{,.kts}` | `./gradlew test`, then `./gradlew build` |
| `pyproject.toml` with `uv.lock` | `uv run pytest`, plus `uv run ruff check` / `uv run mypy` if configured |
| `composer.json` with `artisan` | `composer test` or `php artisan test`; lint via whatever `composer.json` scripts declare |
| `package.json` | the `test`, `lint`, and `typecheck`/`build` scripts that actually exist |
| `Makefile` | `make test` if the target exists, else `make` |
| shell scripts only | the repo's own check script if there is one; otherwise `shellcheck` on changed scripts |

Respect `mise` for runtime selection — if `.mise.toml` or `.tool-versions` is present, run through
`mise exec --` rather than assuming the ambient toolchain. Use `uv` for Python and `gradle` (via the
wrapper) for Java/Kotlin.

If sniffing finds nothing runnable, say so and stop. Do not invent a command.

## 3. Known-failure baseline

A repo may declare failures that are already broken for reasons outside the current change. Treat
them as a baseline, not as a pass:

- **Fail only on new failures.** Baseline failures do not fail the gate.
- **Always report the baseline hits — count and identity.** Never let a baseline entry silently
  absorb a regression. `CheckerFactoryCacheTest — 8 baseline failures, as declared` is the report
  line; "tests passed" is not.
- **A changed count is a finding.** 9 failures where 8 are declared means one new failure inside a
  baseline test. Name the extra test. Fewer than declared is also worth a line — the baseline may be
  stale, or a test may have stopped running.
- **A baseline entry only covers what it names.** A declared failure in `CheckerFactoryCacheTest`
  says nothing about a failure in any other test, even for the same underlying cause.
- **An undeclared failure is never baseline.** If a failure looks pre-existing but is not declared,
  report it as new, and say you suspect it is pre-existing. Confirm by stashing and re-running, or by
  running the gate at the branch point, if that is cheap. Never assume.

## 4. Report

Terse, and structured so a caller can act on it:

- **Result:** pass / fail / incomplete. `incomplete` when a step could not run — that is not a pass.
- **Steps:** each command, and for each: ran / skipped (with the reason) / errored.
- **New failures:** test name and the actual failure text. Not a paraphrase.
- **Baseline failures:** count and names, against what was declared.
- **Where the gate came from:** the file and line you read it from, or "sniffed — no declaration".

Report real output. If the build fails to compile, that is a fail with the compiler error, not a
"could not verify". If a step needs a permission or a resource you do not have — a sandbox denial, a
missing runtime — say exactly which, and mark the result `incomplete`. On a permission error, load
the `nono:nono-sandbox` skill before concluding the failure is real.

Do not fix anything. This skill establishes state; fixing is the caller's next decision.
