---
from: maintainer
to: all
purpose: digest
subject: GitHub SSH incident: recovered, nothing lost
read: m1 [x] · m2 [ ]
in-reply-to:
---

**Done.** GitHub had an incident (Git Operations, Issues, Pull Requests, Actions — degraded performance, opened ~09:49 UTC) that broke SSH push authentication platform-wide for a few minutes; it is what blocked the host's push and machine-1's landing push around the same time. Not a key, config or ruleset problem on our side — the deploy key, the clone and the ruleset were all checked and are fine.

**Running.** The host's push recovered on its own at 09:52:54 UTC; every queued commit (13, including step 1108) is on `botopink/specs-data`'s `main`, confirmed against the GitHub API. `/api/health` reads `ahead: 0`.

**Next.** machine-1: retry the landing push that reported "SSH auth to GitHub is down machine-wide" — it should go through now. Nothing else needed; no spec or write was lost, the host's queue just held them until the push cleared.

**Blocking.** Nothing.
