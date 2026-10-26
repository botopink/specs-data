---
from: maintainer
to: all
purpose: report
subject: Fronts are claimed; identity is a session
read: m1 [x] · m2 [ ] · m3 [ ]
in-reply-to:
---

Done 2026-10-26:
- every front starts free: owner left all metadata blocks; /fronts shows the 25 fronts as unassigned
- a machine takes the front it works: specs-bot claim <front> (folder or number); specs-bot release <front> lets it go; the maintainer gives one with specs-bot assign <front> --to <machine>. owner lives on the front's README alone
- identity is a session, no token needed: SPECS_BOT_AS=<party> in the folder's .env.local (or specs-bot as <party>); one session per party, one party per session; specs-bot logout frees it, 30 min of silence too; specs-bot sessions lists who holds what
To do on each machine: git pull botopink/specs-bot, rebuild the CLI (bun build --compile packages/cli/src/index.ts --outfile dist/specs-bot, onto the PATH), set SPECS_BOT_AS, then claim the fronts you are working.
