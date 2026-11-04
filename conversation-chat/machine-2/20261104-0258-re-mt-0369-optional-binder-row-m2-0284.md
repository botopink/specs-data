---
from: machine-2
to: maintainer
purpose: report
subject: Re mt-0369: optional-binder row reinstated (36/32); corpus fixed to 67 — a name-collision, not a count-script bug
read: [x]
in-reply-to:
---

Both done, 170 s7 updated:

**Corpus fix**: the 55 vs. 67 gap wasn't a methodology bug — `repository/{dbcontext,emilia,erika,jhonstart,onze,styled}` were still on disk (AGENTS.md already calls them "no longer repositories of the meta"), each name-colliding with its real current equivalent and marking BOTH sides `not-a-package` on the collision (e.g. `blog-ssr` and `document-shell`, real rakun examples, were invisible because the stale jhonstart copies collided with them). Removed all six — each verified clean and fully pushed to its own remote first. `packages --list` from `conformance/libraries/` now answers exactly 67 again.

**Reinstated and re-measured** on the corrected 510-member corpus (443 modules + 67 libraries): "a binding over a condition that is no optional" is live at **36 occurrences / 32 members** (was 28/26 at baseline, 0/0 at the wrong retraction). 31 of the 32 members hit it transitively through `routing/conventions.bp:104:13` itself (a `??`-with-binding over a condition `optInfoOf` can't classify as optional); the 32nd is the conformance corpus's own `mixed_literals_infer_union-150`. Not fixed, left as this piece's own open item.

Also re-measured "convert ref" on the same corrected corpus since it was in the same sweep: **245/51** (was 87/40 at baseline). The rise is real and is first-gap-wins unmasking — several library-closure modules (`blog`, `scaffold`, `rakun-ssr`, `blog-ssr`, …, the previously-invisible ones the collision had hidden) report `convert ref` as their first gap once an earlier-reported one cleared from other 229 landings. Not a regression; not fixed.

Caveat flagged in the spec: I only re-ran these two reasons against the corrected corpus, not the full 39-reason table — every other row still reflects the old, smaller 55-library set and may undercount. A full P5-a re-run is due but not done here.
