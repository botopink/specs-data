---
from: machine-2
to: maintainer
purpose: question
subject: Found the exact cast failure — the generic/erased shown<T> body just assumes box_i32, no shape field needed; this may be simpler than the __bp_s port
read: [x]
in-reply-to:
---

Pinned it exactly, reading the emitted .wat (lifted the guard again to get real output, reverted, no diff). The compiler already compiles TWO versions of Dict.display: a specialized `Dict_display__K_string__V_f64` (correct, calls `shown__T_f64`), and a generic/erased `Dict_display` that calls generic `shown`. `print(d)`'s own dispatch (gcDeclPrinter's `$__pr0`, shared across every `Dict` regardless of K/V) calls the generic one — it has to, it can't know K/V.

The generic `shown(x: anyref)`'s own body is the actual bug: `if (x is string) { … } else { ref.cast (ref null $box_i32); struct.get $box_i32 $v; call $__print_i32_raw; }` — the non-string branch unconditionally casts to `$box_i32` no matter what's actually there. For our f64 value it's a real `$box_f64`, so the cast traps. This looks like generic/erased numeric type parameters are just assumed to be `i32` by default (the same erasure `gcErasedRepr` uses for generic record fields, presumably) — not a missing-shape-info problem, a wrong-fixed-assumption one.

`__unk_print_raw` (used elsewhere for `unknown`) already does this correctly — a `ref.test` chain over `box_bool`/`box_i32`/`box_f64`/`box_i64`/`str` before picking a printer. The narrow fix: generic/erased `shown`'s non-string branch does the same dynamic ref.test chain instead of assuming `box_i32` — no shape field, no struct change, no construction/forwarding work at all. This would very likely fix 900 and 985's symptom at the `shown` level directly (985's test still needs B-207's lambda-parameter fix first to even reach this point, but once it does, the same fix applies).

This contradicts the `__bp_s`-port plan — wasm doesn't have JS's "can't tell a float from an int at runtime" problem at all once you're willing to test the box dynamically, which GC mode already does everywhere else. I might be missing why the shape-field design was still the right call even here (maybe `shown`'s case is too narrow and other decision-900 call shapes genuinely need static shape info, not just a fixed dynamic-dispatch fix) — but before building the struct field, wanted to flag that the concrete bug I can now point to doesn't need it. Which way do you want this: (a) the narrow `shown`-dispatch fix, much smaller than the struct-field plan; (b) the struct-field plan anyway, because other cases decision 900 covers need it even if this one doesn't; (c) something else?
