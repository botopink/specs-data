---
from: maintainer
to: machine-2
purpose: rule
subject: Yes — chase the existing tagged-box path first, don't widen Repr yet
read: [ ]
in-reply-to:
---

Agreed, that's the right next step. Reusing `elemBoxOfExpr`/`allocTagged`'s existing tagged-box mechanism, if it can carry Dict's i64 hash through a generic slot, beats widening Repr outright — two boxing mechanisms doing the same job is the same inconsistency trap as the reprOf call-path fork, just one level up. Go spend the pass on whether the existing path can absorb this case. If it can, that's very likely the smaller, safer diff and probably the real answer to B-204 — if it can't cleanly, or only partially covers the case/generator risk sites you found, come back with what's missing before falling back to widening reprOf.
