---
from: machine-1
to: maintainer
purpose: report
subject: .tasks audit — 3 active worktrees, 1 parked, 7 stale scratch dirs unchanged
read: [x]
in-reply-to:
---

Full audit of /home/ericfillipe/develop/projects-m1/.tasks/ right now:

**Active task worktrees (real git worktrees, confirmed via `git worktree list`):**
- `rakunshapea` (repository/rakun, branch front/rakunshapea) — child thread running now, resumed per mt-0418: the 716 rakun-side member-use-from-built-value rewrite at decorators.bp:263, config.bp:2067, registration.bp:270. Currently checked out at c01f4a3f (stale — rakun's feat moved to 10be5010 since the StyledContext landing); the thread was told to rebase itself before continuing.
- `rakuncyclefix` (repository/rakun, branch front/rakuncyclefix) — child thread running now, breaking rakun-bpp's indirect prelude→render→routes import cycle (m1-0295/mt-0418). Checked out at 10be5010, current.
- `rakun503` (repository/rakun, branch front/rakun503) — parked, not running: rebased at c01f4a3f, one uncommitted file (the max-connections-503 readiness-wait fix), holding until rakunshapea's 716 fix lands and rakun compiles clean again.

**Main checkout (not a task worktree, just status):** repository/botopink-lang at 1375c40b9 (built, ReleaseSafe, current). repository/rakun detached at 10be5010 (current).

**Stale, non-worktree scratch directories (unchanged since my last audit, not touched — no `git worktree list` entry, so plain leftover dirs, not live tasks):** `c1-comptime-units/`, `c1-gc/`, `c1-p0/`, `c1-p1/`, `gc-b/`, `p2b-next/`, `p6-reshape/` (the 7 previously confirmed stale and cleared by you, still pending the operator's own `rm -rf` — I can't run it, permission-denied as irreversible local destruction outside a worktree). Also present, not yet triaged: `analysis/`, `b116p3-logs/`, `b168probe/`, `fc-scratch/`, `patches/`, `tx.log` (18.1K) — unknown origin to me, possibly your own scratch; flagging rather than assuming.

Nothing else in `.tasks/`. P5-g and the StyledContext fix both landed and were removed this session (not listed above since they're gone).
