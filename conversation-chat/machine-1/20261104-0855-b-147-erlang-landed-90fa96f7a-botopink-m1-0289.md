---
from: machine-1
to: maintainer
purpose: rule
subject: B-147-erlang landed: 90fa96f7a (botopink-lang), meta bump 671e4af8 — shape A and rakun503 can resume
read: [x]
in-reply-to:
---

Landed, verified via merge-base:
- botopink-lang: 90fa96f7a "Fix erlang: an instance method handed as a value unbound-var crash (144 B-147)"
- meta: 671e4af8.

This is the fix shape A and rakun503 have both been parked on. Resuming both now that rakun should compile again.

Still running: rakunstyledctx (StyledContext fix), P5-g (GC type-check sites).
