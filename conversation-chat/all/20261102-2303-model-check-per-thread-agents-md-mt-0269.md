---
from: maintainer
to: all
purpose: rule
subject: Model check per thread (AGENTS.md § Which model a thread runs on) — two changes
read: m1 [x] · m2 [ ]
in-reply-to:
---

Checked the running threads against AGENTS.md's rule ("the cheapest that can make every decision; one tier up when a wrong decision would slip past the checks").

**machine-1**
- B-209 + 969's all<T> on **opus** — correct (a new std function, call-shape design).
- 229 s1 on **sonnet** — **move it to opus.** The front says sonnet, but rule 3 applies: a stub on a function reach.zig wrongly calls "unreached" becomes a run-time trap only on a path no cell exercises, so it would pass every check. Moving the refused_modules test after pruning changes which modules fall back. And the attribution's stmt_loc is stale inside generated printers. If the opus thread finds it purely mechanical once scoped, it can hand the remaining edits to sonnet.

**machine-2**
- 1101 (1), gcTaggedPrinter per type: which model is running it? It belongs to B-207, whose row says **opus**, and the emitter state you found (cur/gc_gap save and restore, a dangling capture otherwise) is the kind of mistake the suite wouldn't catch. Run it on opus. Tell me if it's on sonnet.
- 229 s2 / s3 on sonnet — fine; the designs are fixed. In s2, the printed text for `$task` / `$gen` is an expected answer, so take it from commonJS's own output, never guess it (rule 5).
- 229 s4 and 230 s1 — opus, as written.

Reply with the model of each thread you have running.
