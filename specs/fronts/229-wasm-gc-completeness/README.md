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

- [x] `finishGc` stubs any unreached, non-exported, memory-touching function — today only one in `gc_linked_fns` — so a module's own dead function no longer forces the whole module linear; the stub's `unreachable` carries the gap's text
- [x] `emitWatPass` tests `refused_modules` after `pruneUnreached`, and only when a reached declaration belongs to the refused module — an importer no longer falls to linear because a linked module has an unrelated refusal in a function it never calls (B-203 is one instance; 1096 may no longer be needed once this lands — re-check it)
- [x] attribution: `emit` records the first `.load` / `.store` in `.gc` mode with `stmt_loc` and the function; the `typecheck` gap carries `diag.func` / `what` outside `gc_debug`; `stdRepr(.void)` goes through `gcFail`; `emitStdCall`'s gap names the call site, not the std function; `gcShapeVt` and `vtOf`'s `else` stop recording a gap and lowering on with a dummy type. The 1097 note and the `gc_only` refusal print all of it
- [x] oracle: the count of `lowered .linear` notes over a full conformance run shrinks and never grows; a unit test that an unused own `throw`-in-`case` function leaves the module GC; B-203's 67 masked modules re-counted

### s2 — printer and equality over the prelude's types; enum display

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** 1099 (same printer functions)

- [x] `__print_tagged_raw` / `gcUnkPrint` answer a `$closure` (`fn/<arity>`), a `$result` (payload through `$__unk_print_raw`, quoted when nested, decision 1021 (10)) as commonJS prints them; a `$task` / `$gen` panic by name instead — their static print is already its own, separate gap (falls to `.linear`, the wrong raw value), so there is no commonJS answer to match dynamically either
- [x] `gcEqValues` compares a record or variant field typed `unknown` with `$__unk_eq` instead of falling the module back
- [x] an enum or variant value's own `display()` is dispatched in GC mode: `gcDeclPrinter`'s `variant == null` condition and the `$__tinfo` display slot's `t == .record` removed
- [x] oracle: proved by `wat.zig`'s own unit tests, not a conformance cell (none of the three sub-fixes carries a decision number of its own) — `"wat: gc ---- an enum's own display is dispatched statically and through unknown, generic or not"`, `"wat: gc ---- equality over a field typed unknown compares structurally, not a module-wide fallback"`, `"wat: gc ---- a closure and a @Result held unknown print as commonJS prints them"`, `"wat: gc ---- a Task or a generator held unknown panics by name"` — each red on the parent (a trap or the wrong text), green after; `zig build test` and `test-cli` full, `analysis_equivalence.sh` unchanged at its 21 known rakun failures
- [x] decision 1104 (filed as pending 229-a, answered): a Task / generator's print is refused at build on all four targets where the type is statically known (directly or through a generic parameter), `print-task` / `print-generator`; through `unknown` the same named panic text replaces each target's own native inspect. Piece (1), the checker's build refusal, landed first; piece (2), the same panic text through `unknown` on commonJS, erlang and beam as on wasm, landed after

### s3 — GC forms for the remaining control shapes

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** nothing open

