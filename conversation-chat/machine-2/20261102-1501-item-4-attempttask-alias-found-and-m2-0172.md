---
from: machine-2
to: maintainer
purpose: question
subject: Item 4 (attemptTask alias) found and fixed — but the bug only reproduces as a bare program, not through compiler.load, so neither cell shape proves it
read: [x]
in-reply-to:
---

Found and fixed the root cause. `calleeSymbol` (wat.zig:18646), used to decide whether an `await`'s operand is a task (`isTaskExpr`) and for several other shape lookups, never resolves `cc.callee` through `self.import_aliases` before its `locals`/`fn_sigs` lookups — unlike ~15 other call sites in the same file that do. An aliased call (`import {failure.attemptTask as doIt}`) misses the `task_syms` lookup, falls through, and `lowerAwait` treats the whole expression as non-task — the `await` is silently dropped. One-line fix: resolve the alias at the top of the function, same pattern as everywhere else. Verified: `zig build test` full suite green; a bare scratch repro goes from wrong ("err"/Error branch taken) to right ("Ok 42") with the fix; the existing decision-494 cell (`std_failure_attempt_task`, unaliased) unaffected on all four targets.

Hit a real snag proving it as a conformance cell. The bug does NOT reproduce when the same code is loaded via `compiler.load` (the folded self-checking `cases/` shape, decision 989) — I added the identical repro as a new case under `attempt_task_form-494/cases/`, and the unfixed compiler already answers "Ok 42" there, cold build, every time I checked carefully (my first attempt showed what looked like a repro but was me misreading a "new case not yet in the snapshot" diff as a wrong answer — it wasn't). It only reproduces as a bare top-level program. The old `cells/` shape would otherwise fit ("a lone case that cannot share a package", decision 779), but per `conformance/AGENTS.md` that shape is "no longer checked by any command" — dead weight being migrated out, not a place to add a new cell to.

So: a real, fixed, verified backend defect with no cell shape in the current suite that both (a) actually exercises it and (b) is checked by anything. Options: (a) land the fix without a cell, noting why in the commit (the suite's two shapes neither reach nor check this path); (b) there's a third shape or flag I'm missing that runs a case as its own bare program rather than loaded — point me at it if so; (c) something else. Not landing until I hear back, since 1096 is already holding this branch anyway.
