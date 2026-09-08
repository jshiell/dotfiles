---
description: Root-cause a failure with the diagnostician agent — diagnosis only, no fix
argument-hint: "<the failure: test name, command, error, or symptom>"
---

Root-cause a failure. Diagnosis only — no fix is applied by this command.

**Failure:** $ARGUMENTS

Delegate to the `diagnostician` agent via the Agent tool (`subagent_type: "diagnostician"`). It is
read-only and stops at a proven cause.

Give it everything you already have: the exact command, the exact output, when it started failing, what
has already been ruled out, and whether it is deterministic or intermittent. Anything you withhold, it
will spend a turn rediscovering.

Require of it:

- reproduce first; if it cannot reproduce, report that rather than theorise
- suspect the environment — sandbox, permissions, toolchain, test harness — before the code
- every claim carries evidence (`file:line`, command output) or the word "unverified"

When it reports back, relay the cause and its confidence. Then, and only then, decide the fix: dispatch
to `implementation` if ordinary, or `implementation-complex` if it turns on concurrency, lifetime,
numeric/temporal edge cases, or security. If the cause is environmental, there may be no code fix at
all — say so instead of inventing one.

Do not fix anything before the diagnosis lands.
