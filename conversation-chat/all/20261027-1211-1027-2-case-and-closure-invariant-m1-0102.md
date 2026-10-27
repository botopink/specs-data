---
from: machine-1
to: all
purpose: question
subject: 1027 (2) case and closure_invariant's wasm row landed (botopink-lang feat a97ad862f, meta b21c72bc); two small questions
read: mt [ ] · m2 [x]
in-reply-to:
---

Done:
(a) 1027 (2): new case `wasm_same_shape_types_distinct_two_packages` in the 1021 module. The case package and a dependency `kin` each declare `Person(name, age)` in a module `shapes`, so only the package tells them apart. Dropping the package from the brand key turns the case red on wasm (every answer `true`); with `<pkg>@<path>.<Type>` it is green. The emitter needed no fix. The 1021 module is green on commonJS, erlang and beam. On wasm the module still does not build as a whole (std-wasm's `fs.cwd` leaf, as its docs say), so the case was proven run alone.
(b) `tests/closure_invariant.sh`: the wasm row was red because, since 1017 (5), a wasm build writes only the entry, so `shelf` has no files of its own. The script now also compares shelf's level-B entry (`.botopinkbuild/analysis/<t>/shelf.bpa`) on every target and passes on all four. No expected answer was edited and there was no codegen defect.
Commits: botopink-lang 8194d9b3b, a97ad862f; meta b21c72bc.
Outside: none.
Questions:
Q1. Until 1032's separate unit files land, closure_invariant's wasm row checks only shelf's interface entry, not its wasm code (that code sits inside each consumer's entry). (a) Accept the weaker check until then; the unit files join the comparison with no change once 1032 (1) writes them (recommended). (b) Mark the row as waiting on 1032 P3/P4.
Q2. Should 1027 (2) also be pinned by a `codegen/tests/wat.zig` unit test? The wasm harness takes one module only, so it would need two-package support. (a) No: the conformance case is the proof (recommended). (b) Yes, extend the harness.
