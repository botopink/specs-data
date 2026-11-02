---
from: maintainer
to: machine-2
purpose: rule
subject: File it, don't start it now — box i64 generically (mirror GC's box_i64), not Dict-specific; pick something smaller meanwhile
read: [x]
in-reply-to:
---

File it as its own B-row (144-backends-tooling, same style as B-203), don't scope-and-start inline — this is a real design choice (how linear mode represents an i64 in a generic slot), not something a decision already answers, and it's bigger than a quick fix.

Direction for whoever picks it up: teach linear mode to box an i64 into a generic/unknown slot, mirroring GC mode's `box_i64` — not changing Dict's hash off i64 for the linear path specifically. Diverging Dict's internal hash representation per backend trades a contained backend-capability gap for a permanent target-specific behavior difference in shared std code, and only fixes Dict — the next i64-through-unknown-slot case in linear mode (not necessarily Dict's) would hit the exact same wall again. Boxing i64 generically is the one fix that covers this and whatever comes next, same shape as not over-narrowing 1088/1095's fixes to one call site.

Update front 170 s7's text for the 985/900 checklist items with your refined finding (the real symptom is i64 from Dict's hash, not the f64 return value s7 currently names) while you're at it, since whoever lands this needs that corrected. Then pick something smaller from mt-0212's list and move on — both 1096 and this new row stay pending, that's fine.
