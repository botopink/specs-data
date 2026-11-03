---
from: machine-1
to: maintainer
purpose: question
subject: 809 (8) discrepancy, measured: cross-call provide visibility through a kept cell doesn't work
read: [ ]
in-reply-to:
---

Per your instruction, the rakun thread hit the discrepancy and stopped rather than working around it. Measured, not guessed:

Built a standalone probe directly against libs/std/src/context.bp (no rakun-bpp code, temp file under rakun-bpp/test/, removed, never committed), isolating exactly what 809 (8) describes: pre-open a child's cell (`scope.childAt(key)`), resolve one component over it (a provider), later resolve a different component over the same kept cell (a reader) and expect it to see what was provided. Three variants tried:
1. Pre-open `childScope = root.childAt(key)`, resolve Provider over `(root, key)` (the same pair, relying on openChild's cell reuse, 817), then resolve Reader over `childScope` as parent.
2. Resolve Provider directly over `childScope` as parent, then Reader over the same `childScope` as parent again.
3. Same as 2 but with a non-root parent first, to rule out a `parent == 0` special case in openChild.

All three: the reader gets the context's declared default, not what the provider wrote — the write isn't visible.

Sanity check ruling out a setup mistake: the ordinary single-component nested case (`use provide` then `use Reader()` inside the *same* component body) correctly answers the provided value. So `use provide`/`use context` work exactly as documented for a normal nested chain — the gap is specifically the cross-call case: pre-open a cell, resolve something else over it later, expect visibility through the kept cell.

Traced openChild/provideIn/enter by hand (context.bp ~290-320, 358-364, 469-475): the code as written predicts cases 2 and 3 should work (childAt snapshots the parent's current cellFrames at creation, provideIn mutates that cell's cellFrames in the shared store, a handle to the same (store, cellId) pair should see it later). Empirically it doesn't. The thread can't narrow further without the Zig lowering code (out of its worktree's scope) — possibly `use provide`/`use context`'s lowering doesn't actually dispatch through these functions as written, or a `Scope` reference/value-semantics issue crossing an `await` on commonJS (`Scope` is opaque). Not tested on erlang/beam yet.

Thread is paused, nothing else touched, render.bp/streaming.bp still untouched. Your call: who looks at the lowering (is this mine, or does it need someone already in wat.zig/context_lower.zig context), and should the thread keep narrowing (try erlang/beam, or a narrower non-async repro) while that happens, or wait?
