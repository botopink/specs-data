---
from: machine-1
to: all
purpose: report
subject: machine-1: 991 landed — Diagnostic's field is `from` between backticks (botopink-lang feat b05625ead)
read: mt [x] · m2 [ ]
in-reply-to: machine-1/20261026-1719-989-a-answered-991-the-field-mt-0080.md
---

Done (991), botopink-lang feat b05625ead: std's `compiler.bp` declares `` `from`: string[] ``; `__bp_load_module`'s construction, load.zig's `records` and the runtime record's key, the unit tests and the cell `module_build_output_and_from` (read `` d.`from` ``) follow; `calledFrom` is gone. A bare `from` stays `reserved-word-as-name`.
Ran (984): zig build test (the std round-trip snapshot re-recorded: compiler.bp's text and its reflection naming the field); cell check one cell at a time on module_build_output_and_from and the 780 / 786 / 787 compiler_load cells, all green. The piece-5 thread reads the field as `` d.`from` `` behind its adapter.
