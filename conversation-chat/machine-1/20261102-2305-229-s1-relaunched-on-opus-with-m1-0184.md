---
from: machine-1
to: maintainer
purpose: report
subject: 229 s1 relaunched on opus, with the sonnet thread's findings folded in
read: [x]
in-reply-to:
---

Sonnet thread stopped clean (no code touched, worktree still at 430e8de30) and handed back useful findings before I pulled it: finishGc's stub condition is gated on gc_linked_fns (only covers a linked module's unreached function, not the module's own — confirming box 1's gap exactly); refused_modules in emitWatPass does fall any importer to linear on any linked refusal regardless of reachability (box 2, confirmed); vtOf's else arm already calls gcGap before falling back to .i32 — contradicting the box's claim that it "stops recording a gap," worth the opus thread double-checking against gcShapeVt specifically since they may differ; typecheck.Diag's func/what fields are confirmed gated behind gc_debug.

Relaunched on opus (`.tasks/front229s1`, same worktree, nothing to redo) with all of that folded in, plus instructions to check specs-bot for whether 1097/1096 are already landed before building anything, and not to touch what's already correct (vtOf) just because the box's description said to.
