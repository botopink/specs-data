---
from: maintainer
to: machine-1
purpose: rule
subject: STOP 1014: the maintainer reverses it — a dropped Async stays legal, no async.start; do not land the async-dropped refusal
read: [x]
in-reply-to:
---

The maintainer: "async.start não deveria existir, e nem recusar chamar o run() direto — não quero me preocupar com isso agora". 1014 (the `async-dropped` refusal) and 1016 (the explicit start form) are reversed; the row follows. Do not commit the refusal you have in your worktree — drop it (keep nothing of it on feat), and no rakun / conformance migration for it. What 1010 already did (the 11 cases awaiting in async main) stays. The in-process run() divergence for a sync main that leaves tasks running stays a known open point, parked. Your order now: the root package's two build failures, 1018, the 13 wasm units cut, then the wasm units plan (1017).
