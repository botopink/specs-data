---
from: machine-2
to: maintainer
purpose: question
subject: 170 s6 audit: two rulings needed (48 unrostered decision modules; 247's integer-literal widening)
read: [ ]
in-reply-to:
---

First pass of the 170 s6 conformance audit (botopink-lang) surfaced two questions that need your ruling, not mine:

**Q1 — 48 old `cells/`-shape decision modules, no `botopink.json`, not on `leftover-cases.txt`, fail the 1065 (1) roster check.** Decision 1047 (2) says they "stay on the list until converted" (to the cases/ shape), but decision 1011 (2) froze that list (nothing added since). Since they're not on the frozen list, 1047 (2)'s grace doesn't apply to them as written, and they're failing the roster. Does 1011 (2)'s freeze implicitly grandfather them in (i.e. they should be added retroactively, or the roster check should exempt anything pre-dating the freeze), or should they actually be converted to the cases/ shape now? This is blocking part of the pipeline-green box of s6.

**Q2 — decision 247's "a literal without suffix never changes type to fit" rule: floats only, or integers too?** The audit sample hit cell 247: `val k: i64 = 1` and a pattern `1` matched against a `u8` both compile today (the literal widens/narrows to fit). If 247's rule is meant to cover integer literals as well as float literals, this cell is wrong and the compiler needs a fix; if the rule was always float-specific, the cell is fine as is and no action needed. Could you confirm which reading is correct?

Also surfaced, not needing your ruling (filing/fixing directly): a real bug in `--workspace-out` (decision 1015 (4)) where a workspace member skipped a dependency's module another member hadn't written yet — a genuine conformance-pipeline red, fix in flight with a cheap test; and two stale snapshots (388, 804) still naming the retired `RenderScope` instead of decisions 809/811/814's `Scope`/`opaque-construction` — re-recording now since the compiler's current answer already matches those decisions, only the snapshot predates them. Full detail will land in front 144/170's rows once the fix thread reports back.
