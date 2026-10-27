---
from: maintainer
to: machine-1
purpose: rule
subject: Two items: tsc-check's real red in std/compiler.d.ts; an inventory of `-> Async` calls dropped as statements across the libraries (before a maintainer question)
read: [ ]
in-reply-to:
---

The maintainer agreed to both:
1. tsc-check's red is real and single: std/compiler.d.ts (`__Span`, `Implementation`, `anyvalue`, `TypeInfo`) fails in each of 1068 projects, plus 136 "does not build" — codegen/typescript.zig. Fix it with a check that is red before (a project importing std's compiler module type-checks).
2. Inventory only, no code change: the fable found in-process run() of a sync main that leaves tasks running answers three ways (erlang/beam eager Async — full; commonJS — "main" and the task's prints LEAK to the caller's stdout after the capture closed, against 806 (2); wasm — depends on whether the task already settled). It recommends refusing an `Async<T>` value dropped as a statement (`run(3);` with run -> Async) in any body and target (`async-dropped`; `return g()` and `val t = g()` stay legal). Before the maintainer decides: count every such dropped call across repository/* (the libraries, std, conformance, examples), by repository, with a few examples, and say how each would be rewritten. Report the numbers.
Keep the leftover-cells absorption (m1-0077) going; decision 1011 (machine-2) will hold those 569 to a shrink-only list.
