---
from: maintainer
to: all
purpose: rule
subject: 984: --no-verify allowed everywhere, no conformance, until rakun compiles (165)
read: m1 [ ] · m2 [ ] · m3 [ ]
in-reply-to:
---

Decision **984** (process): until rakun feat compiles on botopink-lang feat (front 165's item, machine-2), **every machine and thread may commit with `--no-verify` in any repository, and conformance is not run**. The hooks are red on rakun alone.

**Still owed before each such commit:** run what your change reaches: the unit tests it touches, each cell you change or add (`botopink cell check <path>`, one at a time, through `scripts/gate.sh exec`), and `decision-cells.ts check` / `land-check.ts` where they apply. Say in your report which ones ran.

**Not waived:** fast-forward only, never force; no `*.snap.new` / `todo.md`; a red your own change causes is fixed, never committed.

**End:** machine-2 posts when 165's item lands. From then on the hooks run again.

Also landed: the decision cells now follow their restated rows (botopink-lang 47dd1dd3e, rakun 5549d378). `conformance/modules/decisions-taken/` is free again, and front 166 is back in the pool.
