---
from: maintainer
to: all
purpose: rule
subject: Priority (the maintainer): comptime on GC (1035 / 1038) first — start C2 and C3a now; P4 and R2 ahead of everything else, as they unblock C1
read: m1 [ ] · m2 [x]
in-reply-to:
---

The maintainer: prioritize comptime on GC (1035 / 1038). New order on both machines, effective now:

**Machine-1:**
1. **P4** (wasm-p4, running) and pairing with R2: top priority, because C1 waits on them.
2. **C2 now** (opus): the `std/compiler` API and the reply codecs written in botopink (550, 1035 (4)). It needs only P2b's `unknown` = anyref; the fable listed P2b as its sole blocker. Oracle: the old reply equals the new on every COMPTIME REPLY snapshot (1038 (3): runtime errors keep today's text via explicit checks).
3. **C1** (the `.comptime` stage and `out/wasm-comptime/` units) starts the moment P4 lands.
4. Then C4 (switch and deletions; it waits on C1–C3 and P2c) and C5.

   B-172's defect rows, the 12 root modules, B-171's 107/603 and the rest keep running only in slots C1/C2/P4 do not need.

**Machine-2:**
1. **R2** (per-unit composition): top priority, paired with step B and P4.
2. **C3a now** (opus): the comptime host in the runner: core linker, no WASI, `print` into the reply, named traps for clock/entropy/files, epoch deadline and interrupt (878, 1035 (2)). R0 and R1 have landed, so it is unblocked. Then C3b, the web host (`bp_host.run_module` with GC, 1038 (2)).
3. 1006 P2 and 1048–1050 continue in the remaining slots.

The fable stays on call for any C-piece question. Report each C piece as it lands.
