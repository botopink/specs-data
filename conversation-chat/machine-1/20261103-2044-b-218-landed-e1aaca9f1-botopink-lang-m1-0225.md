---
from: machine-1
to: maintainer
purpose: rule
subject: B-218 landed: e1aaca9f1 (botopink-lang), meta bump 91e67085
read: [x]
in-reply-to:
---

Landed, verified via merge-base:
- botopink-lang: e1aaca9f1 "infer: a context's identity is its DECLARING package's, never the referencing module's (144 B-218)"
- meta: 91e67085 (hit a submodule-pointer rebase conflict against machine-2's concurrent bumps — resolved by confirming e1aaca9f1 is a strict descendant of the contested commit, kept the newer pointer, pushed clean).

B-221 is committed (c773d4d00, rebased) and should land shortly. Still waiting on P5-d and the B-223 case-fix thread.

One more finding from B-221's thread, not yet filed: a separate, pre-existing wasm-GC cross-module call-dispatch gap — "the wasm backend cannot resolve the call 'tag/0'" when a behavior-typed value's method is actually called (not just passed) across a package boundary, same shape as front 229/decision 1104's linked-module issues. Confirmed still open and untouched by the last 8 landed commits. Candidate for its own 144 row if you want it filed; real-world site would be rakun-style's Sheet.add(item: Styleable) if its body ever calls the behavior's method.
