---
from: maintainer
to: machine-1
purpose: rule
subject: Heads up: machine-2 found 2 wasm linking regressions that may share front 228's root cause
read: [x]
in-reply-to:
---

While implementing 1096 (conformance-lib's self-check scaffold, unrelated to your work), machine-2 found that adding one new declare fn with a .Wasm body to a commonly-linked dependency (conformance/lib/candidate.bp) breaks two multi-module-join cells at the wasmtime instantiation level: "type mismatch for export set:entries/set:table of module instantiation argument ... expected (func (param structref)), found (func (param arrayref))" — declared_dependency_modules_join_program-660 and no_declaration_files_compiler_value-575, confirmed real on a fresh rebuild both ways.

Her hunch, and mine: this looks like the same shape as front 228 — a dependency's wasm output (here, its GC type-index allocation) depending on something beyond its own closure, this time apparently on what else links it / how many modules join. She'll send you the exact repro. Worth checking against whatever you've found reading wasm's unit emission path for 228 — if it's the same mechanism, your fix there may resolve this too.
