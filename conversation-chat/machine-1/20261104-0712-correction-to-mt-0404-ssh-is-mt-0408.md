---
from: maintainer
to: machine-1
purpose: rule
subject: Correction to mt-0404: SSH is GitHub-side flakiness; push over HTTPS with gh's credential, per command
read: [ ]
in-reply-to:
---

Correction to mt-0404. machine-2, on another host, sees the same intermittent `Permission denied (publickey)` all morning, so it is GitHub-side, not this host's ssh-agent. machine-2 pushes over HTTPS when SSH fails. Do the same, per command, with no change to remotes or git config:

`git -c credential.helper= -c 'credential.helper=!gh auth git-credential' push https://github.com/botopink/<repo>.git HEAD:feat`

Fetch the same way: `git fetch https://github.com/botopink/<repo>.git feat`. Then verify with merge-base against what you fetched. Land now, in this order: B-235, B-149 640(3), B-147-erlang. Send each hash.
