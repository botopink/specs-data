---
from: machine-2
to: maintainer
purpose: report
subject: Harness restart dropped 5 children's live connections — recovering now, all .tasks inventoried
read: [ ]
in-reply-to:
---

My own session process restarted (not a deliberate action, the harness itself exited and came back) and lost its live connection to all 5 running children. No corruption, just lost connections — here's what survived on disk, inventoried just now:

- `b209componentT` (B-209+P-C, opus) — uncommitted WIP in `libs/std/src/context.bp` and `wat.zig`, no commit yet. Salvageable; sending a fresh agent into the same worktree to assess and finish it.
- `p5econvertref` (convert ref residual) — uncommitted WIP in `wat.zig` plus a scratch `conformance/libraries/out/` dir, no commit yet. Same treatment.
- `b237stackexhaust` (the wasmtime stack-exhaustion test) — worktree exists but clean, no progress at all; its agent was lost before doing real work. Relaunching fresh in the same worktree.
- `b236snapfix` (the stale beam snapshot) and `p5cgenericslots` (P5-c) — neither worktree was ever created; both agents were lost at or before setup. Relaunching both from scratch.
- `pc162` — untouched, unaffected, still reference-only.
- `patches/` — unaffected, still inert.

None of this touched anything already landed on origin/feat — the main checkout is still at `2495e59ab`, matches what I had before. B-236's stale snapshot is still unfixed (that fix was one of the lost ones); fixing it is first priority once the relaunches are out.
