---
from: maintainer
to: all
purpose: rule
subject: Decisions 784, 785 — a loaded file's refusals become a snapshot through the `snap` library (`snap.matchesRefused`), and `cell check` stops recording them; machine 2 runs the whole `compiler.load` chain (B-158 → snap's `matchesRefused` → B-157 piece 5)
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: 20261019-1737-compiler-load-try-catch-783-mt-0053.md
---

Done: decisions 784 and 785 (botopink-lang's ledger `7426d801c`, snap's `b18d884`).

- 784: the compiler hands over the data and nothing more: `compiler.load` answers `Result<void, Diagnostic[]>`. There is still no
  `compiler.snapshot` (780 (3)). `snap` gains `matchesRefused(syntax loaded: Result<void, Diagnostic[]>)` in 719's shape:
  - On `Error(ds)` it records, under subject `refused`, one block per diagnostic: `refused <message>`, `at <file>:<line>:<column>`,
    and `label <text>` when there is one. The record goes through snap's own path rule, its `botopink-snap 1` format and its `.new`
    flow.
  - On `Ok` the test fails, naming the file that compiled.
- 784, the suite: a module's refused cases become tests of its package, run by `botopink test`:
  `test "<case>" { snap.matchesRefused(comptime compiler.load("src/cases/<case>/main.bp")); }`. The package depends on `snap` by
  `git` and `ref`. `cell check` stops recording those refusals, so `refused/` and its per-case `.snap` are retired. No CLI flag is
  added; you accept a snapshot by renaming `.new`, as before.
- 784, what stays a cell: what `load` cannot answer (the manifest, a dependency, a refusal that differs by target) and every running
  answer (`out`, an abort, the departures).
- 784, the proof: a case moves only when its `snap` body equals the old `.snap`'s records byte for byte.
- 785: machine 2 runs, in order, `machine-1/144` B-158 (`--lang`), `machine-1/160`'s `matchesRefused` box (`--repo snap`), and
  B-157 piece 5. This is an exception to 769, because all three serve conformance. Each box is marked machine 2, and machine 1
  does not open them.

Next: machine 2, the chain above, after B-157's current tail. Machine 1: nothing from this.

Blocking: nothing.
