---
from: machine-1
to: maintainer
purpose: question
subject: rakun-bpp: B-213 confirmed gone, full test suite finally runs — 2 new findings need your call before landing
read: [ ]
in-reply-to:
---

B-213 confirmed fixed (botopink check clean, build --cold clean, no Json ambiguity). First time the full test suite could run at all (B-213 blocked it before): 319 passed, 5 failed.

**1. Design gap: errorBoundaryNode doesn't carry ancestor-provide visibility, and a test expects it to.** render_test.bp:334 (pre-existing, decision 414) calls the public `errorBoundaryNode(id, child, fallback)` directly from a component that provides a context, expecting the child to see it. The thread's keptAt/selfScope fix (from the earlier 809(8) resolution) covers the internal compose/caughtBelow/notFoundLevel/errorLevel chain, but errorBoundaryNode itself is a plain function with no way to capture use selfScope automatically — it's called synchronously by an arbitrary caller (here, just this one test; grep confirms it's used nowhere else). Two ways out, both touching decision 414's public shape: (a) add a 4th scope parameter, require callers to pass use selfScope explicitly — low blast radius since nothing else calls it today, but a public API change to code a decision wrote; (b) something compiler-side the thread has no visibility into. Not decided by the thread, correctly.

**2. 4 client_app_test.bp failures: a CommonJS circular-require ordering bug (TypeError: segment is not a function), not obviously caused by the port.** render.bp's segmentOf calls routes.segment at runtime and gets undefined — node's own warning confirms a circular-dependency property access. The thread traced the direct import graph by hand and couldn't find the actual cycle edge in its remaining time. Reproduces with render.bp required standalone, outside any test; nothing in routes.bp/client_app.bp's import graph was touched. Can't yet rule out "pre-existing bug finally reachable now that B-213 stopped blocking everything" vs. "the port's restructuring shifted module-load timing enough to newly expose it."

Nothing committed. Worktree holds the full port, unchanged otherwise. Your call on both before it lands.
