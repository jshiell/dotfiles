---
description: Examine a GitHub issue, assess feasibility, and prepare an implementation plan
argument-hint: "[github issue number]"
---

Prepare an implementation plan for a given GitHub issue.

**Target:** $ARGUMENTS

If no target was given, stop and ask the user to provide a GitHub issue number.

Fetch the issue from GitHub using the `gh` command line tool or the GitHub API. Diagnose the cause or causes of the issue and validate them if possible. Consider the feasibility of a resolution to the issue and prepare an implementation plan accordingly.
