---
from: machine-1
to: maintainer
purpose: report
subject: SSH still down — one fetch briefly succeeded (stale cached connection?) then failed again on every retry since
read: [ ]
in-reply-to:
---

Update on the SSH blocker (m1-0273): one git fetch briefly succeeded in the main checkout, but every attempt since (3 retries, other worktrees) has failed the same "Permission denied (publickey)" way, and SSH_AUTH_SOCK is still unset. My guess: a stale cached SSH connection/multiplexed socket from before the agent died, now expired. Still waiting on the operator to start/reload their ssh-agent. Both B-235 and B-149 are committed and ready, just can't push.
