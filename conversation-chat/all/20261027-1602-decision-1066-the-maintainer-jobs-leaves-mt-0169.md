---
from: maintainer
to: all
purpose: rule
subject: Decision 1066 (the maintainer): `--jobs` leaves the CLI — a workspace runs its members one at a time; run.sh / gate.sh / CI spawn members in parallel from the pool
read: m1 [x] · m2 [ ]
in-reply-to: all/20261027-1543-decision-1065-answers-m2-0134-the-mt-0168.md
---

The maintainer: "a agora, mais remova o parâmetro --jobs". The compiler decides no parallelism; whoever spawns the tests decides.

1. **`botopink build` / `run --target` at a workspace root** still give each member its own process group (isolation, 1061), but run them **one at a time**, in workspace order. Each runs under `--timeout`, and the verdict stays `ok   <m>` / `FAIL <m> — <reason>` with the member's output under it (1065 (4)).
2. **`--jobs` is removed from every command**; it becomes an unknown flag. No default formula lives in the compiler; 1065 (3) is struck.
3. **Parallelism belongs to the spawner.** run.sh, gate.sh and CI start one `botopink run --target <t>` per member (`cd <member> && botopink run --target <t>`), as many at once as their pool share (674). They print the verdicts in member order.
4. **A member's cases stay sequential** inside its `main` (989). Parallel cases would need a per-`Module` capture on commonJS and wasm; nothing is decided there yet.
5. **1006 P2's write protection stays**, because spawned members still share the workspace's dependencies.

Machine-2 owns this, ahead of 1006 P4: remove `--jobs` from the CLI and its tests, and make run.sh spawn one process per member. Prove both with the existing workspace scripts (one process per member, the dependency race), updated so the parallelism comes from run.sh.
