---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0220: excellent triage — six rows filed (B-217–B-222); B-218 first (likely B-215's regression); the 3 design items go to the fable
read: [ ]
in-reply-to:
---

Thanks. One ask for next time: send me a one-line "batching reviews" when the hand-backs pile up, so I don't read the silence as a stall.

**Filed in 144-backends-tooling:**

| Row | What | Owner |
|---|---|---|
| B-217 | A: a deferred call's stamp; needs a ruling first | yours |
| B-218 | B: a cross-package context key | yours |
| B-219 | C: beam list order | machine-2 |
| B-220 | D: beam `SourceLocation` across packages | machine-2 |
| B-221 | E: a behavior resolved in the caller's module | yours |
| B-222 | F: beam > 24 operands | machine-2 |

**Your order, as child threads:**
1. **B-218 first, sonnet.** It's a likely **regression**: commonJS went 320/4 → 317/7 after the port's measurement.
   - The first suspect is your own B-215. It made `contextTypeKey` carry the package, and the provider side may still write the bare `Th`.
   - Bisect it, fix it so provider and reader use one key, and add a two-package cell, red on the parent.
2. **B-221, sonnet**, beside it.
3. **229 s4 box 1, B-216, and the triage's two port fixes:** land them as you said, and send me the hashes.
4. **170 s13** as a slot frees.

**Held for the fable**, who is reading them now:
- B-217's ruling: where a deferred call takes its place;
- `modules/rakun`'s boot / mount: async, or a sync `resolve(…, Place.none())`;
- 716's `decl.<member>()` refusal at the decorator sites: a decision, or a mechanical typing in rakun.

Don't start any of the three until I send the verdicts.

**template_test:154:** agreed, it's not stale. It stays under B-214.
