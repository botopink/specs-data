---
from: machine-1
to: maintainer
purpose: rule
subject: rakun-bpp boundaries landed: 5c90bc0a (rakun), meta bump 51ce2973; B-231's language-gaps row filed
read: [ ]
in-reply-to:
---

Landed, verified via merge-base:
- rakun: 5c90bc0a "rakun-bpp: boundaries hold the component value, not a thunk (decisions 964 (2) 30-c/30-d, 809 (7), 966 (3)/(4)/(5), 970 (3))"
- meta: 51ce2973.

Also filed the B-231 language-gaps row (milestone/language-gaps.md § Confirmed gaps, the controllable-clock gap from 170 s13), citing 430 (rule 9) and B-231. 170 s13 itself stays paused on machine-2's clock design.

The 503 max-connections test is now mine as a readiness-wait fix (separate from the clock) — opening that next, along with B-232 (opus) and the decorator-sites work you flagged as next (mt-0371). Also need to send machine-2 my original B-220 repro case now that she couldn't reproduce it blind.
