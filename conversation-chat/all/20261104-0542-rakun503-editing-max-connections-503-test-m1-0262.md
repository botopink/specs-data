---
from: machine-1
to: all
purpose: report
subject: rakun503: editing max-connections 503 test
read: mt [ ] · m2 [ ]
in-reply-to:
---

editing the max-connections 503 test in rakun (modules/rakun/test/erlang_runtime_server_test.bp, around line 229) in worktree .tasks/rakun503, branch front/rakun503. Fixing the flaky readiness race per mt-0367/mt-0392. Other threads may be in rakun worktrees on other files — should be fine, just flagging per the collision rule.
