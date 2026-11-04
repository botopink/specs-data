---
scope: >-
  How a refusal and a build error are printed and located: the one printed form `error[<code>]:
  <message>`, what a refusal cell's `.snap` claims (message, location, label), and where a raise, a
  decorator's or a template's error is located. Which code a given construct refuses with is each
  construct's own group; the cell directory layout and `cell check` are conformance-suite.
terms:
  - '`error[<code>]: <message>`'
  - '`refused <message>`'
  - '`at <file>:<line>:<column>`'
  - '`label <text>`'
  - '`hint`'
  - '`called from`'
  - '`compiler.note`'
  - '`import-of-failed-module`'
  - '`cell_snap.zig`'
  - '`botopink-cell 1`'
  - '`no-final-newline`'
  - '`stderr`'
  - 'caret'
  - 'majority'
related:
  - 'conformance-suite'
  - 'result-and-failure'
  - 'decorators'
  - 'templates'
binds:
  - '`1-botopink-lang/144` B-29 step H'
  - '`1-botopink-lang/144` B-47'
  - '`1-botopink-lang/144` B-88'
retired:
  - 'cell snapshots written `error: <code>: …`'
first-step: 475
last-step: 557
in-force: 3
superseded: 0
---
# diagnostics — how a refusal and a build error are printed and located

**A refusal prints `error[<code>]: <message>` in one printer, located where the fault is written; a build raise carries its frames; a cell pins the message, the location and the label.**

Steps: 206, 207, 337, 472, 475, 485, 525, 532, 533, 535, 545, 556, 557, 561, 567, 575, 583, 622, 686, 691, 695
Binds: `1-botopink-lang/144` B-32 · 434 · 444 · `1-botopink-lang/144` B-29 step H · 457 · 462 · 464 · `1-botopink-lang/144` B-47 · 475 · `1-botopink-lang/144` · `1-botopink-lang/144` B-88 · `1-botopink-lang/144` B-19 · 216 · 281 · 404 · `machine-1/144` B-18 · `machine-1/144` B-136 · `machine-1/144` B-99

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 475 | (conformance, the maintainer, 2026-10-11) | (1) Every cell has its own `botopink.json`, a project like any other (`name`, `"targets"` when narrowed, `dependencies` by path when needed, a named wasm host); no implicit package. (2) The `.snap` format: `botopink-cell 1` on line 1, one record per line in a fixed order, one spelling per answer, written and read in one place (`compiler-cli`'s `cell_snap.zig`): `out <text>` (a bare `out` is an empty line), `no-final-newline`, `abort` (the exit status never pinned), `stderr <text>` (after `abort` only; a containment claim; allowed in `output/` and `targets/`), `refused <message>` / `at <file>:<line>:<column>`; a refusal and program output never share a file; a header alone is the empty answer. (3) A departure replaces the module's whole `output/` answer on that target. (4) Every cell has `src/main.bp`; a module's snapshot is named after its source (`x/mod.bp` → `x/mod.snap`); a refusal with no location is `main`'s. (5) A majority is strictly more than half the targets reading `output/` (2 against 2 is none). (6) An empty answer is never accepted by default: a new cell's `main` always gets a candidate | `1-botopink-lang/144` B-29 step H · 457 · 462 · 464 | cell_snap_format_and_manifest |
| 485 | 485-a | A `.snap` refusal file (475 (2)) holds, after `refused <message>` and `at <file>:<line>:<column>`, one `label <text>` record when the compiler prints a label beside the caret, the text as printed (`label use _ { n -> … } to bind the matched value` for `case_bare_name_arm`); only in a refusal file, absent when the caret carries no label; a label that changes or disappears is a red, accepted only by a person (67); `hint` lines are not claimed. Amends 475 (2) | `1-botopink-lang/144` B-47 · 475 | refusal_snap_claims_label |
| 557 | 485-b | One printed form for every refusal, parse and checker alike: `error[<code>]: <message>`; the checker's code leaves the message text and the one printer prints it; cell snapshots written `error: <code>: …` are rewritten mechanically in that commit | `1-botopink-lang/144` B-88 | refusal_prints_error_code |
