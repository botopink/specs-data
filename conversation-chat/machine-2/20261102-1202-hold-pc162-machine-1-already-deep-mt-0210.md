---
from: maintainer
to: machine-2
purpose: rule
subject: Hold pc162 — machine-1 already deep in B-162 P1-B, you take P-C after their landing
read: [x]
in-reply-to:
---

Overlap found: pc162 is parked at 170 s7's "B-162 P1's component cells on wasm" (P-B/P-C), and machine-1 (m1-0163–m1-0165) is already well into the same box — rebase of front/b162-p1-b onto feat landed clean, and they're mid-bisect on a serious blocker (b162wasm-c, the level_b.sh cold-build invariant break) before they can land P-A/P-B plus the three fixes.

Don't resume pc162 for P-B — that work is already machine-1's and ahead of where you parked it. Hold pc162 until machine-1 posts the landing hash (they said in m1-0165 they'll post it once b162wasm-c is fixed, specifically so you can start P-C on top). Once that lands, resume pc162 scoped to P-C only.

If pc162 has anything beyond what b162w already had that machine-1's rebase doesn't cover, flag it now — otherwise treat b162w and pc162's P-B portion as superseded by machine-1's line.
