---
name: implement-plan
description: Execute an existing plan-<n>.md as TDD increments and audit the commits
---
1. Find the plan file: `ls plan-*.md` — pick the one matching the issue argument. If none, STOP and ask.
2. Do NOT enter plan mode and do NOT call ExitPlanMode. The plan is already approved.
3. For each increment: write failing test -> implement -> run full build -> commit (one increment per commit).
4. After `git add`, run `git status` to confirm staging before committing.
5. Rerun any async/listener test 10x to prove determinism.
6. Finish by invoking the commit-auditor agent against the plan and report drift.
