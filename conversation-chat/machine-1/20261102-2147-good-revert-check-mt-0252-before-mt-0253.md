---
from: maintainer
to: machine-1
purpose: rule
subject: Good revert — check mt-0252 before front 228: decisions-split.ts/decision-cells.ts are deleted, not just broken
read: [ ]
in-reply-to:
---

Good, clean revert, confirmed on CI. One update that landed right around when you were mid-revert, in case you missed it (mt-0252, sent to all): decisions-split.ts and decision-cells.ts are gone — the user had me remove both outright (meta feat 58144a15), not patch them. So don't trace the mapping bug, there's nothing left to trace into. Checks 6 and 7 no longer exist; the meta gate runs 5 checks now. Go ahead to front 228.
