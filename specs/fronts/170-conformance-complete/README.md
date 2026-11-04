---
milestone: 1.0.12-beta
owner: machine-1
---
# Front 170 — conformance complete: every open step the suite's 100% needs, out of 144, 150, 163, 165 and 166

Opened by the maintainer, 2026-11-01. Every step still open between the conformance suite and green at 100% was
scattered across fronts 144, 150, 163, 165, 166 and the whole of front 164 past its first step. This front holds them
in one place, **moved out of their old home, never duplicated** — each origin keeps a one-line pointer here. Front
164 wasm-gc keeps its number and its done s1; its open s2 onward is s7–s11 here. Machine 1 and machine 2 both read
this front first, in the order below, until it closes.

## Alias table

Old id | Step here
---|---
144 B-29 step H's tail (`random.float()`, B-43, B-44) | 170 s1
163 s8's last two boxes | 170 s2
163 s9 (whole) | 170 s3
166 s3's tail — decision 781's packing over `compiler.load` | 170 s4
166 s4 (whole) | 170 s5
166 s5 (whole) | 170 s6
164 s2 (whole) | 170 s7
164 s2b (whole) | 170 s8
164 s2c (whole) | 170 s9
164 s3 (whole) | 170 s10
164 s4 (whole) | 170 s11
165 s7 (whole) | 170 s12
150 s25 (whole) | 170 s13

## Steps

### s1 — the decorator `random.float()` cell and the B-43 / B-44 reds (was 144 B-29 step H's tail)

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** B-46 (front 144, machine 2)

