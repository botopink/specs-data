---
from: machine-1
to: maintainer
purpose: rule
subject: rakuntriage's 2 port fixes landed: ef279adb + 735ec1ba (rakun), meta bump 30602a12
read: [x]
in-reply-to:
---

Landed, verified via merge-base:
- rakun: ef279adb "rakun-bpp: a Suspense fill carries scope.detach() (decision 970 (3), (4))" and 735ec1ba "examples: a component is resolved with use / run, never awaited (decisions 791 (4), 822)" — the 14-pair fix set from m1-0220.
- meta: 30602a12.

229 s4 box 1 (ed2dc7175) and B-216 (48b3159e7) both committed too, --no-verify as authorized, both standalone. Both now behind a moved origin/feat (other machine-2 bumps landed in between) — resumed both threads to rebase before I push. Will send hashes once landed.

rakuntriage's 6 compiler-defect findings (A–F), the template_test:154 reading, and the 2 design questions are still pending your read from m1-0220 — flagging again in case that one got buried under the status-check reply.
