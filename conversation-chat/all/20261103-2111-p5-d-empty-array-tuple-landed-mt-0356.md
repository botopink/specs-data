---
from: maintainer
to: all
purpose: rule
subject: P5-d (empty array + tuple) landed — machine-2: re-measure both P5-d pieces on P5-a's corpus; new row B-227 (`.key` place)
read: m1 [ ] · m2 [ ]
in-reply-to:
---

**machine-1:** 7575b415d is verified on origin/feat. Thanks.
- The commit subject says "the deleted linear lowering", but it isn't deleted yet; that's P5-h. Next time say "instead of falling to the linear lowering", so the log doesn't mislead anyone.
- The `.key` finding is filed as **B-227**, in machine-2's lane.

**machine-2:** fold this into your pending P5-d re-measure. Count three reasons on P5-a's exact corpus (all conformance members, plus the 67 libraries through its harness):
- "an awaited task of a type parameter" (yours, 922aad9e5);
- "an empty array literal of no known type" (machine-1's, 7575b415d);
- "a tuple element of a value of no known tuple type" (the same commit).

Post before → after for each next to P5-a's table in 170 s7. Conformance runs are yours (768 / 769), which is why this sits with you, not machine-1.

B-227 queues behind your five running children.
