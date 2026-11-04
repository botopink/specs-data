---
from: machine-1
to: maintainer
purpose: report
subject: StyledContext regression fixed and landed: 10be5010 (rakun), meta bump 29500884
read: [x]
in-reply-to:
---

Landed, verified via merge-base on origin/feat:
- rakun: 10be5010 "a bare StyledContext read opens no fresh root" (decisions 969, 809, mt-0410)
- meta: 29500884 (pointer bump)

The bisect's shape (mt-0410) diagnosed the symptom right but was incomplete on root cause. Two independent bugs:
1. render.bp's `use provide(createContext(renderSheet()))` keyed its context by the bare "StyledSheet" instead of "rakun-style@@StyledSheet" (144 B-218's declaring-package rule) — render.bp never imported StyledSheet by name, only inferred it through renderSheet()'s return type, so the key generator fell back to render.bp's own package. This alone caused the "no StyledContext provider" panic inside compose() itself. Fixed with one explicit import line, no compiler change.
2. Applied your prescribed shape too (correct per 969/809): renderedStyles() is now `component fn` + `val myScope = use selfScope;` mirroring c01f4a3f's Suspense fix exactly; renderedStylesAt(scope) is the plain-code twin for styled_sheet_test.bp. examples/rakun-style/styled-example/src/main.bp consolidated under one shared root run().

Oracle: styled_sheet_test.bp's 3 cases red→green on commonJS and erlang (confirmed via standalone repro + stack trace both before and after). styled-example: panicked both targets before, now prints the correct layered sheet on both. Full modules/rakun-bpp suite: commonJS 321 passed/4 failed (client_app_test, unrelated — see m1-0291), erlang 325 passed/0 failed.

Outside: client_app_test's 4 commonJS reds filed in fronts/169-gate-green/README § Known Reds under B-216 (24fe927f); asked machine-2 whether they're B-216's family (m1-0291). modules/rakun-style/test/styled_example_test.bp still passes but is now textually out of sync with the example (same-package context, no B-218 exposure) — not fixing since it's not red and wasn't asked.

Worktree removed. Still running: P5-g (GC type-check diagnostics), rakunshapea (decorator-sites rewrite, resumed on B-147-erlang). rakun503 parked on rakunshapea per m1-0290.
