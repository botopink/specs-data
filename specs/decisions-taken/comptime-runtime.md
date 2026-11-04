---
scope: >-
  Decides where comptime runs — on the wasm runtime only, under wasmtime (Cranelift with the
  compiled-module cache) natively and the page's engine on the web; the BEAM comptime runtime and
  wasm3 gone — and that its answer is one text whatever the target: std-wasm's text and case mapping,
  the seeded random stream, interrupts, snapshots. Host cells at build are host-functions; the wasm
  target's runtime is wasm-target-and-runtime.
terms:
  - 'wasmtime'
  - 'Cranelift'
  - 'Pulley'
  - 'wasm3'
  - '`persistent_wat.zig`'
  - '`persistent_wat.interrupt()`'
  - '`comptime-interrupted`'
  - '`COMPTIME REPLY`'
  - '`COMPTIME WAT`'
  - 'std-wasm'
  - 'beam-to-wasm'
  - 'Mulberry32'
  - '`random.seed`'
  - '`env.bp_random_f64`'
  - '`std:random.float`'
  - '`otp.check`'
  - '`string:uppercase`'
  - '`zig build gen-unicode`'
  - '`.botopinkbuild/build/comptime/`'
related:
  - 'host-functions'
  - 'wasm-target-and-runtime'
  - 'strings-bytes-and-text'
  - 'numbers-and-arithmetic'
  - 'caches-and-build-outputs'
  - 'conformance-suite'
