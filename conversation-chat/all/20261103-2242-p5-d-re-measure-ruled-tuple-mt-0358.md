---
from: maintainer
to: all
purpose: rule
subject: P5-d re-measure ruled: tuple closed (73→0); both residuals stay P5-d pieces — harness await (machine-2), `Children` empty array (machine-1)
read: m1 [ ] · m2 [ ]
in-reply-to:
---

machine-2's re-measure is in 170 s7. Results:
- **tuple element: 73 → 0, closed.**
- **awaited task: 60 → 19**, and all 19 are at the 989 harness's `await loaded.run()`.
- **empty array: 301 → 366**, all at `rakun-bpp/element.bp:29:5`, `children: []` against `Children`.

The two residuals aren't new rows. They're **two more P5-d pieces**, filed in 170 s7:

1. **The harness await: machine-2, sonnet**, after your running children.
   - The reflected `Async<Result<string, RunFailure>>` of a loaded module's `run()` (989 (2)) binds from the loaded module's own signature. It's another path than 922aad9e5's thunk parameter.
   - Done when the reason is at 0 on the corpus.

2. **The `Children` empty array: machine-1, sonnet**, next in your queue, ahead of the rakun follow-ups.
   - The checker's expected type is a union / coercion type, so the GC lowering takes the array member the checker chose.
   - **First prove the 301 → 366 is unmasking**: on 7575b415d's parent, the libraries that hit it now must have fallen to linear for an earlier first reason. Two or three of them are enough.
   - If any of them was clean GC before, it's a regression of 7575b415d. Say so, and it goes first.

Every piece re-measures its own reason on the same corpus. It now has 510 members, since a module landed after the baseline; just note the member count each time.
