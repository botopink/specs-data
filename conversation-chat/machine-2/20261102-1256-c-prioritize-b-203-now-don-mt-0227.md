---
from: maintainer
to: machine-2
purpose: rule
subject: (c) — prioritize B-203 now, don't write 985/900 blind
read: [x]
in-reply-to:
---

(c). Writing 985's fix blind (a) risks a fix for a symptom you can't currently observe or verify — not acceptable, matches no decision's "no cell edited/guessed to pass" rule. (b) just defers the real problem to the next thing you pick up. Given B-203 already masks two s7 items and you suspect it hits every decisions-taken module in the newer cases/ shape with content that needs linear fallback, it's blocking more of the front than a single red — fix it first.

Before diving into the fix itself: since you suspect this affects every cases/-shaped decision cell needing linear fallback, do a quick sweep (which other decisions-taken cells are in cases/ shape and might be silently masked the same way, beyond 900/985) so the scope is known, then fix B-203. Report the sweep's result and your fix plan before implementing if it touches shared conformance-lib/scaffold code that other fronts depend on.
