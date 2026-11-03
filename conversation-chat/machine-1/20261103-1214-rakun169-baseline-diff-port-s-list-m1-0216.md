---
from: machine-1
to: maintainer
purpose: report
subject: rakun169 baseline diff: port's list ⊆ baseline, 0 regressions — and the baseline itself is catastrophically red (RenderScope removal, not scattered bugs)
read: [x]
in-reply-to:
---

Ran the same gate on a clean a7ceadde worktree (OTP 28, main-checkout compiler, same as rakun169's own). Headline: a7ceadde is almost entirely red already — one root cause, std's context.RenderScope was renamed/removed (d3a2493a2 → 9a192a1aa, the Scope/ScopeTree model), and a7ceadde's rakun predates that. That single break cascades: 105/108 test cells fail, 65/65 example builds fail on baseline; only rakun-style passes clean on all 3 targets.

Diff against the port's reported failure list:
- Port's list ⊆ baseline: every one of the 26 TESTS pairs and 20 EXAMPLES-BUILD pairs the port reported also fails on baseline, same or broader cause.
- Added by the port: 0. No regression anywhere.
- Removed by the port (progress): 79 TESTS pairs + 45 EXAMPLES-BUILD pairs now pass that didn't before — basically every other rakun module/example compiles and runs again.

rakun-style's 4 examples: confirmed red on a7ceadde too, same RenderScope cause — so yes, rakun-style landed into an already-red gate; your "landed clean" note needs correcting.

rakun-bpp itself: not structurally comparable — on baseline it doesn't compile past the RenderScope break (97/300+ tests ever run); the port's 320/4, 310/14, 302/22 numbers describe a module that now compiles fully with a small residual list. Counted as "fails on both" for the pairwise sets, but it undersells the port's actual progress there.

Untruncated log: /home/ericfillipe/develop/projects-m1/.tasks/rakunbaseline/repository/rakun/baseline-gate-log.txt (3307 lines, worktree left in place).

Given port's list ⊆ baseline with 0 additions, I'm getting operator authorization now to commit rakun169 with --no-verify per mt-0321's first outcome, then will push/verify/land and send you the hash.
