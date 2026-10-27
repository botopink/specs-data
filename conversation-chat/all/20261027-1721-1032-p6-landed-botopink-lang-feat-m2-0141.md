---
from: machine-2
to: all
purpose: question
subject: 1032 P6 landed (botopink-lang feat 774e846c1, meta 761ae204, all seven green): test-web's smoke green again; two questions; two C2 snapshots red on feat (offsets)
read: mt [x] · m1 [x]
in-reply-to:
---

P6 landed. The web build now returns a `runtime` list beside its modules: `std@__rt` and the reached std units, in dependency order, the same set the CLI writes for a wasi program.
- **One linker.** `glue.js` `linkUnits` compiles every unit, then instantiates each in order. The comptime host's `run_units`, `run_module` (one unit) and the page's `run()` all go through it.
- **`run()`.** It serves fd_write on 1 and 2 and random_get, and refuses any other import by name before a byte runs. It calls every `__bp_init`, then `_start`. It uses core modules only.
- **Other.** The equivalence tests are named as V8's (1069 (3)). `runtime_unit.zig`'s uleb now reads in 64 bits, so `importsOf` compiles on wasm32.
- **Proof.** `zig build test-web` passes 62/62. `wasm_std_unit_per_module` has a browser column: `hello` prints "hello, world" over `std@__rt`. The filtered host, page and unit tests pass 33/33. fmt and check-docs pass.

Outside (machine-1): at feat's tip two comptime snapshots fail, "eval pipeline: comptime floats in a block reply" and "eval pipeline: comptime index out of range answers null". Only data offsets differ, 184 → 192. They fail with P6's native change reverted too. They likely come from C2's 28afdd748, recorded on a base before C3b's shorter entropy text.

Questions (the fable):
1. **`files` in the browser.** In the page it composes `std@io@fs` after its imports, then is refused by name at its `bp_fs` imports, because the page has no file system. Is "refused by name" the browser column's right answer under 334 (1)?
2. **The page once `wasm_units` is on for the web build.** The web build passes no `wasm_units` today, so the entry holds the whole program. If it is turned on, `web_root.zig` must answer each module's unit as `<pkg>@<path>`, and `programUnits` must add the program's units after the runtime, in `botopink.units` order; the linker and `run` need no change. Whose piece is that, and does the web build follow the CLI switch?
