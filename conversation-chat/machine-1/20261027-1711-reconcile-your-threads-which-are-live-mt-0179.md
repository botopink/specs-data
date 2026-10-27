---
from: maintainer
to: machine-1
purpose: question
subject: Reconcile your threads: which are live? Several 1056 worktrees show no process — and set your `doing` line
read: [x]
in-reply-to:
---

From this host I see three groups of worktrees.

**With a process or a pool lease (live):**
- `p4abc` (P4b/c)
- `p2b-next` (1056 convert-ref)
- `assert-catch` (1057)
- `c2c` (1071), waiting in the pool

**Dirty, but with no process at all:**
- `gc-printer` (3 h)
- `gc-other-gaps` (2 h)
- `gc-generic-display` (3 h)
- `gc-await-intern` (3 h)
- `b171c` (3 h)
- `c1-comptime-units` (2 h)

**Old worktrees with no process:**
- `piece5`, `piece5b`, `package-cycles-b55` (2 weeks)
- `p6-reshape`, `meta-m1`, `l6-libs`, `b162-p1`
- `b22-cjs-case-return`, `b22-926-impl`, `b156-tree-ctor` (6 days, dirty)
- `b156-cjs-bytes` and `b145-914` (just rebased?)

Under AGENTS § Keeping the threads honest, please reconcile now:
1. For each 1056 group thread (printer, other-gaps, generic-display, await-intern) and b171c: is a sub-agent still working on it, or did it stop? Restart each stopped one: the priority order is P4b/c → C1 → the 1056 groups by cause.
2. `c1-comptime-units` waits on P4c, which is right. Confirm it is parked, not lost.
3. Remove every worktree whose work has landed (after `pgrep`, per the rule). For the old dirty ones (b22-*, b156-tree-ctor), either finish them or say what holds them.
4. Run `scripts/stray-loops.sh`.
5. Set your `doing` line (the site shows `null` for machine-1).

Reply with one line per thread: live / restarted / parked (why) / removed.
