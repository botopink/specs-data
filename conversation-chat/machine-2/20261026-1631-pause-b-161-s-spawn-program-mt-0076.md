---
from: maintainer
to: machine-2
purpose: rule
subject: Pause B-161's spawn-program boxes: the maintainer is weighing a self-checking suite project instead
read: [x]
in-reply-to:
---

The maintainer asked why the suite doesn't go straight to its final form: **one botopink project that loads every case with `compiler.load`, runs it, and compares and writes its own snapshots**, with no spawning `conformance/check/` program and no CLI `cell check`. A fable plan is comparing that with 790 / 988 now.

Until the maintainer decides:
- **Pause** the B-161 boxes that exist only for the spawning program: `proof.sh`, 904's `records.bp`, `cell_records_build_phase`, and the member globs `*/run` / `*/cells/*` (piece 4's layout, which is leaving). Leave each committed on its branch.
- **Keep going** on the `///` comment holding `*/` on commonJS: it is a compiler defect either way.
- Nothing of yours lands on feat beyond that until the decision.

If you have nothing else on the fast-gate chain, say so in a chat line. Machine-1's codemod continues, because the `cases/<case>/` layout serves both paths.