binds:
  - '`01-compiler/14`, `18` (re-pointed)'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` 164 s3'
  - '`1-botopink-lang/144` B-00a–B-00e'
  - '`1-botopink-lang/144` B-00b, B-00c'
  - '`1-botopink-lang/144` B-00c'
  - '`1-botopink-lang/144` B-00e'
  - '`1-botopink-lang/144` B-00g'
  - '`1-botopink-lang/144` B-00h'
  - '`1-botopink-lang/144` B-00j'
  - '`1-botopink-lang/144` B-78'
  - '`machine-2/144` B-77'
  - '`machine-2/164` s1'
retired:
  - 'The BEAM comptime runtime (`persistent_beam.zig`, `runtime/beam/**`, the persistent `erl` spawn, `render_resident`''s erl step)'
  - 'wasm3, `modules/wasm3/`'
  - 'The linear-memory model of a wasm program; `std_wasm.wasm`, `heap.zig`, the Erlang term library'
  - 'The Zig-built wasm runtime (440, 442''s split, `$__std_sp` 447, the heap per task 448/449/522/542, two tables 454)'
  - '`snapshots/codegen/{beam,wat}/<target>/`'
  - 'the commonJS departures `string_trim_keeps_nbsp`, `string_lower_final_sigma`'
first-step: 434
last-step: 901
in-force: 15
superseded: 1
---
# comptime-runtime — one runtime for every target's build, on wasm

**Comptime runs on wasm only, on wasmtime in the native compiler and the page's engine on the web; one answer whatever the build's target.**

(1) One runtime on wasm; `erl` only for an erlang / beam build; beam-to-wasm a utility — 434, 436, 438.

(2) The engine: wasmtime, Cranelift with the cache, SIGINT and cancel — 543, 878, 901.

(3) The comptime compiled by the wasm GC backend, no Erlang layer — 550.

(4) One text: wasm, commonJS, case mapping, `NaN` / `Infinity` — 441, 443, 444, 521.

(5) Random at build: the seeded stream, an unseeded draw refused — 451, 456.

(6) Snapshots: one line per foreign function, `COMPTIME REPLY` the oracle — 446, 558.

(7) Superseded: 449 (544).

Steps: 434, 436, 438, 441, 443, 444, 446, 449, 451, 456, 521, 543, 544, 550, 558, 878, 901, 918
Binds: `1-botopink-lang/144` B-00a–B-00e · `01-compiler/14`, `18` (re-pointed) · 341 · 378 (4) · `1-botopink-lang/144` B-00c · 434 · 228 · `1-botopink-lang/144` B-00b, B-00c · 434 (3) · 435 · `1-botopink-lang/144` B-00e · 440 · 434 (5) · `1-botopink-lang/144` B-00g · 441 · 442 · `1-botopink-lang/144` B-00h · `1-botopink-lang/144` B-00j · 451 · 452 · 454 · `1-botopink-lang/144` B-78 · `1-botopink-lang/144` · `1-botopink-lang/144` 164 s3

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 434 | (comptime, the maintainer, 2026-10-10) | Comptime runs on wasm only — the first thing the milestone does. (1) One comptime runtime: every target's comptime evaluation — decorator, template, `comptime` block, a host cell reached at build — runs on the wasm runtime (`persistent_wat.zig`, `runtime/wat/**`; the engine is 543's, wasm3 retired). The BEAM comptime runtime is deleted — `persistent_beam.zig`, `runtime/beam/**`, the persistent `erl` spawn, `render_resident`'s erl step, `runtime.parity`'s BEAM half; never a persistent Erlang process of any kind. The erlang and beam targets are unchanged — lowering, snapshots and tests stay (`erl` still needed by their build, 436). `snapshots/codegen/{beam,wat}/<target>/` is retired for `snapshots/codegen/<target>/`. (2) `modules/std-wasm/`: std's host functions compiled to wasm, served to the comptime runtime and transpiled into the user's `--target wasm` output (440, 442); its Zig implementation is retired for botopink logic over hand-written `.wat` leaves (544, 550, 560). (3) `modules/beam-to-wasm/`: a standalone utility with no role in botopink (438, 452; deleted with 164's B-84, 544). (4) Resolution at build: 452 (1) — a `std:` cell, else a `.Wasm(body: f)` cell, else refused at the call. (5) One answer: a comptime result is the runtime's answer, whatever the build's target (`string:uppercase` of non-ASCII text, float formatting: one text for the four targets). (6) First: front 144's B-00 group opens before any other step of any front; front 14's and 18's open steps move into 144; the wat runtime's limits (`limit 1`…`4`, the core-module subset, `i64` overflow) are the only runtime's limits (depth of `==`: 471). Amends 84. The render-resident / at-build path of 378 (4) is `434-b` (594's) | `1-botopink-lang/144` B-00a–B-00e · `01-compiler/14`, `18` (re-pointed) · 341 · 378 (4) | comptime_runs_on_wasm |
| 436 | 434-c | `botopink build --target erlang\|beam` keeps needing `erl`; only comptime stops needing it: the erlang and beam targets keep 228's OTP release check and the in-memory OTP compile of the emitted `.erl` (`compiler-cli/src/cli/build.zig`, `otp.check`); "a compile spawns no `erl`" is measured by `botopink check --target erlang\|beam` (the whole comptime pass) and `botopink build --target commonJS\|wasm`, with no `erl` on `PATH` | `1-botopink-lang/144` B-00c · 434 · 228 | erl_needed_only_by_erlang_build |
| 438 | (comptime, the maintainer, 2026-10-11) · (process) | `beam-to-wasm` is a utility: `.beam` in, wasm out, on std-wasm, nothing of botopink (deleted with 164's B-84, 544). (1) A standalone translator: it takes `.beam` files — erlc's output or any BEAM compiler's (Erlang, Elixir, Gleam …) — and translates them to wasm whole module by module, following the calls between the modules it is given; it reads bytecode, never the source language. (2) Its one dependency is std-wasm: a BIF or an OTP function (`lists:reverse/1`, `string:uppercase/1`, …) is served by std-wasm's implementation (its OTP table, 450), never translated from OTP's own `.beam`; an OTP function std-wasm lacks, or an opcode the translator does not convert, is a located refusal naming the function and what is missing — a std-wasm or beam-to-wasm row, never a caller's workaround. (3) No link to botopink the language: no botopink AST, manifest, `bpmp`, library resolution or diagnostic type in `modules/beam-to-wasm`; it imports Zig's `std` and std-wasm only; nothing in botopink calls it (452) | `1-botopink-lang/144` B-00b, B-00c · 434 (3) · 435 | beam_to_wasm_translates_beam |
| 441 | 434-f | A wasm program prints std-wasm's text: where std-wasm's answer differs from the JS engine's, a `--target wasm` program answers std-wasm's — the text of erlang, beam and the comptime (434 (5)): `"${5.0}"` and `5.0.toString()` are `5.0`, `1.0e21` prints `1.0e21`, `trim` uses std-wasm's set (space/tab/LF/CR/VT/FF; a NBSP stays). A wasm program and its own comptime agree (`comptime "${x}"` and `"${x}"`). commonJS answers the same text (521, amending this row's last sentence). The wasm `.out` of each cell that changes is re-read one by one, never bulk-accepted | `1-botopink-lang/144` B-00e · 440 · 434 (5) | wasm_prints_std_wasm_text |
| 443 | 440-b | std-wasm maps case over all of Unicode; wasm and the comptime answer `É`: `toUpper` / `toLower` are implemented in std-wasm from the Unicode data `unicode` already generates (`zig build gen-unicode`), bound by `std:` (440); the comptime's limit 3 is retired; erlang / beam keep `string:uppercase` / `lowercase`, commonJS answers std-wasm's mapping (521); where the JS engine and OTP differ (special casing such as `ß`, the final sigma) std-wasm answers OTP's, as 441 does for text; the build measures each such case | `1-botopink-lang/144` B-00g · 440 · 441 · 442 | wasm_unicode_case_mapping |
| 444 | 440-c | `NaN`, `Infinity` and `-Infinity` print as those words on wasm — std-wasm answers the words commonJS prints (OTP has no such floats; erlang's `badarith` is its arithmetic, not the formatting) | `1-botopink-lang/144` B-00e · 441 | wasm_prints_nan_infinity |
| 446 | (snapshots, the maintainer, 2026-10-11) | A codegen snapshot shows a transpiled std-wasm function as one line, never its body (558 extends it to every dependency): in a wasm codegen snapshot's module text each function transpiled from std-wasm (440; `std_wasm.wasm` retired for `.wat` leaves, 544) is one line — `;; std:hash.contentHash — from std_wasm.wasm (sha256 <first 12 hex of the function's bytes>)` —, its body omitted; the binary the RUN LOG runs is complete, the RUN LOG proves the behaviour, std-wasm's unit tests the implementation; `botopink build --target wasm` still writes the whole `.wat` | `1-botopink-lang/144` B-00h · 440 | codegen_snapshot_std_wasm_one_line |
| 449 | (wasm, the maintainer, 2026-10-11) | Overtaken by 544 | `1-botopink-lang/144` B-30 · 438 · 442 (1) · 447 · 448 | std_wasm_owns_heap |
| 451 | 442-b | The seeded random's stream is std-wasm's; the entropy stays the host's; a build never draws unseeded. (1) The seeded stream (Mulberry32) and its state are std-wasm's, bound by `std:` cells on `io/random.bp`'s `seed` / `seededFloat` (and the functions over them). (2) An unseeded draw calls an import `env.bp_random_f64` that `std_wasm_link.zig` binds to the program's `$__wasi_random_f64` — the host's entropy, in `wat_prelude` (442 (3)). (3) At comptime the seeded stream answers (the same value on every build for one seed); an unseeded draw is refused at the call, located, with 456's message | `1-botopink-lang/144` B-00g · 442 | seeded_random_std_wasm |
| 456 | 451-a | `random.float()` has a `std:random.float` cell: every unseeded draw at build is refused with one message. (1) std-wasm's `exports` gains `random.float () -> f64`; `libs/std/src/io/random.bp` binds `float` with `std:random.float` beside its JavaScript and Erlang cells. (2) In a wasm program it draws the host's entropy through `env.bp_random_f64` (451 (2)); commonJS (`Math.random`), erlang and beam (`rand:uniform`) unchanged. (3) At comptime it raises 451's refusal — `` an unseeded draw: a build has no entropy, call `random.seed` first (decision 451) `` — as `seededFloat()` before a `seed` does, never `comptime-host-cell-unavailable` (retired, 594) | `1-botopink-lang/144` B-00j · 451 · 452 · 454 | unseeded_random_refused_at_build |
| 521 | B-78-a | commonJS answers std-wasm's text wherever it differs from the JS engine's, as erlang, beam and wasm do (434 (5); amends 441's last sentence): an `f64` written as text (`"${x}"`, `x.toString()`, `"n=" + x`, `print(x)`) is `5.0` / `1.0e21`, an imported record's `f64` field included; `trim` uses std-wasm's set (a NBSP stays); case mapping is std-wasm's (`"ΟΔΟΣ".toLower()` is `"οδοσ"`). commonJS calls helpers, not the engine's `trim` / `toLowerCase` / number text. B-78 widens to `trim` and case mapping; the commonJS departures `string_trim_keeps_nbsp` and `string_lower_final_sigma` are removed, the cells answering std-wasm's text on every target | `1-botopink-lang/144` B-78 · 441 · 434 | commonjs_text_matches_std_wasm |
| 543 | wasmtime-a | The comptime runtime's engine is the host's: wasmtime in the native compiler, the page's engine on the web; wasm3 removed. The native compiler (`botopink`, `botopink-lsp`) embeds wasmtime through its C API — a prebuilt library per release target, fetched by `build.zig.zon` and pinned by hash, no cargo in the toolchain; `compiler-web` keeps the page's `WebAssembly` (`bp_host.run_module`). wasm3 and `modules/wasm3/` are removed (amends 434's "wasm3 inside the compiler"). std-wasm does not change (440, 450): the same module linked into the same comptime module, compiled instead of interpreted — one engine runs a `--target wasm` program and its comptime. What was refused at build only because wasm3 lacked the feature is refused no more: exception handling (518), so `attempt` runs in a comptime body as in a wasm program. The compiled-module cache (under `.botopinkbuild/build/`, B-77's place) or wasmtime's Pulley interpreter is the step's measured choice for the build's start-up cost, never a flag (67); Cranelift with the cache is 878's. Front 164 wasm-gc s1 (was 144 B-82), after the B-00 group; the comptime keeps its arena (449 (4)) | `1-botopink-lang/144` | comptime_runs_on_wasmtime |
| 550 | 164-s3-a | Once the Zig term library goes, the comptime is compiled straight by the wasm GC backend and the Erlang layer is deleted: a `comptime` body is compiled by the wasm GC backend like any program — no Erlang lowering of comptime code (`comptime/runtime/wat/lower.zig`, `runtime_module.zig`), no term library (`term.zig`, `otp/*`, `term_faces.zig`); the preludes, the reply's codecs (what `COMPTIME REPLY` carries) and any Erlang-term function the comptime still needs are written in botopink and compiled by the same backend; supersedes the "Erlang-term functions the comptime still needs" reading of 544's std-wasm part; the reply each comptime cell answers is unchanged (434 (5)) | `1-botopink-lang/144` | comptime_compiled_by_wasm_gc |
| 558 | 164-s3-b · (process) | A snapshot shows the bodies of the module under test only; a comptime snapshot's answer is its `COMPTIME REPLY`. (1) A snapshot — a `COMPTIME WAT` listing, a wasm codegen snapshot, any listing of emitted code — writes in full only the module under test and the code the compiler generates for it; a function of any other package, std or an external library, whatever its source (`.bp`, a `.wat` leaf, the retired `std_wasm.wasm`), is one line naming it with its hash, its body omitted; the binary that runs stays complete; extends 446 to every dependency; one snapshot per module, as the conformance cells' `snapshot/output/<module>.snap` (rakun's `conformance/`). (2) Where a step rewrites the comptime's lowering (164 s3, 550), every `COMPTIME REPLY` and every conformance cell's text stay byte for byte, the oracle; the `COMPTIME WAT` is re-recorded once per piece and its diff read against what the piece changes, a change outside it a red; where a step leaves the lowering alone (an engine, s1) the whole snapshot stays | `1-botopink-lang/144` 164 s3 | snapshot_shows_module_under_test |
| 878 | 543-a · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 2" — decided by the fable at the maintainer's delegation; rejected: Winch (it compiles neither exceptions nor GC), no interrupt handler, a division excluded at build, a cache size bound now) | The comptime engine stays Cranelift with the compiled-module cache; a build is interrupted through `persistent_wat.interrupt()` by the CLI's SIGINT and the LSP's cancel, ending as a located error; `attempt` at build catches what it catches in a wasm program; the cache is B-77's to reap. (1) Winch is out: the engine turns exceptions on over s2's GC comptime module. (2) The CLI's SIGINT handler calls `interrupt()`; the build ends with `comptime-interrupted`, located at the running body's expression (380 (2)'s shape), exit 130; the LSP calls it on `$/cancelRequest` of the request running the body and on `shutdown`; no budget. (3) In a wasm program an integer division by zero is checked and raised, not trapped (527 (3)), so the build catching it is 434 (5)'s one answer. (4) The cache under `.botopinkbuild/build/comptime/` is reaped by `botopink cache` / `clean` (B-77); no size bound | `machine-2/164` s1 · `machine-2/144` B-77 · the LSP | |
| 901 | 878-a · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: (b) every SIGINT only interrupting, the process never ended while a body runs — a SIGINT missed between a body's start and its epoch deadline would leave a hung build with no way out) | During a comptime body the first SIGINT interrupts it — `persistent_wat.interrupt()`, the build ending `comptime-interrupted`, exit 130 (878 (2)); a second SIGINT, or one with no body running, ends the process at once. (1) The second is the fallback for an interrupt the epoch missed. (2) The LSP's cancel and shutdown are unchanged (878 (2)). No cell: the CLI's signal handling is a unit test's, as 878's | `machine-2/164` s1 | |
