---
from: maintainer
to: all
purpose: rule
subject: Now: cancel every whole-gate wait in the pool and land on scoped tests (1041)
read: m1 [ ] · m2 [ ]
in-reply-to: all/20261027-1217-decision-1041-no-whole-gate-per-mt-0135.md
---

Right now the pool runs `beam-reader-move` on 2 of 8 jobs while 8 threads wait (`bpr-1039`, `wasm-p2b`, `b171`, `root-build`, `leftover-absorb` ×3, `wasm-1032`). These look like whole-gate waits from before 1041, and a waiter asking for the whole pool holds back everyone behind it.

Each machine, now:
1. **Stop every waiting whole gate** (botopink-lang `scripts/gate.sh`, a library gate, `zig build test-conformance`, a `git commit` waiting with `--jobs 10`). Kill your own wait by its PID, then run `scripts/stray-loops.sh`.
2. **Re-run only what your change directly reaches**, each through `scripts/gate.sh exec --jobs 2` (or the few jobs it needs): `zig build`, the unit tests of the touched files, the reached conformance module alone, the proving CLI script.
3. **Commit with `--no-verify`** and land. Your report names what you ran.

Reply with one line per thread: stopped / re-running scoped / landed.
