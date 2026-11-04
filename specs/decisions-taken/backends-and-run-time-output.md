---
scope: >-
  Decides what each backend computes and prints alike: commonJS's class-per-declaration value shape
  and the print shapes it hands generic code, the erlang runner's exit status, the BEAM lowering of
  every template construct with no Erlang evaluated at run time, `std/math`'s bit-identical answers.
  The one printed text is comptime-runtime and strings-bytes-and-text; host cells are host-functions;
  wasm's runtime is wasm-target-and-runtime.
terms:
  - '`instanceof`'
  - '`Shape$Circle`'
  - '`botopink run --target erlang`'
  - '`erlc -o`'
  - '`erl -noshell`'
  - '`main([])`'
  - '`comptime/runtime/beam/lower.zig`'
  - '`__bp_erl_eval`'
  - '`receive … after`'
  - '`binary:decode_unsigned/1`'
  - '`erl_internal:bif/2`'
  - '`std/math`'
  - '`math.pow`'
  - 'fdlibm'
  - '`__bp_ty_<T>`'
  - '`__bp_s`'
  - '`Display`'
  - '`.d.ts`'
related:
  - 'comptime-runtime'
  - 'host-functions'
  - 'wasm-target-and-runtime'
  - 'strings-bytes-and-text'
  - 'numbers-and-arithmetic'
  - 'caches-and-build-outputs'
open:
  - '5: whether a record''s class also carries the variant machinery, or only a `type` with variants gets subclasses — asked of the maintainer in 5 and not answered there'
binds:
  - '`04-js`''s decision-8 half; `13-module-identity`''s third half on the JS side'
  - '`machine-2/144` B-115'
  - '02-erlang'
  - '03-beam'
  - '05-wasm'
retired:
  - '`''__bp_erl_eval''/2` (a template evaluated from Erlang source at run time)'
  - 'escript''s exit status `127` for a crashed `botopink run --target erlang`'
first-step: 5
last-step: 900
in-force: 7
superseded: 2
---
# backends-and-run-time-output — what every target computes and prints alike

**One computation answers or aborts alike on the four targets; std's math is bit-identical; a run-time abort prints a `Failure`, never a raw term.**

(1) commonJS's value shape: a class per declaration, a subclass per variant — 5.

(2) The erlang runner exits with `erl`'s status — 56.

(3) The BEAM lowering takes every template construct; no Erlang evaluated at run time — 141.

(4) `std/math` bit-identical on every target, `pow` ported — 259, 263.

(5) commonJS print shapes of generics across modules and inside values — 899, 900.

(6) Superseded: 86 (434), 98 (553).

