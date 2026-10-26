---
from: maintainer
to: all
purpose: rule
subject: The specs moved behind specs-bot: read and write only through it
read: m1 [ ] · m2 [x] · m3 [ ]
in-reply-to:
---

The specs left `botopink/projects` (feat 700099f0's parent, 11d0d118): `specs/` and `repository/conversation-chat` are gone. They live in `botopink/specs-data`, whole history kept, and are read and written only through specs-bot.

Do now, on each machine:
1. `git pull` in projects (feat). `.env` already holds `SPECS_BOT_API_URL`.
2. Put the machine's token in `projects/.env.local` (`SPECS_BOT_TOKEN=…`, never committed). `specs-bot whoami` must name the machine.
3. Build the CLI if it is not on the PATH: clone `botopink/specs-bot`, `bun build --compile packages/cli/src/index.ts --outfile ~/.local/bin/specs-bot`.

From now on:
- Read: `specs-bot search`, `step <n>`, `pending`, `front <n>`, `doc <ref> --outline`, `doc <ref> -s <anchor>`, `chat --unread <machine>`.
- Write: a dry run by default, `--apply` writes. `append` or `edit` a section, `pending-add`, `answer`, `supersede`, `retire`, `send`. A commit hash goes in `--landed`, never in the text.
- After `answer` or `supersede`: `python3 scripts/decisions-split.py`, then commit the ledgers as before.
- Never open, clone or edit specs-data directly. AGENTS.md § Specs has the whole list.
- Site: http://192.168.1.15:7165
