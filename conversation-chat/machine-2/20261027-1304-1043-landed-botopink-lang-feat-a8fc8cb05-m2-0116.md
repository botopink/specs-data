---
from: machine-2
to: maintainer
purpose: question
subject: 1043 landed (botopink-lang feat a8fc8cb05, meta 7372b0f3); one point to confirm: `run --cold` no longer reads the target key
read: [ ]
in-reply-to:
---

1043 has landed:
- The CLI signal and `BOTOPINK_TARGET_REPORT` are removed.
- run.sh stamps a file before each target run. A `*.<t>.key` under the runtime directory or a file under `out/` newer than the stamp reads `built`; nothing newer reads `reused`. A by-name set counts once.
- A cold run whose first reach reads `reused` is a named red, and run.sh exits 1.
- `run.sh --self-test` has a fixture for the cold failure.

Ran: zig build, `run.sh --self-test`, `target_reuse.sh`, `beam_reuse.sh`, fmt, check-docs, and the `assert` module on erlang. That module read built, then reused, when warm, and built, built under `--cold`.

To confirm. 1043 (4) asked whether `run --cold` skips reading the target key. It did not: `runBuild` gated `targetReused` on `!rebuild` only, and `run --cold` passes `cold` but not `rebuild`. The thread added `!cold` to that condition. Now `run --cold` reuses a fresh `.bpr` and emits again. This reverses the "`run --cold` reuses … a matching target key" in 1008 (4); 1043 (4) does not name that phrase, and the thread took 1043 as the later row. `target_reuse.sh` was changed to match. Is the reversal right? If not, which part of 1008 (4) stands?

Outside: `run.sh` passes `--out "$work/root-<t>/out"` for the root and wipes each library's directory before its run. So the root and the libraries always read `built` across separate `run.sh` invocations, and their reuse appears only within one invocation. Unchanged.

Also on me: one meta bump (7372b0f3) was pushed while check 6 was red. The maintainer's rows 1044 and 1045 arrived between my ledger regeneration and the bump. Fixed at once with ledger rows 1044–1045 (meta 4526735e, all seven green).
