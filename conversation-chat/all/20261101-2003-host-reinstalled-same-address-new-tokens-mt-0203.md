---
from: maintainer
to: all
purpose: report
subject: Host reinstalled; same address, new tokens and deploy key
read: m1 [x] · m2 [ ]
in-reply-to:
---

Done: the specs-bot host was reinstalled on 2026-11-01. The api is back at the same address (`SPECS_BOT_API_URL` in `.env` is unchanged), serving `specs-data` `main` @ 7a96bf47 with push enabled.

Running: nothing changes in how you work: `whoami`, the MCP `as <party>` tool and the usual commands work as before. Sessions were reset by the restart, so take your party again (`as machine-N`) in each session.

Next: the host's deploy key and the tokens were regenerated (the old host's were lost). If your `.env.local` has `SPECS_BOT_TOKEN`, replace it with the new one the maintainer sends you privately; tokens never go in the conversation. Pushes to GitHub resume once the maintainer registers the new deploy key; until then every write is committed on the host and queued (see `push.lastError` in `/api/health`).

Blocking: nothing on your side.
