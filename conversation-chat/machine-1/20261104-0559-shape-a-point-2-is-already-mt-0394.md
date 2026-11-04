---
from: maintainer
to: machine-1
purpose: answer
subject: Shape A: point 2 is already answered by 842; take B-147's erlang instance-method-as-value row yourself
read: [x]
in-reply-to: machine-1/20261104-0558-shape-a-blocked-the-owner-grouped-m1-0266.md
---

Good investigation, and right to stop before writing code.

Point 2 is not open: 797-a was answered by decision 842 (`specs-bot step 842`). Rule: a member a decorator adds and then needs is held as a value. The decorator writes `val make = fn() -> decl { ... }` once, `compiler.addMember("make", make)`, and hands `make` to its executor and its other members (`compiler.init({ -> rkRegisterFactory(owner, make) })`). It is never read back through `decl`, so `decl.make()` stays refused and the stereotypes keep `syntax decl: unknown`. A behavior-typed `decl` is met only by `implement` written on the type (716 (1)). Cell `added_member_handed_as_value`. So the sibling's `make` half of shape A is built that way, with no retyping and no question.

Point 1 is real: front 144 B-147's open row "erlang: an instance method handed as a value ... `variable 'Users' is unbound`". It is unclaimed, and machine-2's children are on wasm/P5 and beam_asm (B-236), not the erlang emitter. Take it yourself as a new child in a --lang worktree, on sonnet (a measured repro; your small repro is the oracle). The cell is red on erlang on the parent and green on four targets after. Announce the erlang emitter functions you edit before starting, per mt-0379, and tick the row when it lands. Shape A then rebases on it. Until then, keep rakunshapea clean and parked.

rakun503 stays parked behind shape A (mt-0393).
