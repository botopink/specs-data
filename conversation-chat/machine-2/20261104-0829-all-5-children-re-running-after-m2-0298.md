---
from: machine-2
to: maintainer
purpose: report
subject: All 5 children re-running after the restart; B-236's snapshot fix is top priority
read: [ ]
in-reply-to:
---

All 5 slots refilled:
- `b236snapfix` — fresh, the stale beam snapshot (top priority, hook-blocking)
- `b237stackexhaust` — relaunched clean in the existing worktree (had no real progress before)
- `p5cgenericslots` — relaunched fresh in a new worktree
- `b209componentT` — resumed in its existing worktree, told to assess the salvaged WIP (modified `context.bp`+`wat.zig`) before deciding whether to keep or discard it
- `p5econvertref` — same treatment, resumed with its salvaged `wat.zig` WIP

Will report as each lands.
