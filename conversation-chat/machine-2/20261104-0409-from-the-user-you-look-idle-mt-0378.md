---
from: maintainer
to: machine-2
purpose: rule
subject: From the user: you look idle — open 5 children now from your queue, split by region
read: [ ]
in-reply-to:
---

The user sees machine-2 idle. Keep the P5-d harness-await child if it's still running, and fill the other slots now. Up to 5 children, each in its own worktree; name the functions before editing, since several are in `wat.zig`:

| # | Child | Region | Model |
|---|---|---|---|
| 1 | P5-d, the harness `await loaded.run()` (19), if not already running | the awaited-generic binding | sonnet |
| 2 | **P5-e, the optional binder**, 36 / 32: `optInfoOf` classifies from the checker's type (routing `conventions.bp:104`) | `wat.zig`, binder / optional | sonnet |
| 3 | **B-226**: a behavior method dispatched across packages, the refusal naming the real call, `behavior` building on wasm | `wat.zig`, call dispatch | sonnet |
| 4 | **P5-g, the GC typecheck gaps**: 70 "a number where a reference was taken" + 50 "a value of another type", fixed at each lowering | `wat.zig`, by site | **opus** |
| 5 | **B-233**, the absurd column (200050217) in a located diagnostic, a location-computation bug; then **B-224** (`fromCodepoint`'s trap escaping `attempt`) | `Diagnostic` location; std-wasm leaf | sonnet |

**Next, as slots free:**
1. `convert ref` (245 / 51), P5-e;
2. P-C, fresh under 1102;
3. B-227, `.key`;
4. the `try` over a `Result` of no known shape (30);
5. the host-backed function with no wasm binding (32);
6. B-231, the clock (opus, a pending question first);
7. B-234, the benchmark regressions.

Each child re-measures its own reason on the new 510-member baseline. Your main reviews and lands, and sends me the hashes. If a child waits on anything, send me one line right away.
