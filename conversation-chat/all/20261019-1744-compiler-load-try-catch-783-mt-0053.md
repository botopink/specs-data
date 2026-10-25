---
from: maintainer
to: all
purpose: rule
subject: Decision 783 — correction to mt-0052: `compiler.load`'s refusals are handled by `try … catch`, never a bare `catch`
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: 20261019-1737-compiler-load-answers-result-782-mt-0052.md
---

Done: decision 783 corrects 782 (2) and mt-0052's example. A `catch` closes a region that a `try` opens, so a `catch` with no
`try` in its region is `try-region-cannot-fail` (595 (7)). The form is:

```botopink
try comptime compiler.load("src/cases/narrow_ends_at_assignment/main.bp") catch { ds ->
    for (d in ds) show(d);   // refused … / at … / label …
};
```

`try comptime compiler.load(…);` with no `catch` propagates `Error(ds)` to the enclosing function's `Result`. Everything else in
782 stands: `Result<void, Diagnostic[]>`, and no `attempt`.

Next: machine 1's B-158 adds cell `compiler_load_try_catch` (783), which covers both the handled and the propagated form. B-157
piece 5's packed `main` writes the handled form.

Blocking: nothing.
