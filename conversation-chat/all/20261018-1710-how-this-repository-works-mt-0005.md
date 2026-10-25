---
from: maintainer
to: all
purpose: rule
subject: How conversation-chat works — one file per message, a head, a read check, unread.sh
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261018-1704-this-repository-opens-mt-0004.md
---

From now on every message between a machine and the maintainer is a file of this repository
(`botopink/conversation-chat`, pinned by the meta under `repository/conversation-chat`). Clone it over SSH
(`git@github.com:botopink/conversation-chat.git`), work on `feat`, push at once. No branches, no PRs, no hooks.

1. Where. Your conversation with the maintainer is your directory: `machine-1/`, `machine-2/`, `machine-3/`, both
   directions in it. `all/` is the maintainer to every machine. Read your directory and `all/`.
2. One file per message: `<YYYYMMDD-HHMM>-<slug>-<id>.md`. The time is yours, local, to the minute. The slug is
   three to six lowercase words with hyphens. The id is your short name and your running number — `m1-0001`,
   `m2-0001`, `m3-0001`; the maintainer is `mt-` — one sequence per writer, never reused, so nobody waits on
   anybody to number a message.
3. The head. Copy `TEMPLATE.md`; the first lines of every message are its front matter: `from`, `to`, `purpose`
   (`report` — your status in thread-rules' four lines, Done / Running / Next / Blocking, every blocking factor
   named; `question` — one thing you need decided, with options; `answer`; `digest`; `rule`), `subject` (one line),
   `read`, `in-reply-to` (the file you answer, when there is one). The body follows.
4. The read check. You leave `read: [ ]` on what you write. When you read a message addressed to you, turn its
   check into `[x]` and commit — that is the one edit ever made to another side's file. A message to `all` has
   one check per machine, `m1 [x] · m2 [ ] · m3 [ ]`; tick yours only.
5. Before you write, run `scripts/unread.sh machine-N`: it lists what the maintainer wrote to you that you have not
   ticked, exit 1 while something is unread. Read those, tick them, then write.
6. A message is never rewritten after it is pushed; a correction is a new message with `in-reply-to`. Hashes are
   welcome (this is a log, not a spec); scratch paths (`.tasks/…`, `/tmp/…`) are not. English, as everywhere.
7. Commits: `chat(machine-2): m2-0012 status after 674`, one per message or batch, pushed to `feat` at once.
   The meta pointer is the maintainer's, bumped when convenient, never a condition for a message.

Nothing here is a decision. A decision is a row of the meta's `decisions-taken.md`; a question of yours that needs
the maintainer still goes to `decisions-pending.md` as before — the message here points at it.

The seven exchanges of tonight are already filed in this shape. Your first job in this repository: run
`scripts/unread.sh machine-N`, read and tick what is there, then file your next report as a message.
