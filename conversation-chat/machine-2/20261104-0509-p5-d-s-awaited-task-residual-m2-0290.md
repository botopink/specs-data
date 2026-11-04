---
from: machine-2
to: maintainer
purpose: question
subject: P5-d's "awaited task" residual isn't P5-d's — it's B-162 P1's Component&lt;T&gt; erasure (b162wasm-d)
read: [x]
in-reply-to:
---

The `p5dawait` child found the premise wrong rather than fixing anything: the 19 remaining "an awaited task of a type parameter" hits are NOT the decision-989 `Module.run()` harness shape piece 1 already fixed — that shape re-tests clean, standalone, across 7+ decisions-taken modules with no component usage.

The real, repeatable trigger is `context.run<T>(c: Component<T>)` (decisions 504/809/819/825): a `component fn`'s return type is rewritten to `Composition<unknown>` (its `T` erased) before `wat.zig`'s `registerFn` stores it, so `bindAwaitedGeneric`/`genericRetByFnArg` can never recover the concrete `T`. This is the same root cause as the already-known, already-"pending" `b162wasm-d` gap documented in `tests/wat.zig`'s own `"wat: needs ---- a use memo module stays WasmGC"` test (which already expects today's refusal for this exact class of program) — it's B-162 P1's own box, not a P5-d mechanical substitution.

Re-routed in the spec (170 s7): the row now points at B-162 P1 instead of P5-d, and I corrected the P5-a table's annotation and the "closed since baseline" note to match. No fix attempted — this needs a design decision on how a component's concrete `T` survives the `Component<T>`→`Composition<unknown>` erasure, which is a semantic question, not mine to invent (opus/fable tier, per the model-routing rule).

Also worth noting: a scan for this gcFail text initially found 16 hits, but 2 were resource-contention false positives (timeouts) from running alongside the other 3 parallel children on this machine — isolated reruns of both compile clean. Real count: 14 decisions-taken modules + `modules/component` standalone, all genuinely `component fn`/`Component<...>`/`context.run`-shaped. Worth keeping in mind for any measurement under heavy parallel load.

Worktree removed, no commit (nothing to land). My P5-d queue is now down to the one clean mechanical piece (empty array literal, already yours/machine-1's) — awaiting your call on whether/when B-162 P1's design question gets scheduled.
