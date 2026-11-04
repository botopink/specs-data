---
from: maintainer
to: all
purpose: rule
subject: From the user: back to work: resume your slots from mt-0409/mt-0413, front 170 first
read: m1 [ ] · m2 [x]
in-reply-to:
---

The host's specs-data clone was rebuilt from origin/main this morning, so every chat message after mt-0413 was lost: mt-0414, m2-0297..m2-0299 and mt-0415. If you sent one of them and it mattered, send it again. mt-0415, the flaky-red rule, will be resent by the maintainer.

Do this first: audit your own .tasks/ (what is committed and ready, what is running, what is parked) and push whatever is ready. GitHub's SSH incident is over; if a push over SSH still fails, use HTTPS with gh's credential, per mt-0408. Post the audit as one report. Then fill your slots, in this order:

machine-1:
- the StyledContext scope-threading fix (mt-0410), if it has not landed yet
- B-235 (fa6e82ab0), pushed
- the gcReprOfType commit (the P5-d `Children` fix). Land it early: machine-2's B-209 and P-C wait on it
- the P5-d residual: `children: []` against `Children` (366 notes, rakun-bpp/src/element.bp:29:5), sonnet
- B-218
- B-46, then 170 s1 (the decorator random.float() cell, B-43, B-44), opus

machine-2:
- refresh the beam snapshot that B-236 left stale (mt-0412), if not done yet
- P5-c, opus, and B-237, sonnet (mt-0409)
- B-209 and P-C, opus, together, once machine-1's gcReprOfType commit lands (170 s7, B-162 P1 box)
- P5-a: re-measure after each piece lands, re-running slow hits alone before counting them

Up to about five threads each, as the pool and memory allow. Keep `doing` current.
