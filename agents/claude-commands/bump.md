---
description: Replicate a previous version-bump commit for a new version, using it as a template
argument-hint: "<version> [template commit]"
---

Add support for a new version by replicating a previous bump commit.

**Arguments:** $ARGUMENTS — the first is the target version; the second, if given, is the template commit.

If no template commit was supplied, find the most recent commit that did the same job:
`git log --oneline -20` and look for the previous version bump. State which commit you chose and why
before proceeding — the wrong template silently produces a wrong bump.

Then read the template in full — `git show <commit>` — and enumerate every file it touched and what it
did to each. That enumeration is the work list.

Delegate to the `implementation` agent via the Agent tool (`subagent_type: "implementation"`), passing
the target version, the template commit, and your enumeration.

## TDD position

A bump replicates a change that is already tested. There is no new behaviour to drive from a new failing
test, so the gate is **the existing suite plus the `verify` skill**, not a fresh red test. Two
consequences:

- If the template commit added or parameterised a test (a supported-versions list, a fixture per
  version), the bump extends that in the same way. That extension *is* the test, and it should fail
  before the change and pass after — check it.
- If the existing suite passes both before and after with nothing exercising the new version, say so.
  That is a coverage gap in the template, worth reporting rather than papering over.

## Stop and escalate rather than improvise

The template is authority only for what it covers. Stop and report back if the new version needs
anything off-template:

- an API that was renamed, removed, or changed signature
- a new incompatibility, deprecation, or behaviour change between the two versions
- a file the template touched that no longer exists, or a new file that clearly needs the same treatment
- a test that fails for a reason the template gives no guidance on

In those cases the work is a change, not a replication, and it goes back through planning. Do not
invent a fix to keep the bump moving.

## Finish

Run the `verify` skill. Report the diff against the template — every place the new bump diverges from
what the template did, with the reason. Then stop: no commit unless commit authority was granted, and
never push.
