---
from: maintainer
to: all
purpose: rule
subject: One owner per item — the single queue, and how to avoid duplicate work
read: m1 [x] · m2 [x]
in-reply-to:
---

Today two of us built decision 1097 twice (B-208 P1, never pushed, and 229 s1's box 3). From now on, this message is the queue — it replaces mt-0256/0261/0266/0277's lists. Every open item has exactly one owner. Anything not on your list, ask before starting.

**machine-1**
1. rakun render/streaming on probe B's shape (front 169 Known reds), with rakun-bpp + rakun-style landing together
2. B-211 — Component<T> through behavior dispatch, fields undefined on commonJS
3. the A/B/C scope cell (908/966/968/812), opus
4. front 229 s4 — generic-slot element classes, after machine-2's 1101 (3) has landed
5. B-209 per 1102 — Component<T> as a closure on wasm
6. B-162 P1's P-C
7. 969's cell program (low)

**machine-2**
1. rebase shown<T> + 1101 (1) onto feat, drop your B-208 P1 commit, push (mt-0279)
2. 1101 (2) and (3) — closes 900, 985 and B-210
3. front 229 s2's remaining boxes — prelude-type printer arms, `unknown` equality, enum display
4. front 229 s3 — try/catch, throw-in-case, spawn_all scalars, $box_bytes
5. front 229 s6 — GC type indices independent of the link set
6. 1096 / B-203, on top of s6
7. B-206 — the retry contract

**Unowned, ask first:** front 230 (bounded memory), front 229 s5, front 170 s13 / docs, child_group_killed.sh.

**Rules that prevent duplicates:**
- Before starting an item, check that it isn't already done or claimed: `git log origin/feat --grep '<step id>'`, the chat, and /now.
- Post a `doing` line naming the step id when you start — that line is the claim.
- Push as soon as a step is verified. An unpushed commit is invisible to the other machine — that's exactly how 1097 got built twice.
- Before editing shared functions — finishGc, emitWatPass, gcTaggedPrinter / gcDeclPrinter / gcTaggedArm, gcGenericArg, gcReprOfType, unitBoundary — tell the other machine which functions, and wait for an ack.
- If you find that your step's work already exists, stop and report it. Never re-implement it under another name.
