---
milestone: 1.0.12-beta
priority: |-
  maximum — where new development is centred (the maintainer, 2026-10-14); beside 144, the second front that
  edits `repository/botopink-lang` (amends 433). Opens after 144's B-00 group (done but its last box, which holds
  nothing back, 479).
repository: |-
  botopink-lang — worktree `--lang`. **Machine:** 2 — the backends-and-tooling machine runs this front,
  in a `--lang` worktree of its own, ahead of every other open step of 144 it holds. **Model:** opus (every step designs or
  changes a runtime).
gate: |-
  standard (fronts.md § Gate) + every wasm `run/` cell's `.out` and every comptime snapshot's `COMPTIME REPLY` unchanged
  at each step — the engine and the memory are never a source of text (434 (5)); a step that rewrites the comptime's
  lowering re-records its `COMPTIME WAT` once per piece and reads the diff (decision 558).
owns: |-
  `modules/compiler-core/src/comptime/runtime/**`, `modules/compiler-core/src/codegen/wat/**`,
  `modules/{std-wasm,beam-to-wasm}/**`, `modules/compiler-web/**`, `build.zig`'s wasm and engine steps,
  `.github/workflows/release.yml`'s engine fetch; the wasm column of every cell. 144 keeps the rest of the repository;
  a 144 step that reaches the wasm target, the comptime runtime or std-wasm waits on this front's s2, never edits them.
depends-on: |-
  nothing open. **Decisions:** 543 (wasmtime-a), 544 (wasmgc-a); amends 434, 440, 448, 449,
  450, 452, 522; 518 (`needs`) and 392 (the scheduler) unchanged.
---
# Front 164 — wasm-gc: the comptime runtime on wasmtime, the wasm target on WasmGC, std-wasm in botopink and `.wat`

Until s2 lands a wasm program allocates as today (a bump heap, exhaustion a trap, 448 (4)) — a known limit of a long
task, written in the reference. The old model's steps are withdrawn: 144 B-30's open boxes, B-25's steps 9 and 11,
the linear-memory rows (B-22-c, B-25-d).

## Alias table

Old ids stay valid in `decisions-taken.md`'s *Where* column and the closed records: each resolves here.

| Old id | Step here |
|---|---|
| 144 B-82 | 164 s1 |
| 144 B-83 | 164 s2 |
| 144 B-84 | 164 s3 |
| 144 B-85 | 164 s4 |
| 144 B-30 box 3 (the program's `alloc` on `heap.zig`) | withdrawn — 164 s2 |
| 144 B-25 steps 9 and 11 (a prebuilt wasm library) | withdrawn as written — a question of 164's once s2 lands |

## Steps

### s1 — the comptime runtime's engine: wasmtime embedded, wasm3 removed (the maintainer, 2026-10-14; question wasmtime-a)

**Repository:** botopink-lang (`--lang`) · **Model:** opus · **After:** 144's B-00 group (479: its last box holds nothing back)

The comptime runtime's engine is the host's (wasmtime-a): wasmtime in the native compiler through its C API, the
page's `WebAssembly` in `compiler-web` as today (`bp_host`); wasm3 goes. std-wasm, the comptime module, its link and
every comptime answer are unchanged (440, 450): the same wasm, compiled instead of interpreted.

- [x] **the engine behind one interface** in `comptime/runtime/persistent_wat.zig`: compile and instantiate a linked
      comptime module, register the host imports (`env.bp_term_alloc`, `env.bp_term_static`, `env.bp_call<N>`, the
      `@embed` reader, every other `env.*` the module imports), call, read and write the module's memory, a trap an
      error — the same contract `compiler-web`'s `bp_host.run_module` serves, so the two engines are one interface
- [x] **wasmtime's C API** fetched by `build.zig.zon`, one prebuilt library per release target (`linux-{x86_64,aarch64}`,
      `macos-{x86_64,aarch64}`, `windows-x86_64`), pinned by hash, linked into `botopink` and `botopink-lsp`; no cargo
      in the toolchain; `release.yml` and `test.yml` fetch nothing more than `zig build` does
- [x] **wasm3 removed:** `modules/wasm3/` deleted, `build.zig`'s `link` / `exposeHeaders` and compiler-core's `@cImport`
      gone; `comptime/runtime/AGENTS.md` limit 1 (a runaway body) re-read for wasmtime (epoch interruption makes a
      Ctrl-C land; no budget, 380 (2))
- [x] **what wasm3 lacked is no longer refused at build:** exception handling (518) on — `attempt` in a decorator, a
      template or a `comptime` answers as in a wasm program, a cell proving it; any other refusal that stood only on
      wasm3's missing feature found and removed, each with its cell
- [x] **start-up measured:** a build with many small comptime modules (jhonstart's `html`, styled) before and after; the
      compiled-module cache under `.botopinkbuild/build/` (B-77's place) or Pulley chosen by the measurement, written
      in `comptime/runtime/AGENTS.md`, never a flag (67)
- [x] every comptime snapshot and every conformance cell unchanged — the answers are std-wasm's, the engine is not a
      source of text (434 (5)); `compiler-web`'s smoke test green
- [x] docs: 434 amended in the reference's "Decided" table; root `AGENTS.md` ("wasm3 inside the compiler",
      § The comptime runtime), `modules/AGENTS.md` (the wasm3 row), `compiler-core/src/comptime/runtime/AGENTS.md`,
      `compiler-web/AGENTS.md`
- [x] **wasm3 gone from the tree** (the maintainer, 2026-10-15): no mention left in botopink-lang — the comments in
      `comptime/runtime/persistent_wat.zig` (the stack bound's two), `comptime/runtime/wat/lower.zig` and
      `comptime/tests/templates.zig`; the headers of the cells `comptime_attempt_at_build`,
      `comptime_deep_structure_equality` and `decorator_lambda_many_locals` (each states its answer, not the engine that
      once failed it); `comptime/runtime/AGENTS.md` (the engine table's wasm3 row and its prose), `runtime/wat/AGENTS.md`,
      `comptime/tests/AGENTS.md`; `git grep -iw wasm3` empty but `decisions-taken.md`

**Impacted tests:** every comptime snapshot (unchanged), `test-conformance`, `test-web`, `release.yml`'s five targets.
**Consumer commits:** none.

Measured (12 builds — jhonstart's 8 examples, styled's 4; the `instance` + `run` stages): wasm3 163–189 ms; wasmtime
cold 1.0–1.3 s; Pulley 1.5 s; wasmtime with the compiled-module cache under `.botopinkbuild/build/comptime/` warm 48 ms —
the cache is the choice. The binary grows from 53 MB to 74 MB; an artifact linking wasmtime on Linux links with LLD.
543-a answered by 878.
- [x] the interrupt (878): the CLI's SIGINT handler and the LSP's `$/cancelRequest` / `shutdown` call `persistent_wat.interrupt()`;
      `comptime-interrupted` located at the body; `runtime/AGENTS.md` limit 1 rewritten; a unit test
      — built as: the CLI's SIGINT handler (exit 130; a second SIGINT ends the process, 901) and the language server's
      reader thread (`shutdown`, `$/cancelRequest` of the request being dispatched) call `interrupt()`; `comptime-interrupted` from the
      `comptime`, decorator and template evaluators; `attempt` at build catches an integer division by zero (878 (3)); no cell yet for
      either (front 166's row 878)

s2 onward (the wasm codegen in WasmGC, `defer` and backend defects on wasm, std-wasm rewritten, and this front's
Conformance) moved to front 170 (conformance-complete) as s7–s11; see its Alias table.
