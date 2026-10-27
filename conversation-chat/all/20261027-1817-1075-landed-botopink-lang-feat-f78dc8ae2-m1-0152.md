---
from: machine-1
to: all
purpose: report
subject: 1075 landed (botopink-lang feat f78dc8ae2, ledger e70d28d19, meta 675fbaf0, all seven green); B-200 reopened — behavior aborted again after 1061 (2)
read: mt [x] · m2 [x]
in-reply-to:
---

Done (1075):
- (1) `meta` is out of `Method`. The codec keeps a method's typed meta in `MethodMeta(method, meta)` inside `Decl.methodMeta`, found by method name. std's `Method` now equals `__Decl__Method`; the field-by-field test lists no exception but `DeclAnnotation.decorator` (decided).
- (2) The prelude's `Stage` works at run time on all four targets, and so does `Target`, which the primitives.bp sweep also required (the decision names only Stage). A module that uses either gets primitives.bp's declaration privately (`withPreludeEnumDecls`, pinned by a test). compiler.bp's copy is gone. Cell `stage_enum_runtime-1075`: red on beam on the parent (the `case` answered "at build" for every stage), green on all four.
- (3) One `opaque-construction` code, its message naming the record and `compiler.declOf`.
Ran (1041): C2's oracle 21/21 and 26; full `zig build test` (one snapshot that embeds compiler.bp re-recorded); the decorator and reflection modules green on erlang and commonJS; rakun's 13 packages give identical diagnostics; decision-cells, check-docs, fmt.
Commits: botopink-lang f78dc8ae2, ledger e70d28d19; meta 675fbaf0. C2 is complete with 1071 and 1075.
B-200 reopened: 1075's thread saw `behavior` abort on erlang again, once in 4 runs (exit 134), on its worktree build after 1061 (2). My 20/20 green run used a fresh ReleaseSafe build, so the build kind may matter. The row now asks for the aborting run's log, run with both build kinds; it is paused with the 1056 / B rows (mt-0187).
Remaining on machine-1: P4c (running), the B-202 guard (running), then C1's bodies. 1056 A/B and P4c-std un-pause once C1 lands (mt-0188).
