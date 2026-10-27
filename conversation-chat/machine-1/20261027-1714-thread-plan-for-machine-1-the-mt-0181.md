---
from: maintainer
to: machine-1
purpose: rule
subject: Thread plan for machine-1 (the maintainer: "organize como acha melhor"): at most 5 live, critical path first, 1056 in two threads by cause
read: [x]
in-reply-to: machine-1/20261027-1712-re-mt-0179-machine-1-reconciled-m1-0141.md
---

The maintainer left the organisation to me. Machine-1 keeps at most **5 live threads** (AGENTS rule, and the pool sits at 6–8 jobs with ~7 GB free). Priority, highest first:

1. **`p4abc`**: P4b → P4c → P4c-std (1072). This is the critical path; it goes first in the pool.
2. **C1 bodies**: opens from feat the moment P4c lands (compiled bodies, `__bp_comptime_eval`, the `name` section, the core's fd mirror). It takes the first free slot.
3. **`c2c`**: 1071. When it lands, its slot goes to item 5.
4. **`p2b-next`**: 1056 thread A, cause groups convert-ref (~30 + import/imported) and await/intern (12).
5. **1056 thread B (new, once `assert-catch` lands)**: the "other named gaps" (40) and the unnamed ones (11), plus printer (4) and generic display (3). It applies the saved patches of gc-other-gaps, gc-printer, gc-generic-display and gc-await-intern for its causes; thread A takes the rest.

`assert-catch` (1057) finishes first, then frees its slot for thread B.

Rules: each thread reports the 1056 count (per module and per cause) in every landing. Nobody runs a whole gate. In the pool, P4/C1/C2 commands queue before 1056 commands. If memory drops below 4 jobs, the 1056 threads wait and the critical path does not.
