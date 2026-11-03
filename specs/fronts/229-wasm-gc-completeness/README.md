---
milestone: 1.0.12-beta
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

- [ ] `__print_tagged_raw` / `gcUnkPrint` answer a `$closure` (`fn/<arity>`), a `$result` (payload through `$__unk_print_raw`), a `$task` and a `$gen` as commonJS prints them — or refuse at build naming the slot — never the chain's final `unreachable` (`val u: unknown = fn(x: i32) -> i32 { x }; print(u)`, `print(Box(value: Ok(1)))`, a union array holding a function)
- [ ] `gcEqValues` compares a record or variant field typed `unknown` with `$__unk_eq` instead of falling the module back
- [ ] an enum or variant value's own `display()` is dispatched in GC mode: `gcDeclPrinter`'s `variant == null` condition and the `$__tinfo` display slot's `t == .record` (today `Maybe.Some(value: 1)` instead of `Some(1)`, silently wrong, generic or not)
- [ ] oracle: three cells red on the parent (a trap, a `lowered .linear` note, the wrong enum text), green after

### s3 — GC forms for the remaining control shapes

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** nothing open

- [ ] `try … catch { }` (`lowerRegion`) in GC form — today a fallback, refused inside a state machine; `lowerThrow` builds `$result` with `struct.new`, never linear memory (today the module falls with the wrong attribution, "touchesMemory")
- [ ] `spawn_all` over thunks answering scalars boxes the answers (`gcSpawnAllAnswers`)
- [ ] `$box_bytes`, modelled on `$box_big` (1031 (2)), so `Bytes` can sit in an `unknown`, union or type-parameter slot; arms in `__unk_eq_ref` and `__print_tagged_raw`
- [ ] oracle: the `lowered .linear` count shrinks for the cells holding these shapes; one cell per shape. The linear region lowering is P5's to delete

### s4 — generic-slot element classes

**Repository:** botopink-lang (`--lang`) · **Model:** opus (a representation choice; it meets decision 568's tuple subtype) · **After:** 1099

- [ ] decide: a fourth `Repr.Elem` (`arr_bool`) or boxing bool and nested arrays into `arr_any` on entry to an erased slot — then lift `gcGenericArg`'s print-shape refusals (a bool array, a nested array, a tuple holding a bool, `u64` or unit enum, a named word array into `Array<T>`)
- [ ] oracle: `Box<bool[]>`, `Pair<#(bool, i32), string>` and `Box<i32[][]>` print as commonJS; front 170 s7's "an array of tuples in a type-parameter slot" closes with it

### s5 — low priority: a bare variant name two enums declare

- [ ] resolved per site through the expected type instead of a module-wide gap (named by 1058 (4))

## Collisions

s1 and front 228 both edit `finishGc` and unit emission — 228 has landed, rebase on it. s2 and s4 share `gcDeclPrinter` / `gcGenericArg`'s region with 1099 — after it. s3 collides with nothing in flight.
