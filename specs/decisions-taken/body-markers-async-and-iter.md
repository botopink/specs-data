---
scope: >-
  Decides the body markers `async`, `iter`, `async iter`, `component` — their spelling and order, the
  refusals for a keyword without its marker — and the types `Async<T>`, `Iter<T, R>`, `AsyncIter<T,
  R>`: a task as a Promise on every target, failure through `Async<Result<T, E>>`, no task methods,
  wasm's state machine, `is Async<unknown>`. Components' hooks and scopes are contexts-and-components;
  `io/http.fetch` is actions-http-log-routing-i18n.
terms:
  - '`async`'
  - '`iter`'
  - '`async iter`'
  - '`component`'
  - '`Async<T>`'
  - '`Iter<T, R>`'
  - '`AsyncIter<T, R>`'
  - '`await`'
  - '`yield`'
  - '`marker-type-mismatch`'
  - '`marker-without-arrow`'
  - '`marker-on-declaration`'
  - '`await-without-async`'
  - '`yield-without-iter`'
  - '`use-without-component`'
  - '`iter-await`'
  - '`raceOf`'
  - '`is Async<unknown>`'
  - '`HookNode.async`'
  - '`$task`'
related:
  - 'contexts-and-components'
  - 'functions-lambdas-and-blocks'
  - 'result-and-failure'
  - 'wasm-target-and-runtime'
  - 'host-functions'
  - 'std'
open:
  - '523: a task method may return by a later decision, a recovering one under a name that is not a keyword'
  - '505: the wasm A-normal-form binding of operands before an `await`; until it lands the located refusal stays'
binds:
  - '`01-compiler/01-checker` step 23 (the mark)'
  - '`01-compiler/04-js` (the code, the typedef)'
  - '`01-compiler/04-js` step 13'
  - '`01-compiler/05-wasm` (`wat.zig`)'
  - '`01-compiler/134` step 2 (`builtins.d.bp`)'
  - '`01-compiler/140` step 4'
  - '`01-compiler/140` step 6'
  - '`01-compiler/140` steps 4–6'
  - '`01-compiler/24` step 2'
  - '`02/97` step 17'
  - '`1-botopink-lang/144` B-06'
  - '`1-botopink-lang/144` B-116'
  - '`1-botopink-lang/144` B-116 (ii), B-128'
  - '`1-botopink-lang/144` B-116 (machine 2)'
  - '`1-botopink-lang/144` B-25'
  - '`machine-1/144` B-116'
  - '`machine-1/144` B-137 (the codemod)'
  - '`machine-1/144` B-162'
  - '`machine-1/144` B-25'
  - '`machine-1/150`'
  - '`machine-1/155` (`fetch`)'
  - '`machine-2/144`'
  - '`machine-2/164` s2'
  - '`machine-2` item 16 (the reference)'
retired:
  - '`@Task<T>`; `Task` as a prelude name'
  - '`map`, `then`, `mapError`, `catch` on a task'
  - 'Any other marker order (`async pub fn`, …)'
  - '`async { x -> … }`, `iter { -> … }`, `async iter { x -> … }`, `component { -> … }` (a marked lambda''s marker before the brace)'
  - '`effect-await-without-task`, `yield-without-generator`, `use-without-context-effect`'
  - '`component-lambda-not-lowered`'
  - '`conformance/docs.md`''s equivalence `iter { x -> b }` ≡ `{ x -> iter loop { b; break; } }`'
  - '`async fn f()` with no return type'
  - '654'
first-step: 375
last-step: 967
in-force: 18
superseded: 2
---
# body-markers-async-and-iter — `async`, `iter`, `component`; `Async<T>`, `Iter<T, R>`, `AsyncIter<T, R>`

**A body that compiles specially carries a marker; the return type is written whole, named after its marker; a task behaves as a Promise on every target; every composition of a task is an `async` block.**

(1) Markers: next to `fn`, inside a lambda's brace; none on a bodyless declaration — 571, 572, 584, 794.

(2) Refusals: a keyword without its marker, `iter-await`, `marker-type-mismatch` — 573, 584 (3).

(3) Types: `Async<T>` the one name; the hooks list's `async` mark; `Iter`'s helpers; a `component` lambda — 732, 375, 596, 574.

