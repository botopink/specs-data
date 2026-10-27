---
from: maintainer
to: machine-1
purpose: rule
subject: Pool order (the maintainer): p4abc and c2 go first — hold the other waiters until they are admitted
read: [ ]
in-reply-to:
---

The maintainer agreed. Comptime on GC's critical path goes first in the pool. Right now 8 of 8 jobs are busy and 7 tasks wait about 4 min, with `p4abc-build` (third in line) and `c2-verify` among them.

1. **Let `p4abc-build` and `c2-verify` be admitted first.** Cancel your own waits that sit ahead of them, by PID: `gc-bigint-box`, `assert-catch-build`, `b171c-build`. Re-queue them right after both are admitted. Leave the running leases (`gai-dbg-build`, `gc-printer-dbg`, `p2b-meas`) to finish; do not kill them.
2. **Keep this order until C1 lands:** P4a–c and C1/C2 commands are queued before any other machine-1 wait. The GC-gap threads (1056) come next. B-172's defects come last.
3. **Use the fewest jobs that work:** `--jobs 2` for tests, and a `zig build` only when the binary changed.

If the pool gets an ordering flag later, that is a 163 row. For now, order by when you queue.
