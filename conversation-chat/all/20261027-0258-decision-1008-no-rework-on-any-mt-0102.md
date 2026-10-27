---
from: maintainer
to: all
purpose: rule
subject: Decision 1008: no rework on any target — target-folder keys, per-target dependency-unit cache, wasm run emits only its entry, every cache (wasmtime's too) under .botopinkbuild; pieces T1–T5
read: m1 [ ] · m2 [x]
in-reply-to:
---

Read `specs-bot step 1008`. The fable measured per module: commonJS 0.07 s, erlang 0.41, beam 0.42, wasm 4.4 s — on wasm `run` emits every unit (std, conformance/lib, cases) though only main's component runs: 3.4 s/module of units never executed (≈17 min CPU per wasm row).
Pieces:
- T2 machine-1 (opus), FIRST, after your current P3 step: `run` over a `.bpr` on wasm emits only the entry's component (build keeps everything). Oracle: a lib-only package's `run --target wasm` writes only main.wat, bytes equal to build's; 3.4 s → ~0.1 s.
- T1 machine-2 (opus), with/after 1006 P1: <cache root>/.botopinkbuild/runtime/<pkg>/<target>.key (bpr key, target+host, source stamp, emit options, OTP release + compiler options); matching + entry artifact present → run only executes; `run --cold <file>.bpr` keeps the flag (run.zig:77 drops it today); wasmtime's cache pointed at <cache root>/.botopinkbuild/cache/wasmtime/ via its config (never ~/.cache/wasmtime), cleared with the rest. Cells target_output_reused_when_key_matches (4 targets), target_output_rebuilt_when_bpr_changes, target_output_rebuilt_under_build_cold.
- T3 machine-2 (opus): <cache root>/.botopinkbuild/cache/unit/<target>/ dependency-unit cache keyed by the dependency's .bpr key (Merkle) + target/host + partition (249) + emit options; level B's code folds into it (level B keeps analysis). Under --cold a member may read what this same run wrote. Cell dependency_units_reused_per_target; array erlang 0.26 → ≤0.12.
- T4 machine-2 (sonnet): `built N, reused M` in run.sh, the gate and CI logs.
- T5 machine-1 (opus), with 1006 P5: units of packages loaded by compiler.load(package:) in the same cache.
