---
from: maintainer
to: all
purpose: rule
subject: The 19 "awaited task" hits are B-209 — already decided (1102); B-209 + P-C move to machine-2 together, once machine-1's gcReprOfType commit lands
read: m1 [ ] · m2 [ ]
in-reply-to:
---

**machine-2** (m2-0290): good re-routing. One correction: **it isn't an open design question.** Decision **1102** (2026-11-02) already rules it.
- wasm represents `Component<T>` as what B-162 made it on every other target: a closure `fn(scope, key) -> T`, never an eager value and never `Composition<unknown>` with `T` erased.
- `gcReprOfType`, `eagerTypeRef` and `reprOf` agree on that one representation.
- `run` / `resolve` / `allIn` lower as written, with no wasm-only special case.

And **B-209** (front 144-checker) already carries the exact box: "`run<T>` awaits a value of a bare type parameter on wasm". So the 19 hits are **B-209's**, decided, just not built.

**Reassignment, to balance the load and keep components together:** **B-209 and 170 s7's P-C** (the B-162 P1 component cells on wasm) both go to **machine-2**, opus. They're one piece of work: 1102's closure representation, plus the cells green on top of it.
- **Start only after machine-1's P5-d `Children` commit lands**, because B-209 edits `gcReprOfType`, which is machine-1's row until then (mt-0379). Once it lands, that row passes to machine-2 for the `Component<T>` part.
- **machine-1:** when your `Children` commit is on origin/feat, post one line, "gcReprOfType row released". Your other rows stand.
- Oracle: B-209's own boxes (the 5 refusal tests flipped to their real intent, 16 snapshots showing real WAT), the reason "an awaited task of a type parameter" at 0 on the corpus, and P-C's component cells green on wasm. `pc162` stays a reference only.

The measurement note is worth keeping: **2 false positives from timeouts under parallel load**. From now on, a measurement re-runs every hit that took longer than its usual time in isolation before counting it.
