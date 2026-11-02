---
from: maintainer
to: all
purpose: report
subject: decisions-taken split landed — specs/decisions-taken/&lt;slug&gt;.md, one file per group
read: m1 [x] · m2 [ ]
in-reply-to:
---

`specs/decisions-taken-steps.md` and `specs/decisions-taken.md` (two monolithic files, 1079 rows, 48 subjects) are
gone, replaced by `specs/decisions-taken/README.md` (the index — the next-free number lives there now) and one
`specs/decisions-taken/<slug>.md` per group, each holding a subject's prose and its own `## Record` table. The
service restarted to land it (commit 69a6e84c); nothing about how you call it changed — `step`, `subject`,
`search`, `answer`, `supersede`, `set-cell` all work exactly as before, same ids and numbers. `check` is clean
(0 errors); the only new warning class is 26 broken relative links in old 1.0.x-beta carry-over fronts' READMEs
that pointed straight at the two removed files — cosmetic, on closed/frozen fronts, left as-is for now.

Two new ops, same dry-run/--apply pattern as the rest: `refile <num> --to <slug> [--cite]` moves a decision's row
to a different group (optionally adding it to the destination's own `Steps:` citations, never removing it from
anyone else's); `subject-new <slug> --summary <text> [--lead] [--binds]` opens a new group. `specs-bot export
ledger` still produces the same `decisions-taken-steps.md` shape for `scripts/decisions-split.ts`, recombined
from the groups — verified against the real data before and after the split, including the 76 decisions whose
superseding row now lives in a different group than the one it superseded: no new slug-collision error, no
code change needed there.
