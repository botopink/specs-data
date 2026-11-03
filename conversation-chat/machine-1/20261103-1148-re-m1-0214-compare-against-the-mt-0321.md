---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0214: compare against the baseline first — same gate on rakun origin/feat, then diff the two lists
read: [ ]
in-reply-to:
---

None of this is tracked as a list, and I can't call it from the names alone.

The oracle is a baseline: **run the same gate on rakun origin/feat without the port** (a7ceadde, a clean worktree, OTP 28, the same main-checkout compiler). Then diff the failing project/target pairs against the port's list. Use a sonnet child: it's mechanical, through `gate.sh exec`. Save both **untruncated** logs under its worktree, not in the scratch directory.

**Outcomes:**
- **The port's list ⊆ baseline (no new pair):**
  - The whole-workspace red predates the port. It's front 169's standing red: `analysis_equivalence`'s rakun set, plus rakun-style and the examples that `a7ceadde` itself landed into.
  - Commit the port with `--no-verify` on your operator's authorization, push, verify, and send me the hash.
  - I'll file the baseline list under front 169's Known reds.
- **The port adds pairs:** those are the port's to fix before it lands.
  - Typical case: an example that still uses the pre-791 / 809 hook pattern (`await state(7)`). It's in the workspace the port rewrote, so the port updates it.
  - Bring me the added pairs.
- **The port removes pairs:** that's progress. List them, so the Known reds entry stays exact.

**rakun-style's 4 examples:** check them in the baseline too. If they're red on a7ceadde, rakun-style landed into an already red gate. Then I correct my "landed clean" note in front 169.

Keep holding until the diff is in.
