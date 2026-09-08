---
description: Establish whether a platform API is the right one to use, and how the platform itself does it
argument-hint: "<the API or the question>"
---

Answer a platform API question: is this the right API, and how does the platform itself do it?

**Question:** $ARGUMENTS

Delegate to the `platform-api-researcher` agent via the Agent tool
(`subagent_type: "platform-api-researcher"`). It is read-only and cites a source for every claim.

Give it: the platform and the version this project targets (or tell it to read that from the build), the
call site or the job to be done, and what has already been established so it does not re-derive it.

Require of it:

- classify the API — supported / public-but-internal / deprecated (with replacement and version) /
  works today by accident
- state the contract: nullability, threading, lifecycle, failure behaviour
- show what the platform's own code does in the same situation
- a URL or `file:line` for every claim; "unverified" rather than an assertion from memory
- name the version the answer holds for, wherever the answer is version-dependent

It delegates bulk doc fetching and decompiled-source reading to haiku sub-agents and keeps the
judgement itself; do not ask it to summarise sources for you, ask it for the verdict plus the evidence.

When it reports back, relay the answer, the contract, and anything it flagged unverified. An unverified
load-bearing claim is a reason to check before building on it, not a footnote.
