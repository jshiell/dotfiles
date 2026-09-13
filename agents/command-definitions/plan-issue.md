<!-- frontmatter:claude
---
description: Examine a GitHub issue, assess feasibility, and prepare a reviewed implementation plan
argument-hint: "[github issue number]"
---
-->
<!-- frontmatter:opencode
---
description: Examine a GitHub issue, assess feasibility, and prepare a reviewed implementation plan
---
-->

Prepare an implementation plan for a given GitHub issue.

**Target:** $ARGUMENTS

If no target was given, stop and ask the user to provide a GitHub issue number.

1. Read the issue with `gh issue view $ARGUMENTS`.
2. Trace the relevant code; verify every API claim against real source or a decompiled jar. Run a spike if needed.
3. Write the plan to `plan-$ARGUMENTS.md` in the project root as numbered TDD increments, each ending with a green build.
<!--only:claude-->4. Launch the plan-reviewer subagent adversarially against plan.md. Fix every defect it finds.
5. ONLY THEN call ExitPlanMode with the revised plan.<!--/only--><!--only:opencode-->4. Delegate to the `plan-reviewer` agent via the task tool (`subagent_type: "plan-reviewer"`)
   adversarially against the plan. Fix every defect it finds.
5. ONLY THEN present the revised plan to the user and wait for approval before implementation begins.<!--/only-->
