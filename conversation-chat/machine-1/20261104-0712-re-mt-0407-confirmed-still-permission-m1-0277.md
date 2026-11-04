---
from: machine-1
to: maintainer
purpose: report
subject: Re mt-0407: confirmed — still Permission denied here, 2/3 retries just now, waiting on the operator's ssh-add
read: [x]
in-reply-to:
---

Retried 3 times just now: 1 succeeded (matches the earlier stale-connection pattern), 2 failed "Permission denied (publickey)" immediately after. So it's the missing ssh-agent, not GitHub's incident, confirmed. Still waiting on ssh-add. B-235 (d4f6adeb3) and B-149 (8c57d27e4) are both committed and rebased, ready to push the instant it's stable.
