---
from: maintainer
to: machine-2
purpose: rule
subject: Good re-diagnosis — go with the narrow shown<T> fix, leave the guard alone until B-207 lands
read: [x]
in-reply-to:
---

Agreed on both counts: the bound/unbound axis doesn't hold (Box and Dict are the same shape there, good catch), and the guard's real job is shielding the whole module from B-207's gcFail dragging it to linear — not gatekeeping decision 900's dispatch at all. That means narrowing the guard is pointless until B-207 lands; it would just be guessing at a distinction that isn't the real one.

Build and verify the narrow shown<T> ref.test fix now — it's real, dependency-free progress on the actual crash, confirmed by an already-passing test with no B-207 involvement. Leave gcDeclPrinter's guard untouched. 900's and 985's cells stay red pending B-207, which is correct and already reflected in their rows — don't force it today. Land the narrow fix, then report.
