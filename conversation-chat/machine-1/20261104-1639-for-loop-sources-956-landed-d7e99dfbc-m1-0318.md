---
from: machine-1
to: maintainer
purpose: question
subject: for_loop_sources-956 landed: d7e99dfbc (botopink-lang), meta bump 2e028e16 — a boundary-crossing judgment call and a stale B-233 cross-reference, plus a new unfiled gap
read: [x]
in-reply-to:
---

Landed, verified via merge-base on origin/feat (meta-level submodule merge conflict during rebase — resolved cleanly: botopink-lang's own history was a trivial fast-forward, de81ad0a1→d7e99dfbc, the conflict was a transient git recursive-submodule-merge artifact, not a real content clash):
- botopink-lang: d7e99dfbc "a loaded package's own YieldStep splice stays reachable, so a .next()-desugared for over Iter/AsyncIter lowers on .gc" (front 170 s7, decision 956, 144 B-233's test rewritten)
- meta: 2e028e16

My prompt told the thread the bug was in comptime/infer.zig/env.zig (machine-2's trace, which I relayed). It wasn't: the thread instrumented comptime.zig directly and proved env.usesYieldStep propagates correctly through compiler.load() — identically to a top-level build. The real defect is in codegen/wat.zig's pruneUnreached: GC reachability is pure AST-name-matching, and YieldStep (a prelude enum spliced in by decision 122, never named by any AST node) gets pruned as an unreferenced declaration when the splice happens in a LINKED module rather than the entry — unlike SourceLocation/Declared/Asset, which spliceNamedRecords already protects across a link boundary. Fixed by keeping YieldStep unconditionally.

Flagging the thread's own judgment call rather than quietly accepting it: pruneUnreached is in wat.zig, which mt-0379's region map doesn't explicitly assign to either machine (it's not in either row), and the thread crossed outside what I'd told it ("comptime/infer.zig, env.zig — machine-1 only") because the evidence pointed elsewhere. I checked before landing: no current chat announcement claims pruneUnreached, and it doesn't touch either machine's active wat.zig work (machine-2's gcChainedCall/lowerChainedCall, fnArgReturn/bindAwaitedGeneric). I judged this safe to land as a factual bug-location finding, not a design call the ownership rule was meant to gate — but flagging in case you want wat.zig's "unclaimed" functions given an explicit owner going forward.

Confirmed stale: 144 B-233's test already built this exact scenario, with a comment literally documenting the gap, but only ever asserted the diagnostic's column was sane — never that the gap was wrong. Its cross-reference in P5-a's table as "this row already fixed" was never true. Rewritten to assert correctly now.

New gap found, not fixed, no row filed (I have no specs-bot session as a different party to file it under 144/164 myself without more context on where it belongs): once YieldStep stops masking it, for_loop_sources-956 still isn't fully wasm-green — "the wasm backend walks an array or a range; nothing shows this iterable is one" at a synthetic location inside compiler.load()'s own generated helper code. A minimal sum()/tens() repro (no Grid, no await, no three-source loop) is clean; this second gap only shows with the full cell's complexity. Unrelated to decision 956 and to the checker — likely another wat.zig static-type-tracking gap for an array value through compiler.load()'s synthetic AST. Your call whether this is a 144 row or stays a 170 s7/P5 residual.

Still holding on m1-0313 (716(1) final sites) — this landing's own --no-verify cited the exact same decorators.bp:263/config.bp:2067 red, confirmed byte-for-byte, so the known-set citation is holding up consistently across threads. Three threads now have independently hit it (mine, machine-2's p5aregressions, this one).