- [ ] the decorator `random.float()` cell once B-46 lands; the reds B-43 and B-44 found (`generic-loader-binding`
      is erika's cell `conformance/modules/generic_loader_binding`)

### s2 — the meta gate holds every library's dependency text to one, and every library green on `feat` (was 163 s8's last two boxes)

**Repository:** every library repository with a `botopink.json` (a full worktree), and the meta repository · **Model:** sonnet · **After:** 163 s8's earlier boxes (landed, in front 163)

State (machine-2, 2026-11-03, read with `gh`):
- green on `feat`: actions, http, routing, validation, css, snap, json, yaml and markdown;
- `log` and `query`: red at the conformance stage, decision 1002 (c)'s known red until 996 / L5;
- `rakun`: red at decision 1070's 1800 s gate bound, a new red filed in front 169 § Known reds.

- [x] the meta `scripts/gate.sh check` holds every library's `test.yml` dependency step and `BOTOPINK_LIB_ROOTS` to
      one text (478's cheap test: the "not found" reds appear only on a runner with no sibling library) — check 6,
      green locally and on the meta's CI
- [ ] every library's workflow has at least one green run on `feat`, and its latest run green — read with `gh` (474).
      Nine are; `log` and `query` wait on 996 / L5; `rakun` on front 169's 1800 s box

### s3 — the gate and the conformance order timed on a quiet machine (was 163 s9)

**Repository:** botopink-lang and the meta repository · **Model:** sonnet · **After:** s2 (this front)

Every time measurement of the conformance order waits for its end — no step in between spends time measuring.
On a quiet machine (load below 3, nothing else running):

- [ ] the full gate (cold and warm), the step gate (a one-backend and a shared change) and the hook's
      `--no-conformance` gate, per stage, in `scripts/AGENTS.md`
- [ ] `conformance/` by kind and by target (in-process cells against the CLI-run ones), naming the cells a snapshot
      already covers
- [ ] two gates through the meta repository's scheduler against one after the other (decisions 468, 469, 473)
- [ ] each library's gate (`scripts/gate.sh libs`), per library

### s4 — decision 781's packing over `compiler.load` (was 166 s3's tail) — **closed, overtaken by 789**

The rest of 166 s3 (the per-repository drafts) landed; this step was what remained (the maintainer, 2026-10-26, mt-0064): decision 781's packing over B-158's `compiler.load`.

- [x] decision 781's packing mechanism over `compiler.load`. Closed (the maintainer, 2026-11-03): 781 is retired in favour of 789 (4) — one package per module, `src/main.bp`'s `runCase(comptime name)` loading each case through `compiler.load`, a refused case answering its `Diagnostic`s as `refused` / `at` / `label` lines. That is the shape every conformance module runs in today (B-157 P3, the root package of 989 / 990). Nothing of 781 is left to build

### s5 — the flip: the cells run, per repository (was 166 s4) — **retired**

Retired (the maintainer, 2026-11-03). The step was built on `scripts/decision-cells.ts` (`scaffold` / `promote` / `check`) and CI check 7, and the maintainer removed both on 2026-11-02. With them went the per-repository `promote`, check 7 (ii)'s completeness rule, and the generated per-repository `decisions-taken.md`. The cells already under `conformance/modules/decisions-taken/` stay as real content and run with the root package like every other module. A more structured way to tie decisions to cells is not designed yet; until it is, no step depends on one. What remains of this step's purpose is s6's simplified check.

### s6 — Conformance, front 166's last step (was 166 s5; decisions 459, 465, 477–480)

**Repository:** botopink-lang, then each library with a `conformance/` · **Model:** opus · **After:** nothing open (s5 retired, the maintainer, 2026-11-03)

Simplified when s5 was retired: no completeness check, no generated ledger. The cells under `conformance/modules/decisions-taken/` are checked as they stand today.

- [ ] `feat`'s pipeline green in every repository with the decision cells as they stand in its `conformance/` — each
      red reproduced locally, fixed first (430) with 478's cheap test, or filed with its row and its cell's state
- [ ] the cells' answers audited against their decisions' text (through specs-bot): a cell whose answer contradicts its
      decision is a red of the step; the reference (480): the root `conformance/docs.md` row, no text contradicting a
      cell; front 166 closes

### s7 — the wasm codegen emits WasmGC: every value a GC struct or array, no linear-memory value (was 164 s2; the maintainer, 2026-10-14; wasmgc-a)

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** front 164's s1 (landed: the engines run WasmGC; wasm3 did not)

The program's memory is the host's collector (wasmgc-a): wasmtime's and the browser's. The codegen emits WasmGC
types, never linear-memory values; 522's own heap is never wired (B-30 closed as superseded). Each piece keeps every
cell's answer; a module not yet lowerable in GC form falls back to the linear lowering, deleted at P5.

Pieces: P0 `Repr` in place of the type strings, the two modes · P1 the GC core — strings, printers, the std-wasm
boundary (an arena reset after each call, deleted by s10) · P2 arrays, tuples, optionals, records and variants (one
struct type per declaration), `case`, `unknown`, `Bytes`, `Dict` (scalars boxed inside `anyref`, never `i31ref`) ·
P3 closures, `var` cells, components · P4 tasks · P5 the linear lowering deleted · P6 the bounded-memory cells and
the docs, per decision 555 (the codegen breaks its own cycles — a settled task drops its waiters and frame; the gate
pins the wasmtime CLI beside the C API; a cycle a program builds may live until exit on wasmtime).

Landed: P0–P4 (P2b: `unknown`, `Dict`, generic records and enums, the arrays' and `Result`'s methods, union arrays,
generators; P3: function values, closures, fn refs, `var` captures, components, generic static methods, a float, array
or function value in a type-parameter slot, `==` over a generic record with written type arguments, a `yield` ending a
`case` arm, a `try` inside a generator over a `Result`, a function value in `unknown`; P4: `$task`, a typed frame per
state machine, waiters, the ready queue, gates, `race` / `raceOf` / `spawnAll`, `async` blocks and awaiting
components, the exception tag's payload an `anyref` `$exn`, `attempt` and `try … catch` in GC, a settled task nulls its
waiters and frame, 544-a) — 600 GC modules of 1399. Representation: a function value is `$closure {idx, mark}`, each
lifted lambda a subtype `$env<n>` with one mutable field per capture, called through one boxed table entry per arity;
a component is `scope_carry`'s `fn(unknown) -> unknown` lambda.

Still on the linear lowering, lifted with P5: an array of tuples in a type-parameter slot; a `try` inside a generator
whose item is no `Result`; a block or `case` value typed apart from its function (`{ yield 5; 6 }`); the refusal of a
generic body reached with nothing bound, which the GC lowering answers as commonJS does (`Box(n)`) — **landed**
(900 (3), B-207, B-210; machine-2, 2026-11-02, decision 1101 (1)-(3)). Writing a
type-parameter field is lowered but no cell reaches it.

- [ ] **the types:** one GC type per value shape — string (an `i8` array), array, tuple, record, enum and variant,
      closure, `Async` record, `Dict` — declared in the module's type section; `unknown` a reference to any of them;
      `Bytes` an `i8` array (346); a value never has an address
- [ ] **the operations:** construction, field read, array get and length, comparison and `terminal.print`'s text over
      GC values; the `wat_prelude` keeps representation, operators, output and runtime (442) in GC form; `alloc` and
      every linear-memory helper gone from the program
- [x] **a tuple's own subtype, a structural `$__unk_eq` (568, 569):** `$tuple` a subtype of `$arr_any`, a slot's
      printer telling `#(1, 2)` from `[1, 2]`; `$__unk_eq` compares records, variants, arrays, tuples, `Result` and a
      boxed `i64` by their parts; cells `generic_tuple_slot`, `generic_record_equality_unwritten`; an array of tuples in
      a type-parameter slot still falls back to linear memory (front 229 s4's `arr_bool` box lifts it)
- [ ] **tasks and the scheduler** (392) over GC records: a settled value is shared, never copied (immutable); a
      mutable cell a GC struct with one mutable field; no heap per task, no copy at a send, no cycle to detect (the
      host's collector follows cycles)
- [x] **`is Async<unknown>` on wasm** (decision 823): `$task` the GC type of an `Async` type ref, a `ref.test (ref
      $task)` row in `gcTypeTests` (`codegen/wat.zig`), a task boxed into an `unknown` as is, the task's state not read
      (`v is Async<unknown>` answers whether `v` is a task, settled or not); `lowerAwait` over a `T | Async<T>` (the
      `await` that `use c` lowers to) tests the same instead of deciding by the static type; cell
      `is_async_answers_a_task` (166's, under `decisions-taken/`) green on four targets; B-162 P1's `run` and `use c`
      waited on it on wasm only
- [ ] **B-162 P1's component cells on wasm** (809, 815–825, 823; machine 1's thread on P1-B, chat m2-0036 / m2-0037):
      P-A ✓ — std's memo / hook cells a GC `$cell {filled, value}` (`gc_memo_cell_*`), so a module binding them stays
      WasmGC; a `use memo` slot over a `Context<T>` typed `T` in `context_lower.zig` (`createContext(v)` is `v`, 379) ·
      P-B (machine 1): a lowered component fn typed `fn(unknown, unknown) -> R` so `run<T>` / `resolve<T>` bind `T` ·
      P-C: the component cells green on wasm over P-B and 831, `wat.zig` only; linear `is Async<unknown>` not built
      (the module stays GC)
- [x] **`needs: [.Gc]`** (518) on every program emitting GC types — wasmtime `-W gc=y`, node and the browser by default
- [ ] **every `run/` cell's `.out` on wasm unchanged**; a long-running cell (a loop of 10M allocations, a recursion
      without a loop, a request loop) whose memory stays bounded; `std_wasm.wasm` still linked for the std's functions
      until s10 — values crossing into it marshalled at the boundary, measured, the boundary deleted by s10
- [ ] docs: 448, 449, 522 amended in the reference's "Decided" table (the program's memory is the host's);
      `codegen/wat/AGENTS.md`, `modules/std-wasm/AGENTS.md` § The heap (superseded)

**Impacted tests:** every wasm snapshot and `run/` cell; `test-libs` wasm column; `test-web`. **Consumer commits:** none.

- [x] wasm refuses a call of a generic type's method whose body needs its type parameters bound (900 (3)):
      `d.display()` and `print(d)` of a `Dict<string, f64>` built in std, read in another module — "the wasm backend
      cannot call the generic `Dict.display` here: nothing at this call binds the type parameters its body needs bound
      (a type parameter's slot is not monomorphised)"; cell `generic_type_value_carries_shapes` (900) red on wasm alone
      until this lands. **Landed** (machine-2, 2026-11-02, decision 1101 (1)-(3), after front 229 s1/s2 made
      `__print_tagged_raw`'s walk degrade per type): the cell's bare case and the real `Dict<K,V>` repro (a generic
      wrapper calling `print(d)` with nothing bound, and `d.display()` directly) both answer as commonJS now on all
      four targets, re-run and confirmed clean (no `.snap.new` written)

- [x] wasm refuses a method's own type parameter bound to `f64` (985): `mapValues` from `i32` to `f64` — "the wasm
      backend would narrow an `f64` value to an `i32` slot it does not fit" at the lambda; cell
      `generic_method_own_parameter_takes_shape` red on wasm alone. **Landed** (machine-1, 2026-11-03, front 229 s4):
      the method's specialised copy was built but the lambda's expectations read the unspecialised one, so the lambda
      argument's own type parameter had no type and the module fell to linear, where the refusal fired; the
      specialised copy is now read first. The cell is green on wasm and commonJS

- [x] wasm: packages loaded side by side (982's folded module, `compiler.load` of each case) broke three cases that
      answer alone — `case_arm_record_named_like_a_variant`, `case_record_field_null`, `case_union_constructor_arms`.
      **Answered** (machine-2, 2026-11-03, after front 229 s1 and 1096 landed): the three, loaded side by side with
      only themselves in the package, answer their accepted snapshot on wasm (the method checked by corrupting one
      expected line, which failed). The whole `case` package is still refused on wasm for another case's gap
      (`case_alternatives_and_arrays`' `array.slice`), which is front 229 s8's

- [x] wasm: a call to `failure.attemptTask` imported under an alias of its own (`import {failure.attemptTask as x}`)
      loses its `await`; through `import {failure as f}` it awaits (found building 990 piece 2); a cell on four
      targets, red on wasm — **landed** (machine-2, 2026-11-02): `calleeSymbol` (`codegen/wat.zig`) now resolves
      the alias before its `fn_sigs`/`locals` lookup, the same as every other call site in the file. No cell: the
      bug only reproduces as a bare top-level program, not through `compiler.load`'s folded `cases/` shape, and
      the old `cells/` shape is no longer checked by anything — the gap is filed as its own row, B-205


**P5, the linear lowering deleted — its pieces** (planned by the fable, 2026-11-03; decided by 1105). Each piece shrinks the count of `lowered .linear` notes, and none may grow it. Each one carries a `wat.zig` unit test per gap reason it removes, red on the parent.

- [ ] **P5-a, measurement** (sonnet, machine-2): the `lowered .linear` notes counted over every conformance member and `libraries/`, on wasm (`botopink run --target wasm`, stderr grepped for `^wasm: .* lowered \.linear: `), and posted here as a table per reason. It is re-run after each piece.
- [ ] **P5-b, the boundary** (sonnet, after 229 s8): `array.*` written as hand-written `.wat` leaves (1105 (2)); every other std-wasm export a GC module reaches given a marshallable type or listed for s10. Oracle: `conformance/modules/case` and `import` green on wasm, and no std-marshal gap left.
- [ ] **P5-c, generic slots** (opus, after 229 s4): `gcGenericArg`'s remaining refusals and `gcEqValues`' composite payloads:
  - a `u64` in a tuple, `$box_u64 <: $box_i64`;
  - a generic field of a generic type;
  - a boxed variant.
- [x] **P5-d, type recovery** (sonnet): each "of no known type" / "nothing types" gap answered from the checker's types, across generators, lambda parameters, awaited tasks and empty literals. It also closes s9's "`failure.attempt` over an `i64`". **"an awaited task of a type parameter" (piece 1) landed** (machine-2, 2026-11-03, decision 1105): `bindAwaitedGeneric` reused `genericRetByFnArg`'s own substitution for a generic call's single thunk parameter (`attemptTask<T>(f: fn() -> Async<T>)`, never bound before), and `declareNestedLocals`'s early pre-pass now reads a `for`-loop element's own declared type the same way the real lowering does, so `gcFail`'s first-gap-wins side effect stops poisoning the whole module before the real pass runs. **"an empty array literal of no known type" and "a tuple element of a value of no known tuple type" (pieces 2/3) landed** (machine-1, decision 1105): a GC-gap site now reads the checker's own declared type instead of falling to the deleted linear lowering. Re-measured on the full P5-a corpus (510 members — one more conformance module landed since P5-a's own 509; `disabled.txt` ignored, same methodology): "a tuple element of a value of no known tuple type" **73/25 → 0/0**, fully closed. "an awaited task of a type parameter" **60/60 → 19/19**, all 19 left in conformance modules (0 libraries), every one at the same site — the decision-989 harness's own `await loaded.run()` over a comptime-loaded case's reflected async return, a different generic-resolution path than piece 1's thunk-parameter shape, which doesn't reach it. "an empty array literal of no known type" **301/24 → 366/28**, now library-only (0 modules), every hit the same site (`rakun-bpp/src/element.bp:29:5`'s `children: []` against the builtin `Children` union/coercion type, not a plain declared array type) — the count rising rather than falling is very likely first-gap-wins unmasking (these libraries plausibly already fell to `.linear` under a different, now-fixed reason, and this is the newly-exposed first one), not a regression, though this isn't directly confirmed. The two residuals stay P5-d pieces (the maintainer): see below. The other remaining P5-d gaps (generators, lambda parameters, s9's `failure.attempt` over an `i64`) are still open.
- [x] **P5-e, control shapes** (sonnet) — **piece 2 landed, piece 1 (the `convert ref` residual and the `binding`-expression gap) landed by 229 s8; the optional-binder text below was wrongly retracted and is reinstated**:
  - an inlined lambda's endings;
  - defer arms;
  - a `yield` naming an enclosing scope;
  - destructuring;
  - `is` over a tuple;
  - an optional all-unit enum;
  - the `convert ref` that remains after 229 s7 — **closed, front 229 s8**: `case_arm_ending_in_for`'s own `Many(vs)` arm (decision 1097's `emitConvert` gap, a bare `for` over an array with no accumulator) now lowers in GC form, scoped to that one call site; red on the parent, green after;
  - "the wasm backend has no lowering for a `binding` expression" (`ast.Expr.binding` — a plain local declaration/assignment in expression position, distinct from the optional-binder text below) — **closed, front 229 s8**: now has a GC lowering of its own (run the statement, answer the neutral value; decision 1021 (10)'s existing rule generalised past the one `assign` case it was scoped to); confirmed at 0 occurrences across the full 510-member corpus, and the literal text no longer exists anywhere in `modules/compiler-core/src/`;
  - "a binding over a condition that is no optional" — **reinstated, 2026-11-04**: the 2026-11-03 retraction ("zero before and after P5-d's own landing, eight hand-built repros all fine") does not survive a full-corpus sweep taken after 229 s8 landed. Live at **36 occurrences in 32 members** on the corrected 510-member corpus (443 modules + the 67-library corpus, fixed below). The dominant site is a genuine, reproducible bug entirely outside the conformance suite: `repository/routing/src/conventions.bp:104:13`, a `??`-with-binding over a condition `optInfoOf` can't classify as optional, reached transitively by every library depending on `routing` (31 of the 32 members — `actions`, `blog`, `rakun-ssr`, …); the remaining member is the conformance corpus's own `decisions-taken/mixed_literals_infer_union-150`'s `array_literal_numeric_join` case — the exact site the row's original example named before the retraction. The disagreement with the retracting thread's own measurement is unreconciled (plausibly a different binary, or a corpus missing members at the time), but this sweep is the one to trust. Not fixed; stays this piece's own open item, unowned.
  - **landed** (machine-2, 2026-11-03, decision 1105, B-206): a loaded case's own gap or refusal now reports its own file and line (`Emitter.refuse`'s `loaded` field, `loadedDeclFile` decoding the same `compiler.load()` package-path encoding `printLinearNote` already decoded), never `foreign_origin`'s synthetic site (the generated `run()` import's folded line, `comptime/load.zig`'s `withRunImports`) — a new `Diagnostic.TypeDiagnostic.origin` field (already existed, unused by this path before) carries it. Verified against two live corpus members. A `wat.zig` unit test, red on the parent, green after.

  It also closes s9's "a GC module with exceptions keeps the checked site in GC", which is likely stale: verify it.
- [ ] **P5-f, helper groups** (sonnet): each prelude group with no GC form is given a GC twin or proven unreachable from GC.
- [ ] **P5-g, typecheck gaps** (opus): every GC type-check diagnostic fixed at its lowering. rakun-stylesheet's module (s9's third box) is the oracle.
- [ ] **P5-h, the deletion** (sonnet), only when P5-a reads zero, `libraries/` included:
  - goes: `repr.Mode`, the `.linear` attempts and their notes, and the linear twins of the prelude;
  - a gap is the one located refusal of 1105 (1), and an unreached gap a stub;
  - comptime answers the same refusal (1105 (4));
  - the wasm snapshot corpus is every module in GC (1105 (3));
  - stays until s10: `memory`, `alloc`, the std marshal and `std_wasm_link`;
  - a program function that touches memory is a compiler bug.


**P5-a's table** (machine-2, 2026-11-03): `zig build`, then every `conformance/modules/` workspace member (442, via its own root package, `.linear` notes go to stderr, grepped per member) and every `botopink packages --list` library (67, via `conformance/run.sh`'s own `lib_one` harness replicated in a scratch package per library, `BOTOPINK_LIB_ROOTS` unset so the walk-up resolves) — 509 members total, `--target wasm`, `rm -rf .botopinkbuild` first each time. 39 distinct reasons, 1040 raw occurrences, 186 distinct members hit at least one (119/442 modules, 67/67 libraries — every library hits the universal "an awaited task of a type parameter" harness note).

| Total | Members | Reason | Example |
|---|---|---|---|
| 301 → 366 | 24 → 28 | an empty array literal of no known type *(P5-d piece landed, raised to its own residual piece above — not re-fixed as a row)* | `modules/untyped` — `cases/untyped_array_float_push/src/main.bp:11:5` (pre-fix example; the residual is library-only) |
| 288 | 24 | a declaration of `…`, a module this backend refused *(cascading, not a root cause — fires once per module importing an already-refused one)* | `modules/decisions-taken/unreached_unlowerable_function_ignored-531` |
| 87 → 245 | 40 → 51 | **convert ref** *(front 229 s7's box, and its `case_arm_ending_in_for` residual — both landed; the rise is first-gap-wins unmasking, not a regression: fixing other 229 s8–s10 gaps let several library-closure modules reach this text as their new first-reported gap once their old one cleared — measured on the corrected 510-member corpus, library-corpus fix below)* | `modules/embed` — `cases/embed_field_read_other_module/src/main.bp:11:5` |
| 73 → 0 | 25 → 0 | a tuple element of a value of no known tuple type *(P5-d piece 3 landed — fully closed, re-measured on the full corpus)* | `libraries/validation` — `src/json.bp:187:13` |
| 60 → 19 | 60 → 19 | an awaited task of a type parameter *(P5-d piece landed, raised to its own residual piece above)* | `modules/component` |
| 47 | 24 | the GC module does not type-check: a number where a reference was taken | `modules/decisions-taken/comptime_reflection_types_at_runtime-1071` |
| 43 | 42 | the GC module does not type-check: a value of another type | `modules/array` — `__panic_raise` in `cellOf` |
| 28 → 36 | 26 → 32 | a binding over a condition that is no optional *(reinstated 2026-11-04, after a 2026-11-03 retraction proved wrong under a full-corpus sweep — see P5-e above for the real dominant site, `routing/conventions.bp:104`, outside the conformance corpus; measured on the corrected 510-member corpus)* | `repository/routing/src/conventions.bp:104:13` |
| 25 | 25 | a try over a Result of no known shape | `modules/decisions-taken/brace_without_arrow_is_block-525` |
| 24 | 20 | a host-backed function with no wasm binding | `modules/behavior` — `panic` |
| 10 | 10 | a bare variant name more than one enum declares | `modules/enum` |
| 8 | 6 | an array whose elements disagree with its class | `modules/record` |
| 6 | 6 | internString *(unfiled)* | `modules/fn` |
| 6 | 6 | a field of a receiver of no known record | `modules/async` |
| 4 | 4 | box_i32 | `modules/hof` |
| 3 | 3 | a tuple element of no known type | `modules/optional` |
| 2 | 2 | the wasm backend cannot resolve the call: no function/method/variant/function-value answers it | `libraries/snap` |
| 2 | 2 | a payload of no declared type | `modules/lambda` |
| 2 | 2 | a lambda parameter nothing types | `modules/decisions-taken/fn_tail_value-409` |
| 2 | 2 | **a call of std-wasm's `array.slice`, which has no GC marshal** *(front 229 s8's box — landed)* | `modules/case` — `cases/case_alternatives_and_arrays/src/main.bp:13:5` |
| 1 each | 1 each | 20 more singleton reasons (i64→unknown narrowing — **landed, front 229 s8**, which also exposed and then closed "the wasm backend has no lowering for a `binding` expression" at the same site, see P5-e above; no iterable-walk form; the await-resumed-twice note (392); no string/array-method lowering; optional-container/no-print-shape; optional-all-unit-enum; `is` over a run-time type token; `at` over no known array type; array-of-another-shape in a type-param slot; array-literal no element type; `spawn_all` over thunks of no known type; run-time type token; `next()` with no `YieldStep`; loop over no known array type; lambda param of a type with no repr; call through a function value of no known result; `defer` not lowered yet; unbound name) | — |

Not blindly "unrelated" red: of the 75 module build/run failures and 31 library harness failures alongside this, 40+2 are cascading consequences of a sibling module's own `.linear` fallback (in scope for 1105), 18 are genuine runtime traps with no `.linear` note at all (pre-existing wasm runtime bugs, out of scope), and the rest are target-exclusion audits or unrelated refusals. Full raw data and methodology kept by the thread, not committed (scratch).

**The library corpus was mismeasured at 55, not 67, from some point after the 2026-11-03 baseline** (machine-2, 2026-11-04, per the maintainer's ask): six stale, pre-absorption repository clones sat on disk in `repository/` — `dbcontext`, `emilia`, `erika`, `jhonstart`, `onze`, `styled`, already documented in this repository's own `AGENTS.md` as no longer repositories of the meta — each name-colliding with its real, current equivalent (`blog-ssr` and `document-shell`, both resolved under `rakun`, among others) and marking both the stale and the real package `not-a-package` on the collision. Removed (each one clean, fully pushed to its own remote, no local changes — confirmed before deleting). `botopink packages --list` from `conformance/libraries/` now answers exactly 67 again, matching the baseline. Only the `convert ref` and `a binding over a condition that is no optional` rows above are re-measured against the corrected, 510-member corpus (443 modules + 67 libraries); every other row still reflects the 55-library corpus and may undercount — the full table is due for a complete re-run, not done here.


**The bounded-memory box above ("every `run/` cell's `.out` on wasm unchanged; a long-running cell … bounded; … marshalled at the boundary, measured") is closed by front 230** (the maintainer, 2026-11-03):
- s1: a store limiter bounds the GC heap, and decision 544's four cases complete under a 2 MiB cap at 10× the linear table's trap point.
- s2: 448's growth table re-measured under GC, now at the engine's 64 KiB floor; the std-wasm boundary's marshal measured, 47 functions marshalling and 15 leaves free.
- The `run/` cells no longer exist (989's in-process modules replaced them), so "every `.out` unchanged" reads as the modules' answers. Those are tracked by P5 and s11.
- Read that box as done; it stays unticked only because this note is appended rather than the section rewritten.


**P5-d's two residuals** (machine-2's re-measure on P5-a's corpus, 2026-11-03). Both stay inside P5-d, as pieces of their own (the maintainer):
- [ ] **P5-d, an awaited task at the in-process harness** (machine-2, sonnet): 19 notes in 19 conformance modules, every one at the 989 harness's `await loaded.run()`, over a comptime-loaded case's reflected async return. It is another generic-resolution path than the thunk parameter's: the reflected `Async<Result<string, RunFailure>>` (989 (2)) must bind from the loaded module's own signature. Oracle: the reason at 0 on the corpus; a `wat.zig` unit test red on the parent
- [ ] **P5-d, an empty array where the expected type is a union or coercion type** (machine-1, sonnet): 366 notes, libraries only, all at `rakun-bpp/src/element.bp:29:5`, `children: []` against `Children`. The checker's expected type for an empty literal is a union or coercion type, not a declared array, and the GC lowering must take the array member the checker chose. **First confirm that the rise from 301 to 366 is unmasking, not a regression**: on the parent commit, the libraries that now hit it must have fallen for an earlier first reason. Oracle: the reason at 0; a unit test red on the parent

### s8 — `defer` on wasm: every exit 539 (3) names (was 164 s2b; decision 539)

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** s7 (this front, the same codegen)

539 landed on wasm with four gaps, each a cell red on wasm (never a `snapshot/targets/` departure) until its box lands.

- [x] a panic in a block or `case` arm runs the arm's defers with exceptions on (a panic region covers more than
      statement lists and the function's own body)
- [x] a `defer` inside an inlined higher-order lambda, or an `if` branch answering a value, built on wasm
- [x] a `val` shadowing, after the `defer` in the same block, a name the deferred code reads: the deferred code reads
      the binding in scope at the `defer` (names bind there, only the value is read late — 539's amendment)
- [x] a deferred statement that panics on an inline exit path inside an enclosing region runs once (`attempt` around
      a `return` with a panicking inner defer)
- [x] question 539-b's answer, decision 597: a function holding a `defer` adds `.exceptions` to the program's `needs`.
      It already held on wasm (a function with a `defer` asks for exceptions itself, and 518 (2)'s reachability pass
      carries that into the module's `needs`). What was missing was a guard: a `wat.zig` unit test for a bare `defer`
      with no `attempt`, since the cross-target cell cannot observe wasm's own `needs`

### s9 — 537 and 541 on wasm (was 164 s2c)

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** s7 (this front)

Each box a cell on every target, out on wasm (never a `snapshot/targets/` departure) until it lands.

- [x] `continue` inside a block or a `case` arm in a loop builds; cell `block_continue_reaches_loop`
- [x] `await tasks[1]!` on an array of tasks answers the task's value; a `[]!` line in `await_postfix_binds_tighter`
- [x] an abort's text (535): `panic` / `@todo` / `assert` write `panic: <message>` — cell `abort_text_panic` on the
      four targets, its `message` binding removed (144 B-90)
- [x] an integer overflow and an integer division by zero write 527 (3)'s checked message (the operator, the type,
      `file:line:col`), not a bare trap — the site a message argument on each checked call in both lowerings, raised
      through `panic_raise` when the module has exceptions; under `attempt` the trap answers `Error(panic)` and the
      program goes on (492); `int_division_by_zero_is_panic`'s wasm departure deleted, an overflow line in
      `std_failure_attempt_abort_kinds`, `abort_text_overflow` for the uncaught text
- [x] `INT_MIN / -1` writes 527 (3)'s overflow message, i32 and i64, caught by `attempt` — a line in
      `abort_text_overflow`, `int_division_min_by_minus_one`'s wasm departure deleted
- [ ] a GC module with exceptions keeps the checked site in GC (today it falls back to linear memory for it:
      `panic_raise` has no GC form)
- [x] an untyped fn expression with a `string` parameter writes its text (`fn(s) { return s + "x"; }`; found by 144
      B-116 P1) — typed by its arguments as a closure local's call is (`gcValueCall`, `inlineCallIsString`); cell
      `fn_expression_string_parameter` green on every target
- [ ] `failure.attempt` over an `i64` answer (today refused on wasm: "would narrow an `i64` value to an `i32` slot") —
      an `i64::MIN / -1` line in `abort_text_overflow` under `attempt`
- [x] a field read on a record the module does not declare is placed — cells `embed_field_read_other_module` and
      `declared_field_read_other_module` on wasm, their `through` host binding and `targets` narrowing removed (144
      B-95, B-97)
- [x] a loop's label read (`break :outer`, `continue :outer`) — cells `block_jump_label_reaches_loop`,
      `block_jump_label_continue_reaches_loop`, `block_jump_label_continue_nested_shapes`; a bare `return` in a
      yielding arm ends the generator, not the arm — cell `case_arm_return_in_yielding_arm` (144 B-88)
- [x] `val f: ?f64 = 5.0; f?.toString()` answers `5.0` — a line in `optional_chain_string_text` (144 B-78's Conformance)
- [ ] rakun-stylesheet's module lowers on wasm: every rakun-stylesheet cell fails the narrowing audit, wasm refusing
      it with `type mismatch: expected i32, got void` rather than a missing host binding (measured before s7 too) —
      rakun-stylesheet's cells (in rakun, front 165) audited green, wasm then in their targets

### s10 — std-wasm rewritten: its logic in botopink, its leaves in hand-written `.wat`; `std_wasm.wasm`, `heap.zig` and beam-to-wasm deleted (was 164 s3; the maintainer, 2026-10-14; wasmgc-a)

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** s7 (this front)

Pieces (each keeps every wasm cell's answer and every comptime reply): P0 the `.wat` reader, the leaf table and a
`std:` cell naming a leaf (beside s7) · P1 `text.*` in botopink over leaves · P2 `array.*`, an integer's text,
`encoding.*`, `hash.contentHash`, `random.*` · P3 a float's text (one leaf), `bigint.*` in botopink · P4 the comptime
compiled straight by the GC backend, its Erlang layer and term library deleted (550) · P5 `io.fs` on
`wasi:filesystem` (after s7 P4) · P6 the deletions and the docs. P1–P4 flip wasm once s7 P5 has deleted the linear
lowering. Rules: a leaf names the codegen's GC types (549); a piece re-records its `COMPTIME WAT` and reads the diff
(558); a dependency's function, std's included, is one line with its hash in every snapshot (558 (1)); a `String`
method moving to botopink is bound on wasm by a `#[compiler.external(.Wasm(body: …))]` cell, wasm alone (565), after
s7 P5 (566). Question 164-s3-g.

Landed: P0 (the reader, the leaf table, `text.length` and `text.charCodeAt` as leaves; a `std:` leaf with no std-wasm
export has its signature check written but unexercised until P1 adds one). P1-a (leaves `text.byteLength`,
`text.byteAt`, `text.byteSlice`, `text.fromCodepoint`, each with a twin std-wasm export of the same name and types so a
linear-fallback module still builds; proved by a GC-module unit test on wasm, since 445 refuses a `std:` cell outside
`libs/std`; their four-target cells come with the `String` method that binds them — P1-b, P1-c, after s7 P5, 565, 566;
`slice` with P1, 879). P1-b, P1-c: the prelude binds `true` / `false` first and hides a private bodied prelude `fn`
from programs after inference (`primitives.bp` is a core file flattened into the global environment — free bodied fns
there broke std's compile on every target until this); a `String` method whose wasm cell is `fn:` lowers as a call of
its private `primitives.bp` body, adopted with the private fns it calls (565, read literally); the 18 bodies sit in
`primitives.bp`'s trailing section, bound by nothing until P1-d (566). P1-d: the bodies' names mangled and their
locations `std/primitives.bp`'s (else an adopted body's panic names the program's file with `primitives.bp`'s line,
and a program `fn textFindFrom` captures the call). P2-a: an integer's text as leaves (`wat/number.wat`:
`number.i32ToString`, `i64ToString`, `u64ToString`); a GC module's integer printing calls them, no std-wasm marshal left.

- [ ] **the logic in botopink:** string, array, Dict, hash, Unicode (its case tables generated by `gen-unicode` and
      embedded by `compiler.embed`, 559, 607 — `compiler.embed` inside std reading std's files first, if it does not),
      number text (441), the comptime's preludes and reply codecs (550: no Erlang layer) — `.bp` modules of std compiled
      by the compiler itself, module by module, each module's cells green before the Zig function it replaces is deleted
- [ ] **the language's runtime in `.wat` (560), after s7 P5:** `wat_prelude.zig`'s functions (printing, panic and
      abort, comparison, the task scheduler, `bp_ready`, the `unknown` and `Dict` helpers) moved to hand-written `.wat`
      files read by the `.wat` reader; Zig keeps the GC type table and the choice of what a program links; the reader
      reads imports, the exception tag and globals; every cell's answer the same
- [ ] **the leaves in `.wat`, written by hand — no generator writes one (559):** `modules/std-wasm/wat/`, one file per
      leaf or small group, named functions, comments — a byte read or written, a GC array made, a float's text, what no
      `.bp` form reaches —, each function bound by a `std:` cell, proved by a conformance cell on the four targets,
      within 442's scope; no wat inside Zig, no wat generated for a fixed leaf (Zig builds `wat_ast` only where
      emission is parametrized: the codegen, `wat_prelude`)
- [x] **the `.wat` reader:** the compiler reads a `.wat` file into its `wat_ast` (an s-expression reader of its own,
      no tool) and transpiles it as 440 transpiles std-wasm today; a `.wat` that does not read is a located error
- [ ] `io.fs` importable on wasm: a module whose body calls a host function with no wasm binding builds, and only the
      call is refused (518 (4)); `io.fs` on `wasi:filesystem` (540, `needs: [.Filesystem]`) — today the whole module is
      refused (`std_fs_walk_root_spellings`' wasm departure), and the six `fs_*` cells of 540 leave wasm out
- [ ] **deleted at the end:** `modules/std-wasm/src/*.zig` (`std_wasm.wasm`, `heap.zig`, the term library) and
      `modules/beam-to-wasm/` (452's standalone utility, built on the own heap, used by no botopink build); `zig build
      std-wasm` goes; `modules/std-wasm/` holds `wat/` alone
- [ ] every comptime snapshot's `COMPTIME REPLY` and every conformance cell unchanged — one text on every target
      (434 (5)); each piece's `COMPTIME WAT` re-recorded and its diff read against what the piece changes (558)
- [ ] docs: 440, 450, 452 amended in the reference's "Decided" table; root `AGENTS.md`, `modules/AGENTS.md`,
      `modules/std-wasm/AGENTS.md`, `libs/std/AGENTS.md`

**Impacted tests:** every comptime snapshot (the reply unchanged, the listing re-recorded by piece, 558), `test-conformance`, `test-libs`, `test-web`. **Consumer commits:** none.
- [x] P2-d's leaves trap outside their domain (880): `bytes.wat`'s `at` the bare `array.get_u`, `ofWords`
      `unreachable` past 255; the unit test's in-domain run and three traps; no `.bp` codec calls the leaves yet
      (`encoding.bp`, `hash.bp` use `Bytes`' methods), so none needed a bound

### s11 — Conformance, front 164's last step (was 164 s4; decisions 459, 474, 477, 478, 479, 480)

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** front 164's s1 (landed), s7, s9, s10 (this front)

After s7, s9 (537/541) and s10 have landed on `feat`; it holds back no front that builds on them (479).

- [ ] `feat`'s GitHub pipeline green after the group landed (477): `scripts/gate.sh` with conformance, every cell on
      every target it declares; a red reproduced locally, fixed at once (430), pushed again; no cell edited to match
      the compiler
- [ ] for each red, the cheap test the hook already runs that would have caught it, red on the breaking commit and
      green on the fix (478) — or the report says why none can
- [ ] the group's changes analysed together against the cells (a table here); the cells they call for written in
      decision 457's shape (a bounded long task, an `attempt` at build, a `.wat` leaf's answer on four targets); the
      missing ones proposed as rows

### s12 — Conformance, front 165's last step (was 165 s7; decisions 465, 477, 478, 479, 480)

**Repository:** rakun · **Model:** opus · **After:** front 165's s5 and s9 (both landed, in front 165)

- [ ] `feat`'s pipeline runs `botopink cell check conformance/` over the whole `rakun/conformance/` green; every red
      reproduced locally and fixed at once (430); for each, the cheap test the hook runs that would have caught it
      (478); the reference (`docs.md` beside each cell) updated (480)

### s13 — rakun's timing tests on a controlled clock, never the wall clock (was 150 s25; measured 2026-10-11)

**Repository:** rakun (`--repo rakun`) · **Model:** sonnet

Under the botopink-lang gate's load (one job budget 8 / 4 / 1 / 1, load 28–30 on 16 cores), three rakun tests go red
that pass alone — a verdict that depends on the machine's load, not on the code (decision 67):

| Test | Where | What waits on time |
|---|---|---|
| watcher: "one touched file is one reload" | `rakun/modules/rakun-data/test/devtools/devtools_test.bp` | a 40 ms poll and a 200 ms sleep; 1 red in 4 cold gates |
| "over max-connections answered 503" | `rakun`, erlang | the response's timing |
| the dlq test | `rakun-messaging`, erlang | the redelivery's timing |

- [ ] each test drives a controlled clock the test advances (a test clock source behind `io.clock` and the timers
      the code under test reads), never a real sleep or poll; its assertions unchanged
- [ ] measured: each test green in every run of the botopink-lang gate at its busiest split and alone
- [ ] if std offers no controllable clock source, a `language-gaps.md` row naming the 144 step that adds one, and
      this step pauses on it (rule 9, decision 430) — no rakun-local workaround