(4) Tasks: Promise semantics, failure through `Async<Result<T, E>>`, no task methods, no cancellation — 392, 432, 523, 704, 654.

(5) wasm: the state machine, operands bound before `await`, host adapters, gate adapters — 392 (2), 505, 393, 394, 690.

(6) `is Async<unknown>` — 967 (replacing 823).

Steps: 335, 375, 376, 392, 393, 394, 432, 505, 523, 547, 553, 570, 571, 572, 573, 574, 584, 596, 654, 690, 704, 712, 725, 732, 794, 823, 967
Binds: `02/97` steps 11, 17 · `01-compiler/140` · `lib-test-runner` (the wasm column) · `01-compiler/01-checker` step 23 (the mark) · `01-compiler/04-js` (the code, the typedef) · 277 · `01-compiler/140` steps 4–6 · `01-compiler/05-wasm` (`wat.zig`) · `02/97` step 17 · 375 · 335 · `01-compiler/140` step 4 · 238 · 305 · `01-compiler/140` step 6 · 334 · `01-compiler/134` step 2 (`builtins.d.bp`) · `01-compiler/04-js` step 13 · backends 02, 03, 05 · `01-compiler/24` step 2 · `1-botopink-lang/144` B-25 · 392 · `1-botopink-lang/144` B-06 · 432 · `1-botopink-lang/144` B-116, B-88 · `1-botopink-lang/144` B-116 · `2-libraries/150` · `1-botopink-lang/144` B-116 (machine 2) · `1-botopink-lang/144` B-116 (ii), B-128 · `libs/std` · `machine-1/144` B-25 · `machine-2/144` · `machine-1/150` · `machine-2/144` B-116 · `machine-1/144` B-162 · `machine-2/164` s2

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 375 | (async) | A component or hook is asynchronous only where the hooks list marks it so; the language does not change. (1) Each node of the hooks list (277) carries `async: bool` — `HookNode.async`, readable by a decorator (`#[page]`); a node is asynchronous when its body writes `await` or `async { … }`, when it `use`s an asynchronous hook or calls an asynchronous component (with or without `await`), when it calls a host function answering `Async`, or when it calls what the checker cannot follow (a function value, a method, a `use` with `hook: null`); a cycle is asynchronous when any node in it is. (2) A synchronous component's lambda (388) is a plain function, an asynchronous one's run answers an `Async` (commonJS: an `async function`); no `await` is emitted on a synchronous one; the TypeScript typedef follows the mark; erlang, beam and wasm unchanged by this row (`await` the identity; wasm since 392 (2)). (3) The type stays `Component<R>`; `await` stays legal on any component (a no-op on a synchronous one); a field read without `await` stays the checker's refusal (`language-gaps.md`'s row). Amends 104 (6) | `01-compiler/01-checker` step 23 (the mark) · `01-compiler/04-js` (the code, the typedef) · 277 | async_marked_by_hooks_list |
| 392 | 140-a | `Async<T>` behaves as a Promise on every target; on wasm an asynchronous function is a resumable state machine driven by a scheduler. (1) A task starts when it is made and runs to its first `await`; `await` suspends the awaiting body while other tasks run (commonJS and wasm; erlang and beam per 967 (5)); a task settles once, with a value or an error (432); `race` answers the first to settle, `raceOf` runs its thunks concurrently — node's Promise, erlang's process per task, and wasm alike (335 (2)): `raceOf([{ -> async { await delay(30, ()); "a" } }, { -> delay(10, "b") }])` is `"b"` everywhere. (2) On wasm a function 375 marks asynchronous compiles to a resumable state machine (state index and locals in a heap frame across each `await`; loops, `try` and closures holding one transformed with it); the prelude's scheduler waits on the pending pollables and resumes the task owning the ready one — `wasi:io/poll` on the `wasi` host, the JS event loop on `browser`; one mechanism for both hosts, no JSPI, no WASI 0.3; a synchronous function pays nothing | `01-compiler/140` steps 4–6 · `01-compiler/05-wasm` (`wat.zig`) · `02/97` step 17 · 375 · 335 | task_behaves_as_promise |
| 393 | 140-b | A host adapter may answer `Async<T>` over a generic `T`: `#[compiler.external(.Wasm(wasi: .Delay))] pub declare fn delay<T>(millis: i32, value: T) -> Async<T>;`, its signature (`(i32, T) -> Async<T>`) checked by shape at the annotation, the compiler wrapping the host's pollable into the pending task 392's scheduler waits on; `io/http.fetch(req: Request) -> Async<Result<Response, HttpError>>` reads and writes `Request` / `Response` in the compiler's record layout; each adapter's signature is a row of `docs.md`'s list, any other shape refused at the annotation | `01-compiler/140` step 4 · `02/97` step 17 · 238 · 305 | host_adapter_answers_generic_task |
| 394 | 140-c | One adapter list for both wasm hosts: each `wasi:` adapter has a preview 2 implementation and a JavaScript one, `host:` written only where the hosts truly differ — `#[compiler.external(.Wasm(wasi: .HttpOutgoing))]` serves `wasi` through the component's adapter and `browser` through the loader's JavaScript, 392's scheduler the one suspension mechanism for both (334); no `js: .Adapter` form | `01-compiler/140` step 6 · `02/97` step 17 · 334 | one_adapter_list_both_hosts |
| 432 | 24-b | `Async<Result<T, E>>` is the task that fails with `E` — its Promise rejects with `E`, resolves with `T`; `Async<T>` does not fail; the type is 431's: `val u = try await buscar(1);` propagates, `try await buscar(1) catch User.guest()` handles, `val r = await buscar(1);` is a `Result<User, HttpError>`. commonJS: `throw e` / an `Error(e)` rejects the Promise with `e`, a success resolves with the bare value (no `{ Ok }` / `{ Error }` wrapper), so a JavaScript caller catches `e` and the `.d.ts` names `E`; erlang and beam: `{error, E}`, which `await` answers as `Error(e)` (967 (5): no task process, the value alone); wasm: 392's scheduler settles the task with the error. A rejecting host Promise enters as `Error` through 431's `throws: true` (since `result: true`, 490); a crash in an `Async<T>` is a defect, contained by `attempt` (431). The task methods this row declared, one spelling each (67) — `map`, `then`; `mapError(f)`, `catch(f)` on a failing task; no `flatMap` — are withdrawn by 523 | `01-compiler/134` step 2 (`builtins.d.bp`) · `01-compiler/04-js` step 13 · backends 02, 03, 05 · `01-compiler/24` step 2 | task_result_rejects_with_error |
| 505 | 140-f | The wasm backend binds each operand evaluated before an `await` in its statement to a frame local (A-normal form), so the statement runs as written and as on commonJS, erlang and beam: `pair(label("x"), await answer(21))` stores `label("x")`, then awaits — the call runs once; until it lands the located refusal stays, so nothing runs twice silently; `run/task_await_after_call_refused_on_wasm` then becomes a cell that runs on every target | `1-botopink-lang/144` B-25 · 392 | wasm_await_operands_bound_before |
| 523 | B-06-a | `map`, `then`, `mapError` and `catch` are withdrawn — removed — from tasks (amends 432): no nested-form declaration, the prelude declares none; a failing task is read only by `try await … catch` or `case` on `await`'s `Result`; composing without awaiting is an `async { … }` block (375), itself an `Async` whose value is its tail (blk-a) — `val safe = async { try await load() catch 0 };` is an `Async<i32>`; every composition (map, bind, recover, map the error) is an `async` block (`async { (try await t catch 0) * 2 }`). The reversed cell is `task_failure_rejects`. A task method may return by a later decision, a recovering one under a name that is not a keyword | `1-botopink-lang/144` B-06 · 432 · 375 | task_methods_withdrawn_async_block |
| 571 | B-116-b | A marker is for a body: the markers (`iter`, `async`, `async iter`, `component`, 553) say how a body is compiled, so a bodyless function — a `declare fn` (`declare fn sleep(ms: i32) -> Async<void>;`), a behavior's abstract member — writes its return type alone; a marker on one is refused, located, `marker-on-declaration`; the type implementing the member marks its own body as it needs (570) | `1-botopink-lang/144` B-116 | marker_on_declaration_refused |
| 572 | B-116-c | A marker sits next to `fn`: `#[…] [pub] [default] <marker> fn`, the marker one of `iter`, `async`, `async iter`, `component` — `#[serverAction] pub async fn count(…)`, `pub default async fn load()`, `pub async iter fn lines(…)`; any other order (`async pub fn`) is a parse error at the marker; on a lambda the marker is inside the brace (`{ async x -> … }`; 584 (1) replaced `async { x -> … }`); the formatter and the codemod write this order | `1-botopink-lang/144` B-116 | marker_order_before_fn |
| 573 | B-116-d | The keyword without its marker is refused under the marker's name — `effect-await-without-task` → `await-without-async`, `yield-without-generator` → `yield-without-iter`, `use-without-context-effect` → `use-without-component` (B-116 piece (i); the old names gone, no alias; every cell, snapshot and reference page updated in the same landing) —, each message and hint naming the marker to write ("write `async fn`"). 553's codes stay: `marker-without-arrow`, `marker-lambda-without-expected-type`, `marker-on-declaration` (571), `marker-type-mismatch`. A code refusing something other than a missing marker keeps its name (`iter-await`: an `await` in an `iter` body, the hint naming `async iter`) | `1-botopink-lang/144` B-116 | keyword_without_marker_refused |
| 574 | B-116-e | A `component` lambda — `val c: () -> Component<Element> = { component -> … }` (584 (1)'s spelling), checked against its expected type (147; without one `marker-lambda-without-expected-type`) — compiles and runs as a `component fn` does, through the component-fn path (a lambda over the `Scope`, 388, 504; on wasm `scope_carry`), its captures carried, on four targets (B-116 piece (i)); `component-lambda-not-lowered` is deleted. Cells: a component lambda bound to a typed `val` and one passed to a typed parameter, rendered, one answer on every target | `1-botopink-lang/144` B-116 | component_lambda_runs |
| 584 | B-116-f · B-116-g · B-116-j · (the maintainer, 2026-10-17) | (1) A lambda's marker is written inside the brace, before the parameters — `{ async x -> … }`, `{ iter -> … }`, `{ async iter x -> … }`, `{ component -> <div/> }`; `async { x -> … }`, `iter { -> … }`, `async iter { x -> … }`, `component { -> … }` are retired: `async {` is always 523's block, `iter loop {` 125's loop, `{ async` / `{ iter` / `{ component` always a lambda; 553 (1)'s sentences on the `->` and on a trailing marked lambda's parentheses go; a marked lambda goes wherever a lambda goes, trailing included (`f(1) { async x -> … }`); the formatter migrates the 7 `marker_*` cells. (2) A marked lambda's body is a function body, as an `iter fn`'s: `return v` is the iterator's `R` (553 (2)), a top-level `continue` refused `continue-outside-loop`, `break v` refused; the lowering onto `iter loop { b; break; }` is the compiler's own, `conformance/docs.md`'s equivalence `iter { x -> b }` ≡ `{ x -> iter loop { b; break; } }` dropped. (3) `async fn f()` with no return type is refused `marker-type-mismatch`, "write `-> Async<…>`" (583). Amends 553 (1), 574 | `1-botopink-lang/144` B-116 (machine 2) | lambda_marker_inside_brace |
| 596 | B-128-a · (the maintainer, 2026-10-17) | `Iter<T, R>` declares the iterator helpers whole, typed, on every target (Node's `Iterator.prototype` set, beside `next`, 553 (ii)): `map<U>(f: fn(T) -> U) -> Iter<U, R>`, `filter(p) -> Iter<T, R>`, `flatMap<U>(f: fn(T) -> Iter<U, R>) -> Iter<U, R>`, `take(n)` / `drop(n) -> Iter<T, R>`, `forEach(f)`, `toArray() -> T[]`, `reduce<A>(init: A, f: fn(A, T) -> A) -> A`, `some(p)` / `every(p) -> bool`, `find(p) -> ?T`; commonJS binds Node's helpers through the typed receiver, erlang and beam complete their runtime (`flatMap` added), wasm implements the set in GC; a method outside the set is `unresolved_method` everywhere alike; no helper reaches a program through an untyped receiver. Cells `iter_helpers_*` (one per helper, four targets), `iter_flat_map_generator` | `1-botopink-lang/144` B-116 (ii), B-128 · `libs/std` | iter_helpers_declared |
| 654 | lg2-b · (the maintainer, 2026-10-18) | Overtaken by 392 | `machine-1/144` | |
| 690 | B-25-a · (confirmed as built, the maintainer's batch, 2026-10-18) | B-25's wasm gate adapters are `.GateNew`, `.GateOpen`, `.GateAwait` (a gate is a pending task no host answers; opening it drops each pending wait's timer); std's test-only cells (`monoMillis`, `hostTarget`, `newCounter`, `countUp`, `countOf`, `panicOf`) stay unbound on wasm until `botopink test` runs wasm (335 (3)); `std_async_on_every_target` green on four targets, both hosts | `machine-1/144` B-25 | std_async_on_every_target |
| 704 | lg2-p · (confirmed as built, the maintainer's batch, 2026-10-18) | No cancellation in std's async: a losing racer and an expired timeout run to completion, their results dropped; `raceOf` / `timeout` document it. (1), as built: the contract is the result and the order of answers (335 (2)), never the interleaving; tokens and linked processes come when a front measures the need | `machine-2/144` · `machine-1/150` | async_race_loser_runs_to_completion |
| 732 | ctr-ab · (the maintainer, 2026-10-18) | `Async<T>` is the one name of an `async` body's return type; `Task` is retired as a prelude name (553 (2) renamed `@Task`; the name follows the marker): 606 (1)'s `fn load() -> Task<User>` and 623's `fetch(req) -> Task<Result<Response, HttpError>>` read `Async<User>` and `Async<Result<Response, HttpError>>`; 553 (6)'s codemod carries the spelling | `machine-1/144` B-137 (the codemod) · `machine-1/155` (`fetch`) · std | async_is_name_of_async_body_return |
| 794 | docs-a · (the maintainer, 2026-10-20: ticked (a)) | `marker-without-arrow` covers every marker written before a brace that opens no block form — `iter {`, `async iter {`, `component {`, with or without `->` (`async {` stays the block, `iter loop {` the loop) —, its label naming `{ iter -> … }` and `iter loop { … }`; the code keeps its name; amends 553 (1) as 584 (1) left it, keeps 573. `val xs = iter { -> yield 1; };` is `marker-without-arrow`, the hint `write { iter -> … }`; the old spelling is refused where written, naming the new one | `machine-1/144` B-116 · `machine-2` item 16 (the reference) | marker_before_brace_refused |
| 823 | 810-b · (the maintainer, 2026-10-21: shown the fable's check of a coordinator's option (d) — (b)'s static rule refusing the test at `run` and the renderer, whose type is `T | Replaced by 967 | `machine-1/144` B-162 · `machine-2/164` s2 | is_async_answers_a_task |
| 967 | 823-fix · (the fable, at the maintainer's delegation — the review triage of 814–955, 2026-10-26) | `is Async<unknown>` answers whether a value is a task — what one `await` reads its `T` through, settled or not; on erlang and beam no value is one; restates 823 with 883 (2) folded in. (1) commonJS: `instanceof Promise`. (2) erlang and beam: `false` for every value — a call answering `Async<T>` answers its settled `T`, `await` is the identity, `async { … }` runs in place; a pid or a ref is never typed `Async`. (3) wasm: a `ref.test` over the runtime's `$task` struct, its state not read; landed with 164 s2, the test answers on four targets. (4) Readers: std's `run` (825), the renderer (809 (6), 504 — its fork between emitting at once and the fallback) and, on wasm, the `await` that `use c` lowers to over `T \| Async<T>`. (5) 392 (1)'s start-and-suspend reading of a task is commonJS's and wasm's (§ body-markers (3)); on erlang and beam a body runs to its end when called, a failure the `{error, E}` value with no task process (432), no test depending on the difference (335 (2)). (6) Cell `is_async_answers_a_task`: a settled and a pending task `true` on commonJS and wasm, every value `false` on erlang and beam | `machine-1/144` B-162 · `machine-2/164` s2 | is_async_answers_a_task |
