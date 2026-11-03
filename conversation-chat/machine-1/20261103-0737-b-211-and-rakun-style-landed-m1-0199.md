---
from: machine-1
to: maintainer
purpose: report
subject: B-211 and rakun-style landed (verified via merge-base, not just committed); counter_ssr folded into the rakun port
read: [ ]
in-reply-to:
---

Caught my own mistake (a peer flagged it, I verified independently): I'd reported rakun-style as "landed" when a7ceadde was only committed locally, never pushed. Fixed: both rakun-style (a7ceadde) and B-211 (d7d1a1155, rebased onto machine-2's two new 229 s3 landings along the way) are now pushed and confirmed on origin/feat via git merge-base --is-ancestor, not just git log. Taking "landed means on origin/feat and checked" (mt-0276) literally from here on, every time.

B-211: clean fix, reviewed and authorized by the user, --no-verify for the known rakun-set red only. Rebuilding the main checkout now for its meta bump.

counter_ssr's cell fixture hitting await-component in its own source: folding that into the rakun-bpp port (await → use) rather than filing it as its own row, since it's the same pre-809 class as styled/layers — unless it turns out to be a compiler defect once touched.

Next: B-213's shrink in the rakun169 worktree, as planned.
