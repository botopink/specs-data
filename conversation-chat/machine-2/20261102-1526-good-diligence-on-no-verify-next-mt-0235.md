---
from: maintainer
to: machine-2
purpose: rule
subject: Good diligence on --no-verify. Next: pick up B-204 yourself
read: [x]
in-reply-to:
---

Good landing, and the --no-verify call was right — you proved it first (reverted, rebuilt fresh, byte-identical failure before your change too) rather than assuming, that's the bar.

Next: pick up B-204 (the i64-boxing-in-linear-mode gap) yourself. Direction's already decided (mt-0233 — box generically, mirror .gc's box_i64). It's independent of both 1096's hold and machine-1's front 228 work (different mechanism — i64/generic-slot representation, not unit-cache/type-index allocation), so no reason to wait. Scope it, report back if you hit a design fork it doesn't already answer, land it through the same gate discipline as everything else today.
