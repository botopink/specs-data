---
from: machine-1
to: all
purpose: question
subject: 1035 C0 inventory done (read-only): 12 input shapes, 3 reply dialects, 17 Erlang-only groups, 13 GC gaps; five choices for the maintainer before C1/C2
read: mt [ ] · m2 [ ]
in-reply-to:
---

C0 (decision 1035) is done. It was read-only: nothing was built or run and no repository was touched. Section 4 was read from the code and was not measured.

Corrections to the premise:
- Comptime does not go through modules/beam-to-wasm. The path is Erlang text → erl_parse → wat/lower.zig → link → std-wasm's term library → wasmtime, with an arena heap.
- `std@__heap` exists only in 1028's text.
- Three files 1035 (6) deletes are shared with the BEAM target: comptime/runtime/wat/erl_parse.zig (used by codegen/beam/erl_template.zig and erl_lower.zig), comptime/runtime/etf.zig (used by beam_file.zig) and codegen/beam/term.zig.
- The web build runs comptime too, through bp_host.

Section 1, what crosses: 12 input shapes and 18 record maps, over a Term model with 9 variants, through 3 evaluators that call etf.encode + evalWithArg (decorator_eval.zig:259, template_eval.zig:203, block_eval.zig:1906). Load answers, typeinfo, embed and @src are source rewrites, not Terms, and need no codec. The reply is already JSON, in three dialects (decorator ok/fail/error+printed, template $tuple, block tuple/record/atom/float/fn/resource) plus `frames`; the C2 codecs must reproduce all of them.

Section 2, Erlang-only constructs, 17 groups:
- 139 BIF entries
- 75 rt_* names
- 126 `.Erlang` primitive cells against 54 `.Wasm`
- 39+8 prelude forms
- 21 __bp_* helpers
- 8 process-dictionary keys

The untyped lowering is the root of most helpers. The compiler string-matches the `~p` text of Erlang exceptions in 5 places (block_eval.zig:1932–2073, host_cells.zig:582).

Section 3, the C2 oracle: 46 COMPTIME REPLY sections, 19 of them distinct (the codegen copies are byte-identical across targets). Zig tests: 22 + 44 + 32 + 12 + 32. Conformance has at most 423 leaf cells that run an evaluator. comptime_compiled_by_wasm_gc-550 exists only as a draft; comptime_units_per_module does not exist yet.

Section 4, GC gaps G1–G13. The main ones:
- G1–G2: no entry that compiles a unit from an untyped decorator or template body.
- G3: no std/compiler surface on wasm.
- G4: the reply encoding and closure identity.
- G5: traps cannot be caught, so the located frames are lost.
- G6: the linear fallback must become GC-only.

Questions for the maintainer:
Q1 (C4). Deleting erl_parse.zig, etf.zig and Term would break the beam target, which 434 (1) keeps. (a) Move them out of comptime/runtime/ into codegen/beam/ (recommended), or (b) delete them and re-implement for beam. Also: are beam-to-wasm and the term library deleted in C4 with the switch, as 1035 (6) is written (recommended), or earlier, separately?
Q2. The web build's comptime runs on the page engine (bp_host). After C4: (a) a GC-capable bp_host.run_module (recommended), (b) the web build loses comptime until a host exists, or (c) the web build stays out of 1035.
Q3 (C2). Runtime errors in a comptime body (divide by zero, a non-exhaustive match, an index out of range):
- (a) keep today's reply text through explicit checks, as `__bp_cdz` does (recommended, keeps the oracle "old reply = new");
- (b) take the engine's trap text, which changes the replies and several diagnostics;
- (c) a structured error field in the reply, with the 5 matchers rewritten to read it.
Q4 (C1). A decorator or template body is compiled into the declaring module's own `out/wasm-comptime/<pkg>@<path>.wasm`, never shared with out/wasm/ (only the core and std are the same bytes, 1035 (3)). Confirm (recommended), or a separate comptime-only unit per module.
Q5 (C2/C4). The comptime snapshots' `COMPTIME WAT` sections: (a) drop them (recommended — they would list units' GC text, not per-evaluation modules), or (b) re-record all 46.

machine-1 next: C1 waits on P4 (1032 step B and 1028).
