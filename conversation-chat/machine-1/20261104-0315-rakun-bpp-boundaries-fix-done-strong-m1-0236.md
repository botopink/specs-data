---
from: machine-1
to: maintainer
purpose: question
subject: rakun-bpp boundaries fix: done, strong improvement (erlang 307/17→322/3), needs --no-verify + 2 design calls
read: [x]
in-reply-to:
---

rakunboot landed: f1f6f2d2 (rakun), verified via merge-base, main checkout fast-forwarded. Clears the RenderScope test-cli red for good, as hoped.

The boundaries thread (opus) is done too, substantial result:
| | Base | After |
|---|---|---|
| rakun-bpp commonJS | 317/7 | 318/7 (only the new oracle test added) |
| rakun-bpp erlang | 307/17 | 322/3 |
| rakun-bpp beam | 299/25 | 311/14 |
| rakun-stylesheet | red on beam | 751/0 all three; bridge_test:116 green |
| blog-ssr commonJS/erlang | red | green |

Followed the fable's verdict (Boundary.child a value, Fill(scope: myScope.detach()), run(b.child, fill.scope), keptAt/boundTo gone), but needed one addition beyond the verdict's explicit list: compose/componentOutcome/fixturePageOver also had to take the page as a value (964(2) 30-c) — the page thunk was getting re-numbered on each composition body's cell, which kept scope-foreign alive on streaming_test:402 even after the listed fixes. Public signatures changed: compose, componentOutcome(c, scope), errorBoundaryNode, fixturePageOver.

Three things need your call before I land it:
1. --no-verify authorization is the operator's, I'll ask them — gate's red for the known Known-reds families (rakun-data, rakun-scheduling, rakun-security, rakun-messaging, rakun-cache, rakun-app, rakun-restclient, assorted "no test blocks found"), none of it this change's.
2. __jhPushBoundary stays, not removed as the verdict said to — the thread's reasoning: an Element can't carry a component until 809(7) makes tree children components; making Suspense a #node would print <#node> through the frozen renderToString, breaking suspense_boundary's cell. So Suspense(b) still registers, now as Placed(boundary, at). Is that an acceptable deviation from the verdict, or does it need the fable's eyes again?
3. A Suspense placed directly in a page (not under errorBoundaryNode) doesn't see that page's providers — a plain function can't reach its caller's cell, so its fill gets the enclosing run's scope, detached, instead. The new oracle test only covers the errorBoundaryNode-nested case, which does see providers. Is a bare-in-page Suspense's provider visibility meant to work, or is that out of scope for this fix (a future 809(7)-dependent gap, like the #node issue above)?

Remaining reds, all pre-existing per the thread (not re-verified against base by me yet): styled_sheet_test's 3 (B-218's own fix, lands separately), commonJS's client_app 4 (B-216, already landed separately — should recheck this is actually 0 now), beam's render_test:157/streaming_test:328/helpers_test 169+184 plus 7 badarg (the harness-recording-cell theory from the thread's own debugging, not pinned).
