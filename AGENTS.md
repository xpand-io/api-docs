# Xpand API docs

## Summary

The TypeSpec definition of the public Xpand API. `main.tsp` declares the
service and every operation; the OpenAPI 3.1 emitter compiles it to
`docs/openapi.yaml`, which GitHub Pages serves through `docs/index.html`
(Stoplight Elements) at https://xpand-io.github.io/api-docs/.

This repo documents the API, it does not implement it. There is no server, no
application code, and no test suite. `pnpm compile` succeeding is the only
check. Longer prose about the API lives in the wiki:
https://github.com/xpand-io/api-docs/wiki

## Build & Run Commands

- **Install:** `pnpm install` (Node version pinned in `.tool-versions`)
- **Compile:** `pnpm compile` (`tsp compile main.tsp`, writes `docs/openapi.yaml`)
- **Preview:** `pnpm preview` (serves `docs/` at http://localhost:8080)
- **Both, watching:** `overmind s` (the Procfile pairs `compile --watch` with the server)

`pnpm format` runs `tsp format main.tsp`, so it touches that one file and
nothing else. To format the whole tree:

    pnpm exec tsp format "**/*.tsp" -x "node_modules/**"

Add `--check` to verify without writing. Some files under `models/` are not
currently formatted, so reformat only what you edited rather than sweeping the
tree in an unrelated commit.

## docs/openapi.yaml is generated

It is emitted output, committed only so Pages can serve it. Never hand-edit it.
Change the `.tsp` source, run `pnpm compile`, and commit the regenerated YAML in
the same commit as the source change.

## Project Structure

- `main.tsp`: service metadata, `BearerAuth`, and every `op`, grouped into route namespaces under `API`
- `models/`: the `Models` namespace, one resource shape per file
- `requests/`: the `Requests` namespace, request body shapes
- `responses/`: the `Responses` namespace, mostly spreads of a model
- `scalars.tsp`, `enums.tsp`, `errors.tsp`: shared scalars, the `Enums` namespace, the `Errors` namespace
- `tspconfig.yaml`: emitter config (openapi3, output to `docs/`)
- `docs/`: generated `openapi.yaml` plus the hand-written `index.html` viewer

Each directory has a barrel that imports its files: `models/main.tsp`,
`requests/main.tsp`, `responses/main.tsp`, and an `index.tsp` in `models/task/`
and `models/task_submission/`. A new `.tsp` file is invisible to the compiler
until it is imported there.

## TypeSpec Conventions

- **File names:** `snake_case.tsp`, one model per file, named after the model it holds
- **Naming:** `PascalCase` models, enums and scalars; `snake_case` properties and enum members, matching the JSON the API actually emits
- **Enums:** members spell out their own value, `published: "published"`
- **Cross-namespace references:** always qualified, `Models.Document[]`, `Requests.UserUpsert`
- **Reuse before redefining:** a response is usually `...Models.X`; a new task type extends the shared base rather than restating its fields
- **Scalars:** use `UUID`, `Email`, `Phone`, `Date`, `DateTime`, `Base64` from `scalars.tsp` instead of bare `string`. They carry the `@format` and `@example` that the rendered docs show
- **Every op:** `@summary` (a few words, title case) and `@doc` (a sentence). Every query parameter gets its own `@doc`
- **Examples:** add `@example` wherever the expected value is not obvious from the property name, following the models already there
- **Routes:** versioned per namespace, `@route("/v1/users")`, `@route("/v2/journeys")`. Match the version a resource already uses; do not renumber one
- **Comments:** the `.tsp` sources hold no `//` comments beyond one commented-out decorator in `main.tsp`. Anything worth saying to a reader belongs in `@doc`, which reaches the published docs

## Commits

A change tied to a ticket leads with the Jira tag, `[XP-3122] Add tasks
endpoint to openapi.yaml`. Dependency bumps land as `Weekly dependency
upgrades`. This repo has no Rollbar items and no linters, so those tags and
scope prefixes never apply here.
