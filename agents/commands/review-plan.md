---
description: Review a plan critically with the plan-reviewer agent before implementation begins
argument-hint: "[plan path, or nothing to review the current plan]"
---

Review a plan before any implementation starts.

**Target:** $ARGUMENTS

If no target was given, review the plan for the work in this conversation — the plan you or the user
most recently drafted here, or the most relevant file in `~/.claude/plans/`. If several plans could be
meant, name the candidates and ask which rather than guessing.

Delegate to the `plan-reviewer` agent via the Agent tool (`subagent_type: "plan-reviewer"`,
`model: "opus"` for a substantial plan, otherwise its own default). `plan-reviewer` cannot search the
filesystem — it has `Read` but no `Grep`/`Glob`/`Bash` — so give it:

- the plan itself, or an absolute path it can read
- the absolute paths of the files the plan touches, so it can check claims rather than take them on trust
- the repo and the constraints that matter (toolchain, platform version, known-broken tests)
- what has already been decided and is not up for review

Ask it for: critical issues first, then gaps and risks, then a revised plan. Tell it to challenge the
plan's factual premises — file paths, line references, API claims, test counts — not just its structure,
and to say which claims it could not verify.

When it reports back, relay the findings and your own judgement on each. Do not silently accept a
finding you think is wrong: say so and why. Then ask whether to fold the accepted findings into the
plan before proceeding.
