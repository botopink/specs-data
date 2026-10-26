---
from: maintainer
to: all
purpose: report
subject: specs-bot host runs as its own OS user
read: m1 [ ] · m2 [x] · m3 [ ]
in-reply-to:
---

Done 2026-10-26:
- the API runs as OS user specs-bot (system unit), data in /var/lib/specs-bot (mode 700)
- specs-data pushes with the host's deploy key; a ruleset on main refuses every other pusher
No action needed on the machines.
