---
milestone: 1.0.12-beta
---
# Front 165 — rakun-workspace: one `rakun` repository, a workspace of 17 plug-and-play packages — status

## L2 — the libraries' critical path

### 165 rakun-workspace

- [ ] 165 s5 — landed: `#[rakun.module]` over a component fn, `Service` / `Lifecycle` / `Module`, `use inject` / `use onStop`, `rakun.boot()` over a `ServiceScope`, `#[rakun.config]`, `boot_modules`; left: the two build errors (B-146's catalogue read) and discovery without imports (question 165-h) · B-146 · 165-h
- [ ] 165 s7 — moved to front 170 (conformance-complete) s12

## Done — landed on `feat`

### 165 rakun-workspace

- [x] 165 s9 — one conformance read by feature: cells by package and feature, each `docs.md` beside its code, code only linked, one root `conformance/botopink.json` (each cell declaring its package); `cell check` answers as before (126 of 132, the six `rakun-service` reds of `deps/rakun`)
- [x] 165 s1 — erika, dbcontext, emilia, styled, jhonstart and onze joined into rakun by `git subtree add` (history kept), lifted to `modules/<name>` with names unchanged, cells in `conformance/<package>/`, examples and refusals per package; rakun's gate green but the reds already on `feat` (150 s27, 144 B-89); `AGENTS.md` per package
- [x] 165 s2 — every package renamed per the table by codemod (rakun-style, rakun-bpp with html/link/forms/testing, rakun-stylesheet with testing/bridge, rakun-service with actuator, rakun-ssr with cli/bundler/assets/content/og/release/testing, rakun-restclient; rakun-test → `rakun/src/testing/`), the starters removed, `rakun-ssr create` on the `botopink/rakun` source, `version_set.bp` one row per package (165-a (a)); erika and dbcontext untouched · question 165-b
- [x] 165 s3 — dbcontext's plan folded into `rakun-data` (its `AGENTS.md`, the entity / context / repository layer to come), `modules/dbcontext/` removed; `rakun-data` declares `query`
- [x] 165 s6 — erika renamed `query` (repository `botopink/query`, packages `query` and `query-test`); rakun holds no copy of it
- [x] 165 s8 — 148/149/153/154/162's open steps refiled under 150 (s32 … s71); the six former submodules removed, `repository/query` in, every pointer at its `feat`; § Layout, CI check 4 (12 library repositories), `gate.sh`, `decisions-split.py` and the marker index name the workspace; the five former GitHub repositories archived
