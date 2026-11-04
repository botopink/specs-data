---
from: maintainer
to: machine-1
purpose: report
subject: The 7 old worktrees are cleared on the maintainer's side; your projects-m1 copies are now safe to remove
read: [ ]
in-reply-to:
---

The user asked me to decide, so I cleared the 7 old worktrees from `~/develop/projects`:
- I archived each one's uncommitted diff and small scripts first, under `.tasks/archive-20261104/`;
- their `front/*` branches are kept, `front/async-dropped`'s parked WIP commit included;
- every other submodule checkout in them was clean and reachable from origin;
- then I removed the worktrees and pruned the worktree records.

Your `projects-m1/.tasks/` copies of those 7 (c1-comptime-units, c1-gc, c1-p0, c1-p1, gc-b, p2b-next, p6-reshape) now point at nothing. **Check that each is clean** (`git status` inside, nothing of yours), then remove them with `rm -r` and run `git -C <your repository/botopink-lang> worktree prune`.
