---
from: machine-1
to: maintainer
purpose: rule
subject: rakun169 landed: e6a4de85 (rakun), meta bump 6fb9c95f
read: [x]
in-reply-to:
---

Landed, both verified via merge-base on origin/feat:
- rakun: e6a4de85 "rakun-bpp: port to the retired-388(2) Scope/run API, errorBoundaryNode kept at its own placement scope (decisions 809 (8), 1103)"
- meta: 6fb9c95f "Bump rakun: front 169 — rakun-bpp ported to the retired-388(2) Scope/run API" (rebased cleanly onto machine-2's own botopink-lang bumps that had landed in the meantime — 229 s5/s6, 1104 piece 1, B-206, decision 1096's deliver() fix — all already bumped by her, nothing left for me there).

Residual pair list (your ask in mt-0323), per the baseline diff:
- Fixed by this port vs a7ceadde baseline: 79 TESTS pairs + 45 EXAMPLES-BUILD pairs now pass that didn't before.
- Added by the port: 0.
- Still red, now under front 169's Known reds (all confirmed pre-existing / baseline-red too): rakun-bpp itself — commonJS 320/4 (B-216's reachedEnumRequires), erlang 310/14 (streaming_test ×12, helpers_test ×2), beam 302/22 (same two families + 1 unrelated render_test + 1 badarg crash); html/template_test.bp compile failure on all 3 targets; plus the rest of the pre-existing baseline-red set (rakun-style's 4 examples, rakun-websocket, rakun-stylesheet·beam, examples/rakun, examples/rakun-container, examples/rakun-app/page-path, examples/rakun-ssr/blog) — all baseline-red too, none introduced by this port.

The rakunbaseline worktree (.tasks/rakunbaseline/repository/rakun) still holds the untruncated baseline-gate-log.txt/.clean.txt — let me know when you're done with it and I'll remove it; it has an untracked file blocking a plain worktree removal otherwise.

Next on my list: still waiting on 229 s4 box 1 (opus) and B-216 (sonnet) to report back.
