---
from: maintainer
to: machine-1
purpose: rule
subject: From the user: you're idle — open 5 children now, split by repository and file
read: [ ]
in-reply-to:
---

The user sees machine-1 idle. Open these as child threads now, each in its own worktree, pool permitting. If the 2 stale-RenderScope cases from mt-0345 are still waiting on `--no-verify`, ask your operator for that first, then:

| # | Child | Repo / files | Model |
|---|---|---|---|
| 1 | **P5-d, the `Children` empty array** (`rakun-bpp/element.bp:29`'s `children: []`, 366 notes; mt-0358). First prove the 301 → 366 rise is unmasking, on 7575b415d's parent. | botopink-lang `wat.zig` | sonnet |
| 2 | **B-229 + B-230**, moved to you from machine-2 to balance the load. B-229: `internString` unresolved, the whole `case` module falls to linear. B-230: a Node-shaped variant's GC print-dispatch type check. Together they finish `conformance/modules/case` on wasm. | botopink-lang `wat.zig`, a different region from #1. Name the functions | sonnet |
| 3 | **rakun-bpp's boundaries hold the component value** (front 169 Known reds, ex-B-217): `Boundary.child: Component<Element>`, `Fill(… scope: myScope.detach())`, `run(b.child, fill.scope)`. `keptAt`, `boundTo` and `__jhPushBoundary` go. | rakun `modules/rakun-bpp` | opus |
| 4 | **`modules/rakun` off RenderScope**: `pub async fn boot()`, `mount` with `Place.key(m.name)`, `inject` by hand with `Place.key(name)` (mt-0341 (2)). | rakun `modules/rakun/src/rakun.bp` | sonnet |
| 5 | **170 s13**: rakun's three timing tests on a controlled clock, or a `language-gaps.md` row if std has none. | rakun `rakun-data` devtools, `rakun`, `rakun-messaging` tests | sonnet |

Then, as slots free: the decorator sites (mt-0341 (3)), opus for the first site of each shape, sonnet after that.

Each child verifies itself; your main reviews, lands and sends me hashes. One more thing, so you don't go silent like yesterday: when a child is done and waits on a `--no-verify`, **send me one line right away** ("X done, waiting on the operator"). I'll know it's not a stall, and the user can unblock it.
