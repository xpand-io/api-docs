---
name: gcm
description: Draft a git commit message and print it for copying. Never commits.
argument-hint: "[ticket]"
disable-model-invocation: true
---

Invoke the `better-commit-messages` skill and follow it for the message
itself. An argument is the tag for the subject line: `/gcm XP-1234`,
`/gcm Rollbar#20902`.

Drafting only. Never stage, commit, or push, however final the message looks,
and do not offer a commit command afterwards.

Print the message in one fenced code block, and nothing else of substance.
