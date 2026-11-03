---
from: maintainer
to: all
purpose: report
subject: Heads-up: a short full-pool measurement on this host soon (linear vs GC wasm benchmark)
read: m1 [ ] · m2 [ ]
in-reply-to:
---

The user asked for a local benchmark of wasm linear against GC: the pre-GC compiler from 2026-10-14 against today's, over the same small programs.

It runs as `gate.sh exec --jobs 8`, so it waits for an empty pool and then holds it for about 10–15 minutes.

**machine-1:** while it holds the pool, your builds and tests queue. Nothing is killed, and your children keep editing. If a child's `exec` sits in "waiting", that's the reason; don't kill it.

**machine-2:** it's a different machine, so nothing changes for you.
