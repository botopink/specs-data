---
milestone: 1.0.12-beta
---
# Front 169 — gate green: the whole gate passes again after the freeze's scoped landings

Opened by the maintainer, 2026-10-27: "depois vamos fazer uma frente só para deixar o gate verde". Taken after the freeze of 987 closes; free until then.

## Why

Decision 1041 lets every thread land on the tests and cells its change reaches, with `--no-verify`, and leaves the whole suite to `feat`'s pipeline. Reds the scoped runs did not reach can collect on `feat`. This front brings the whole gate back to green on every target.

## Steps

1. **Inventory**: run the whole gate once, on an empty pool, over `feat`: botopink-lang's `scripts/gate.sh` with conformance on machine 2, each library's gate, `scripts/gate.sh check`, and `feat`'s latest pipeline run. List every red with its repository, stage, cell or test, and target.
2. **Classify** each red: a defect, which gets a 144 / 164 row and its cell, red until fixed; a stale expected answer, re-recorded only where a decision states the answer; or a known red with a decision of its own (1002 (c)).
3. **Fix** the reds by area, one thread per area, each proving its reds green.
4. **Close**: the whole gate green twice in a row on `feat`, and its pipeline run green.


## Known reds

- `modules/compiler-cli/tests/analysis_equivalence.sh`: rakun-bpp and rakun-style modules fail to check (`await-component`, `import-of-failed-module`); from the library sources, not from the compiler commits that met it (m2-0114).
- 1050 (4), "a bare `botopink check` passes": blog, scaffold and rakun-ssr fail on rakun-style / rakun-bpp checker errors (`await-component`, `await-without-async`, unknown `Navigation`) — front 165's migration, after 144; green when `analysis_equivalence.sh` is (1052 (4)).
- feat's pipeline: every `test` run since the scoped landings of 1041 is red (`test`, `test-cli`, `test-web`, `tsc-check`, test-conformance on all four targets); left red until this front by decision 1053. Step 1's inventory starts from feat's latest run; the gains are measured only once it is green.


- **Now actionable (the maintainer, 2026-11-02):** B-162 P1 has landed and 969's `all<T>` is built (827/884's lowering), so the `analysis_equivalence.sh` red above is rakun's own source behind B-162 — no compiler change left. Every one of its 21 failures is commonJS / erlang / beam (wasm is not reached). A `--repo rakun` task, sonnet, assigned to machine-1 as a second thread:
  - [ ] rakun-bpp's `hooks`, `server`, `render`, `streaming` and `client_app` ported off std's removed `RenderScope`
  - [ ] rakun-style's `styled.bp` and `layers.bp` written over `use all` / spliced components (they predate `all<T>`), and their two stale `// LANGUAGE GAP` markers and `language-gaps.md` rows dropped
  - [ ] `analysis_equivalence.sh` green, `test-cli` green on `feat`'s pipeline (read with `gh`) — the standing red that hid front 228 for a week
- `modules/compiler-cli/tests/analysis_equivalence.sh`'s `scopes` and `provides` rakun example projects: `#[provides]` and `#[repository]` are `annotation-not-a-decorator` on erlang and beam (19-module list: `rakun/decorators`, `rakun/config`, `rakun/request_context`, `rakun/request_memo`, `rakun/lifecycle`, `rakun/context`, `rakun/conditions`, `rakun/autoconfig`, `rakun/condition_report`, `rakun/ssl_bundle`, `rakun/actuator_api/registration`, `rakun/logging/{correlation,logging,digest,setup,endpoints}`, `rakun/rakun`, `rakun/testing/mod`, `main`) — unrelated to the RenderScope/`all<T>` red above; part of the standing 21-failure count (confirmed present in feat's own CI log before front 229 s1 landed, not a new regression). Not fixed as part of 229 s1 or the rakun RenderScope port; fix only if it turns out to share a root cause with B-212 (decision 809 (8)'s scope defect).


- `scripts/check-docs.sh` (`zig build test-docs`): `conformance/docs.md:3178` names `component_is_lambda_over_render_scope-388/cells/render_scope_construction` — the retired `cells/` shape; 388's directory is now `cases/`. A stale reference, haiku-sized: point it at the case that now holds the example (machine-1 found it, 2026-11-02).