Steps: 5, 21, 23, 56, 86, 98, 109, 141, 259, 260, 263, 264, 319, 333, 437, 441, 444, 513, 517, 521, 527, 535, 546, 556, 601, 610, 673, 675, 899, 900
Binds: 05-wasm · 02 · 02-erlang · 03-beam · `02/97` step 16 (A) · `05-wasm` step 9, `04-js` step 11, front 18's emitter (B) · `1-botopink-lang/144` B-00f · 238, 263 (`fn:` on `@External.Erlang` serves beam) · `1-botopink-lang/144` · `1-botopink-lang/144` B-101 · `1-botopink-lang/144` B-22 (machine 1) · the four backends · `machine-2/144` B-78, B-114, B-115

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 5 | 1.0.5-beta · (the maintainer, 2026-09-18) | On the JS backends a `type` emits a class per declaration and a subclass per variant, a payload-less variant a singleton — `class Shape {} · class Shape$Circle extends Shape { constructor(radius) { super(); this.radius = radius; } } · class Shape$Dot extends Shape {} · const Dot = new Shape$Dot();` —; the prototype is the value's identity, so `13-module-identity`'s third half has nothing to do on the JS side. Per feature: `x is Shape` is `x instanceof Shape`; `case x { .Circle(r) { … } .Dot { … } }` is `instanceof` per arm, exhaustiveness the class list; printing a method on the prototype a subclass overrides; a union of named types `instanceof A \|\| instanceof B`; the `.d.ts` real classes (`declare class Person`, never `{ tag: "Circle" }` / `{ tag: "Dot" }` / a bare `"Dot"`). Cross-module variant identity needs the class imported, as types are; a value handed to a host JS library is a class instance, `JSON.stringify` rendering it the same minus the `tag` field. Still owed by the maintainer: whether a record's class also carries the variant machinery, or only a `type` with variants gets subclasses | `04-js`'s decision-8 half; `13-module-identity`'s third half on the JS side | commonjs_variant_is_subclass_of_its_type |
| 56 | 1.0.5-beta · (the maintainer, 2026-09-18) | `botopink run --target erlang` exits with `erl`'s status: a crash is `1` (escript's `127` is retired), and `modules/compiler-cli/AGENTS.md`'s command contract is amended in the same commit as the runner fix. The runner is `erlc -o <out_dir>` over every emitted `.erl` found recursively (the layout nests, the module atom is flat), then `erl -noshell -pa <out_dir> -eval "<module>:main([]), halt()."` — `main([])` because `main/0` is emitted only when `main` is `pub`. Rejected: mapping `erl`'s failure onto `127`; a status per outcome across four targets (a command-contract row of its own when one is needed) | | |
| 86 | 1.0.10-beta · (the maintainer, 2026-09-20) | Overtaken by 434 | `00 · 18-comptime-runtimes` step 1c | |
| 98 | 1.0.10-beta · (the maintainer, 2026-09-21) | Overtaken by 553 | front 20 step 1 (F2) | |
| 141 | 0203-b · (the maintainer, 2026-09-26) | The BEAM lowering takes every construct the templates use; nothing evaluates Erlang at run time. `comptime/runtime/beam/lower.zig` — the lowering of the beam backend's `.Erlang` templates (BR5; the comptime BEAM runtime that shared it is retired, 434) — takes, within 86's OTP-24-stable opcodes: (1) `receive … [after T -> …] end` as `erlc`'s selective-receive loop (`loop_rec`, the clauses, `remove_message`, `loop_rec_end`, `wait` or `wait_timeout` + `timeout`); `!` as `send`; the old `catch E` as `catch` / `catch_end`; `try … of` matching after `try_end` (no clause is `{try_clause, V}`); `try … after` running the `after` body on both ways out; (2) a binary pattern of fixed-size unsigned big-endian integer fields (`<<A:32, _:4, B:12>>`, optionally with a `/binary` tail) through `binary:decode_unsigned/1` and shifts; (3) a call to any of `erl_internal:bif/2`'s auto-imported functions (`open_port/2` included). The beam backend's `'__bp_erl_eval'/2` is deleted (67): a template the reader or the lowering refuses is a build error at its call site naming the function and the construct. All 177 Erlang templates `libs/std` and the bundled libraries ship lower — the 8 once evaluated from source (`async.spawnAll` / `raceOf`, `json.unquote`, `encoding.percentDecode`, `io/http.fetch`, `io/random.uuidV4`, `io/process.run`, `validation`'s `rkvIsolated`) included — and the five sibling libraries' 29 | compiler (`beam/lower.zig`, `wat/erl_parse.zig`, `wat/lower.zig` refusing the three read-only constructs, `beam_asm.zig`, `asm_text.zig`); `codegen/tests/beam_templates.zig` (every shipped template lowers), `program.zig`'s `erlc`-comparison module for each construct, `tests/language/run/external_template_refused_on_beam` | |
| 259 | 05w-c | wasm's `std/math` agrees with commonJS bit for bit, `pow` included: std ports glibc's `pow` (the algorithm since glibc 2.28, its 128-entry `log` and `exp` tables) as a private botopink body, `pow` on every target (263); `math.pow(158.42161580281933, 2.853827476501465)` is `1896229.4525711867` everywhere | 05-wasm · 02 | math_pow_bit_identical |
| 263 | 05w-g | `std/math` answers the same bits on every target and OS: its transcendental functions call std's private botopink bodies (the fdlibm port) on erlang and beam too (`.Erlang(body: tanBody)`, 305, 610; beam reads it, 437); `pow` is 259's body everywhere, commonJS included; `sqrt`, `floor`, `abs` and the other operations IEEE 754 makes exact stay host calls; `run/std_math_on_every_target` keeps its exact values | 02-erlang · 03-beam · 05-wasm · 02 | math_same_bits_every_target |
| 899 | B-115-a · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: (b) each module's set of shape-taking fns carried in the export info — a caller's output would depend on a callee's body, so a cached dependant goes stale, 509 (2)) | On commonJS a call into a bodied, non-host generic fn of another module hands it the print shape of each type parameter, judged by the callee's declared signature alone (B-115 box 2 under 673). (1) The caller reads the callee's signature from the cross-module export info — generic, bodied, no host binding — and appends one trailing `__bp_ty_<T>` per type parameter, as B-114 does inside the callee's own module (673); the hidden slots follow the signature's last parameter, a call omitting a trailing default filling it with `undefined` first; a callee whose body writes no `T` as text ignores them (JS drops extra arguments). (2) A caller's output depends on signatures alone, never on a dependency's body, so the code cache stays sound (509 (2)). (3) std's and a dependency's callers included; the `.d.ts`, the `T` values and the other targets unchanged (673). (4) Cell `generic_fn_of_other_module_takes_shape`: `lib.show(2.0)` through another module's `fn show<T>(v: T) -> string` prints `2.0` on the four targets, red on the parent on commonJS | `machine-2/144` B-115 | generic_fn_of_other_module_takes_shape |
| 900 | B-115-b · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: (b) a hidden shape argument on every generic method filled from the receiver's static type — `print(d)`'s run-time `Display` dispatch has no static type to read) | On commonJS a value of a generic type carries its type arguments' print shapes (`__bp_s`): the generic constructor writes the shapes its call handed it (673) into the value, a method answering a new value of the type copies them, a generic method reads them where it writes a `K` / `V` as text — `d.display()` in another module and `print(d)`'s `Display` dispatch print alike (B-115 box 3). (1) `Dict.empty<K, V>()`, `Dict.ofEntries`, `Set.fromList` and every generic constructor of std take B-114's trailing shapes as any generic fn does and store them; `insert`, `remove`, `map` and every method answering a new value of the type carry them on; a value built where `T` is concrete prints as B-114 prints it. (2) `collections.shown` / `display` read the instance's shapes, no hidden argument per method. (3) erlang, beam and wasm unchanged, one text (521); wasm's refusal of the program (`shown` not monomorphised through a behavior's member) is a 164 row. (4) Cell `generic_type_value_carries_shapes`: `print(d)` and `d.display()` of a `Dict<string, f64>` built in std and read in another module print `2.0` on the four targets, red on the parent on commonJS | `machine-2/144` B-115 · std (`collections`) | generic_type_value_carries_shapes |
