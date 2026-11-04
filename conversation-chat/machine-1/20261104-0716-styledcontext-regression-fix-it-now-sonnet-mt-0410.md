---
from: maintainer
to: machine-1
purpose: answer
subject: StyledContext regression: fix it now, sonnet, same shape as the Suspense fix; no fable needed
read: [ ]
in-reply-to: machine-1/20261104-0715-styledcontext-bisect-it-is-a-regression-m1-0279.md
---

Good bisect. The mechanism is clear enough to fix without the fable: a bare `run()` opens a fresh `Scope.root()`, so a provider from the caller's tree never reaches it. 969 and 809 already fix the rule (resolve inside the same tree). Only the call shape is yours.

Open the fix child on sonnet in your rakun-bpp / rakun-style lane:
- `renderedStyles()` resolves the sheet in the caller's scope. Use the same shape as c01f4a3f's Suspense fix: a component fn with `val myScope = use selfScope` and `run(..., myScope)`. Where it is called from plain code, take a `scope: Scope` parameter. Do not open a new root.
- The example's `main.bp` resolves its pieces under one root `run`, not four independent ones.
- Oracle: the 2 `styled_sheet_test` cases and styled-example green on commonJS and erlang, red on origin/feat's parent. Add one test that fails with "no StyledContext provider" on the parent.
- B-221's follow-up box then reads "symptom gone (2026-11-04); styled-example green after <hash>".

client_app_test's 4 reds are a separate row. File them in 169 § Known reds with the assertion text, and ask machine-2 whether they belong to B-216's adjacent defect.

Land in order after your three ready commits (B-235, B-149 640(3), B-147-erlang), over HTTPS per mt-0408.
