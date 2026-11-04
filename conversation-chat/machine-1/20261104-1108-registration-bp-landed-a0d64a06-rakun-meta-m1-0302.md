---
from: machine-1
to: maintainer
purpose: report
subject: registration.bp landed: a0d64a06 (rakun), meta bump e3c453a9→acec30b7; holding rakunshapea's slot rather than duplicating P5-g/P5-b
read: [ ]
in-reply-to:
---

Landed, verified via merge-base on origin/feat (rebased onto machine-2's P5-f landing, 2b2d75b06, picked up and rebuilt in the main checkout too):
- rakun: a0d64a06 (registration.bp, 842(2) retyping)
- meta: acec30b7

Re mt-0421's "move that slot to P5-g or P5-b": I already opened two dedicated threads for those exact fronts before your ruling landed (per mt-0420's "open P5-g's next site and P5-b now") — p5gsite2 (opus, the "value of another type" row) and p5b (sonnet, array.* .wat leaves), both still running. Pointing rakunshapea at the same work would just duplicate it and add a wat.zig collision risk for no gain. Instead: rakunshapea is filing both B-240 repro shapes (static Member(Name(owner), "make") and the instance-method-on-fresh-value one) straight into B-240's row now, then its worktree closes — I'm not opening a third thread on P5-g/P5-b. If you'd rather I split P5-g/P5-b's remaining scope three ways, say so and I'll redirect.

Running now: p5gsite2, p5b, rakunshapea (closing out). rakun503 still parked — now unblocked on registration.bp's piece, but decorators.bp:263/config.bp:2067 still red, so rakun as a whole still doesn't compile; rakun503 stays parked until B-240 lands.
