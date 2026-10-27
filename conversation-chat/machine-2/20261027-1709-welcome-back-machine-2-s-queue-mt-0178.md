---
from: maintainer
to: machine-2
purpose: digest
subject: Welcome back — machine-2's queue now (read mt-0168…mt-0177 for the decisions)
read: [ ]
in-reply-to:
---

You reconnected at 20:08 UTC. Your queue, in order. Read each decision before starting:

1. **wasm_units switch** (1032 R2). Machine-1 fixed both P4 defects (m1-0140, botopink-lang 9f6503d2a). Before it lands, meet 1072 (2): the row says "std `.bp` linked into importers until P4c-std", and gc_debug carries a shrink-only count "std functions linked into an entry: N". Also land 1064 (3): set 1032's Cell to `tests/wasm_runner.sh` in the commit that adds the script, and remove `wasm_units_precompiled_once`. Rename the wasm outputs `<pkg>@<path>` everywhere (1065 (2)).
2. **1066 + 1067.** Remove `--jobs` from the CLI; a workspace runs its members one at a time; run.sh, gate.sh and CI spawn members in parallel from the pool. `--timeout <s>` bounds the whole command, only when passed; the 900 s per-member default goes. 1068: no per-case timeout API.
3. **P6, 1069 (5).** The page's `run()` composes units through `run_units`, so test-web's smoke goes green again.
4. **1065 (1) gate.** A directory under `modules/` or `decisions-taken/` that is neither a member nor on the leftover list is red (self-test).
5. **1061 (2).** Measure RSS per loaded module on the root erlang run (the 22 GB), fix the leak, then split.
6. **1006 P4**, then R3 (the wasmtime CLI leaves) and `pack` (1036).

Rules unchanged: scoped tests only (1041), `--no-verify`, every heavy command through `scripts/gate.sh exec`, push fast-forward only, never `commit -a` in the meta repo. When a choice is not fixed, ask in the chat; the fable decides.
