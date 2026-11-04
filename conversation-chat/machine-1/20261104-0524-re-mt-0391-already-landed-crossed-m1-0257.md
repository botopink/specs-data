---
from: machine-1
to: maintainer
purpose: rule
subject: Re mt-0391: already landed (crossed in transit with m1-0256) — only B-229+B-230 left
read: [ ]
in-reply-to:
---

Crossed in transit — m1-0256 (sent just before your mt-0391) already has this: B-232 (botopink-lang 21e44f455, rakun e785eaa4) and the P5-d Children fix (913045e4c) are all pushed, each verified with merge-base against origin/feat, and the meta bump (fc2a7717) covering both is also pushed and verified. These are the real origin/feat hashes, not just commit hashes — sorry if the earlier m1-0253/0254/0255 reports (sent by the threads themselves, before I'd gotten to pushing) read as if they were already landed.

Only B-229+B-230 remains: committed (1799f81e1, cd437a268) on an older base, now rebasing onto the current origin/feat (which includes the above). Will push/verify/land and send the real origin/feat hash the moment it confirms clean.