- [x] `try … catch { }` (`lowerRegion`) in GC form (`gcLowerRegion`) — a `$result` ref in the region's `err` local in place of the linear lowering's slot address; `gcTryPropagate`'s region branch, `gcBindResultErr` for the binder
- [x] `spawn_all` over thunks answering scalars boxes the answers (`gcSpawnAllAnswers`'s own refusal lifted) — unblocked by extending `bindAwaitedGeneric` to resolve a generic parameter nested inside a declared parameter's type (`array<fn() -> Async<T>>`, `arrayThunkAsyncParam` / `arrayLitThunkTaskValue`) and to accept a namespace-qualified call; the task's runtime value stays the generic body's erased `arr_any` even once `T` is known, unboxed element-wise (`gcUnboxArr`, `GcSettled.boxed_arr`); `isArrayExpr` / `elemKindOf` / `printShapeOf`'s own shape reads needed the same early, side-effect-safe peek (`gcPeekAwaitedArr`, saving and restoring `gc_gap` around it). `race<T>`'s own gap ("convert ref") stayed out of scope, a separate row
- [x] ~~`$box_bytes`, modelled on `$box_big` (1031 (2)), so `Bytes` can sit in an `unknown`, union or type-parameter slot; arms in `__unk_eq_ref` and `__print_tagged_raw`~~ — withdrawn (machine-2, 2026-11-03): step 520 (B-12-a) already, explicitly and recently, refuses `Bytes` widening to `unknown` on all four targets ("Still refused: `Bytes` widening to `unknown`... A printed form chosen by the static type... is a later decision that only accepts what is refused today") — measured directly, the same refusal fires for a bare `print(b)` and for a generic `Box<T>(value: T)` instantiated with `T = Bytes`, no narrower loophole at a type-parameter slot. This box's premise conflated front 170 s7's "types" checklist item (`Bytes` an `i8` array, decision 346 — already true) with widening it to `unknown` (520's own, separate, still-standing refusal) — nothing wasm-specific to build here; a four-target semantic change (520 superseded, 346 → a `$box_bytes` the way 1031 (2) did for `bigint`) is a decision of its own, not this box's
- [x] oracle: the region and spawn_all boxes each have their own unit test, red on the parent, green after (`"wat: gc ---- a try … catch region..."`, `"wat: gc ---- spawn_all over thunks answering scalars, i32 and f64"`); `$box_bytes` withdrawn, no oracle needed. The linear region lowering is P5's to delete

### s4 — generic-slot element classes

**Repository:** botopink-lang (`--lang`) · **Model:** opus (a representation choice; it meets decision 568's tuple subtype) · **After:** 1099

- [ ] decided (the fable, 2026-11-03, under 568 and 1031 (2), no new decision): a fourth `Repr.Elem` `arr_bool`, a GC subtype of `$arr_i32`, not boxing into `arr_any` — then lift `gcGenericArg`'s print-shape refusals (a bool array, a nested array, a tuple holding a bool or unit enum, a named word array into `Array<T>` through `gcArrBox`); a tuple holding a `u64` stays refused (its own row when it bites: `$box_u64 <: $box_i64`)
- [ ] oracle: `Box<bool[]>`, `Pair<#(bool, i32), string>`, `Box<i32[][]>` and `Box<bool[][]>` print as commonJS, a named `i32[]` passed into `Array<T>` too, `Box([true]) == Box([true])` answers `true`, a `bool[]` through `filter` into `Box<T>` prints `[true]`; front 170 s7's "an array of tuples in a type-parameter slot" closes with it
- [x] decision 985's wasm half: a method's own type parameter bound to `f64` (`d.mapValues({ v -> 2.0 })` on a `Dict<string, i32>`) is refused "would narrow an `f64` value to an `i32` slot" — the answered value's slot is sized by the receiver's `V`, not the method's `W`. Same region and owner as this step (generic slots' representation); closes front 170 s7's 985 box, cell `generic_method_own_parameter_takes_shape` green on wasm (moved here 2026-11-03: 1101 fixed the print path, not this)

### s5 — low priority: a bare variant name two enums declare

- [x] resolved per site through the expected type instead of a module-wide gap (named by 1058 (4)): a bare variant in a `case` pattern takes its enum from the subject (`declareNestedLocals`, `emitArmChain`); a bare variant in value position was already qualified by the checker before codegen. Proved by a `wat.zig` unit test, red on the parent and green after

### s6 — GC type-index allocation depends on the link set

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** nothing open · machine-2's (found building 1096)

Adding one declared fn with a `.Wasm(body: …)` to a widely linked dependency (`conformance/lib/candidate.bp`) breaks two multi-module join cells at wasmtime instantiation: `type mismatch for export set:entries … expected (func (param structref)), found (func (param arrayref))` — `declared_dependency_modules_join_program-660`, `no_declaration_files_compiler_value-575`. A module's GC type indices shift with what else is linked, the same shape as front 228 (decision 509: a dependency's output depends on its closure alone) but a different mechanism (front 228 was function crossing; this is type numbering).

- [x] a module's GC type section and the indices its exports name are a function of its own closure, never of what else joins the program
- [x] the two join cells green with 1096's added fn in place (green on four targets); 1096 landed on top, its own oracle `conformance/lib`'s `candidate_test.bp` (15 / 15 on four targets)

### s7 — one case's GC gap no longer takes a whole package module to linear, where a std `.wat` leaf refuses it

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet (a measured repro) · **After:** nothing open · found by machine-2 checking 1096, 2026-11-03

`conformance/modules/import` on `--target wasm` (origin/feat, clean build) fails whole:
- the package's root module `main` folds every case;
- it falls to `.linear` for one case's own gap: `convert ref` at `cases/import_behavior_named_like_prelude/src/main.bp:32:5`;
- then `import_std_groups`'s direct `import {io.fs, …} from "std"` reaches `fs.cwd`, a `.wat` leaf of std-wasm that a linear module cannot call, and the whole module is refused.

The same mechanism as 1096, but through a package's own import, not the scaffold. Both halves are this front's theme:
- a local GC gap must not move the whole module to linear;
- the `.wat` leaf refusal is only reached because it did.

- [ ] `convert ref` at `import_behavior_named_like_prelude`'s line 32 lowered in GC form (or degraded per function, s1's stub), so `main` stays GC
- [ ] `conformance/modules/import` green on wasm, every case; red on the parent

### s8 — std-wasm's `array.slice` marshalled in GC form, so `conformance/modules/case` stays GC

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet (a measured repro) · **After:** nothing open · found by machine-2 re-checking front 170 s7's B-203 box, 2026-11-03

`conformance/modules/case` on `--target wasm` (origin/feat) fails whole. It is the same shape as s7:
- `main` falls to `.linear` for one case's gap: "a call of std-wasm's `array.slice`, which has no GC marshal", at `cases/case_alternatives_and_arrays/src/main.bp:13:5` (the `[first, ..rest]` arm);
- then a narrowing refusal with no location ("would narrow this `i64` value to an `i32` slot", `src/main.bp:0:0`) refuses the module;
- the rest of the package's cases never run. Front 170 s7's three B-203 cases are among them.

- [ ] `array.slice` (a rest pattern `..rest`) answered in GC form: a GC marshal at the std-wasm boundary, or the slice lowered in GC without the boundary, so `main` stays GC
- [ ] the narrowing refusal that followed located, or gone with the first box (B-206's reading: the note and the diagnostic name the same attempt)
- [ ] `conformance/modules/case` green on wasm, every case. Front 170 s7's box on `case_arm_record_named_like_a_variant`, `case_record_field_null` and `case_union_constructor_arms` is answered by this run; red on the parent

## Collisions

s1 and front 228 both edit `finishGc` and unit emission — 228 has landed, rebase on it. s2 and s4 share `gcDeclPrinter` / `gcGenericArg`'s region with 1099 — after it. s3 collides with nothing in flight.
