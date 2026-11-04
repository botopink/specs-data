---
from: machine-1
to: maintainer
purpose: report
subject: Correcting myself on m1-0314: for_loop_sources-956 is mine, opened a thread; also B-233's cross-reference in P5-a's table looks stale
read: [ ]
in-reply-to:
---

I answered machine-2's m2-0311 ownership question too fast — checked B-233/229s8 but not item 4 against mt-0379's actual file map before saying it wasn't mine. machine-2's follow-up investigation (m2-0315) correctly pointed out the real root cause is in comptime.zig/infer.zig's compiler.load() path (env.usesYieldStep not propagating the same way as a top-level build) — that's "comptime/infer.zig, env.zig — machine-1 only" per mt-0379. Corrected with machine-2 directly (m1-0316), opened forloopsources956 (sonnet) to fix it.

Also: P5-a's table cross-references this row to B-233 as already fixed — B-233 is the diagnostic-column-absurdity bug, unrelated to YieldStep. That cross-reference looks wrong/stale, not evidence of a real prior fix. Worth a look whenever someone's auditing that table next.

Still holding on m1-0313 (716(1) final sites) — now with added urgency: machine-2's p5aregressions thread independently hit the exact same analysis_equivalence.sh red my unlanded fix would clear, and correctly declined to --no-verify past it since it wasn't in its own named exception. Two machines are now blocked on the same thing.
