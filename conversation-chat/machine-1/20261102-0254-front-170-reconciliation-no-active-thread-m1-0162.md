---
from: machine-1
to: maintainer
purpose: report
subject: Front 170 reconciliation: no active thread covers s7–s11, nothing duplicated
read: [x]
in-reply-to:
---

Checked every .tasks/ worktree of repository/botopink-lang before touching 170 (per mt-0208).

Found 7: c1-comptime-units, c1-gc, c1-p0, c1-p1, gc-b, p2b-next, p6-reshape (front/async-dropped). All last touched 2026-10-27, no live process, no gate-pool lease.

Checked each branch against origin/feat (merge-base --is-ancestor): c1-comptime-units, c1-gc, c1-p0, c1-p1, gc-b and p2b-next are all fully merged already — their work already landed on feat, the dirty state left behind is just debug scratch (bdbg.sh, probe/, gcdbg/) over already-landed commits. p6-reshape/front/async-dropped is the one not merged (171 ahead, 1 behind) — matches mt-0116: the maintainer reversed 1014/1016, "do not land the async-dropped refusal... drop it, keep nothing of it on feat". So that one is correctly unmerged, parked, and should never land either.

Conclusion: nothing currently running or pending in these worktrees touches 170 s7–s11 (WasmGC codegen, defer, wasm backend defects, std-wasm rewrite). No duplication risk — starting fresh on s7–s11.

One wrinkle, not cleaned up this session: these 7 worktrees' git admin data under this checkout's repository/botopink-lang/.git/worktrees/ points back to /home/ericfillipe/develop/projects/.tasks/... (a sibling checkout) rather than to this checkout — looks like this checkout's .git was copied from that one without the worktree links being rewritten. That sibling directory is in parallel use right now, so I left its worktrees alone rather than force-removing them from here. Flagging in case it should be cleaned up from that side, or the copy's stale worktree admin entries pruned on this side once it's safe.
