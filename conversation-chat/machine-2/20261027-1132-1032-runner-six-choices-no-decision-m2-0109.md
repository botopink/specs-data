---
from: machine-2
to: maintainer
purpose: question
subject: 1032 runner: six choices no decision fixes (each with a recommendation)
read: [ ]
in-reply-to:
---

The fable planned machine-2's piece of 1032, the in-process runner over the wasmtime 49.0.3 C API, which is already linked statically by 543. These six choices are not fixed by any decision:

1. `backend_exec.sh` runs a core module with `wasmtime --invoke main`, and the wasmtime CLI is leaving. (a) Keep installing the CLI only for that test. (b) Move the check to a zig test of the runner that calls a core export. (c) Drop the check. Recommendation: (b). The CI install then leaves.
2. The harness timeout (`RUNTIME_TIMEOUT_NS`) once the program runs in-process. (a) An epoch deadline plus a watchdog thread; SIGINT uses the same epoch. (b) No timeout. (c) Keep spawning the CLI for the harness only. Recommendation: (a).
3. What a trap prints, and its exit status. (a) `wasm trap: <message>` on stderr, exit 1. (b) The CLI's full `Error: failed to run main module` chain. (c) 535's `host: <message>`. Recommendation: (a). The harness takes out the same line it takes today, so the snapshots stay byte-equal.
4. Where the runner lives. 1032 (3) says "in the CLI". (a) compiler-core (`codegen/wat/runner.zig`): the snapshot harness and 1033's comptime need it, and the CLI calls it. (b) The CLI only, with the harness still spawning the wasmtime CLI. Recommendation: (a).
5. Precompile the entry component as well as the units. (a) Yes, with the same folder and key. (b) Units only. Recommendation: (a). A run whose target key matches then compiles nothing.
6. The `wasi:http` half of `wasm_runner_keeps_wasi_p2` when CI has no network. (a) The script starts a loopback server with node. (b) Expect a typed error from an unreachable host. (c) Do what today's http cells do. Recommendation: (c).

Pieces, in order:
- R0 (sonnet): the engine, the per-unit `.cwasm` cache and the import-name probe. Starting now: it needs none of these answers.
- R1 (opus): `run`, `test` and the harness switch to the runner over today's monolithic component.
- R2 (sonnet): composition per unit, after machine-1's P3, with the two cells.
- R3: the wasmtime CLI leaves, once (1) is answered.
