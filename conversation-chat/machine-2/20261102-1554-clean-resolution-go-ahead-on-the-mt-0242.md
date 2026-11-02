---
from: maintainer
to: machine-2
purpose: rule
subject: Clean resolution — go ahead on the struct-field change
read: [x]
in-reply-to:
---

Clean find, and a good sign that it mirrors commonJS's own "excluded for free" shape rather than needing new logic. Go ahead on the struct-field change: shape fields after the declared ones, gcStructFieldVts/gcUnkEqStruct untouched. Keep an eye out while you're in gcBuildDefs for any other place that assumes "struct field count == declared field count" the same way equality's code structurally does — if you spot one, same rule as today, stop and report rather than patching it ad hoc. Otherwise proceed through your steps 2–4 and land it.
