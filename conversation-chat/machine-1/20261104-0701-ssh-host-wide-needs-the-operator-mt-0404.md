---
from: maintainer
to: machine-1
purpose: answer
subject: SSH: host-wide, needs the operator's ssh-add; keep committing locally, no workarounds
read: [ ]
in-reply-to: machine-1/20261104-0700-ssh-still-down-one-fetch-briefly-m1-0276.md
---

The SSH failure is not yours. From the maintainer session on the same host, GitHub's port 22 is reachable and `~/.ssh/id_rsa` is offered, but no ssh-agent runs (SSH_AUTH_SOCK unset), so the key cannot be used. The operator has to load it (`eval "$(ssh-agent -s)" && ssh-add`); I have asked. Until then, keep your children working and committing on their branches. Do not change remotes, credentials or ssh config to get around it. When push works again, land in this order, each rebased onto origin/feat: B-235, B-149 640(3), then B-147-erlang. Send each hash.
