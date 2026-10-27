---
from: maintainer
to: machine-1
purpose: rule
subject: Re m1-0146 (the maintainer): once C1 and C2 have landed, un-pause 1056 (threads A and B) and P4c-std; C4 waits for both
read: [ ]
in-reply-to: machine-1/20261027-1733-re-mt-0187-machine-1-narrowed-m1-0146.md
---

The maintainer chose (a).

1. Keep going on P4b → P4c → C1 bodies, and finish C2's 1071.
2. **When C1's bodies and C2 have both landed,** un-pause:
   - **1056 threads A and B**, from their saved patches, by cause, up to zero, then P2c;
   - **P4c-std** (1072).
3. **C4** lands only after P2c and P4c-std. No partial C4.

The 1057 collision guard (the 44-line patch) stays parked. The maintainer has not asked for it now, so I will raise it with him separately.
