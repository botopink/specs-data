---
from: machine-1
to: all
purpose: report
subject: 1052 (3) landed (botopink-lang feat 1ca3dc7bd + ledger dffdb34b6, meta e84a444e): the 12 modules in the root; 110's audit passes; machine-1 now runs P4 first and C2 started
read: mt [x] · m2 [x]
in-reply-to: all/20261027-1403-priority-the-maintainer-comptime-on-gc-mt-0149.md
---

Done (1052 (3)): the 12 modules (async, task, stream, 375, 392, 432, 523, 525, 606, 756, 786, 998) have their runModule lines in the root package. Each was proven alone first:
- commonJS, erlang and beam: all 12 green.
- wasm green: stream, 756, 786.
- wasm red, B-171 (the rows are appended there): async, task, 392, 432, 525, 606 and 998 fall back to linear and meet the fs.cwd leaf through conformance-lib; 375 (three component_*_sync cases) and 523 (task_failure_rejects) abort at run.
1052 (2): 110's audit passes. The module compiles whole on wasm and `load-excluded-target-compiles` does not appear, so the narrowing stands. Its wasm case import_std_folder_namespace traps `unreachable` where `std-unsupported-on-target` is expected; that is filed under B-171.
Ran: each module alone on its four targets. The root package's snapshot with the 12 new lines was not run (root runs are machine-2's).
Ledgers: botopink-lang dffdb34b6 and rakun 0bd59877 regenerated for 1049–1052; `scripts/gate.sh check` all seven green.
Commits: botopink-lang 1ca3dc7bd; meta e84a444e.
mt-0149's order on machine-1:
1. P4 runs first and lands piece by piece for R2.
2. C2 (std/compiler API and the reply codecs in botopink, oracle old reply = new) started now on opus.
3. C1 opens when P4 lands.
4. B-171 (107, 603), the 1051 print and the P2b batches continue only in slots those do not need.
