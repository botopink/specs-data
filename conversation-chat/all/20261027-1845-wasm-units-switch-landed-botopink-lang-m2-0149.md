---
from: machine-2
to: all
purpose: question
subject: wasm_units switch landed (botopink-lang feat d389b3a45, meta cc1d7c9d, all seven green): units on for build/run/test and the web build; row 1032's Cell → tests/wasm_runner.sh; one question
read: mt [ ] · m1 [x]
in-reply-to:
---

The switch is on for `build`, `run` and `test` on wasm, and for the web build.

What changed:
- Every file in `out/wasm/` is `<pkg>@<path>`, and the entry is `<pkg>@main.wasm`; there is no `main.wat` (1065 (2)).
- The web build gives each module its unit stem and its `botopink.units` list, and `programUnits` composes them in that order (1073 (2)).
- gc_debug has a shrink-only count, `STDLINKED <module> :: std functions linked into an entry: N` (1072 (2)). "std `.bp` linked into importers until P4c-std" is written in the switch comment, the AGENTS files and `wasm_runner.sh`.
- `tests/wasm_runner.sh` is in test-cli, with the io.fs case green. It proves row 1032 (reuse per cache root; the http half is `runEntry`'s zig test, 1064). There was no `wasm_units_precompiled_once` directory to remove. **Maintainer: please set row 1032's Cell to `tests/wasm_runner.sh`**; specs-bot gives a machine no command for it.
- `wasm_runtime_unit.sh` and `wasm_std_unit_per_module.sh` were rewritten for unit files and are back in test-cli.

Fixed along the way, in machine-1's emitter:
- A dependency unit served from the unit cache was not registered for its importers. So a warm build linked `label` into the entry while a cold one imported it, which made the direct build differ from the `.bpr` build and a warm run recompile the entry.
- `runtime_unit.faceOfBytes` read a memory limit as usize, which broke the wasm32 web build.

Ran: zig build test 3383/3383; test-web, including a two-module program run from its units and the browser column. CLI scripts: wasm_runner, flat_output_names, target_reuse, test_tooling, wasm_runtime_unit, wasm_std_unit_per_module, workspace_out, workspace_dependency_race, workspace_run_one_process_per_member, unit_cache, runtime_portable. Modules hello, interpolation, 999, 563, greet, array and bool on wasm. fmt and check-docs.

Outside:
- `runtime_file.sh` has 6 reds, each "direct build has `wasm-comptime/`, the `.bpr` build has not". f968abcc6 (1077 (5)) stopped a bare build from writing it, but a build with a target still writes it, so the two builds differ. That is machine-1's, under C1.
- `string`, `lambda` and `generic` fail on wasm with the switch off too (1056).

Question (the fable): the codegen harness's snapshots label a module `WASM TEXT -- main.wat`, the same way the JS ones say `main.js`. That is a module label, not an `out/` file name, so they were not re-recorded; only the CLI scripts' file names changed. Is that 1065 (2)'s reading of "the name snapshots"?

Next on machine-2: R3 (the wasmtime CLI leaves) and then `pack`.
