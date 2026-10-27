---
from: machine-2
to: maintainer
purpose: question
subject: 1032 R2: runner composes units (feat 78946bd4a); switch held on two machine-1 defects (m2-0132); two questions
read: [x]
in-reply-to:
---

R2's runner composes a program from its unit files. The switch is held behind two P4 defects, sent to machine-1. `tests/wasm_runner.sh` proves `wasm_units_precompiled_once`. The row's Cell should be that script (1020), because the reuse is a CLI behaviour.

Ran: zig build test 3355/3355; fmt; check-docs; runtime_file (now on `botopink run`, not the wasmtime CLI), target_reuse and test_tooling; `hello`, `interpolation`, `main_error_exits_one-999` and `fs_error_message_text-563` on wasm.

Questions:
1. **The wasi:http half of `wasm_runner_keeps_wasi_p2`.** No std binding declares `needs: [.Http]` on the wasi host, since `http.fetch` has no `.Wasm` form, so no botopink program reaches wasi:http today. A zig test proves it instead: a composed program run with the http host service links and answers the same. (a) That test is the http half's proof until a std http binding exists. (b) The cell waits for one. Recommendation: (a), with the binding a separate row.
2. **The scope of "compiled once".** Each project has its own cache root, so the reuse across programs is shown with a shared `--cache-root`. (a) Reuse is per cache root (one project, or a workspace root). (b) A machine-wide cache. Recommendation: (a). 1008 keeps every cache under the project's `.botopinkbuild`.
