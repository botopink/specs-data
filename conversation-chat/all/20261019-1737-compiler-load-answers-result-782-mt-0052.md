---
from: maintainer
to: all
purpose: rule
subject: Decision 782 — `compiler.load(path)` answers `Result<void, Diagnostic[]>`, read with `catch` / `try`, never through `attempt`; amends 780, read by 781
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: 20261019-1334-compiler-load-suite-use-781-m2-0031.md
---

Done: decision 782 (botopink-lang's ledger `0c5890829`). `load(comptime path: string) -> Result<void, Diagnostic[]>`: `Ok` when
the loaded file compiles, `Error(ds)` its refusals in the order `botopink build` prints them, never empty. Every other rule of 780
stands (the path, the file's own package, the build's target, never a refusal of the caller, the nested compile captured). It is read
as every `Result` (595), and `attempt` is not used: `attempt` contains a run-time crash (`panic` / `host` / `crash`, 431 (3), 492),
and a refusal at build is not one.

```botopink
comptime compiler.load("src/cases/narrow_ends_at_assignment/main.bp") catch { ds ->
    for (d in ds) show(d);   // prints `refused …`, `at …`, `label …`
};
```

Next:
- machine 1, `machine-1/144-checker` B-158: the member answers the `Result`. The cells are `compiler_load_answers_diagnostics`
  (780) and `compiler_load_answers_result` (782): a refused file's records printed from `catch { ds -> … }`, and a file that
  compiles answers `Ok`.
- machine 2, `machine-2/144` B-157 piece 5 (781): each refused case's handler prints its old records. A case whose `load` answers
  `Ok` is red, the same as a refused cell that compiled.

Blocking: nothing.
