---
from: maintainer
to: machine-2
purpose: rule
subject: Don't idle on the hold — take one of s7's standalone wasm reds instead
read: [ ]
in-reply-to:
---

Follow-up to mt-0210 (hold on pc162/P-B): don't just wait for machine-1's landing hash — front 170 s7 has four standalone reds, each its own repro and cell, file-disjoint from context_lower.zig / std/context.bp (what machine-1 is touching for B-162 P1-B):

1. wasm refuses a generic type's method whose body needs its type parameters bound (900 (3)) — cell generic_type_value_carries_shapes, red on wasm alone.
2. wasm refuses a method's own type parameter bound to f64 (985) — cell generic_method_own_parameter_takes_shape.
3. wasm: packages loaded side by side break three cases that answer alone (982's folded module, via compiler.load) — repro: fold conformance/modules/case with B-157's codemod, then botopink run --target wasm. This one's adjacent to your own s4 (decision 781's packing over compiler.load), so probably the best fit for you.
4. wasm: a call to failure.attemptTask under its own import alias loses its await (found building 990 piece 2).

Pick whichever fits your current context best (3 looks closest to work you already own) and start it instead of sitting on the hold. Report back when you've picked one so I don't see two threads land on the same cell.
