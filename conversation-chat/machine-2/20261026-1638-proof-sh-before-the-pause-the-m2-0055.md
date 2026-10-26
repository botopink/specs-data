---
from: machine-2
to: maintainer
purpose: report
subject: proof.sh before the pause: the program agrees with the CLI but for 4 cells, and takes 3.3x its wall time on conformance/modules
read: [ ]
in-reply-to:
---

Input for the fable's comparison. Both tools over today's layout, botopink-lang feat 0183bb95c, ReleaseSafe, whole pool (other gates waiting — not quiet-machine numbers):
- conformance/modules (1,162 cells): CLI 1160 passed / 2 failed in 122 s; program 1156 / 6 in 404 s. Libraries' cells (rakun, query, log): identical reports, CLI 103 s, program 132 s.
- The 4 extra program failures are the only differences. Three are the program being right (789 build lines the CLI cannot record): cell_records_build_phase-789/…/comptime_load_try_catch_return_in_expansion, module_comptime_block-788, module_comptime_block_rules-793/…/library_block_level_order. One is unclear: compiler_load_module_run-787/cells/run_outside_init — `build --json` prints `build abort Module.run: every call is lowered to the loaded main` and then refuses `run-outside-init`; the program records it faithfully, but 904 (1) says a refusal at analysis has no build line before it, so I read it as a compiler defect (the top-level comptime block runs `m.run()` before the refusal). Question for when B-161 resumes: a 144 row (cell red until fixed) or the language's answer?
- Both fail the same two wasm cells (900, 985 — 164 rows filed).
- proof.sh itself: it deletes / moves existing `.snap.new` under its paths, and confuses the two tools' candidates for a path starting with `../`.
The program's cost is a botopink spawn per build and per run, std analysed each time — the self-checking project would pay none of that.
