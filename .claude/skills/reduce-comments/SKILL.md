---
name: reduce-comments
description: "Minimal code comments: why, never what. Apply when writing or editing code."
disable-model-invocation: true
user-invocable: false
---

# Reduce comments

Default to none. Prefer renaming the variable, extracting a named function, or
naming the constant. A comment is the fallback when naming cannot carry it.

**Comment only for**: why this and not the obvious alternative; non-local
consequences ("callers rely on this staying sorted"); facts unreadable from the
code, such as an API quirk, a spec clause, a measured number, or a
version-specific workaround; a deliberate oddity a reader would flag as a
mistake; public API docs where the project already has them.

**Never**: restatements (`// increment i`); section banners; docstrings that
re-spell the signature; ownerless TODOs; commented-out code, delete it; a
comment repeating the name below it.

**Style**: one or two lines, above the code, present tense.

    Bad:  // Retry 3 times
    Good: // Concurrent batches trip the API's secondary rate limit.

When editing, delete stale or restating comments, but do not strip a
codebase's conventions or public API docs wholesale, and do not add comments to
code you merely touched. Project rules in AGENTS.md or CLAUDE.md win.
