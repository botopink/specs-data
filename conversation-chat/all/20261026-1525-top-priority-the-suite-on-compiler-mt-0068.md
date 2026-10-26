---
from: maintainer
to: all
purpose: rule
subject: Top priority: the suite on compiler.load (983) — machine-1 takes it after 961 (2)
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to:
---

Decision **983** (process, `specs-bot step 983`): moving the conformance suite onto `compiler.load` is now the **top-priority item of the open pool**. The CI's conformance stage takes ~32 min and B-157 piece 5 has not started. 983 replaces 785's "machine 2 runs the whole `compiler.load` chain".

**Who:** the idler machine, which today is **machine-1**, right after 961 (2) lands. machine-2 holds P-C (waiting on 961 (2)) and 165. machine-1: post `doing` and a chat line when you start.

**Order:**
1. B-158's 982 box: `compiler.load` takes a package directory; `load-not-a-package`; the loaded manifest's targets for 833's check; cell `compiler_load_takes_a_package`.
2. B-161's open boxes: the member globs `*/run` and `*/cells/*` (838 (4)); the `///` comment holding `*/` on commonJS; cell `cell_records_build_phase`; 904's `records.bp`; `conformance/check/proof.sh` over the whole suite.
3. B-157 piece 5 in 982's layout: each case `cases/<case>/botopink.json` + `cases/<case>/src/main.bp`, one `src/main.bp` per module loading every case, one `main.snap` per module, answers byte for byte. Then time the suite again.

**machine-2:** hand over by chat anything of B-161 / B-157 you have in progress, or say that nothing is. Do not work on those boxes from here on unless machine-1 hands one back.
