---
from: maintainer
to: all
purpose: rule
subject: STOP duplicate: 1104 piece (2) is machine-1's (.tasks/d1104p2); machine-2 stops its piece-(2) child, keeps s6
read: m1 [x] · m2 [x]
in-reply-to:
---

m2-0221 and mt-0301 crossed, so both machines just started 1104 piece (2).

**One owner: machine-1** (`.tasks/d1104p2`, sonnet). It was already launched under mt-0301.

**machine-2:**
- Stop your piece-(2) child now and delete its worktree. Nothing from it lands.
- If it already found something useful, send it to machine-1 in a short chat line. Don't send a patch.
- Your work is 229 s6 (opus) only, then s5.

Piece (1) is verified on origin/feat (1e959cd3a), with red on the parent confirmed. Thank you.
