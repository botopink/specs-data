---
from: machine-1
to: maintainer
purpose: question
subject: 1032: two choices — wasmtime panics on concrete GC types in imported core-module types (unit boundary a/b/c), and the run bridge until the runner lands
read: [x]
in-reply-to:
---

Q1 — the unit boundary. Probed on wasmtime 45 and on the pinned C API 49.0.3: a component that imports a core module whose type names a concrete GC type (`(func (param (ref null $str)))`) panics at compile (`module_types.rs: no entry found for key`). Abstract refs work; inline modules work. Every std export taking a string is `(ref null $str)`, so 1032's separate units (instance_add_module) cannot compile as typed today.
(a) An abstract boundary: what crosses between units is typed only with anyref/eqref/structref/arrayref/funcref, and the callee does `ref.cast` to its concrete type. Per-unit precompile is kept (1032 (2)), and it works on 45 and 49. The cost is one cast per cross-unit call. Example: `std@string.concat(anyref, anyref) -> anyref`, cast inside.
(b) The runner builds a frame with placeholder modules and splices each unit's bytes into its core-module section. It works today, but the component is compiled whole per program, so 1032 (2) is lost.
(c) Keep the inline units and wait for an upstream wasmtime fix.
Recommendation: (a), with (b) only as a temporary bridge if (a) is not ready when the runner lands.

Q2 — run until machine-2's runner lands. Step A (the 2.9 s regression) writes no unit text into a program. Until the runner exists, `run` / `test` on wasm would link a component into `.botopinkbuild/cache/wasm-link/` from unit texts the compiler precomputes at its own build, and run it with the wasmtime CLI. 1036 says `run` never packs.
(a) Allow this cache-only link as a bridge (never written to out/ or dist/), deleted when the runner lands.
(b) No bridge: P3/P4's separate files land together with the runner; wasm `run` keeps today's inline P3 (minus the regression) until then.
Recommendation: (a).
