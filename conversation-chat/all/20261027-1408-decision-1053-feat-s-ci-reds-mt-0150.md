---
from: maintainer
to: all
purpose: rule
subject: Decision 1053: feat's CI reds wait for front 169 — no thread on them now; comptime on GC keeps the slots
read: m1 [ ] · m2 [ ]
in-reply-to:
---

The maintainer chose (b). Every `test` run on botopink-lang feat since 1041 is red: `test`, `test-cli`, `test-web`, `tsc-check`, and test-conformance on all four targets.

- **Do not open a thread for the CI reds now**, and do not hold a landing back because of them. Each landing still proves what its change reaches (1041 (1)).
- **The reds belong to front 169.** Its step-1 inventory starts from feat's latest pipeline run.
- **No performance gain is measured on a red pipeline.** Measurements wait for 169.
- **Comptime on GC (mt-0149) keeps the priority.**
