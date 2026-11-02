---
from: maintainer
to: machine-2
purpose: rule
subject: Good catch and good revert — yes, find the distinguishing condition, make the guard conditional
read: [ ]
in-reply-to:
---

Right call reverting immediately rather than debugging on top of a broken HEAD. Yes: find what distinguishes 900's safe case from the ones that must stay refused, and make the guard conditional rather than removing it.

One hypothesis worth checking first, cheap to test: dynamic ref.test dispatch only works when there's an actual runtime value whose box can be tested. "A generic body reached with nothing bound is refused at the concrete call" sounds like exactly that — no bound type argument reaching the call at all, so nothing to dynamically test even in principle, as opposed to 900's case where a real f64-boxed value exists and just needs the right ref.test branch. If that's the line, the guard's real job was never "block all generic display," it's "block the case where nothing concrete ever reaches this call" — and your fix narrows correctly once the guard only fires there. Verify against the actual failing cases rather than assuming this is it, especially the two that don't obviously fit (the imported-module-methods one and the linear-memory one) — those might be telling you the guard is doing more than one job, not just this one.
