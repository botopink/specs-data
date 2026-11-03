---
from: machine-2
to: maintainer
purpose: question
subject: (c) is deeper than one change: a correct GC-mode refusal gets silently swallowed by emitWat's linear retry, and .linear has its own separate wrong-output bug for this shape
read: [ ]
in-reply-to:
---

Diagnostic only, all reverted, nothing committed. Tried to build (c) as two pieces:

1. `gcUnkScalarPrint`'s call site in `lowerPrintArg`: added `self.refuseUnlessTemplate(...)` before the scalar dispatch — marks the enclosing generic body (e.g. `shown`) as `template_traps`.
2. `gcPrintArg`'s record case (GC mode's own auto-print dispatch to a generic record's `display()`): it never called `noteTemplateCall` at all — unlike `.linear` mode's equivalent path (`recordTypeOfExpr`, line ~15981). Added the same `if (self.generic_methods.contains(dsym)) noteTemplateCall(dsym, loc)` there.

Result, traced with debug prints: this DOES correctly mark and refuse in the GC pass — `print(Box(value: 1))` and the nested-generic chain (`callIt<T> → outerShow<T> → innerShow<T> → shown<T>`) still print correctly (scalars untouched, confirmed), and `Box<Box<T>>` now gets a real `error.WasmLoweringRefused` out of the GC attempt instead of a trap.

But it never reaches the user as a refusal. `emitWat`'s own GC→linear retry (the `else => if (gc_debug) ...` branch) doesn't distinguish a refusal (`error.WasmLoweringRefused`) from a soft gap (`error.GcFallback`) — both just retry in `.linear`. And `.linear` mode, for this exact shape (a bare generic `T` field holding another generic record instance, printed through `shown<T>`), has its own, separate, pre-existing bug: `"" + x` just reads `x`'s linear-memory word as an `i32` and prints the inner record's heap address — `Box(11752)`, silently wrong, no refusal, no trap. (Confirmed this `.linear`-mode bug is independent of my change — it's whatever `.linear` mode has always done for a bare-`T` print that isn't gated by `self.mode == .gc`.)

So landing (c) as scoped doesn't actually produce "refused at build" for Box<Box<T>>/Box<T[]> — it produces `Box(11752)`-style silent wrong output, worse than the trap I found in the first sweep. Two separate things would need fixing together: (i) `emitWat` needs to tell a `.gc`-mode refusal apart from a gap and stop retrying `.linear` when it's a refusal (a change to the retry dispatch itself), or (ii) `.linear` mode's own bare-`T` print needs the same `refuseUnlessTemplate` treatment GC mode now has, so the fallback is also safe. Neither is in scope of what I understood (c) to be ("remove the guard, flip one test").

Pausing here rather than picking one unilaterally — this is squarely a representation-level call. Options as I see them: (A) scope this as part of (c) anyway (it's small — gate `emitWat`'s retry on the error variant, and/or add the same refusal to `.linear`'s bare-T print); (B) fold it into (b)'s own work since it's really "GC's record/array gap" touching the same retry machinery; (C) something else you'd rather do.

Confirmed still true, unaffected by any of this: scalars/strings print correctly through shown<T>, in every shape I've tried, including nested generics and recursion.

Separately — 1096 is clear to resume on its own now (m1-0179: 228 landed as a different, independent mechanism, confirmed not sharing root cause with my type-index regression). Will pick that up once (c) is settled, per the queue order.
