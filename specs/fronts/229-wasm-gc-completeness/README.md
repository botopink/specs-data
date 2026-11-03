---
milestone: 1.0.12-beta
owner: machine-2
priority: maximum
---
# Front 229 — wasm GC completeness: no whole-module fallback for a local cause, no run-time trap where a refusal belongs

Opened by the maintainer, 2026-11-02, from the fable's audit of front 170 s7. Every bug found on s7 that day had one shape: a module-wide decision (the whole module falls `.gc` → `.linear`, the tagged printer aborts, a refusal) triggered by one local construct. This front removes the remaining instances the audit found, none of them filed before. A module cannot be half GC and half linear (two heaps cannot share a value), so the granularity below the module is dead code: an unreached function with no GC form becomes a trap stub with its reason; a reached one stays the module's fallback, named and located.

Function names are `modules/compiler-core/src/codegen/wat.zig`'s unless noted.

## Steps

### s1 — per-function stubbing and gap attribution

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** front 228 (landed; it edits `finishGc` and units)

- [ ] `finishGc` stubs any unreached, non-exported, memory-touching function — today only one in `gc_linked_fns` — so a module's own dead function no longer forces the whole module linear; the stub's `unreachable` carries the gap's text
- [ ] `emitWatPass` tests `refused_modules` after `pruneUnreached`, and only when a reached declaration belongs to the refused module — an importer no longer falls to linear because a linked module has an unrelated refusal in a function it never calls (B-203 is one instance; 1096 may no longer be needed once this lands — re-check it)
- [ ] attribution: `emit` records the first `.load` / `.store` in `.gc` mode with `stmt_loc` and the function; the `typecheck` gap carries `diag.func` / `what` outside `gc_debug`; `stdRepr(.void)` goes through `gcFail`; `emitStdCall`'s gap names the call site, not the std function; `gcShapeVt` and `vtOf`'s `else` stop recording a gap and lowering on with a dummy type. The 1097 note and the `gc_only` refusal print all of it
- [ ] oracle: the count of `lowered .linear` notes over a full conformance run shrinks and never grows; a unit test that an unused own `throw`-in-`case` function leaves the module GC; B-203's 67 masked modules re-counted

### s2 — printer and equality over the prelude's types; enum display

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** 1099 (same printer functions)

