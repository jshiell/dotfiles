# Instructions

## Core principles
- Ask rather than assume; prefer the simplest passing solution. When a decision is ambiguous, offer 2–3 options with trade-offs and wait.
- Keep responses terse, direct, plain language. Explain behaviour, not code.
- Clean code: intention-revealing names, small focused functions, no duplication.

## TDD (source-code changes, projects with an existing test suite)
- Non-negotiable for feature/bugfix work. Exploratory/spike work is exempt but must be flagged as throwaway.
- Use the `tdd` skill: Red (smallest failing test) → Green (minimal code, no over-engineering) → Refactor (remove duplication, don't change behaviour).
- Never skip tests. Never modify passing tests to make new code compile.
- One test, one implementation, one commit per increment.

## Workflow
1. Clarify requirements before writing code.
2. Propose a plan and wait for approval before non-trivial changes (more than one file touched, or any new public API/behaviour).
3. Implement one increment at a time; commit after each green test.
4. Run the `verify` skill before declaring work done. No large diffs.

## Commits
- Atomic, meaningful, after every green test or discrete task delivering value.
- Short, direct messages (e.g. `Add user login endpoint`). No file lists.

## Source control/Git
- Only rebase, never merge or squash commits.
- Never push, even if instructed to.

## Subagents
- Choose the model for sub-agents explicitly; don't inherit the session model on spawn.
  - Haiku-class: mechanical, high-volume work — codebase search/exploration, document fetching, log processing, bulk file reads.
  - Sonnet-class: routine implementation.
  - Opus-class: hard design, subtle debugging, adversarial verification, final review.
- When in doubt between two tiers, take the cheaper one; escalate only if it fails.
- Delegate anything expected to produce large intermediate output, even if it could be done inline.
- Keep inline: small targeted edits, judgment-heavy work that depends on context, anything with commit authority.
