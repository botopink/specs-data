---
from: machine-2
to: maintainer
purpose: question
subject: Rebase conflict: machine-1's landed 229 s1 reimplements decision 1097's build note independently of my B-208 P1 — needs reconciling, not a guess
read: [x]
in-reply-to:
---

Rebasing onto origin/feat (de5053592, machine-1's "wasm: per-function GC stubbing and named fallbacks, front 229 s1, decision 1097") produced a real merge conflict in wat.zig — not routine. Both their commit and my earlier B-208 P1 landing (6238f49eb, now bda8a8d6a after the first rebase) implement the SAME decision (1097's `.gc`→`.linear` build note), independently, under different names: mine is `fallback_gap`/`fallback_gap_loc`/`reportGcFallback`; theirs is `gc_failure`/`recordGcFailure`/`takeGcFailure`/`printLinearNote`/`takeLinearNote`, and by their own commit message theirs is richer (handles the case where the `.linear` lowering then also refuses, records the first gap's site, a per-function memory-access site, a few more gap sources through `gcFail`). This collided at the exact same threadlocal-declaration block near `emitWat`.

Separately, my own gcTaggedPrinter fix (de5fda5e2, now ce9ca62e7 after my own rebase) saves/restores `fallback_gap`/`fallback_gap_loc`/`first_gap` by name inside `gcTaggedArm` — if my B-208 mechanism is the one that goes away in favor of theirs, that code needs reworking to restore whatever their mechanism's equivalent state is instead, not just a textual conflict resolution.

Machine-1's commit also touches `finishGc`/`emitWatPass` (per-function stubbing, `reach.zig`) — the same functions my gcTaggedArm's save/restore and the per-type degradation sit inside. We'd agreed on regions before (hers: unit-emission/~390-600/2116/3245; mine: GC-repr/lowering/~3700-5600+) back before front 229 existed as s1/s2 — this is new overlap neither of us flagged, in the actual area both our latest work reaches.

I aborted the rebase rather than guess which build-note mechanism survives or how to carry my restore-state logic over — this is representation-level and touches both our work. Not asking machine-1 directly since you may want to decide which mechanism is kept rather than have us negotiate it. My front/foldwasm is currently based on 430e8de30 (just before their s1 landing), both my commits intact, nothing pushed, nothing else touched. Holding here for your read.
