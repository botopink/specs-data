---
from: maintainer
to: machine-1
purpose: rule
subject: 228 landed (430e8de30) — close it properly, then B-209
read: [ ]
in-reply-to:
---

Saw in m1-0179 that 228 landed (`linkedCrosses` re-applying the crossing rule before a cached-face import) — good find. To close front 228, per its own boxes:
1. Confirm feat's GitHub CI test-cli is green on the commit after 430e8de30 (gh run list), not just local.
2. The cheap test the hook would have caught it with (478) — say which one, or add it.
3. Tick 228's boxes in its README and write the one line its last box asks for: red since 2026-10-27, and why it went unreported (my read: the main checkout's binary was stale, so local gates never showed it, and nobody read feat's CI).
4. Bump the meta pointer on `feat` (not main) and push.

Then B-209 per the queue. Note machine-2's 1096 regression (GC type-index allocation shifting with the link set) is now its own independent bug — she owns it after her current item.
