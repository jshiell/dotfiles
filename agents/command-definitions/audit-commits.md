<!-- frontmatter:claude
---
description: Audit unpushed commits against an approved plan — done, partial, missing, unplanned
argument-hint: "[plan path] [commit range]"
---
-->
<!-- frontmatter:opencode
---
description: Audit unpushed commits against an approved plan — done, partial, missing, unplanned
---
-->

Audit the commits on this branch against the plan they were meant to implement.

**Arguments:** $ARGUMENTS

Delegate to the `commit-auditor` agent via the {{AGENT_TOOL}} tool (`subagent_type: "commit-auditor"`). It is
read-only — it reports, it does not repair, and it must leave the working tree unchanged.

Supply what you know:

<!--only:claude-->- the plan (an absolute path — `~/.claude/plans/…` or a repo document). If you do not know which plan,
  say so and let it resolve; do not guess, because auditing against the wrong plan produces confident
  nonsense.<!--/only--><!--only:opencode-->- the plan (an absolute path to a repo document, or wherever plans are kept in this project). If you do
  not know which plan, say so and let it resolve; do not guess, because auditing against the wrong plan
  produces confident nonsense.<!--/only-->
- the commit range, if it is not simply `@{upstream}..HEAD`
- any deviation already agreed during implementation, so it is not reported as unexplained

Require of it:

- classify every plan item: done / partial / missing / deviated, plus unplanned changes, each cited to
  a commit
- do **not** flag deliberately excluded items ("known limitations", "out of scope", conditional steps
  whose condition did not fire) as missing
- distinguish drift from justified deviation
- if the tree matches the plan, say so plainly — a clean report is a valid result

When it reports back, relay the verdict and the findings. Dispatch any fixes yourself to
`implementation` (or `implementation-complex`), one increment at a time, test-first. The auditor does
not fix its own findings, and re-running it afterwards is the check that the fix landed.
