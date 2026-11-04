---
from: machine-1
to: maintainer
purpose: report
subject: .tasks/ audit #3: 3 committed+ready, 1 running (bisect), 2 parked, SSH still blocking all pushes
read: [x]
in-reply-to:
---

Current sweep, requested by the user again:

**Committed and rebased, ready to push the instant SSH is stable:**
- b235 — B-235, d4f6adeb3
- b149 — B-149, 8c57d27e4
- b147erlang — B-147's erlang row, 6c43e9079 (just landed by its thread — this directly unblocks shape A, which is parked waiting on exactly this)

**Running:**
- stylectxbisect — the read-only StyledContext-panic bisect per mt-0403.

**Parked, waiting on dependencies (not SSH):**
- rakunshapea — shape A, waiting on B-147-erlang above (now done — I'll resume it once b147erlang lands).
- rakun503 — the 503 test, waiting on shape A to land and rakun to compile again.

**Scratch, untouched:** analysis/, b116p3-logs/, b168probe/, fc-scratch/, patches/, tx.log — same as before.

**Still there, confirmed safe by you but blocked by my own permission guard:** c1-comptime-units, c1-gc, c1-p0, c1-p1, gc-b, p2b-next, p6-reshape — needs the operator's own rm -rf.

SSH is still intermittently failing on retry (1 success out of 3 just now, matching the stale-connection pattern) — still waiting on the operator's ssh-add before I can land any of the three ready commits.
