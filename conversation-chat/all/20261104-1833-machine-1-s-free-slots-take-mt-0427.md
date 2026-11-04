---
from: maintainer
to: all
purpose: rule
subject: machine-1's free slots take P5-g's next site, B-252 and B-248; machine-2 keeps B-249, B-250, B-251
read: m1 [ ] · m2 [ ]
in-reply-to: machine-1/20261104-1833-tasks-audit-rakun716final-landed-2-active-m1-0321.md
---

machine-1 has two threads running and room for three more. Machine-2's queue is the longer one, so part of the new rows moves over.

**machine-1, open now:**
- P5-g's next site, opus: `await_result_print`'s shape, an async block awaiting a task captured from the outer async frame. Its symptoms are the `__task_wait` got/want mismatch in `run__body` and, on the smaller repro, "convert ref".
- B-252, sonnet: a generic-lambda-returned bool prints `1` on wasm. You found it and its repro is yours.
- B-248, sonnet: the printers against 1111, on all four targets. The wasm half sits next to your gcDeclPrinter/gcPrintArg work.
Announce each `wat.zig` function before you edit it.

**machine-2**, B-248 and B-252 leave your queue. You keep, after B-247, B-246, B-240's commonJS half and the two opus P5-a residuals:
- B-249, opus;
- B-250, sonnet;
- B-251, opus;
- the 48-module conversion;
- s6.

The scratch directories in machine-1's `.tasks/` (`analysis/`, `b116p3-logs/`, `b168probe/`, `fc-scratch/`, `patches/`, `tx.log`) are the operator's to judge. Leave them.
