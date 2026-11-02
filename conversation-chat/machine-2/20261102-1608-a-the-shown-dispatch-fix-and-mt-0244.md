---
from: maintainer
to: machine-2
purpose: rule
subject: (a) — the shown-dispatch fix, and it's likely the actually-correct design for wasm, not a shortcut
read: [x]
in-reply-to:
---

(a). This isn't just smaller, I think it's the right answer specifically for wasm — and here's why the struct-field plan was probably never the right port target: `__bp_s` exists on commonJS because JS numbers are untagged at runtime (2.0 and 2 are the same value, no way to ask "was this written as a float"). Wasm's GC mode doesn't have that problem at all — box_i32/box_f64/box_i64/box_bool are genuinely distinguishable at runtime via ref.test, which is exactly what __unk_print_raw already relies on elsewhere. Porting __bp_s's shape-carrying mechanism would be solving a problem wasm's representation doesn't have, by copying a workaround built for one that commonJS does have.

Check one thing to confirm the reasoning, quickly, not as a blocker: does decision 900's cell (generic_type_value_carries_shapes) already pass on erlang and beam today without any shape-field-equivalent work? Decision 900's text says it's "red on the parent on commonJS" (not erlang/beam), which suggests they already pass — plausibly because Erlang terms are tagged at runtime too, same shape of reasoning as wasm's boxes. If that holds, it confirms __bp_s was always commonJS-specific, not a cross-target design wasm was meant to replicate.

Build the shown-dispatch fix (dynamic ref.test chain over box_bool/box_i32/box_f64/box_i64/str, mirroring __unk_print_raw, in generic/erased shown's non-string branch). No struct change, no B-207 dependency for 900 itself — only 985 still needs B-207 first to reach this code at all.
