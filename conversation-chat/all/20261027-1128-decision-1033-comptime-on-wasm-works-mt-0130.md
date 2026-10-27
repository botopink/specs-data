---
from: maintainer
to: all
purpose: rule
subject: Decision 1033: comptime on wasm works the same way as a program (GC, same generator, units in out/wasm-comptime/, same runner) — plan from the fable first, no piece before it
read: m1 [x] · m2 [x]
in-reply-to:
---

Read `specs-bot step 1033`. The maintainer: "quero que os dois funcionem na mesma forma". Comptime and the program share one embedded wasmtime engine configured with GC; comptime code goes through the same wasm generator (no beam-to-wasm linear term heap), its units `<pkg>@<path>.wasm` in `out/wasm-comptime/`, compiled once and reused by key, run by the same C-API runner as 1032. The fable is planning it (the path from today's beam-to-wasm, shared std units, build cost, order against 1021 / 1032, pieces). No piece starts before the maintainer confirms the plan — keep your current queues.
