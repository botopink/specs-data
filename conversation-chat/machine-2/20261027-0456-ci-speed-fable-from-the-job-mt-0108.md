---
from: maintainer
to: machine-2
purpose: rule
subject: CI speed (fable, from the job logs) + decision 1011 (no case on disk unrun): your pieces, in order
read: [ ]
in-reply-to:
---

The maintainer agreed. From the fable's read of runs 40459521888 / 40461836730 / 40464518696:
- CAUSE 1: the zig cache never serves `build`: all 8 jobs save under one key, the first to finish (backend-partition) wins, `build` gets "Unable to reserve cache"; its zig build is 8.5 min every time (the old 6.5 min were pushes with no .zig). CAUSE 2: tsc-check is a serial loop over 1068 projects (build --target commonJS --typescript + tsc each); 10 vs 19 min is runner luck.
Pieces, yours, in this order (sonnet each; 1011 first since it guards the gate):
0. Decision 1011 (`specs-bot step 1011`): stage 9 (and the root's run once 1006 lands) fails when a member's cases/<c> has no runCase("<c>") or a call has no directory, naming module + case, every target; the leftover cells/ run/ refused/ cases (569) held to a frozen, committed, shrink-only list, printing `N cases outside 989's shape (shrink-only)`. Cells case_on_disk_not_run_refused, case_call_without_directory_refused. This would have caught the 27-module / ~150-case loss in the same commit.
1. ci-setup: zig cache key per job kind (zig-0.16.0-Linux-<job>-<hash>, restore `-<job>-`), or cache/restore + cache/save only in jobs that compile. Oracle: `build` on a push with no .zig ≈ 1 min; with .zig ≈ 8.
2. tsc-check's projects on the pool (xargs -P, one output file per project, printed in order). No per-hash skip of a dependency .d.ts (1011 (3)). Oracle: 18 → ~5 min, same verdicts.
3. With 1006 P4: tsc-check restores the .bpr artifact too (and 1008's units). 
4. `zig build test -Dtest-shards=8` in CI. Oracle: test 13 → ~9 min.
5. When P4 lands, measure what the root .bpr build adds to `build`.
Not to do: `concurrency: cancel-in-progress` on feat — 474 (1) needs every feat run's verdict. Your 1006 P1 / T1 stays in flight; slot these where they do not collide.
