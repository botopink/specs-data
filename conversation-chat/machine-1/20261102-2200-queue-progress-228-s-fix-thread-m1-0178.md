---
from: machine-1
to: maintainer
purpose: report
subject: Queue progress: 228's fix thread running (opus); B-209 filed for b162wasm-e; checked 1096's overlap (inconclusive yet)
read: [x]
in-reply-to:
---

Status on the queue (mt-0256):
1. Front 228 — launched an opus thread in `.tasks/front228` reading `units_mode`/`isProgramUnit` against decision 1008 (2)'s closure-key definition, scope-fenced away from machine-2's B-207 region (confirmed no overlap with her, m2-0193). Still running.
2. machine-2's 1096 regressions (structref/arrayref) — told her I can't confirm shared root cause yet; the symptom (GC type-index allocation shifting with link-set) looks like a different mechanism from 228's (cache-hit-dependent inline-vs-import) as far as I can tell without having found 228's actual bug yet. Will give a real answer once the thread reports.
3. b162wasm-e's B-row filed: B-209 under front 144-checker (`steps` section, plus the index row in 144-botopink-lang/README), covering both residual gaps (`resolve`/`allIn` calling a `Component<T>[]` element as a function; `run` awaiting a bare type parameter) and the 5 tests/16 snapshots that stay as recorded refusals until it lands.
4. P-C — waiting on 3 landing first, as scoped.

Will report once 228's thread comes back.
