---
from: machine-1
to: all
purpose: question
subject: B-172 done (botopink-lang feat ebd7b5b5d + e569e7d43, meta 86a0def6): 52 leftovers join their cases, leftover-cases.txt 131 → 78; 23 defect rows filed (B-173…B-195); three questions; meta check 6 red on the ledger
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done: every line of leftover-cases.txt converted and run loaded on commonJS, erlang and beam; each of the 24 touched modules run alone by path (wasm skipped: B-171). 52 lines removed, either green or by design and rewritten:
- 989 (1), (2): a sync `main` that never awaited its async work now awaits it: async, 392 ×3, 432 ×3, 523, 525, 538, 541 ×2, stream, task ×4.
- 989 (3): narrowed or emit-refused cases answer `.Excluded` or `.Refused`, recorded per target: 31, 375 ×3, 432, 523, external_erlang_only.
- 1003 (2): 756 prints only its root's tail.
- behavior and 606: their run/ cases were split by case; the rejoined output equals the old snapshot byte for byte.
76 lines stay as defect repros. With old-shape's groups merged, they are filed as rows B-173…B-195 in 144-checker, one per cause, with the case list in each row. 518 is 1035 C5 and was not refiled.
Commits: botopink-lang ebd7b5b5d (B-172), e569e7d43 (three docs links it left; meta check 7 green again); meta 86a0def6. Untracked `cells/` leftovers in the main checkout were removed.
Outside:
- 12 touched modules have no runModule line in conformance/modules/src/main.bp, as already on feat: async, task, stream, 375, 392, 432, 523, 525, 606, 756, 786, 998.
- Meta check 6 is red on the ledger itself: "decision 1049: slug `manifest_unknown_field_refused` is already decision 1048's". That is the maintainer's to fix in the record.
Questions:
Q1. 254's typeinfo_all_registration differs by a mangled path, not by the diagnostic's location, so it is filed as a defect (B-173), against 1047 (3)'s "254 by design". (a) Confirm the defect (recommended: 1047 (3) itself says "a defect only if…", and a mangled name is no location). (b) Keep it as by design.
Q2. 110 was narrowed to commonJS, erlang and beam, citing 833 (2) as a by-design reason. That is outside 1047 (1)'s two named classes. (a) Accept 833 (2) as a third citable class for a manifest narrowed by its own decision (recommended). (b) Undo it and count it as a defect.
Q3. The 12 modules without a root runModule line: (a) add them to the root package now, each proven alone (recommended — a module not in the root package is not run, so by 67 it counts as red). (b) Leave them out.
