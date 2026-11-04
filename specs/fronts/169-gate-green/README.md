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
  - [x] rakun-bpp's `hooks`, `server`, `render`, `streaming` and `client_app` ported off std's removed `RenderScope` onto `Scope` / `run`; `errorBoundaryNode` keeps the scope of its own place (809 (8), 1103). Measured against rakun before the port, with the same gate and compiler: no pair added, and 79 test pairs plus 45 example-build pairs green that were red
  - [x] rakun-style's `styled.bp` and `layers.bp` written over `use all` / spliced components (they predate `all<T>`), and their two stale `// LANGUAGE GAP` markers and `language-gaps.md` rows dropped. It landed into a rakun gate already red, its 4 examples red from the same `RenderScope` removal
  - [ ] `analysis_equivalence.sh` green, `test-cli` green on `feat`'s pipeline (read with `gh`) — the standing red that hid front 228 for a week
- `modules/compiler-cli/tests/analysis_equivalence.sh`'s `scopes` and `provides` rakun example projects: `#[provides]` and `#[repository]` are `annotation-not-a-decorator` on erlang and beam (19-module list: `rakun/decorators`, `rakun/config`, `rakun/request_context`, `rakun/request_memo`, `rakun/lifecycle`, `rakun/context`, `rakun/conditions`, `rakun/autoconfig`, `rakun/condition_report`, `rakun/ssl_bundle`, `rakun/actuator_api/registration`, `rakun/logging/{correlation,logging,digest,setup,endpoints}`, `rakun/rakun`, `rakun/testing/mod`, `main`) — unrelated to the RenderScope/`all<T>` red above; part of the standing 21-failure count (confirmed present in feat's own CI log before front 229 s1 landed, not a new regression). Not fixed as part of 229 s1 or the rakun RenderScope port; fix only if it turns out to share a root cause with B-212 (decision 809 (8)'s scope defect).


- [x] `scripts/check-docs.sh` (`zig build test-docs`): `conformance/docs.md:3178` named `component_is_lambda_over_render_scope-388/cells/render_scope_construction`, the retired `cells/` shape. It now points at `cases/render_scope_construction`, and that case has its `docs.md` (machine-2, 2026-11-03).


- The rakun workspace gate after the port: what stays red. None of it was added by the port; all of it was red before it too. These reds are not classified yet: each family is a port follow-up fixed in rakun (an example still on the pre-791 / 809 hook form, `await state(7)`), or a compiler defect that gets a 144 row with its case.
  - rakun-bpp's own suite, first runnable after the port and B-213:
    - commonJS: 320 / 4, the 4 being `client_app_test.bp`, which is B-216;
    - erlang: 310 / 14 — `streaming_test.bp` 12 (Suspense, boundary, fill order, plugin) and `testing/helpers_test.bp` 2;
    - beam: 302 / 22 — the same two families (12 + 9), plus `render_test.bp`'s "the shell carries every placeholder and no child, and no document" and a `{error,badarg}` crash in a placeholder-children test.
  - `html/template_test.bp` fails to compile on all three targets at line 154 (`expected string | i32 | … | Element[], got function`, a function value in an html-DSL hole). Whether that hole is refused by 809 (7), which would make the test stale, is read from the decisions first.
  - Other projects:
    - tests and builds: `modules/rakun-stylesheet` (beam) · `modules/rakun-websocket` (erlang, beam);
    - examples: `rakun` (erlang) · `rakun-container` (erlang) · `rakun-app/page-path` (erlang) · `rakun-bpp/blog-ssr` (commonJS, erlang) · `rakun-bpp/jhonstart-counter` and `rakun-bpp/jhonstart-todo` (commonJS, erlang, beam) · `rakun-ssr/blog` (beam);
    - rakun-style's examples: `styled-context`, `styled-context-unbound`, `styled-example`, `styled-source-order` (commonJS, erlang).
  - [ ] each family shrunk to a case on the targets it fails (commonJS as the oracle where it answers) and classified (port follow-up or compiler); the compiler ones filed as 144 rows; the port ones fixed in rakun; the rakun workspace gate green on the three targets


- The libraries' `feat` workflows (read by machine-2 with `gh`, 2026-11-03, front 170 s2):
  - green: actions, http, routing, validation, css, snap, json, yaml and markdown;
  - `log` and `query`: red at the conformance stage (`error: unknown command: cell`), decision 1002 (c)'s known red until 996 / L5 moves the libraries to the root-package shape;
  - `rakun`: a different red. Its latest completed run hit decision 1070's 1800 s bound for the whole gate (exit 124).
  - [ ] rakun's CI gate inside 1070's bound: measure which stages take the time, then split the gate, or shorten it, or bring the bound to the maintainer. A bound changed per repository is a decision, never a quiet edit


- rakun follow-ups the fable read against the decisions (2026-11-03). Each is rakun work, with no compiler change and no new decision:
  - [ ] **rakun-bpp's boundaries hold the component value** (was 144 B-217; 964 (2) 30-c / 30-d, 809 (7), 966 (5), 970 (3)):
    - `Boundary.child: Component<Element>`, evaluated in the page body;
    - `Fill(boundary, scope: myScope.detach())`;
    - the fill runs `run(b.child, fill.scope)`;
    - error and not-found boundaries take the value the same way, and `keptAt` / `boundTo` / `__jhPushBoundary` go.

    Oracle: a `Suspense` fill reading a provided context on four targets, red on erlang and beam on the parent; `streaming_test`'s 12 and `helpers_test`'s 2 (erlang, beam) and `bridge_test:116` green.
  - [ ] **`modules/rakun` off `RenderScope`** (165 s5; 809 (4) / (6), 825 (1), 966 (5), 967 (2), 968 (6)):
    - `pub async fn boot() -> Async<void>`, and `main` writes `await rakun.boot();`, because a boot is a root;
    - `mount` resolves `resolve(c, root, Place.key(m.name))` and awaits a task answer. It never uses `Place.none()`: every module would share one cell, and their hooks' slots would collide;
    - `inject(name)` resolves by hand over its own cell with `Place.key(name)`.

    Oracle: `examples/rakun`, `rakun-container`, `rakun-app/page-path` (erlang) and `rakun-websocket` (erlang, beam) green.
  - [ ] **the decorator sites refused by 716 (1)** (165 s10 rows 234 / 236; 625 (1), 613, 842 (1) / (2)):
    - the method-marker sites register through `compiler.init` with the declaration as code (625 (1)), and `rkRoutes` / `rkSchedules` / `rkJobs` and the string `addMember` go: `decorators.bp:263`, scheduling `markers.bp:139`, jobstore `markers.bp:114`, actuator `registration.bp:270`;
    - a decorator that adds a member uses it from the value it built, never read back through `decl` (842 (1)), with `syntax decl: <Behavior>` only where the type writes `implement` (842 (2)): `config.bp:2067`, `entity.bp:334`, `transactional.bp:131`.
- [ ] **`test-cli`'s `child_group_killed.sh`** (2026-11-04, machine-1): its two build-timeout cases answer `wasmtime: call stack exhausted` before the timeout fires. The failure is identical on a clean `origin/feat`. It is front 144's B-237, and it is in the known set the operator's standing `--no-verify` terms cover until B-237 lands.
