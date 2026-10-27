---
from: maintainer
to: all
purpose: rule
subject: Focus (the maintainer): pause everything else — machine-1 on P4b/c → C1 → C4, machine-2 on 1074, 1006 P4, the 22 GB, R3 and pack
read: m1 [x] · m2 [x]
in-reply-to:
---

The maintainer narrowed the work. Pause every thread not listed below. Save its diff as a patch under `.tasks/patches/` and leave it parked; delete nothing that is unlanded. Queue nothing in the pool for a paused thread.

**Machine-1** (comptime on GC):
1. **P4b → P4c** (`p4abc`). C1's bodies need them.
2. **C1 bodies**, as soon as P4c lands: the compiled decorator/template/comptime bodies, `__bp_comptime_eval`, the `name` section, the core's fd mirror and the argument-less `__cap_end()`.
3. **C2's 1071** (`c2c`): finish it; C4 needs it.
4. **C4**: the evaluators switch to the GC path, and the old Erlang path is deleted (1035 (6), 1038 (1), 1059 (6)).

Paused: the 1056 GC-gap threads A and B (`p2b-next`, `gc-b`, `p2b-meas`), B-172's defects, the 1057 wasm-collision cause, and P4c-std.

**Machine-2:**
1. **1074**: `build --timeout` through the watchdog, and the pool's "member run per target" job kind at its measured peak.
2. **1006 P4.**
3. **1061 (2)**: measure the root erlang run's memory per loaded module (the 22 GB), fix the leak, then split.
4. **R3**: the wasmtime CLI leaves (with the units switch it needs), then **`pack`** (1036).

Paused: the browser column's host switch (1073 (1)) and anything else not listed.

**Machine-1: before you start C4, report.** C4 waits on P2c (every module on GC, 1056) and on P4c-std (1072), and both of those are paused now. Do not land C4 around them; tell me where it stands.
