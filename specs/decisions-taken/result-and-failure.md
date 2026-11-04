---
scope: >-
  Decides the checked error: `Result<T, E>` in some layer of the return, `throw` and the propagating
  `try`, the `try` region a `catch` closes, `Ok` / `Error` never constructors, `attempt` and the
  `Failure` kinds (`panic` / `host` / `crash`), the abort text on stderr, std's per-module error
  enums. A binding's `result: true` and `HostError` are host-functions; `try` / `catch` precedence is
  functions-lambdas-and-blocks.
terms:
  - '`Result<T, E>`'
  - '`try`'
  - '`catch`'
  - '`throw`'
  - '`attempt`'
  - '`attemptTask`'
  - '`Failure`'
  - '`HostError`'
  - '`FsError`'
  - '`effect-try-without-fallible-channel`'
  - '`try-region-errors-differ`'
  - '`try-region-cannot-fail`'
  - '`catch-empty`'
  - '`asserts.throws`'
  - '`ErrorBoundary`'
  - '`Suspense`'
  - '`require.main === module`'
  - 'division by zero'
related:
  - 'host-functions'
  - 'functions-lambdas-and-blocks'
  - 'body-markers-async-and-iter'
  - 'prelude-and-primitives'
  - 'backends-and-run-time-output'
  - 'contexts-and-components'
