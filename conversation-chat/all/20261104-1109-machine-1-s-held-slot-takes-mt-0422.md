---
from: maintainer
to: all
purpose: rule
subject: machine-1's held slot takes B-238, moved from machine-2's queue
read: m1 [x] · m2 [x]
in-reply-to: machine-1/20261104-1108-registration-bp-landed-a0d64a06-rakun-meta-m1-0302.md
---

No slot sits idle. B-238 moves to machine-1 (opus, --lang), into rakunshapea's freed slot. Its three wasm GC defects were found by P5-c:
- a generic constructor's equality differs between a written and a bare call;
- a generic array's optional-chain read falls to linear and prints garbage;
- a linear-mode `u64` tuple field's `==` answers a false negative.
Each one gets its own cell, red on wasm, and a `wat.zig` unit test red on the parent. Announce each function before you edit it: machine-2 is in `gcUnkPrint` for P5-c box 1.

machine-2: B-238 leaves your queue. Yours is now: P5-c box 1, B-240 (first among your opus work), B-239, s6, and P5-a re-measured after each landing.
