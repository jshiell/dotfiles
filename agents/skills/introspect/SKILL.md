---
name: introspect
description: Review the current session for lessons learnt and route them — project-specific ones into the local AGENTS.md, cross-project ones as proposed edits to the global instructions, and behaviour changes as recommendations to the user. Use when the user asks what was learnt, wants the session's lessons captured, or invokes /introspect.
argument-hint: "Optional: an area to focus on (e.g. the test setup, the API work)"
disable-model-invocation: true
---

# Introspect

Review the session that just happened and capture what is worth keeping. Two rules govern everything
below:

1. **Every recommendation cites a moment in this session.** No generic best practice. If you cannot
   point at the turn where it cost something, it is not a lesson — it is filler.
2. **Route by scope, not by topic.** Where a lesson goes depends on where it would still be true, not
   on what it is about.

If the user passed arguments, treat them as an area to concentrate on. Still scan the whole session —
the focus narrows what you report, not what you read.

## 1. Gather the evidence

Walk the session from the start and mark the friction. Look for:

- **Rework.** Something built, then rebuilt — a wrong assumption about the code, a test that did not
  reflect what was asked, a change reverted.
- **Search cost.** Something that took several attempts to discover: a path, a build incantation, an
  API shape, a fixture, an environment quirk.
- **Corrections.** Explicit ones ("no, do X instead") and implicit ones — the user rephrasing, editing
  your output, or re-asking a question you answered badly.
- **Near misses.** A wrong step you caught before it landed, and *what* caught it. The catch is the
  lesson, not the near miss.
- **Dead ends.** A route that could not work, whose signpost is now known.
- **Failed or denied commands.** Especially ones that failed for an environmental reason rather than a
  code reason.

A session that went smoothly yields nothing. **"Nothing worth recording" is a valid result** — say it
plainly rather than manufacturing lessons to fill the report.

## 2. Route by scope

Three destinations. Apply the tests in order; first match wins.

| Destination | Test | Form |
|---|---|---|
| Local `AGENTS.md` | True *because of this repo* — its layout, build, fixtures, invariants, traps. Meaningless or false in another repo. | Edit, applied after approval |
| Global instructions (`~/.claude/CLAUDE.md`) | True of how to work *anywhere* — a habit, an ordering, a tool preference. Still useful in a repo never seen before. | Proposed wording, printed only |
| The user | The change is in *their* behaviour, not yours — guidance that arrived too late, an ambiguous request that cost a rerun, access or tooling worth setting up once. | Recommendation, printed only |

When a lesson could be project or global, ask: *would I have needed this in a different repo last
week?* If no, it is project-specific.

Never write to the global instructions file. Propose the wording and let the user decide — those rules
govern every project they have.

## 3. Filter

Drop a candidate if any of these hold:

- **Already recorded.** Re-read `AGENTS.md`, the project `CLAUDE.md`, and the memory directory before
  writing anything. If a rule already exists and was ignored anyway, the lesson is *not* "add the
  rule" — it is that the rule is unfindable or unclear. Recommend sharpening the existing wording, and
  say which line.
- **Derivable.** Anything the code, the tests, or `git log` already say. Instruction files are for what
  the repo does not tell you.
- **One-off.** True of this single bug or this one file, with no next time.
- **Costless.** Advice with no observed consequence in this session. Advice you cannot attach a cost to
  is advice you invented.

Then cap the result at roughly **five entries across all three destinations**. If more survive, keep
the ones that cost the most time. A long list of small notes is how instruction files stop being read.

## 4. AGENTS.md edits

- Put each entry in the section that already covers its topic. Add a new section only when none fits.
- Match the file's existing voice — imperative and terse.
- State the trap and the correct move. Not the story of how it was found, not who got it wrong.
- Prefer sharpening an existing line over appending a new one.

**Show the proposed edits as a diff and wait for approval before writing.** Do not commit unless asked.

## 5. Report

Terse, in this order. Omit any section that is empty rather than writing "none".

**AGENTS.md** — the proposed diff, and one line per entry saying which turn in the session it came
from.

**Global instructions** — exact wording to paste, and the `##` section of `~/.claude/CLAUDE.md` it
belongs under. Say what it would have prevented here.

**For you** — recommendations to the user. Each one: what happened, what to do differently, what it
would have saved. State these plainly and without flattery; they are only useful if they are honest.
Equally, do not invent user error to balance the report — if the friction was yours, say so and move
on.

**Considered and dropped** — one line each, only for candidates the user might expect to see. This is
a short list, not an audit trail.
