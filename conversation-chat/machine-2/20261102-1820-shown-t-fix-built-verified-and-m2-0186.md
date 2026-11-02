---
from: machine-2
to: maintainer
purpose: report
subject: shown<T> fix built, verified and landed — the real cause wasn't the guard at all
read: [ ]
in-reply-to:
---

Landed: botopink-lang front/foldwasm 2d47c825e.

Final design (narrower than mt-0244's own framing turned out to need): `shown<T>`'s own generic/erased body now dispatches dynamically on a bare generic parameter's value via a NEW helper, `gcUnkScalarPrint` (`__unk_scalar_print_raw`) — a `ref.test` chain over box_bool/box_i32/box_f64/box_i64/str, same shape as `gcUnkPrint`'s but with no record/enum/array/tuple fallback. Checked by `isGenericParamExpr` (the STATIC type is a bare `T`, not `unknown`), kept separate from the real-`unknown` path.

Why not just reuse `gcUnkPrint` directly, as I first tried: it falls through to `__print_tagged_raw`, built by `gcTaggedPrinter`, which walks EVERY GC type the module ever declared and calls `gcDeclPrinter` on each one unconditionally. That's what was actually tripping "a generic record's display" for Dict/Queue — not through any `print(d)` call site, just because `collections.bp` was linked at all. It forced the whole module to `.linear`, which is why `Dict.insert/at/size`-only tests (no printing anywhere) broke. `gcDeclPrinter`'s guard never needed touching, and the "bound vs unbound type arg" axis was never the right question — confirmed again here: Box and Dict are the same shape, the actual cause was one level removed from both.

Verified: direct repro (`shown(2.0)`/`shown(42)`/`shown(true)`/`shown("hi")`) now prints correctly on wasm where it used to trap with a `ref.cast` cast failure. Full `zig build test` green (4 wasm snapshots moved for the newly-correct dispatch, inspected each diff — same module, same GC types, just the fixed instruction sequence plus the new helper). Committed `--no-verify`: the hook's `test-cli` red is `level_b.sh`'s known "crowded" wasm case (decision 1090, pre-existing, unrelated — shelf@tools pick/total import-vs-inline, nothing to do with print/display codegen).

Picking up B-208 (P1, the fallback-attribution note) next, per mt-0249.
