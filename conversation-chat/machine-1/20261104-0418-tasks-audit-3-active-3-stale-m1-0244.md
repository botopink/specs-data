---
from: machine-1
to: maintainer
purpose: report
subject: .tasks/ audit: 3 active, 3 stale removed, 7 scratch dirs untouched, 7 possibly-foreign worktrees found — needs your eyes
read: [ ]
in-reply-to:
---

Full sweep of /home/ericfillipe/develop/projects-m1/.tasks/ and its worktrees, requested by the user. Three buckets:

**Active (correlate with my 3 running threads):**
- b229230 — B-229+B-230, botopink-lang, running
- b232 — B-232 (Children/804), botopink-lang, running
- p5dchildren — P5-d's Children-empty-array fix, botopink-lang, running

**Stale and landed — removed just now (clean, no uncommitted work, confirmed via merge-base before deleting):**
- front229s4 — 229 s4 box 1 landed as 7c746370d weeks... hours ago; I'd simply forgotten to remove this one earlier.
- b212cell, b212docs — B-212 (the scope-cell-kept-by-place question), closed "not a defect" and landed as cell scope_cell_kept_by_place-968 a while back; both were 36-38 commits behind, clean.

**Scratch directories, not git worktrees — untouched, no action taken:**
- analysis/ (b00-dump, b00-tools, b00b-dump, x1, x2 subdirs)
- b116p3-logs/ (old log .txt files)
- b168probe/ (a loose botopink.json + src/out, not a worktree)
- fc-scratch/ (loose .bp files, a 204.9M "bp-base" dir, "bp-s5" 8.0M dir, "copies/")
- patches/ (b00b-wip, b00g, b00g-finish, b00i, b162-p1 subdirs — looks like saved diffs from early fronts)
- tx.log (18.1K)
These all look like leftovers from much earlier work (before anything in my visible history) — didn't touch any of them since I don't know their provenance or whether anyone still needs them.

**Found something that needs your eyes, not mine to act on: 7 worktree entries in botopink-lang's own `git worktree list` point to `~/develop/projects/.tasks/<name>/...` (the OLD/sibling checkout, which still exists separately at `~/develop/projects`), while directories with the SAME names also physically exist under `~/develop/projects-m1/.tasks/`:**
- c1-comptime-units, c1-gc, c1-p0, c1-p1, gc-b, p2b-next (branch front/p2b-next), p6-reshape (branch front/async-dropped, oddly — name mismatch)

My read: this `projects-m1` checkout may have been created by copying `~/develop/projects` wholesale (not a clean clone/worktree-add), which carried over `.tasks/` directory copies whose embedded git worktree metadata still points at the old absolute path. I haven't touched these — I don't know if `~/develop/projects` is still someone's live work, whether these are genuine duplicates, or whether the projects-m1 copies are inert/broken. Flagging rather than guessing; happy to investigate further or clean up on your or the operator's direction.
