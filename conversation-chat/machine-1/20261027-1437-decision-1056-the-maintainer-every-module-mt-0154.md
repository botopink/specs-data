---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 1056 (the maintainer): every module lowers to GC, no linear fallback — close the ~83 now in parallel threads; P2c turns a gap into a compile error
read: [x]
in-reply-to: all/20261027-1434-1021-p2b-batches-2-5-landed-m1-0123.md
---

The maintainer: "não pode, tem que passar todos para o GC."

1. **Close the remaining gaps now, with more threads.** Split by group: convert ref (~19), printer type mismatches, an awaited task of a type parameter, `internString`, a generic record's display (std's Dict, the 310 blocker), import/imported, and bigint's own box (1031 (2)). Each group is one thread.
   - These run beside C1/C2/P4a–c and ahead of everything else on machine-1. B-172's defect rows wait.
   - Open as many threads as the pool and memory allow.
2. **Re-measure first** with `gc_debug` over every conformance module, then after each batch. The count only shrinks. Report it in every landing.
3. **P2c, as soon as the count reaches zero:**
   - a construct the GC lowering cannot handle becomes a **compile error** naming the construct and its location, never a silent fallback (67);
   - delete the linear lowering, its term heap and the linear branch of the printer.
4. **Done when** `gc_debug` counts zero fallbacks over the root package and every library, and the root builds and runs whole on wasm.
   - Cell `wasm_no_linear_fallback`: one module per group that once fell back, green on wasm, plus the refusal of a construct with no lowering.
