---
from: machine-1
to: maintainer
purpose: question
subject: rakun port: design verified correct, check clean, but a new Json-ambiguity blocks test/gate on rakun-bpp — need your call
read: [x]
in-reply-to:
---

The port itself is done and verified correct. The thread confirmed probe B's mechanism empirically at std level first (a Component<Scope> value kept inside the providing body, resolved later, correctly sees the provide — 42, not the default) before touching render.bp, then applied it: a module-level `val selfScope: Component<Scope> = { scope, key -> scope };`, and a `keptAt(scope, inner)` wrapper that ignores whatever scope a later caller (renderErrorBoundary/renderNotFound/a stream fill) hands the deferred thunk and resolves the real continuation over the kept scope instead — which sits under compose's own `use provide(StyledSheet)`, giving back exactly the ancestor-visibility the old Rendered-with-scope return used to give. Also needed: every await<Component> in the compose chain switched to use (809's retirement of implicit await-sugar); decision 357's refusal of `use` inside `if`/`else` branches worked around with an if-expression-typed val feeding one unconditional top-level use; styled_sheet.bp's Sheet.render() made genuinely async over use all per the earlier guidance; 8 rakun-bpp test files mechanically ported.

Result: botopink check is fully clean for both rakun-bpp and rakun-style. One remaining check red (rakun-bpp/test/html/template_test.bp:154, an HTML-DSL optional-binder bug) confirmed pre-existing and unrelated — it only surfaced because render.bp finally compiles enough to reach it.

Blocking: botopink test/build (the codegen pass the gate runs, not check's type-check-only path) fails on render.bp and streaming.bp with "Json is declared pub by std/compiler and by std/json, and this import does not say which." This is crossModule.zig's pickFor/Contested, real ambiguity detection, not a false positive from check being insufficient. The thread spent real effort isolating it: tried every import-statement shape (splitting the import, leaf-importing json.quote/arrayOf/object, from "std/compiler"/from "std/json" submodule paths — which additionally failed to bind names at all, differently broken from the bare form); built three progressively larger standalone repros outside rakun (single file, two-package dependency, then matching globals.bp/plugin.bp's exact shapes including the plugin.Json as PayloadJson alias) — all compiled clean, none reproduced it. Read crossModule.zig's actual mechanism (ImportDecl.leafSource, CrossModule.pickFor) — it's scoped per-consumer-module's own use declarations, which makes the isolation failure more puzzling, not less. Confirmed not caused by anything in the port's own diff (reverted experimental import changes back to the clean post-port state, ambiguity persists either way). Whatever triggers it needs something about the real, full 91-module rakun-bpp package that doesn't show up in isolation.

This is separate from the earlier-reported .toStyled()/behavior-dispatch bug (B-211) — that one's commonJS-only, isolated to rakun-style's Sheet-via-Styleable path (4 tests), still present, unrelated to this.

No commit made — check is clean but test (gate stage 4) is red for this new reason, and the thread correctly won't --no-verify around it without asking.

Three questions, verbatim from the thread, since this needs your call:
1. Keep chasing the Json ambiguity's exact trigger (next idea: shrink the real 91-module rakun-bpp package module-by-module until it reproduces — slower but might actually find it), or hand it to someone with more compiler visibility, or is this already known under a different symptom?
2. Does this front's bar require test/gate green before landing, or is check green enough for a partial land with the Json issue filed separately?
3. rakun-style has no such blocker (test green except B-211's already-reported 4 failures) — land rakun-style alone now, or hold both together as originally asked?
