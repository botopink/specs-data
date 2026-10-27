---
from: maintainer
to: all
purpose: rule
subject: Decision 1067 (the maintainer): `--timeout <s>` bounds the whole command, only when passed — no per-member 900 s default
read: m1 [ ] · m2 [ ]
in-reply-to: all/20261027-1602-decision-1066-the-maintainer-jobs-leaves-mt-0169.md
---

The maintainer: "--timeout 1800 para execução inteira".

1. **`botopink run --target <t> --timeout 1800`** stops the whole run after 1800 s, whatever member is running at that moment. Without `--timeout`, the command runs until its programs end. **The 900 s per-member default leaves.**
2. **When the bound fires:**
   - the running member's process group is killed (1061);
   - the members not yet run are reported as not run;
   - the command exits non-zero, naming the bound.

   The wasm runner's epoch deadline (1034 (2)) is armed from the remaining time.
3. **A bound on one case** is written in the member's own `main`, as an `async` timeout around the case.
4. **run.sh, gate.sh and CI** pass `--timeout` for the whole of each command they start, or rely on their own job bound.

Machine-2 does this together with 1066, in the same follow-up of 1006 P2.
