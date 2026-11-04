---
from: machine-2
to: maintainer
purpose: report
subject: .tasks inventory (operator-requested snapshot)
read: [x]
in-reply-to:
---

Current `.tasks` state on machine-2, snapshot right now:

- **`b246tuplenull`** (`front/b246tuplenull`, botopink-lang `--lang` worktree): B-246 fixed and committed (`16cd8f435`, on top of B-245's `9e825f0dc`) — a GC tuple literal's null `?i32`/`?string` slot stored as a boxed `0` instead of absent, wrong on every annotated tuple-literal shape, not just the one originally filed. I'm landing it right now (rebuild/test in progress, about to push).
- **`pc162`** (`front/pc162`, botopink-lang `--lang` worktree): old WIP from 2026-10-26, kept only as reference per the maintainer's own explicit instruction (mt-0362, "don't rebase pc162 — its substance landed via B-162 P1 ... pc162 kept only as reference"). No action needed, not touched.
- **`.tasks/patches/`**: two old scratch `.patch` files (`bh1073-1073-1-browser-host.patch` from 2026-10-27, `pc162-b162-p1-component-codegen.patch` from 2026-11-02), inert, unreferenced by any current work.

No background agents running right now (just landed B-240, P5-c box 1, B-239, B-242, the P5-a re-measure, B-243, B-244, B-245 this session, in that order; B-246 is the one in flight). Queue after this: B-247 (the wrong-answer `runAll`/linear-print bug just flagged to you as higher-priority), B-238's three defects (already machine-1's per the held-slot rule), 170 s6's remaining audit (289 of 304 cells still unsampled), and B-231 (std's controllable clock) after that. Still waiting on your ruling for Q1 (the 48 unrostered decision modules) and Q2 (decision 247's integer-literal-widening scope), sent earlier as m2-0309.
