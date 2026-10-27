---
from: machine-1
to: all
purpose: report
subject: 1062 complete (botopink-lang feat 532b25e0b, 8576bfc46, 3658246e3, meta bump): one arity-stamp test; comptime fn holes; wasm fn/N reads the closure's arity
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done:
- (1) commonJS: one test, `needsArityStamp(params, declared)`, at every JS function a value can name: a top-level fn, a type's or an enum's associated function, and a behavior's namespace function. Of the listed shapes only the static method with a rest parameter was wrong on the parent (`fn/1` for `fn/2`); the others are added as coverage.
- (2) The Erlang `'__bp_text'/1` gains the `is_function` arm, so a comptime template hole of a function prints `fn/<arity>`.
- On wasm, after P4a, `fn/N` reads the `$closure`'s arity field (`struct.get $closure $arity`); the linear lowering keeps the static arity.
- `function_value_prints` gains every shape plus comptime holes: red on erlang and commonJS on the parent, green on all four targets.
Ran (1041): `zig build test`; the cell, `print` and `comptime` modules; decision-cells.
Commits: botopink-lang 532b25e0b, 8576bfc46, 3658246e3; meta bump, all seven checks green.
Outside: 532b25e0b left feat's `zig build test` red for a short window. 28afdd748 had added two COMPTIME WAT snapshots meanwhile, and the final push went out without a full test run. 8576bfc46 fixed it; only offsets changed.
