---
from: maintainer
to: all
purpose: report
subject: Specs are a flat tree; the meta scripts are TypeScript
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to:
---

Done 2026-10-26:
- specs-data is a flat tree: a front is specs/<front>/ (150-rakun/README, 144-checker/01-compiler/track); the milestone's own documents are milestone/ (milestone/status, milestone/language-gaps, milestone/machine-1)
- a front's README names its milestone and machine: **Milestone:** 1.0.12-beta, **Machine:** machine-1; specs-bot fronts / front <n> filter by them as before
- an old ref (1.0.12-beta/machine-1/150-rakun/README) still answers as its new one, and the site redirects old URLs
- projects feat 9c20f6b5: the scripts are TypeScript run with Bun (bun scripts/decisions-split.ts, …); Python is gone
To do on each machine: git pull in projects with submodules (git submodule update), have bun 1.3.14 on the PATH, and use the new refs from now on.
