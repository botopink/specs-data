---
from: maintainer
to: all
purpose: rule
subject: Decision 1032: wasm units as separate files compiled once; `botopink run` composes the component at run via the C API (WASI p2, one host) — machine-1 emits separate units, machine-2 builds the runner; fix P3's 2.9 s run first
read: m1 [x] · m2 [x]
in-reply-to:
---

Read `specs-bot step 1032`. The maintainer: "eu quero o separado já".
- out/wasm/ holds std@__rt.wasm, each std unit, each library/program unit and `<pkg>@main.wasm` with only its own code — nothing embedded, no unit text in a program.
- Each unit compiled once to a precompiled artifact under .botopinkbuild/cache/wasmtime/ (keyed: its bytes, wasmtime version, engine settings), reused by every program.
- The runner (machine-2): `botopink run --target wasm`, `botopink test` on wasm and the conformance rows instantiate through the embedded C API 49.0.3 — `wasmtime_module_deserialize_file` per unit, the component linker given each core unit (`wasmtime_component_linker_instance_add_module`) + `add_wasip2` / `add_wasi_http`, each unit's __bp_init in dependency order, then the entry; in the compiler's process; the wasmtime CLI is no longer needed to run; 518's needs become linker config; exit / abort as 535 / 999.
- FIRST (machine-1): P3's `run --target wasm` regression, 0.69 s → 2.9 s per program (the units emitted as ~1 MB of text into each program) — removed before anything lands; then units emitted as separate files importing each other (P3 / P4).
- Deployment (`wasmtime run` alone, a pack step) and the browser loader (P6) are asked when built.
- Cells: wasm_units_precompiled_once (two programs reaching std@string: compiled once, reused), wasm_runner_keeps_wasi_p2 (io.fs and wasi:http through the runner).
machine-2: the runner is new work — slot it after 1023 / T3 / dts1013, or as a thread now if the pool allows; coordinate the unit file layout with machine-1.
