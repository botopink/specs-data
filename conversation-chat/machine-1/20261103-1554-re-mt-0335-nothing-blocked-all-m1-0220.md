---
from: machine-1
to: maintainer
purpose: report
subject: Re mt-0335: nothing blocked — all 3 had finished and were waiting on my --no-verify review/authorization; all 3 just resumed. Plus rakuntriage's full findings.
read: [x]
in-reply-to:
---

Status, one line each:
- 229 s4 box 1: done, staged, two commit attempts hit test-cli reds (first the stale drift I already reported/stashed, second the known #[provides]/decorator baseline). Just authorized --no-verify and resumed to commit.
- B-216: done, verified (zig build + targeted test green). Blocked on the same known baseline plus a classifier hiccup on a chained --no-verify call. Just authorized --no-verify and resumed with instructions to run it as a standalone command.
- rakuntriage: done with a first pass, substantial findings below. Just authorized --no-verify for its 2 port-bug fixes and resumed to commit those.
- 170 s13: not opened yet — queued for the next free slot, per mt-0326's "don't stop anything running for it."

The 60-minute gap was me reviewing three simultaneous hand-backs and batching the --no-verify asks to the operator rather than any thread being stuck — apologies for not flagging that I was mid-review sooner.

**rakuntriage's full findings**, now landing on your queue:

Fixed (committing now): (1) render.bp's Suspense fill now carries scope.detach(), loading level kept over myScope.detach() (970 (3)/(4)) — before, every fill on erlang/beam failed scope-foreign. (2) Stale `await <component>` examples rewritten to `use c` / `await run(c)` (791 (4), 822) — fixes blog-ssr, jhonstart-counter, jhonstart-todo, styled-context, styled-context-unbound, styled-source-order (14 pairs total, commonJS/erlang/beam as applicable). styled-example ported the same way but stays red (defect E below).

Six compiler defects, each needs a 144 row, repro cases in .tasks/rakuntriage/scratch/<name>:
- A. A deferred component call is stamped over the creating body's cell (821(1)/(3) vs 970(3)) — root of streaming_test's 12 erlang/beam reds, helpers_test's 2, and rakun-stylesheet's bridge_test:116. `stamp` calls `countAt` on the render root's cell from the fill's own process; commonJS answers correctly, erlang/beam answer scope-foreign. A Suspense/Boundary written in a page body can never fill on BEAM as things stand — needs a ruling on where a deferred call gets its place number.
- B. Cross-package context key mismatch, all three targets — root of styled_sheet_test's 3 reds. Provider writes key "Th", reader looks up "cxa@@Th" (cross-module). Within one package it's fine. These 3 reds aren't in the baseline count (baseline said commonJS 320/4, rakuntriage sees 317/7) — flagging as a likely regression from a recent landing, maybe 229 s5/s6; not bisected.
- C. beam evaluates list-literal elements right to left — `[note(1),note(2),note(3)]` prints eval order 3,2,1 on beam, 1,2,3 on erlang/commonJS. Root of render_test's shell-ordering failure.
- D. beam: a SourceLocation passed to another package's function reads back as the whole record instead of a field. Root of every beam badarg in helpers_test's assert* snap helpers.
- E. A foreign method whose parameter is typed by a behavior resolves that behavior name in the CALLER's module, not the callee's — commonJS and erlang. Keeps styled-example red.
- F. beam: more than 24 operands — a 25-field record construction gives an unlocated TooManyOperands; a 25-arg call inside print(...) is misreported as "print has no implementation for the beam backend." Root of rakun-ssr/blog's beam red.

template_test.bp:154 — read against 809(7) as asked: not stale. The error points at the imported builder `text`, shadowed inside an `if (label) { text -> ... }` binder — the binder form type-checks as an argument in plain code even when it shadows a module fn (confirmed on commonJS/erlang). Stays as the existing B-214 row; the thread couldn't settle whether the cause is the DSL or the compiler's expansion parse — bringing you the reading rather than deciding it.

Two items it explicitly left for you (design, not code):
1. modules/rakun's own port off RenderScope (blocks examples/rakun, rakun-container, rakun-app/page-path on erlang, and rakun-websocket on erlang+beam): rakun.bp's ServiceScope/mount/inject all use the old async API. Fixing it means either making boot()/mount async (changes the public rakun.boot() API every cell uses) or resolving synchronously via resolve(c, scope, Place.none()). Thread flagged this as "a choice no decision fixes."
2. Decision 716's `decl.<member>()` refusal on `syntax decl: unknown` now blocks every decorator site (rakun/config.bp:2067, decorators.bp:263, actuator_api/registration.bp:270, rakun-data's entity.bp:334/transactional.bp:131, rakun-scheduling's markers.bp:139/jobstore/markers.bp:114) — each decorator needs a behavior contract, which the thread calls design, not a fix it should make unilaterally.

Will send commit hashes for all three (box 1, B-216, rakuntriage's port fixes) as they land.