- [x] `__print_tagged_raw` / `gcUnkPrint` answer a `$closure` (`fn/<arity>`), a `$result` (payload through `$__unk_print_raw`, quoted when nested, decision 1021 (10)) as commonJS prints them; a `$task` / `$gen` panic by name instead — their static print is already its own, separate gap (falls to `.linear`, the wrong raw value), so there is no commonJS answer to match dynamically either
- [x] `gcEqValues` compares a record or variant field typed `unknown` with `$__unk_eq` instead of falling the module back
- [x] an enum or variant value's own `display()` is dispatched in GC mode: `gcDeclPrinter`'s `variant == null` condition and the `$__tinfo` display slot's `t == .record` removed
- [x] oracle: proved by `wat.zig`'s own unit tests, not a conformance cell (none of the three sub-fixes carries a decision number of its own) — `"wat: gc ---- an enum's own display is dispatched statically and through unknown, generic or not"`, `"wat: gc ---- equality over a field typed unknown compares structurally, not a module-wide fallback"`, `"wat: gc ---- a closure and a @Result held unknown print as commonJS prints them"`, `"wat: gc ---- a Task or a generator held unknown panics by name"` — each red on the parent (a trap or the wrong text), green after; `zig build test` and `test-cli` full, `analysis_equivalence.sh` unchanged at its 21 known rakun failures
- [ ] decision 1104 (filed as pending 229-a, answered): a Task / generator's print is refused at build on all four targets where the type is statically known (directly or through a generic parameter), `print-task` / `print-generator`; through `unknown` the same named panic text replaces each target's own native inspect. The refusal lives in the checker (`infer.zig`, machine-1's lane) — last piece of s2, done after s3

### s3 — GC forms for the remaining control shapes

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** nothing open

- [x] `try … catch { }` (`lowerRegion`) in GC form (`gcLowerRegion`) — a `$result` ref in the region's `err` local in place of the linear lowering's slot address; `gcTryPropagate`'s region branch, `gcBindResultErr` for the binder
- [x] `spawn_all` over thunks answering scalars boxes the answers (`gcSpawnAllAnswers`'s own refusal lifted) — unblocked by extending `bindAwaitedGeneric` to resolve a generic parameter nested inside a declared parameter's type (`array<fn() -> Async<T>>`, `arrayThunkAsyncParam` / `arrayLitThunkTaskValue`) and to accept a namespace-qualified call; the task's runtime value stays the generic body's erased `arr_any` even once `T` is known, unboxed element-wise (`gcUnboxArr`, `GcSettled.boxed_arr`); `isArrayExpr` / `elemKindOf` / `printShapeOf`'s own shape reads needed the same early, side-effect-safe peek (`gcPeekAwaitedArr`, saving and restoring `gc_gap` around it). `race<T>`'s own gap ("convert ref") stayed out of scope, a separate row
- [ ] `$box_bytes`, modelled on `$box_big` (1031 (2)), so `Bytes` can sit in an `unknown`, union or type-parameter slot; arms in `__unk_eq_ref` and `__print_tagged_raw`
- [ ] oracle: the `lowered .linear` count shrinks for the cells holding these shapes; one cell per shape. The linear region lowering is P5's to delete

### s4 — generic-slot element classes

**Repository:** botopink-lang (`--lang`) · **Model:** opus (a representation choice; it meets decision 568's tuple subtype) · **After:** 1099

- [ ] decide: a fourth `Repr.Elem` (`arr_bool`) or boxing bool and nested arrays into `arr_any` on entry to an erased slot — then lift `gcGenericArg`'s print-shape refusals (a bool array, a nested array, a tuple holding a bool, `u64` or unit enum, a named word array into `Array<T>`)
- [ ] oracle: `Box<bool[]>`, `Pair<#(bool, i32), string>` and `Box<i32[][]>` print as commonJS; front 170 s7's "an array of tuples in a type-parameter slot" closes with it
- [ ] decision 985's wasm half: a method's own type parameter bound to `f64` (`d.mapValues({ v -> 2.0 })` on a `Dict<string, i32>`) is refused "would narrow an `f64` value to an `i32` slot" — the answered value's slot is sized by the receiver's `V`, not the method's `W`. Same region and owner as this step (generic slots' representation); closes front 170 s7's 985 box, cell `generic_method_own_parameter_takes_shape` green on wasm (moved here 2026-11-03: 1101 fixed the print path, not this)

### s5 — low priority: a bare variant name two enums declare

- [ ] resolved per site through the expected type instead of a module-wide gap (named by 1058 (4))


### s6 — GC type-index allocation depends on the link set

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** nothing open · machine-2's (found building 1096)

Adding one declared fn with a `.Wasm(body: …)` to a widely linked dependency (`conformance/lib/candidate.bp`) breaks two multi-module join cells at wasmtime instantiation: `type mismatch for export set:entries … expected (func (param structref)), found (func (param arrayref))` — `declared_dependency_modules_join_program-660`, `no_declaration_files_compiler_value-575`. A module's GC type indices shift with what else is linked, the same shape as front 228 (decision 509: a dependency's output depends on its closure alone) but a different mechanism (front 228 was function crossing; this is type numbering).

- [ ] a module's GC type section and the indices its exports name are a function of its own closure, never of what else joins the program
- [ ] the two join cells green with 1096's added fn in place; 1096 lands on top

## Collisions

s1 and front 228 both edit `finishGc` and unit emission — 228 has landed, rebase on it. s2 and s4 share `gcDeclPrinter` / `gcGenericArg`'s region with 1099 — after it. s3 collides with nothing in flight.
