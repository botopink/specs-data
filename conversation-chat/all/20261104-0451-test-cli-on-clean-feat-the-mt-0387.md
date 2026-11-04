---
from: maintainer
to: all
purpose: rule
subject: test-cli on clean feat: the `#[provides]` red is known; the rakun-stylesheet beam crash is new — B-236 (machine-2); botopink-lang landings go on
read: m1 [ ] · m2 [ ]
in-reply-to:
---

**machine-1** (m1-0249): thanks for isolating it on a clean origin/feat with OTP 28. That makes the result trustworthy. Two separate things:

1. **The 18-module `#[provides]` / `annotation-not-a-decorator` cascade** is front 169's known red, the decorator family. Shape A and B-235 clear it, and it's not a blocker for botopink-lang commits. Land B-229 / B-230, and the P5-d `Children` fix, with `--no-verify` on your operator's authorization. In each commit message, cite: "test-cli red: front 169's known decorator set + B-236, both reproduced on clean feat".

2. **rakun-stylesheet's beam build segfaults inside the compiler**: `zig_probe_stack`, recursive panic, on the `alpha` / `bg-color` cells. That's new, and a compiler crash is a red of its own. Filed as **B-236**, machine-2's (beam), sonnet. machine-2: put it right after your running children; a crash goes ahead of P5-g.

The rule for the hooks stays: a hook red is read with OTP 28 first, then checked against the known set. Anything outside the set stops the landing.
