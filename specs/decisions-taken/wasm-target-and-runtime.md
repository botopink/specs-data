---
scope: >-
  Decides the wasm target: the `wasi` and `browser` hosts, WasmGC values (front 164, the linear model
  discontinued), the hand-written `.wat` runtime and what Zig keeps, std's `std:` / `.Wasm` cells,
  what has no wasm binding, cycles and tuples in GC form. Tasks on wasm are
  body-markers-async-and-iter; `attempt` on wasm is result-and-failure; a `.Wasm` cell's forms are
  host-functions.
terms:
  - '`wasi`'
  - '`browser`'
  - 'wasmtime'
  - 'WasmGC'
  - '`needs: [.Gc]`'
  - '`.wat`'
  - '`wat_prelude`'
  - '`repr.zig`'
  - '`$arr_any`'
  - '`$str`'
  - '`std:`'
  - '`memory.grow`'
  - '`log.fileSink`'
  - '`io/fs.workingDir`'
  - '`bp_wat_rt.wasm`'
  - 'std-wasm'
  - 'front 164'
  - '`fn main`'
related:
  - 'host-functions'
  - 'body-markers-async-and-iter'
  - 'result-and-failure'
  - 'comptime-runtime'
  - 'backends-and-run-time-output'
  - 'std'
open:
  - '405: `log.fileSink` on wasm is revisited when a front needs it — a real file on `wasi` once `01-compiler/140` has `wasi:filesystem`, or a build-time refusal'
  - '241: which directory a wasm program sees returns with a std restructure'
