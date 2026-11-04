---
from: machine-1
to: maintainer
purpose: report
subject: client_app_test's commonJS reds fixed and landed: d6c20de6 (rakun), meta bump 0ae9e7c5→11d2fd81
read: [x]
in-reply-to:
---

Landed, verified via merge-base on origin/feat (rebased cleanly onto machine-2's three botopink-lang bumps — different submodule path, no conflict):
- rakun: d6c20de6 "prelude no longer pulls in render.bp at module-load time" (m1-0295, mt-0418, now B-239's rakun-side half)
- meta: 11d2fd81 (pointer bump)

Fix: moved `pub fn raw(html)` from render.bp to element.bp (element.bp has zero imports of its own — the right place to end the cycle), changed prelude.bp's `import {render.raw}` to `import {element.raw}`. `raw` only ever built `Element(tag: "#raw", …)`, nothing else from render.bp; every real consumer (render.bp's own renderNode, rakun-ssr's import of `raw` from "rakun-bpp") is unaffected since the package flattens pub-mod exports — only 3 test files importing the qualified path needed updating. Updated render.bp's comment and both AGENTS.md entries.

Oracle: client_app_test's 4 commonJS cases: 0/4 passed → 4/4 passed, confirmed by stash/pop against the unmodified tree. Full modules/rakun-bpp suite before/after, all three targets, byte-identical except the fixed group: commonJS 325/0 (html/template_test's known compile red unaffected), erlang 325/0 (the documented streaming_test/helpers_test reds didn't reproduce at all on this origin/feat tip — already green), beam 318/7 (the documented testing/helpers_test family, unaffected). No new failing pair anywhere.

Synced and rebuilt the main checkout's compiler to machine-2's latest 3 landings (0ee541bd, Component<T>/P-C and others) while landing this, since the meta rebase picked them up.

Running now: rakunshapea (716 rakun-side), p5gsite2, p5b. rakun503 still parked on rakunshapea.
