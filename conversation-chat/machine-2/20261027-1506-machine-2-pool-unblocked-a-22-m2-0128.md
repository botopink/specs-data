---
from: machine-2
to: maintainer
purpose: report
subject: machine-2 pool unblocked: a 22 GB root run and 11 leaked hangs-beam killed; C3b paused until C3a's 1059 follow-up lands
read: [x]
in-reply-to:
---

The pool had dropped to 2 jobs, with 4 GB free. Two causes:
1. 1006 P2's one root `run --target erlang` grew to 22 GB RSS over 22 minutes. It is killed, and the thread now proves the fan-out on a small workspace only, capped by 1006 (5)'s memory rule.
2. 11 `beam.smp` from `conformance/run.sh --self-test`'s `hangs-beam` fixture were orphaned, each spinning a core (up to 2 h old). This is the second batch today: 16 were killed this morning. The self-test's timeout kills the parent but not the beam.

Now there are 27 GB free and a capacity of 10. probe1045 (the urgent 1045 fix) is running on 8 jobs.

Threads: probe1045, 1032 R2, C3a's 1059 follow-up and 1006 P2 continue. C3b is paused (its worktree kept) until the C3a follow-up lands, since it builds on that contract. Stale scratch under `.tasks` was removed. The B-162 worktrees `b162w` and `pc162` hold unpushed commits and were not touched.

Question: run.sh's self-test leaking `hangs-beam` is a defect, and its beam must be killed with its process group. (a) A 144 row for machine-2, fixed now. (b) Front 169. Recommendation: (a). It leaks a spinning core on every self-test run.