binds:
  - '`03-bundled-libs/106` step 3 (box 1''s wasm column, box 3)'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` 164 s2'
  - '`1-botopink-lang/144` 164 s3'
  - '`1-botopink-lang/144` B-00a, B-00c, B-00e'
  - '`1-botopink-lang/144` B-00g'
  - '`1-botopink-lang/144` B-00i'
  - '05-wasm'
  - '18-comptime-runtimes'
retired:
  - 'The linear-memory model of a wasm program; `std_wasm.wasm`, `heap.zig`, the Erlang term library'
  - 'The Zig-built wasm runtime (440, 442''s split, `$__std_sp` 447, the heap per task 448/449/522/542, two tables 454)'
  - '`stdWasmSymbol`''s implicit match-by-name table; the `body:` a `std:` cell replaces (`contentHashBody`)'
  - '`bp_wat_rt.wasm` and its build step'
  - 'a program without `fn main` running (wasi''s `no exported instance named wasi:cli/run`, an exit 0, a raw `error:undef`)'
first-step: 241
last-step: 568
in-force: 12
superseded: 4
---
# wasm-target-and-runtime — hosts, WasmGC, the hand-written runtime, std's wasm forms

**A wasm build binds to the runtime it runs on; a program's values are WasmGC's; the language's wasm runtime is hand-written `.wat`, its logic in botopink; a wasm program answers as every other target does.**

(1) No wasm binding; the linear heap until B-83 — 241, 261, 405.

(2) std-wasm, the prelude split — 440, 442, 450; overtaken 447, 448, 454, 542.

(3) Hand-written `.wat`, leaves, cycles, tuples — 560, 549, 555, 568, 566.

(4) `fn main` missing — 517.

Steps: 241, 261, 334, 335, 405, 440, 442, 445, 446, 447, 448, 449, 450, 451, 454, 455, 456, 505, 517, 522, 531, 542, 544, 549, 550, 555, 558, 559, 560, 565, 566, 568, 569, 585, 618, 641
Binds: 05-wasm · 02 · 18-comptime-runtimes · `01-compiler/140` · `02/97` steps 11, 17 · `05-wasm` · front 18 · `02/98` (the manifest key) · `lib-test-runner` (the wasm column) · `03-bundled-libs/106` step 3 (box 1's wasm column, box 3) · `language-gaps.md` (the file-system row) · `1-botopink-lang/144` B-00a, B-00c, B-00e · 434 (2), (4) · 238 · `1-botopink-lang/144` B-00g · 440 · 441 · 440 (3) · 442 (4) · `1-botopink-lang/144` B-30 · 447 · 392–394 · 438 · 442 (1) · 448 · `1-botopink-lang/144` B-00i · 438 (2) · 449 · 442 · 445 · 450 · `1-botopink-lang/144` B-00j · 451 · 452 · 454 · `1-botopink-lang/144` B-25 · 392 · `1-botopink-lang/144` · `1-botopink-lang/144` 164 s2 · `1-botopink-lang/144` 164 s3 · 164 s2 · `1-botopink-lang/144/machine-2-backends-tooling/164-wasm-gc` s3 P2

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 241 | 05w-b | `io/clock.offsetMinutes`, `io/fs.workingDir` and `io/fs.scratchDir` have no wasm binding: under 146 `io/clock` and `io/fs` stay refused on wasm (group 3 of 230); a value WASI does not define is refused, never invented; which directory a wasm program sees returns with a std restructure | 05-wasm · 02 | wasm_clock_fs_refused |
| 261 | 05w-e | Until 164 B-83 (544): every allocation goes through a helper calling `memory.grow` when the heap passes `memory.size`, a failed grow trapping; `wat_ast` gains `memory.size` / `memory.grow`, the binary emitter its two opcodes; memory is bounded by the host; the heap itself is 448/449's | 05-wasm · 18-comptime-runtimes | wasm_heap_grows |
| 405 | 106-a | **`log.fileSink` is one API on every target; on wasm, both hosts, it answers a named `Error`.** The four file cells (`appendLine`, `fileBytes`, `moveFile`, `removeFile`) get a wasm `body:` reaching no file, so `log` imports on every build (349, 146) and `consoleSink` works; `fileSink` writes nothing and drops nothing silently: `try fileSink(LogFile(path: "app.log", maxBytes: 10485760l, maxFiles: 7), Format.Ecs, levels)` → `Error("log.fileSink: a wasm program has no file system - use consoleSink")`, at run time, at the one call not served; revisited when a front needs it — a real file on `wasi` once `01-compiler/140` has `wasi:filesystem`, or a build-time refusal | `03-bundled-libs/106` step 3 (box 1's wasm column, box 3) · `language-gaps.md` (the file-system row) | log_file_sink_errors_on_wasm |
| 440 | 434-e | **std-wasm is the wasm codegen's and the comptime's one implementation, bound by `std:` cells** (the Zig transpilation of (2) is superseded by 544, 550, 560: std-wasm's logic is botopink, its leaves hand-written `.wat`). (1) A std function std-wasm implements answers by std-wasm in a `--target wasm` program and at comptime on every target, replacing every `wat_prelude` helper and `wasi:` binding it implements. (2) One module: std-wasm's functions are ordinary functions of the program, its `.wat` text the whole program, the binary from the same model; no host change, no second module. (3) The `std:` label beside `body:`, `op:` and `wasi:`: `#[compiler.external(.Wasm(std: "hash.contentHash"))]` names the std-wasm export `<module>.<function>`; one cell serves codegen and comptime; std's alone (445); no implicit match by name (`stdWasmSymbol`'s table removed); a `std:` naming no export, or one whose parameter and result types differ from the declaration's, is a located error at the annotation; the `body:` a `std:` cell replaces (`contentHashBody`) is deleted; a wasm program's text is std-wasm's (441) | `1-botopink-lang/144` B-00a, B-00c, B-00e · 434 (2), (4) · 238 | std_wasm_one_implementation |
| 442 | (wasm, the maintainer, 2026-10-11) | **`wat_prelude` keeps only what defines a value's representation or talks to the host; what only computes over values leaves it** (its Zig half is superseded by 544, 550, 560: such a helper is botopink or a `.wat` leaf). (1) Stays in `codegen/wat/wat_prelude.zig`: representation — `box_i32` / `box_f64` / `box_i64`, `arr_at_box`, `arr_new`, `arr_push`, `arr_at`, `str_concat`, `str_eq` (`alloc` std-wasm's, 449; `str_slice`, `mem_eq` deleted, 455); the arithmetic checks — `int_chk`, `u64_chk`, `i32_range_chk`, `i64_range_chk` (264), `i32_abs` / `i32_min` / `i32_max`; output — `print` (`fd_write`, `$__write_bytes`; the `wasi` / `browser` profiles of 334 print one text), `print_str`, `print_bool`, `print_opt*`, `print_shaped`, `print_tagged`, `print_unknown`, `display_of`, the I/O half of `print_f64` / `print_i64` / `print_u64` / `print_arr_*`; the host's entropy (451); the `Async` scheduler (`task*`, 392–394), `unknown`, `assert_fail`. (2) Leaves, under 440's `std:` binding: every text, number-to-text, array and random helper std declares (`str_case`, `str_trim`, `str_split`, `str_replace`, `str_pad`, `str_lines` / `str_words`, `str_cp_*`, `str_from_cp`, `str_char_code`, `str_index_of` / `last_index_of`, `starts_with` / `ends_with`, `str_repeat`, `str_at`; `dtoa`, `f64_to_str`, `i32` / `i64` / `u64_to_str`; `arr_reverse`, `arr_slice`, `arr_concat`, `arr_prepend`, `arr_zip`, `arr_fill`, `arr_join_*`, `arr_index_of_*` / `last_index_of_*`, `arr_unique`, `arr_flatten`, `arr_chunked`, `arr_sliding`; the seeded random, 451) and `bigint` (`bn_*`), its limbs internal, the codegen passing pointers. (3) A new helper stays when it reads or writes the layout the codegen decides or talks to the host; it leaves when it only takes values and answers values. (4) What leaves uses the program's `$__alloc` and the codegen's string / array layout; every wasm `.out` and RUN LOG unchanged except where 441 changes the text | `1-botopink-lang/144` B-00g · 440 · 441 | wat_prelude_representation_only |
| 447 | 442-a | Overtaken by 544 | `1-botopink-lang/144` B-00g · 440 · 442 (4) | wasm_one_stack_overflow_traps |
| 448 | (wasm, the maintainer, 2026-10-11) | Overtaken by 544 | `1-botopink-lang/144` B-30 · 447 · 392–394 | wasm_heap_per_task |
| 450 | 438-b | **The Erlang term library and the OTP functions are std-wasm's; `bp_wat_rt.wasm` goes** (the Zig term library superseded by 544, 550, 560). (1) `comptime/runtime/wat/rt.zig` — the term representation and the OTP functions and BIFs it serves (`lists:*`, `maps:*`, `erlang:`) — moves into `modules/std-wasm` (`term.zig`, `otp/*.zig`). (2) beam-to-wasm (deleted with 544's B-84) imports std-wasm's OTP table directly. (3) The comptime runtime links std-wasm; `bp_wat_rt.wasm` and its build step cease — one wasm runtime (434). (4) Two value representations in std-wasm, each in its own file (the codegen's typed layout, the Erlang terms); 449's collection knows both. (5) A term allocates on the comptime's arena when the comptime calls it, on the current process's heap (449) in translated code — the caller's choice. (6) A function with two faces (`string:titlecase`) has one | `1-botopink-lang/144` B-00i · 438 (2) · 449 | std_wasm_owns_otp_terms |
| 454 | 442-c | Overtaken by 550 | `1-botopink-lang/144` B-00g · 442 · 445 · 449 · 450 | std_wasm_two_tables |
| 517 | B-79 | **`botopink run` of a program with no `fn main` is a located error, one message on every target and host.** The CLI refuses before running, naming the package's entry module and that it declares no `fn main` — commonJS, erlang, beam, wasm under both hosts; not taken: a silent exit 0, or each target's own answer (`no exported instance named wasi:cli/run`, an exit 0 running nothing, a raw `error:undef`) | `1-botopink-lang/144` | run_without_main_refused |
| 542 | B-30-b | Overtaken by 560 | `1-botopink-lang/144` | wasm_heap_generic_slots_tasks |
| 549 | 164-s3-c · (process) | **A hand-written `.wat` leaf names the codegen's GC types, never declares one.** A leaf of `modules/std-wasm/wat/` writes `$str`, `$arr_any` and the other GC types by name, the `.wat` reader resolving each against the codegen's type table; a `(type …)` in a leaf is refused at the declaration — one representation, in one place (442 (3)) | `1-botopink-lang/144` | wat_leaf_declares_no_type |
| 555 | 544-a | **wasmtime does not collect cycles yet: the codegen breaks its own.** The codegen leaves no cycle of its own making (a settled task drops its waiters and its frame); the gate pins the wasmtime CLI version beside the C API's; 544's "the host's collector follows cycles" reads "the host's collector; a cycle a program builds may live until exit on wasmtime until its collector follows cycles" | `1-botopink-lang/144` 164 s2 | wasm_codegen_breaks_own_cycles |
| 560 | — (the maintainer, 2026-10-15) | **The language's wasm runtime is hand-written `.wat`, never Zig building `wat_ast`.** Printing, panic and abort (`__panic_fail`, `__chk_fail`), comparison, the task scheduler (`__task_host_poll`), `bp_ready`, the `unknown` and `Dict` helpers move from `codegen/wat/wat_prelude.zig` to `.wat` files read by the compiler's `.wat` reader, as std-wasm's leaves (549); Zig keeps only the codegen's part — the GC type table (`repr.zig`) and what a program links (WASI or `bp_host` imports by `needs`, the variants needed, the order); the reader learns what the runtime writes (imports, the exception tag, globals); after s2 P5 (the linear lowering deleted) every cell's answer is the same; with 559 no Zig source writes or holds `.wat` | `1-botopink-lang/144` 164 s3 | wasm_runtime_handwritten_wat |
| 566 | 164-s3-f · (process) | **164 s3 P1's methods move to botopink after s2 P5, never before.** A `string` method moves to its botopink body (565) once s2 P5 has deleted the linear lowering; until then each leaf keeps its twin std-wasm export of the same name and types, so a module falling back to linear memory still builds; P1's leaves and their unit tests may land before | `1-botopink-lang/144` 164 s3 · 164 s2 |  |
| 568 | 164-s2-a | **On wasm in GC form a tuple has a GC subtype of its own, never an array's type.** A tuple is its own subtype of `$arr_any`, so an `unknown` slot prints `#(1, 2)` for a tuple and `[1, 2]` for an array, as on the other targets; a tuple bound to a `T` never sends its module to the linear lowering; every tuple construction changes, the GC snapshots' `.wat` re-recorded, no answer moving | `1-botopink-lang/144` 164 s2 | wasm_tuple_gc_subtype |
