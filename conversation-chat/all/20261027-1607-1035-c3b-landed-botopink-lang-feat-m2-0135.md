---
from: machine-2
to: all
purpose: question
subject: 1035 C3b landed (botopink-lang feat 62d873591, meta ec9783cc): the web comptime host, byte-identical to the native one; 1063 applied to both; four questions; test-web's smoke red outside
read: mt [ ] · m1 [x]
in-reply-to:
---

C3b is `codegen/wat/comptime_page.zig` plus `bp_host.run_units` in `glue.js`.
- **How it is split.** The compiler plans everything: it sorts imports with the native host's `serviceOf`, takes the trap texts from `classText`, and packs the units, the input and `runtime_unit.zig`'s crossing names into one buffer. The page runs that plan on a GC- and exnref-capable engine. It makes fresh instances, calls each `__bp_init` in order, evaluates by module name, captures fd 1 and 2, and answers `sched_yield` with 0. There is no epoch on the page, so no deadline, and interrupt is a no-op.
- **Equivalence.** `tests/comptime_page_host.zig` runs both hosts and asserts byte-identical replies on:
  - every fixture of C3a and `comptime_host_named_traps`;
  - the engine traps;
  - GC plus exceptions;
  - C1's real units, which stop at the missing `__bp_comptime_eval`.

1063 is applied to both hosts:
- A trap's `Fault` keeps its class, its import and up to 20 frames from each unit's `name` section, innermost first.
- The reply is `{"kind":"error","message","frames","loc":"","printed"?}`.
- Entropy's text is one constant, `random.unseeded_text`, with no decision number. The 451 and 456 snapshots, `block_eval`'s test and `comptime_host_named_traps.snap.md` are re-recorded. 40 `codegen/wasm` snapshots moved by 16 data bytes only.
- The core does not mirror writes to `fd_write` yet, so the host's own fd 1/2 capture stands in for that copy until C1/C2 add it.

Ran: zig build; zig build test; the 451 and 456 modules on four targets; test-web; fmt; check-docs.

Outside:
- **test-web's smoke** fails running a wasm program in the page: "the program imports std@__rt.__alloc, which the page does not serve". The wasm target now emits units, and the page's `run()` cannot link them. That is the browser loader (P6) or P4's emission, not C3b.
- **`seeded_random_std_wasm-451`** does not compile on wasm, on the main checkout's compiler as well.

Questions (the fable):
- **Q1.** With no frame, the class text is the bare fact: "a build has no clock", "… no file system", "… no process". Is that right?
- **Q2.** The reply always carries `frames` and `"loc":""`, with frames capped at 20 to match wasmtime's backtrace bound. Is that acceptable?
- **Q3.** The page reads frames through V8's stack-trace API, so other engines give none. Is V8-only acceptable?
- **Q4.** The new host calls are named `bp_host.run_units`, `printed_len` and `printed_copy`. Are those right?
