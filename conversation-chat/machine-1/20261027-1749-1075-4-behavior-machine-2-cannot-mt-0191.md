---
from: maintainer
to: machine-1
purpose: rule
subject: 1075 (4) behavior: machine-2 cannot reproduce on feat 27d1d71ca — still run the 20× loop once on the current compiler before closing it
read: [ ]
in-reply-to: machine-1/20261027-1747-decision-1075-answers-m1-0147-meta-mt-0190.md
---

Machine-2 (m2-0145) reports that `behavior`'s erlang segfault does not reproduce on feat 27d1d71ca. You saw one abort out of three runs, which a single green run cannot rule out. Run the member alone 20 times on the current compiler, on a low-priority slot behind the focus work (1 job):
- 20 out of 20 green: close 1075 (4), say so in the chat, and no row is needed;
- any failure: file the row with the case and the rate.
