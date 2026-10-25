---
from: maintainer
to: all
purpose: rule
subject: The four decision files moved to specs/ (one file each, above every milestone); decisions-taken.md reads the rakun workspace's package names (724)
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261018-2330-decisions-737-738-props-and-no-pair-mt-0023.md
---

Two changes of the maintainer (2026-10-18), both landed (meta b55f42019, gate green):

1. **Paths.** `decisions-taken.md`, `decisions-taken-steps.md`, `decisions-pending.md` and `decisoes-pendentes.md` live at
   `specs/` now — `specs/decisions-taken-steps.md`, not `specs/1.0.12-beta/…` — one file each above every milestone (the
   numbering is global; a closed milestone keeps its frozen copies). Every link in the milestone tree, `decisions-split.py`,
   `gate.sh`'s check 6, `AGENTS.md` § Layout and the CI comment are repointed; your generated `decisions-taken.md` was
   recommitted with the new header line only. A question you file goes to `specs/decisions-pending.md` (EN) and
   `specs/decisoes-pendentes.md` (PT); a README link from `machine-N/<front>/` is `../../../decisions-taken.md`.
2. **Names.** `specs/decisions-taken.md` now reads the workspace's package names everywhere a library is meant: jhonstart →
   `rakun-bpp`, styled → `rakun-style`, emilia → `rakun-stylesheet`, onze → `rakun-ssr` (its command line and `rakun-ssr.json`),
   dbcontext → `rakun-data`, erika → `query` (`query @`…``). Three section slugs changed: `markup-and-rakun-bpp`, `rakun-ssr`,
   `query-and-rakun-data`. Code identifiers stay (`html`, `styled(…)`, `emilia(tokens)`, `#[emilia]`, `Onze.run`, `ONZE_KEY`);
   the steps file is append-only and keeps the old names in its rows. Where a README of yours still says "jhonstart's" or
   "onze's" for a package, respell it when you next touch the file.

Machine 2: `scripts/scratch-refs.py` names four lines of `specs/1.0.12-beta/machine-2/README.md` (16, 39, 41, 44) that cite
task branches `front/b138p`, `front/b137t`, `front/b139p`, `front/b142` — a queue row says what runs and what blocks it, never
a branch (land-check's `scratch-ref` red). Drop the branch names at your next landing.
