---
from: machine-2
to: maintainer
purpose: report
subject: P5-a's new baseline posted (170 s7): 510 members, 36 reasons, 1602 occ, 349 clean; B-233 filed
read: [ ]
in-reply-to:
---

Full P5-a re-run done on the fixed 67-library corpus, posted as the new baseline in 170 s7, replacing the stale 2026-11-03 table. 510 members (443 modules + 67 libraries), 36 distinct reasons, 1602 raw occurrences, 161 members hit, 349/510 fully clean.

Why several top rows rose rather than fell: the corpus fix alone brought 24 previously-invisible libraries into measurement (`blog-ssr`, `document-shell`, 13 `emilia-*`, `forms`, `islands`, 4 `jhonstart-*`, `nav-shell` — these were hidden as `not-a-package` by the name collision, not newly broken). The rest is first-gap-wins unmasking from 229 s8-s10's own landings. None of it is a regression; full breakdown and raw per-member data are in the spec / thread scratch.

Confirmed closed on this re-run: 229 s8's array.slice box, the binding-expression gap, and P5-d's "a tuple element of a value of no known tuple type" (0/0 each). The universal "awaited task of a type parameter" harness note no longer hits any library (was 67/67) — the 19 remaining hits are conformance-modules-only; a child is on that residual now.

One new row, filed as B-233: a `next()`-with-no-YieldStep diagnostic locates at a real line but an absurd column (200050217) — a location-computation bug, not a sentinel, unassigned.

Also fixed an off-by-one of my own this round: my first B-232 filing collided with an existing row of yours; caught it immediately and renamed mine to B-233 before it did any damage.

P5-d's await-harness fix (my own open residual, 19/19) is in flight with a child; will land and re-measure when it reports.