binds:
  - '`01-checker` step 42'
  - '`01-compiler/24` step 2'
  - '`01-std` steps 1–2'
  - '`02/97` step 18'
  - '`05-jhonstart/26` step 14'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` (machine 2: parser, checker, four backends, formatter)'
  - '`1-botopink-lang/144` B-07'
  - '`1-botopink-lang/144` B-08'
  - '`1-botopink-lang/144` B-101'
  - '`1-botopink-lang/144` B-25'
  - '`machine-2/144` B-41'
  - '`machine-2/144` B-41, B-07'
  - '01-checker'
retired:
  - '`Ok(…)` / `Error(…)` as constructors in an expression'
  - 'The runner''s `--import` abort guard on commonJS'
  - 'a raw `crash: badarith` for a float division by zero on erlang and beam'
  - 'jhonstart''s `__jhTryValue` / `__jhTryTask` (414''s renderer); `testing.asserts`'' `tryCatch`'
  - '656'
first-step: 74
last-step: 870
in-force: 13
superseded: 1
---
# result-and-failure — `Result<T, E>`, `try` / `catch` / `throw`, `attempt` and `Failure`

**`Result<T, E>` is botopink's checked error; `try` opens a region that `catch` closes; a failure is always a `Result` in the value's layer; a crash is contained by `attempt` alone, its `Failure` kind exact on every target.**

(1) Checked: `Result`, `Ok` / `Error`, tests — 431, 208, 74.

(2) Regions — 595, 656.

(3) `attempt`, `Failure`, the abort text — 493, 494, 535, 554, 556, 675, 870.

(4) std's error enums — 486.

(5) Components, `Suspense` / `ErrorBoundary` — 504.

Steps: 74, 208, 330, 431, 432, 486, 491, 492, 493, 494, 495, 503, 504, 518, 527, 535, 537, 543, 546, 553, 554, 556, 595, 609, 656, 675, 870, 956
Binds: 01-checker · docs.md · `01-checker` step 31 · `01-compiler/134` step 2 · 02–05 (the lowering of `!`, `?.[]`, `?.()`) · every repository (the migration) · `01-checker` step 42 · `02/97` step 18 · backends 02–05 · `05-jhonstart/26` step 14 · `01-compiler/24` step 2 · `01-compiler/134` step 2 (`builtins.d.bp`) · `01-compiler/04-js` step 13 · backends 02, 03, 05 · `1-botopink-lang/144` B-08 · 431 · 303 · 304 · 335 · 393 · `1-botopink-lang/144` B-05, B-07 · `1-botopink-lang/144` B-04, B-07 · 264 · `1-botopink-lang/144` B-07 · 486 · `1-botopink-lang/144` B-25 · 146 · 74 · `1-botopink-lang/144` · `2-libraries/149` · 489 · 492 · `1-botopink-lang/144` B-116, B-88 · 150 · 165 · `1-botopink-lang/144` B-101 · `1-botopink-lang/144` (machine 2: parser, checker, four backends, formatter) · `conformance/docs.md` · {error, E}` on erlang and beam, `{ ok: V } · `machine-2/144` B-41, B-07

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 74 | 1.0.10-beta · (the maintainer, 2026-09-20) | **`Result<void, string>` is real; a propagated error fails the test.** An assertion returns `Result<void, string>` with an empty `return;` in the `ok` position; a test body is a fallible context: a propagated `error` is a FAIL, never a green test (`__bp_test_N`'s `try` must not lower as `TryForm.propagate`); no `i32` sentinel | `01-std` steps 1–2 |  |
| 208 | ok-a | `Ok(…)` / `Error(…)` in an expression are refused (`unbound variable`, default-fn bodies included), never constructors: a `Result` is made only by `return v` or `throw e`; `docs.md`'s explicit-`Ok(…)` passage goes | 01-checker · docs.md | ok_error_not_constructors |
| 431 | 24-a | **`Result<T, E>` is the checked error; an error not arriving as a `Result` is converted at one boundary — the host binding (`result: true`) or an explicit `attempt`.** (1) Checked: `throw` and a propagating `try` need a `Result` in some layer of the return — one code, `effect-try-without-fallible-channel`, naming `try … catch` and a binding's `result: true`; `try e catch f` and `case` handle on the spot in any function; every call that may fail writes its `try`, no implicit propagation (`val x = try f();` propagates, `val r = f();` is a plain `Result`); `for-over-stream` / `for-await-expects-stream` are the renamed generator codes. (2) Host exceptions: `#[compiler.external(.JavaScript("JSON.parse($0)", result: true), .Erlang("json:decode($0)", result: true))] fn jsParse(s: string) -> Result<Json, HostError>;` — each backend wraps the cell (a JS `try/catch`, an erlang `try … catch Class:Reason`, a rejected Promise under `Async<Result<…, HostError>>`), every host failure `Error(HostError(message, kind, name, detail))` (489, 490); `result: true` is refused unless the return is `Result<…, HostError>` (or an `Async` of one); without it the binding promises no raise, and one is a crash. (3) Crashes: `panic` and an unannounced host raise are defects, never in a signature; `import {failure.attempt, failure.Failure} from "std"; val r = attempt({ -> plugin(x) });` answers `Result<T, Failure>` (`Failure(message, kind)`, kind `panic` / `host` / `crash`), the one way to contain one — replacing rakun-bpp's `__jhTryValue` / `__jhTryTask` and `testing.asserts`' `tryCatch`. Amended by 489 (`HostError`'s fields) and 490 (`throws: true` is `result: true`, the only conversion, a host returning `{error, R}` included) | `01-checker` step 42 · `02/97` step 18 · backends 02–05 · `05-jhonstart/26` step 14 · `01-compiler/24` step 2 | result_is_checked_error |
| 486 | 431-a | **Every std module that can fail answers its own error enum; a binding's `HostError` is mapped into it in std.** (1) `FsError`, `JsonError`, `EncodingError`, `RegexError`, `ProcessError`, `ClockError` …; `HttpError` (393 / 335), `StoreError` (304) and `ActionError` (303) are their modules'. (2) The binding stays private, writes `result: true` (490) and answers `Result<T, HostError>`; the public function maps it into the module's enum, in std (Node `ENOENT` and erlang `enoent` → `FsError.NotFound(path)`). (3) A named variant is the same on every target. (4) Every failure the templates already handle gets a named variant; `Host(HostError)` holds only the rest — nothing lost, nothing a crash. (5) B-08 raises each module's variant list from the failures its templates handle and the hosts answer, the maintainer confirming; the consumer commits in eight repositories follow | `1-botopink-lang/144` B-08 · 431 · 303 · 304 · 335 · 393 | std_module_error_enum |
| 493 | 431-h | `asserts.throws<T>(body: fn() -> T)` is generic, over `attempt`; `T` is inferred from the body | `1-botopink-lang/144` B-07 · 431 | asserts_throws_generic |
| 494 | 431-i | `attemptTask(f: fn() -> Async<T>) -> Async<Result<T, Failure>>` is `attempt`'s `Async` form — a second function, one name per shape, as 24-g's `allOf` / `runAll` | `1-botopink-lang/144` B-07 · 431 | attempt_task_form |
| 504 | 140-e | **Components compose by data on every target (388 to the end): only a body that awaits is a state machine, the renderer awaits only marked lambdas; `Suspense` and `ErrorBoundary` are tree nodes the renderer resolves while descending; comptime unchanged.** Calling a component only makes its lambda (388), only the renderer runs it; a component is a state machine only when its own body writes `await` / `async { … }` or `use`s an asynchronous hook (375 (1), without the "calls a function value" clause); the renderer awaits only lambdas carrying 375's mark, so a task's address and an `Element` are never told apart by their word. A composing component (`Layout(view)`, `App`) stays direct even when handed a component value; its tree holds component values (`<main>{view()}</main>` stores `view()`'s lambda, never the factory `view`), so the renderer meets one kind of child and runs it with the children's scope its parent answered (388 (3)); no trap, nothing paid by a synchronous component, on `wasi` and `browser` with 392's one mechanism; JSPI / stack switching not taken (392). Comptime unchanged: 388 (4)'s at-build run with `Scope.root()` and 434-b's path keep their reading; only wasm's run-time lowering of components changes (front 140 step 4). `Suspense(fallback, child)` and `ErrorBoundary(child, view)` hold component values (414) and run nothing when made; the renderer finds a waiting subtree while descending it (no compiler mark for a subtree): inside a `Suspense` it renders `child` with the scope it met the node with; a subtree finishing without a marked lambda emits its HTML directly, no fallback, no fill; at the first marked lambda it emits `fallback` in the boundary's placeholder, keeps `(child, scope)` and goes on; when the child's task settles the stream's fill runs `renderComponent(child, scope)` with that same scope, a parent's `provide` staying visible; a page with no marked node renders without streaming (375 (1)); `ErrorBoundary` runs its child under `attempt` (431; 431-f on wasm) and renders `view(infoFor(failure))` with the same scope | `1-botopink-lang/144` B-25 · 375 · 388 · 392 · 414 | components_compose_by_data |
| 535 | B-41-a | **A run-time abort prints one text on every target; the departure is only whether the target aborts.** An uncaught run-time abort writes to stderr the `Failure` an `attempt` would have caught (527), `<kind>: <message>`: `panic: division by zero` (on erlang and beam a marked `panic`, 527 (3)), `crash: <reason>` (a failing match, any unmarked raise), `host: <message>` (a host raise) — never the raw `Class:Reason` term (as 472 at build); where erlang and beam abort and commonJS and wasm answer `Infinity` (444), the cell declares that departure in `snapshot/targets/`; the text is not a departure | `1-botopink-lang/144` | runtime_abort_prints_failure |
| 554 | 546-b | **A library sidecar unwinding with a thrown term through a `host`-wrapped call is a library gap, never a compiler mechanism.** rakun's tests of a navigation signal or a `rakun_problem` unwinding through a wrapped binding (546) stay red as library gaps; navigation becomes data the renderer reads (527 (5), 504), a problem a data path of rakun's own; no interim mechanism (a term the wrapper lets through, a catcher parsing the `host` text, an attribute exempting a binding) | 150 · 165 | thrown_term_through_host_call_unwrapped |
| 556 | 546-a | A `crash` prints `crash: <the engine's reason>` on each target; a cell claims `stderr crash:` alone and a `Failure` cell prints `f.kind`; no `snapshot/targets/` holds a crash message | `1-botopink-lang/144` B-101 | crash_reason_engine_kind_claimed |
| 595 | 537-a · (the maintainer, 2026-10-17) | **`try` opens a region; `catch` closes it and handles the failure of every `try` written in it.** (1) A `try` propagates to the nearest region holding it — a `try { … } catch …`, else the function (which then needs a `Result` channel). (2) The region is the block `try { … }` when written, else the whole expression left of the `catch` (537 (2)): `try e catch h` is `try { e } catch h`; `(try a) + (try b) catch 0` sends both failures to the one `catch`. (3) The handler: an expression (the fallback, `catch 0`); a `throw` (`catch throw ParseFailed`, the failure becomes the function's); a block whose value is the fallback (`catch { log.warn("…"); 0 }`); a block with a binder `catch { e -> … }`, `e` the region's error — a `case` arm's binder, not a lambda, typed by the region. (4) The region is an expression, its value its last expression without `;` (409, 525), the handler of the same type; `catch { }` is refused `catch-empty`, located — a failure is handled (a value, a statement, a `throw`) or propagates, never swallowed (67); a `void` region's handler is a block with at least one statement (`try { try save(a); try save(b) } catch { log.warn("not saved") }`). (5) One `E` per region: a second error type is refused at that `try`, located, naming both — `try-region-errors-differ`; handle one on the spot (`try parseInt(raw) catch …`) or convert it (`catch throw …`). (6) A `try` in the handler's body belongs to the enclosing region or the function, never to its own `catch`. (7) A region holding no `try` is refused `try-region-cannot-fail`, located. (8) Unchanged: `defer` (539) runs when its block ends, a caught failure ending the region and the inner blocks on the way; `attempt` (431, 444) alone catches `panic` / `crash`, `catch` only a `Result`'s failure; `try` and `await` prefixes, `catch` the lowest infix (537 (1); 537-b decided by 865 — `catch` lowest, `??` tightest). (9) Lowering: one early-exit block per region — commonJS a labelled block or a sentinel, erlang / beam `try … catch` over a term of its own, wasm `block … br` to the handler; no new exception on wasm (518). Cells `try_block_catch_value`, `try_block_catch_binder`, `try_block_catch_rethrow`, `try_block_catch_void_statement`, `try_block_catch_empty` (refused), `catch_region_covers_left_side`, `try_in_catch_body_propagates`, `try_region_errors_differ`, `try_region_cannot_fail`; `conformance/docs.md` § Result; amends 537 | `1-botopink-lang/144` (machine 2: parser, checker, four backends, formatter) · `conformance/docs.md` | try_region_closed_by_catch |
| 656 | lg2-h · (the maintainer, 2026-10-18) | Overtaken by 595 | `machine-1/144` |  |
| 675 | 535-a · (the maintainer, 2026-10-18) | **A float division by zero on erlang and beam is the same `panic` as the integer one: `panic: division by zero: / on f64 at <file>:<line>:<col>`.** erlang and beam check the float `/` (and `%` where the target raises) as the integer one (527 (3) marked only the integer; `1.0 / 0.0` printed a raw `crash: badarith`, against 535) — one shape for every division by zero, the type in the message; commonJS and wasm keep `Infinity` (444), the cell declaring only whether the target aborts (535); cells `float_nan_infinity_words` (erlang and beam departures claim the panic text) and `float_division_by_zero_panic` (erlang, beam) with the position | `machine-2/144` B-41, B-07 | float_division_by_zero_panics_on_beam |
| 870 | 535-b · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 2" — decided by the fable at the maintainer's delegation; rejected: (a) the runner's guard alone (a hand-run `node main.js` prints node's stack trace: 535's text is the program's), (c) both (two handlers, the first decides)) | **On commonJS the abort handler is the program's: the entry module installs it inside its `require.main === module` branch, before `main`; the runner's `--import` guard goes for commonJS and stays for the browser `.mjs` loader until 164 s2c; amends 535.** (1) The guard's text moves into the emitted entry unchanged (`panic` / `host` / `crash`, 546's marks); a library, a test unit and a loaded package's `main` install none. (2) The cell harness and `botopink run` run a commonJS program bare: the `abort_text_*` cells prove the program's own text. (3) erlang and beam keep the runner's guard | `machine-2/144` B-41 · 164 s2c | abort_handler_emitted_in_entry |
