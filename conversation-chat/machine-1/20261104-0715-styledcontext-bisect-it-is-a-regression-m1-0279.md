---
from: machine-1
to: maintainer
purpose: report
subject: StyledContext bisect: it IS a regression from today's rakun-bpp port (e6a4de85, bare scope-less run()); client_app_test confirmed unrelated
read: [ ]
in-reply-to:
---

Full bisect table (fixed compiler 5eae5c6b8, read-only, 8 commits from a7ceadde to c01f4a3f):

Two unrelated compile walls blocked parts of the range: (1) the example's main.bp used the pre-791/822 "await X" shape, identical compile error at a7ceadde/e6a4de85/ef279adb, until 735ec1ba rewrites it — predates the port, not introduced by it. (2) the whole rakun-bpp module (styled_sheet_test, client_app_test) doesn't compile against the FIXED compiler until e785eaa4 lands NodeChildren (the fixed compiler already has B-232) — untestable before that.

First observable panic point: 735ec1ba for the example (can't test earlier due to wall 1); e785eaa4 for the library tests (already failing identically to HEAD, can't test earlier due to wall 2, but it's the first point where it's even testable).

**client_app_test confirmed NOT related** — its 4 failures never flip with StyledContext anywhere in the range, same "(assertion failed)" message throughout, matching the already-known B-216-adjacent defect both e6a4de85's and c01f4a3f's own commit messages name explicitly.

**Mechanism, from reading the actual diffs:** std's `run<T>(c, scope: ?Scope = null)` opens a brand-new disconnected `Scope.root()` when called with no scope — confirmed with a scratch std-only repro that normal nested use/provide propagation is fine, this isn't a generic regression. e6a4de85's own diff to `styled_sheet.bp` changed `renderedStyles()` to a bare scope-less `await run(__jhStyledSheet(...).render())` — per decision 969 (rakun-style, landed yesterday at a7ceadde), `Sheet.render()` now resolves under `use all(...)` so it needs to run inside the SAME component tree as whatever provided its context; the bare `run()` opens a fresh root instead of inheriting the caller's scope, hitting styled.bp's `missingProvider()` panic. The example (main.bp, fixed by 735ec1ba) independently wraps Render/RenderProperty/tabRed/sheet.render() each in their OWN separate bare run() calls — same shape, a provider set up in one run()'s scope never reaches another.

Thread couldn't prove e6a4de85 is THE exact introducing commit directly (compile walls blocked testing it in isolation against the fixed compiler), but its diff is the first place in the range creating this shape, and the other two candidate commits (ef279adb: erlang/beam-only Suspense scope work, unrelated path; f1f6f2d2: doesn't touch render.bp/styled_sheet.bp at all) don't plausibly cause it.

**Suggested fix (not applied/verified, read-only task):** thread the caller's Scope through instead of bare run() — give renderedStyles() a scope: Scope parameter and call run(..., scope); have main.bp resolve its pieces under one shared run()/scope instead of four independent ones.

My call: this looks like my own regression from e6a4de85 (and partly 735ec1ba), in my own rakun-bpp/rakun-style lane — I'd like to open a fix thread for it unless you want to hold for some reason (e.g. if 809(7)'s later migration makes this moot, or if you want the fable to weigh in on the scope-threading design first, since it touches a function signature and multiple call sites).
