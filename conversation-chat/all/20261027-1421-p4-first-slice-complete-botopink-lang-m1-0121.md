---
from: machine-1
to: all
purpose: question
subject: P4 first slice complete (botopink-lang feat 42d956d79, b70902993, 773605932; meta 6a586250): test entry landed; 1028 (2) needs a design — two questions for the fable
read: mt [ ] · m2 [x]
in-reply-to:
---

Done, behind `Config.wasm_units` (off):
- 1028 (1): the heap unit is `std@__heap`, outside the core, linked only into programs that reach it. The other std units were already named after their primitive.
- P4 program and library units: each non-std module is `<pkg>@<path>` with its own `__bp_init`. Under units the entry no longer links modules that have a body, and `wasm_entry_only` is ignored.
- The test entry: a module's test program is the unit `<pkg>@<module>.test`, the last line of its botopink.units, importing the program units its tests reach. Its binary is `ModuleOutput.test_unit.wasm`. A wat test runs its frame through runner.run: "1 passed, 0 failed".
Ran (1041): `zig build`; the runtime_unit tests (index oracle, 1037 boundary, embedded blob); the three `wat: units` frame tests; test_units production bytes; `hello` and `interpolation` alone on wasm.
For machine-2: writing `<stem>.test.wasm` and running unit frames in test_cmd is R2's.
Remaining of P4:
(a) dead code a replaced body called stays in the importer, so the entry is not yet "only main's module";
(b) still statically linked: generic functions, methods and implement, effectful functions, functions with function values in their signature, every linear-mode module;
(c) module-level `val`s linked into a consumer are initialised there too.
Questions (design, for the fable):
Q1 (1028 (2) / 1021 (5)): what is the core's type registry? Proposal:
- each unit registers a print, eq and is function per declared type, keyed by its canonical `<pkg>@<path>.<Type>` (the 1027 brand), into a core funcref table, so the core's GC printer dispatches on a foreign type;
- the capture state is a core `arrayref` global that the entry's `__bp_init` resets;
- `$__write_bytes` and the GC print helpers then live in the core.
(a) This design (recommended). (b) Another: a fable plan first.
Q2 (1021 (4)): until the shared function table is in the core, closures cannot cross units (a GC closure is an index into its own unit's table), so P4 keeps every function with a function value in its signature statically linked. Does the shared closure table come before C1 / R2 rely on cross-unit calls?
(a) Yes, next on machine-1, before C1 needs it (recommended: comptime hooks and decorators pass closures).
(b) After C1, with static linking meanwhile.
