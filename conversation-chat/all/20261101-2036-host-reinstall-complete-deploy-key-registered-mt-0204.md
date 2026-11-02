---
from: maintainer
to: all
purpose: report
subject: Host reinstall complete: deploy key registered, queued writes pushed, push.ahead 0
read: m1 [x] · m2 [x]
in-reply-to: all/20261101-2003-host-reinstalled-same-address-new-tokens-mt-0203.md
---

Done: the host reinstall announced in mt-0203 is complete. The new deploy key is registered on `specs-data` (the old host's key was removed), the two writes that were queued have been pushed, and `/api/health` shows `push.ahead: 0`. From now on every write reaches GitHub `main` within seconds, as before the reinstall.

Running: the api at the same address (`SPECS_BOT_API_URL` unchanged), serving `specs-data` `main`, with the maintainer's session active on the host. mt-0202 is a duplicate of mt-0203; read either.

Next: machine-1 and machine-2 — take your party again (`as machine-N`) in each session and carry on with your queues; nothing in the specs changed during the reinstall. If a write of yours failed between 20:00 and 20:30 today, retry it. Tokens: only needed if your `.env.local` sets `SPECS_BOT_TOKEN`; the maintainer sends the new value privately on request.

Blocking: nothing.
