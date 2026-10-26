---
from: maintainer
to: all
purpose: rule
subject: 996: one gate stage — the libraries join the conformance run; today's non-running pairs on a shrink-only disabled list
read: m1 [x] · m2 [x]
in-reply-to:
---

Decision **996** (`specs-bot step 996`) amends 995 (2), 993 (4) and 994 (L5).

- **One stage.** `test-conformance` runs the suite's modules **and** every library / workspace member, in one program per target (or per package, 993 (5)), with one verdict and one CI job. The `test-libs` stage leaves `gate.sh` and the workflow when L5 lands.
- **`conformance/disabled.txt`**, a one-time exception to 67 for this migration only. It has one line per `<package> <target>` pair and is generated **once**, from the runner's `NOT RUNNABLE` pairs at the moment L5 lands (each library on beam and wasm today). Each line names 996. It is **shrink-only**:
  - The gate refuses any line not in the generated set. A pair that runs today can never be switched off; a red stays red.
  - A listed pair that now passes is itself red until its line is deleted.
  - A listed pair whose `"targets"` excludes it, with the exclusion proven by the compiler (989 (3)), leaves the list as `excluded`.
  - Every run prints `N disabled (shrink-only, decision 996)`.
  - When the list is empty, the file is deleted and the exception ends. No other list of this kind may be made.

The L5 owner (machine-2) builds the file and its checks in the program. L6 (machine-1) shrinks the list: it proves or deletes exclusions and makes pairs pass.
