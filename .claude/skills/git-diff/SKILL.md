---
name: git-diff
description: Reading a git diff. What git diff will not tell you on its own.
disable-model-invocation: true
user-invocable: false
---

# Reading a git diff

**`git diff` never shows untracked files.** A file that was never `git add`ed
is invisible to every diff command, and a new file is often the whole point of
the branch. Take the `??` entries from `git status --porcelain` and read each
one as an added file.

**Read every diff in full.** Do not skim or skip files. Past roughly 50 files
or 3000 lines, read it in directory groups rather than one command, so nothing
truncates mid-file.

**Drop the noise, then say what you dropped.** Lockfiles, `node_modules/`, and
generated output bloat a diff without informing anything. Here the generated
file is `docs/openapi.yaml`, which `pnpm compile` emits from the `.tsp`
sources. Read the sources for the change itself, and look at the YAML only to
confirm it moved with them: a source change with no YAML diff means compile was
never run, and a YAML change with no source diff means someone hand-edited
emitted output. Exclude noise with pathspecs rather than hand-listing the files
you do want, and name what you excluded in one line: a silent omission reads as
full coverage.

    git diff <base>..HEAD --find-renames -- . \
      ':(exclude)pnpm-lock.yaml' ':(exclude)docs/openapi.yaml'

**Derive `<base>`** with `git merge-base HEAD origin/HEAD`, falling back to
`origin/master`, then `master`. When `git log <base>..HEAD --oneline` lists
commits that have nothing to do with the branch, the base is wrong: re-derive
it against the real fork point and name the base you used. On `master` diff the
working tree instead; on a detached HEAD, ask. Binary files need no flag, and
`--no-binary` does not exist.
