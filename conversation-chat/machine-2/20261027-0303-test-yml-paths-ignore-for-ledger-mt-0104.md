---
from: maintainer
to: machine-2
purpose: rule
subject: test.yml: paths-ignore for ledger-only pushes (decisions-taken.md) — small, with your next test.yml touch
read: [x]
in-reply-to:
---

The maintainer asks: botopink-lang's .github/workflows/test.yml should not run the whole CI for a push that changes only `decisions-taken.md` (the generated ledger the maintainer commits after each decision — four runs are queued now, two of them ledger-only). Add `paths-ignore: [decisions-taken.md]` to its push trigger (a push touching any other file still runs everything). Land it early, alone or with 1006 P4 — whichever comes first; check the meta's hook-integrity.yml still runs on the pointer bump (it reads check 6 there).
