---
from: machine-2
to: maintainer
purpose: answer
subject: Item 3 root cause narrowed: compiler.load + case's content forces module-wide GC→linear fallback, exposing the scaffold's dead io.fs path
read: [ ]
in-reply-to: machine-2/20261102-1235-good-catch-keep-digging-on-item-mt-0223.md
---

Bisected by truncating case's runCase list in a scratch copy (fixing the conformance-lib path so it still resolves). Findings, each isolating one variable:

1. case truncated to just its first case (case_alternatives_and_arrays) still gets the fs.cwd compile-time refusal — count isn't the trigger, it reproduces with n=1.
2. case_alternatives_and_arrays compiled and run as its own bare top-level program (no scaffold, no compiler.load) is clean on wasm — prints true/false/empty/one/many, no fallback, no refusal.
3. Renaming array's botopink.json to `"name": "case"` and truncating it to one case (array_fill) through the exact same scaffold: compiles fine (the module name "case" colliding with the keyword isn't it either).
4. Swapping array's content for case_alternatives_and_arrays's content under the scaffold is what I haven't isolated down to the single construct yet, but the shape is clear: scaffold (self-check + `compiler.load`) + case's own content together force something array's content doesn't — most likely the module-wide GC→linear fallback 170 s7 documents (a module not yet GC-lowerable falls back whole, not per-function). case_alternatives_and_arrays's `[first, ..rest] -> "many"` (an array rest-spread pattern inside a `case` arm) is my best guess at the specific construct, since it's the one piece of its content with no obvious GC counterpart in s7's "still on linear lowering" list — but I haven't confirmed that specific line is the trigger, only that the combination (scaffold + compiler.load + this case's content) is.

Once linear, the self-check scaffold's `io.fs.writeText` (candidate.bp's `deliver()`, only called on an actual snapshot mismatch — dead on the happy path) gets treated as compile-time reachable through the generic cross-module "foreign_origin" refusal (wat.zig:4539) and the whole module is refused before it ever runs — even when the snapshot matches and that path would never execute.

This is real and narrow, but pinning the exact triggering construct needs either reading wat.zig's GC/linear fallback decision directly or more bisection on case_alternatives_and_arrays's own two case blocks (Color enum vs array rest-spread). Want me to keep going to the exact line, or is this enough to file as a 144-style row (defect, not item 3's original 3-cell symptom) and move to a different s7 red?
