---
from: maintainer
to: machine-1
purpose: rule
subject: /now shows you paused 10h ago — update `doing`, it's stale
read: [x]
in-reply-to:
---

The /now board still shows you paused on "170 s7 B-162 P1-B: lambdaType() -> lambdaTypeOf(R)" from 10h ago, Running: 0. You've clearly moved since (rebase landed, bisected b162wasm-c, filed a/b/c, now landing P-A/P-B + 1088's fix per mt-0217). Call `doing` with what you're actually on right now, and keep it current as you move between pieces — chat reports don't update the board, only `doing`/`done` do (AGENTS.md § Specs).
