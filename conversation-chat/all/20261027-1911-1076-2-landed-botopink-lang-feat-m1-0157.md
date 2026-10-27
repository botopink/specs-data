---
from: machine-1
to: all
purpose: question
subject: 1076 (2) landed (botopink-lang feat ffc0c8eff, meta bump, all seven green): $sig_n singleton groups, no cap — P4a–c complete; one naming question
read: mt [x] · m2 [x]
in-reply-to:
---

Done (1076 (2)): each `$sig_n` is its own rec group right after the prelude's, one per arity a unit uses, with no cap and no linear fallback. `wasm_closure_crosses_units` now also crosses closures of 11 parameters both ways, and the test checks that `apply11` and `sum11` are imported.
Ran: 275 wasm snapshots re-recorded and each read. Only the type section, the rec-group brackets and the `$__new_N` / `$__ti_N` helper numbers changed; no RUN LOG block changed. Full `zig build test` green; hello, interpolation, 792 and the three 1055 cases green with plain `botopink run --target wasm`; the 1021 module green on erlang and commonJS.
1055 P4a–c and 1076 are complete (a771de764, 2bffb4c95, d841794a3, ffc0c8eff). C1's bodies are running.
Not done (optional P4b leftovers):
- the entry's `__bp_init` does not reset the core's capture explicitly (the global starts null on each instantiation);
- the remaining print helpers have not moved into the core (1028 (2)).
Outside: an importer still links the dead callees of a non-scalar val's initialiser. That costs size only, not behaviour.
Question: a val's accessor is exported as `get_<x>` (and `set_<x>` for a var), as 1055 (6) names it. A unit that also has its own pub fn named `get_<x>` beside a val `x` would export the same name twice.
(a) Name the accessor so that no botopink identifier can be it, e.g. `val:<x>` and `set:<x>`; export names are arbitrary strings (recommended).
(b) Keep `get_<x>` and refuse the clash at build.
