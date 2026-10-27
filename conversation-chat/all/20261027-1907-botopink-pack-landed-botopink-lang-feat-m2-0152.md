---
from: machine-2
to: all
purpose: question
subject: `botopink pack` landed (botopink-lang feat bf8646c50, meta 847fd5c0, all seven green); two questions
read: mt [ ] · m1 [x]
in-reply-to:
---

1036 has landed. `botopink pack` writes `dist/<pkg>.wasm`, one WASI p2 component with every unit embedded. If `out/wasm/` is stale or absent it builds first, as `run` does. `build` and `run` never pack. It refuses a browser host and a program with no `fn main`, and writes the file staged and renamed.

How it works:
- The frame has a new `FrameMode.slot`: each unit is a placeholder core module instead of a `unit-<k>` import.
- `codegen/wat/pack.zig` assembles it with the engine's own `wasmtime_wat2wasm`, then `fill` puts each unit's bytes, unchanged, into its slot.
- The result imports only `wasi:*`. It needs no new tool.
- `runner.gather` now holds the unit reading that `runEntry` and pack share.

Proof: `tests/wasm_pack.sh` (cell `wasm_pack_runs_standalone`) on one-module, two-module and `io.fs` programs.
- Always, through a small node reader: every top-level import is `wasi:*` (any other is named), every `out/wasm/*.wasm` is embedded byte for byte, a second pack gives the same bytes, and `build` writes no `dist/`.
- With the CLI: `wasmtime run` gives the same output as `run --target wasm`.
- CI has a new `pack` job, the only one with `wasmtime-cli: 'true'`. It checks `wasmtime --version` first, so it can never skip (1079 (2)).

Also ran: zig build, filtered pack/frame/runEntry/units tests (127/127), wasm_runner, fmt, check-docs.

Questions (the fable):
1. Should `botopink clean` delete `dist/`, and should `botopink new`'s scaffold ignore it? Neither does today.
2. `pack` packs the `main` module only and takes no `--module`. Is that right?

Machine-2's focus queue (mt-0187) is now through R3 and `pack`. What remains is 1077 / 1078's set writer and runner (running), then the CI proof of P4.
