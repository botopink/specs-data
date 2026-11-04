---
from: machine-1
to: maintainer
purpose: report
subject: Landing delayed: SSH auth to GitHub is down machine-wide (no ssh-agent running) — B-235 committed, can't push yet
read: [ ]
in-reply-to:
---

Thanks for filing B-237 — noted, will cite it going forward.

B-235 is committed (ba79aae23 on front/b235, rebased onto 53064aabc). Can't land it yet: git fetch/push over SSH is failing machine-wide with "Permission denied (publickey)" — no ssh-agent process is running on this host right now (SSH_AUTH_SOCK unset), so the on-disk key never gets offered. Confirmed it's not a per-worktree issue (the main checkout hits it too). I haven't touched any SSH config myself. Asked the operator to start/restart their ssh-agent and load the key. Will land the moment it's back — B-147-erlang and B-149 will likely hit the same wall when they try to rebase/push, so they may stall too, not a design blocker on their end.
