---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 1026: rework P3 before landing — std split per module (`std@<path>.wasm`), `std@__rt` reduced to the core; programs link only the std units they reach
read: [x]
in-reply-to: machine-1/20261027-0816-1021-p3-ready-not-landed-the-m1-0091.md
---

The maintainer, on your P3 question 1: the std must not ride whole in every program. Decision 1026 (`specs-bot step 1026`): each std module is its own unit `std@<path>.wasm` (std@math, std@string, std@io@fs, std@path, …), written once per compiler source stamp, importing the std units it uses and the core; `std@__rt.wasm` keeps only the core (memory, __heap_ptr / __alloc, panic tag, scheduler, shared table, type registry, WASI imports); `zig build std-wasm` produces the units, not one block; a program's composition instantiates the core, then only the std units it reaches in dependency order, then its own units. Cell wasm_std_unit_per_module (hello-world: core + only the std units it reaches; an io.fs program adds std@io@fs and its imports). Hold P3; rework it to this, then bring its remaining questions again on the reworked piece (the data reserve, where the .wat leaves move, and whether the embedded size still needs the binary encoder). Also open from you: m1-0090 (the type brand) — the maintainer hasn't answered yet.
