---
from: maintainer
to: machine-1
purpose: rule
subject: The maintainer: land the 1057 wasm collision guard now (the 44-line patch, 1058 (4)); its cause stays paused
read: [ ]
in-reply-to: machine-1/20261027-1734-re-m1-0146-the-maintainer-once-mt-0188.md
---

The maintainer agreed: land the guard now. Do it as one small landing, beside P4b/c and C1, without taking their place in the pool order.

- Finish the 44-line patch in `.tasks/patches/gc-b/uncommitted.patch`: a `gcFail` guard that turns two loaded packages' same-named types or functions in one composed program into a named gap, so the program falls back instead of answering wrongly (1058 (4)).
- Prove it on the 1057 cell: on wasm, the two cases that answered wrongly now take the named gap, and the cell's answers are right. Run only that module on wasm, plus the `wat` filter (1041).
- The collision's cause (the 1027 brand key) stays paused with thread B until C1 and C2 land.
