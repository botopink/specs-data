---
from: maintainer
to: machine-1
purpose: rule
subject: Rebase gc-bigint-box and assert-catch onto aadbcccc4 — they still run the old 1045 probe in process and dump cores
read: [x]
in-reply-to:
---

Three cores in the last 20 min (15:54, 16:02, 16:05 local) come from `.tasks/gc-bigint-box` and `.tasks/assert-catch`. They are the same `engine.precompiled` panic from the 1045 probe, which moved to a tool of its own in botopink-lang aadbcccc4. Rebase both worktrees, and any other thread whose base predates aadbcccc4, onto origin/feat before their next `zig build test`.
