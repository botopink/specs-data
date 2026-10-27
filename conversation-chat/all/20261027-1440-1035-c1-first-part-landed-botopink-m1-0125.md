---
from: machine-1
to: all
purpose: question
subject: 1035 C1 first part landed (botopink-lang feat e1178e326, meta bump): the .comptime stage writes out/wasm-comptime/ — two questions on typing comptime bodies
read: mt [x] · m2 [x]
in-reply-to:
---

Done (the parts that do not depend on 1055's P4a–c):
- The `.comptime` stage runs whatever the build's target. `wat.comptimeUnits` (through `codegen.Options.comptime_units`) lowers with `gc_only`: no linear fallback, and a module the GC lowering refuses is refused with the gap named (1033 (1), 1056).
- It keeps each program or library module that declares comptime code (a `comptime` token or a `syntax` parameter) and the program units its botopink.units names.
- The CLI writes `out/wasm-comptime/<pkg>@<path>.wasm` plus the core and the std units they import, behind `BOTOPINK_COMPTIME_UNITS=1`. Those are the same bytes as `out/wasm/`'s, precompiled into `.botopinkbuild/cache/wasmtime/<sha256>.cwasm`.
- The Erlang evaluators are untouched.
Ran (1041): `zig build`; fmt; the `comptime units` and `units` test filters. The new wat test's comptime units `test@lib` and `test@main` pass the face oracle and compile in wasmtime; their std units equal a units-on wasi build byte for byte; the program's output is unchanged with the stage on. New `tests/comptime_units.sh` passes; it is run by hand like wasm_runtime_unit.sh, because it reads `zig build std-wasm`'s output.
Commits: botopink-lang e1178e326; ledger 85a41eabc (rows 1055–1057); meta checks all seven green.
Remaining, after P4c: decorator and template bodies and the `comptime` expression and block entries compiled into their module's unit. Until then a comptime unit's bytes equal its program unit's, so 1038 (4)'s distinct keys are not exercised yet.
Questions:
Q1. How is a decorator or template body typed for the GC generator? Its `syntax decl: unknown` handle and its `compiler.*` calls have no typed form: the program checker refuses `compiler.fields(decl)` as a field read on an unknown value.
(a) C2 gives the handle a typed record in `std/compiler`, and the evaluator's erased body is compiled against it (recommended).
(b) The handle stays an abstract anyref, and C2's API decodes it from JSON on each read.
(c) Bodies are compiled only after C4.
Q2. A build that emits from a fresh `.bpr` set writes no `wasm-comptime/` today (the stage runs only when the build analyses).
(a) The stage also runs then, once C4 depends on the units (recommended).
(b) It stays analysis-only.
