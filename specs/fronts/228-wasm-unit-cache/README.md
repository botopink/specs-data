---
milestone: 1.0.12-beta
owner: machine-1
---
# Front 228 — wasm unit-cache: a dependency's level-B (cached) build differs from its `--cold` build (decisions 509, 1008)

Opened by the maintainer, 2026-11-02, from decision 1090 (b162wasm-c) and the pending question `wasmcache-a`. `feat`'s
GitHub CI has been red on `test-cli`'s `level_b.sh` since 2026-10-27T21:58 — every "test" workflow run since, confirmed
both on CI and on a fresh local `origin/feat` build — unreported until machine-1 found it while bisecting front 170's
B-162 P1. **Not a regression of front 170**: reproduces on `feat` with none of that front's commits applied.

`modules/compiler-cli/tests/level_b.sh`'s crowded/shelf fixture: the `--cold` build inlines `shelf@tools`'s `pick`/
`total` as local functions in `crowded@main.wasm`; the level-B (cached) build instead imports them. This breaks
decision 509's "a dependency's output depends on its closure alone, never its consumer" — the choice comes from
wasm's per-module unit emission (`units_mode`, `isProgramUnit`, decision 1008 (2)/(3)) reacting to a dependency's
cache hit in a way that is not a pure function of the dependency's own closure key.

## Steps

### s1 — the fix: wasm's unit emission made a pure function of the dependency's own closure key

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** nothing open; max priority — `feat`'s gate has been red on this for about a week

- [ ] read wasm's unit emission path (`units_mode`, `isProgramUnit`, decision 1008 (2)/(3)) directly against 1008 (2)'s
      closure-key definition and find the consumer-dependent input (`wasmcache-a`'s option (b)); fall back to
      bisecting `feat`'s own history (option (a)) only if (b) does not locate it
- [ ] `modules/compiler-cli/tests/level_b.sh`'s crowded/shelf fixture green at both `--cold` and level-B (cached)
- [ ] the cheap test the hook would have caught this at (478) — red on the regressing commit if one bisects to it,
      or a new one if the defect predates any single commit in `feat`'s history
- [ ] `feat`'s GitHub CI green on `test-cli` again; the report says since when it had been red and why unreported
