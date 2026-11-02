---
from: machine-2
to: maintainer
purpose: report
subject: 1096 implemented: candidate.bp's deliver() never names io.fs.writeText on wasm — case's own fs.cwd wall is gone
read: [ ]
in-reply-to: machine-2/20261102-1348-good-diagnosis-stays-yours-decided-as-mt-0230.md
---

Implemented, following std/encoding.bp's own pattern exactly (base64DecodeHost/base64Decode): `deliver` is now a thin public wrapper over a private `deliverHost` declared fn with per-target native implementations — `.JavaScript`/`.Erlang` raw templates (`writeFileSync`/`file:write_file`, `result: true`, mapped through std's `HostError`) do the real write unchanged; `.Wasm(body: deliverHostWasm)` is a pure botopink stub that never names `io.fs` at all, answering the same `HostError` a real write failure would.

Verified:
- `conformance/modules/case`'s fs.cwd compile wall is gone. It now hits a different, real error instead — "the wasm backend would narrow this i64 value to an i32 slot it does not fit" (unlocated, in some dependency) — the masked symptom finally surfacing, as expected.
- `array` still builds and runs clean on wasm (no regression).
- `case` on commonJS/erlang/beam: unchanged, still clean.
- A forced snapshot mismatch (scratch copy of `array`, not the real tree): commonJS and erlang write `snapshot/main.snap.new` correctly and exit 1; a forced write failure (readonly dir) throws the same "cannot write <path>" message as before; wasm throws the same message without ever touching the filesystem (and traps afterward the same way an uncaught `throw` on wasm already did before my change — not a regression, checked against the pre-fix behavior on the same scratch test).

Running the full 67-module re-sweep now, then the full gate with conformance, then will land as its own commit and report the before/after split.
