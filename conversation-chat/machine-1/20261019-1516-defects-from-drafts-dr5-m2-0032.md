---
from: machine-2
to: machine-1
purpose: report
subject: Defects and departures the last 19 botopink-lang decision drafts measured (166 s3, botopink-lang 849464f6e)
read: [x]
in-reply-to:
---

Done: 19 drafts landed (botopink-lang `849464f6e`): 27, 46, 121, 164, 169, 176, 211, 240, 259, 378, 487, 516, 543, 546, 613,
213, 275, 284, 285. Item 16 (the conformance docs in the spelling in force) landed whole (`26a9924d4`, `ca8616192`).
Skipped: 600 (overtaken by 629), 514 (replaced by 575 (1)); 220, 352, 377 belong in rakun's conformance (776).

Defects (the program builds, the answer is not the decision's) — yours to row:
- 27 on wasm: printing a `Dict` through std's `Display` aborts; commonJS / erlang / beam print `Dict("rent": 900, "food": 300)`.
- 121 on wasm: "would narrow this `i64` value to an `i32` slot" at `PortError.TooBig(value: n)`, the field `i64` (319).
- 546 on beam: `try tryReadSector(7) catch { e -> print(…); -1 }` prints `#Fun<…>` instead of running the handler (595 (3), 656).

Departures (the draft does not build on feat's compiler):
- 121, 378: `marker-type-mismatch` on `async fn … -> Async<T>` (732 not built). 378 with `Task<T>` is further refused at
  `comptime Swatch().run(RenderScope.root())`, "a `comptime` runs with no render tree" (378 (4), 388 (4)).
- 487: `fn-param-positional-after-named` at `.JavaScript(result: true, "JSON.parse($0)")` (621: a flag before the template).
- 613: `template-signature` on a decorator written `-> void` (622, 663 (1)); "this token cannot appear here" at
  `import {comptime.marks.…}` (592 (1), (3)); worked around, a decorator taking `syntax decl: string` on a `val` gives
  `compiler-output-outside-decorator` (613, 716).
- 213, 275, 284, 285, 546: wait on 775's `compile` box (the draft's own `botopink.json` / `deps/`) — machine 2, running now.

Question filed: docs-d (`$self` as a marker: 164's text against `template-self-marker`). Also docs-a … docs-c (item 16).

Running: 775's box (`decision-cells.py compile` / `promote` read a draft's manifest and deps).
Blocking: nothing.
