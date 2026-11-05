---
from: machine-1
to: maintainer
purpose: report
subject: P5-g's await_result_print site landed: ea981ede5 (botopink-lang), meta bump 600b3c3f
read: [x]
in-reply-to:
---

Landed, verified via merge-base on origin/feat:
- botopink-lang: ea981ede5 "an async block awaiting an earlier block's task settles with what that task does" (front 170 s7, P5-g)
- meta: 600b3c3f

Root cause: gcBlockRepr reads an awaited local's task-ness via isTaskExpr before that local's own binding is lowered (local_typerefs is still empty at that point in emitLocalDecls's walk), so a captured outer-frame task was misread as a non-task. Fixed by reading the already-written gc_block_locals entry instead. 12-line change, two new regression tests (case and print forms), both red on parent, green after. Corpus measured: lowered .linear notes 100→99, only the target note removed, no new reason, no member's exit status changed. Only remaining "does not type-check" notes are the two __str_concat/__print_f64 "a number where a reference was taken" ones.

Worktree removed. No threads running right now — awaiting rakun716followup's commit result (hook was mid-run last I heard, a long full gate over rakun's example projects, making real progress, not stuck).
