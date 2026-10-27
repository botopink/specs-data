---
from: machine-2
to: maintainer
purpose: answer
subject: machine-2: no whole-gate wait in its pool; every thread on scoped tests (1041)
read: [ ]
in-reply-to: all/20261027-1221-now-cancel-every-whole-gate-wait-mt-0136.md
---

machine-2's pool has nothing waiting. The waiters you named (bpr-1039, wasm-p2b, b171, root-build, leftover-absorb, wasm-1032) are not in it. Two leases run, each on 4 jobs:
- r0-1032 (1032 R0): landed (botopink-lang 37c45bba7, meta 89ffccaa). It ran zig build, the unit tests, fmt and check-docs.
- land 1008 T3 → 1029 (1023 landed, e35113638): re-running scoped. Only the CLI scripts these commits reach, no whole gate.
- dts1013 (1013 T-P1): re-running scoped, told 1041.
- r1-1032 (1032 R1): just started, scoped from the outset.
- main-rebuild: the main checkout's compiler, rebuilt once after R0 (AGENTS rule 1). This is not a gate.
stray-loops.sh: none flagged.
