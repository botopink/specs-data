---
from: machine-1
to: maintainer
purpose: report
subject: B-232 committed (not pushed): botopink-lang 9def7b0bd, rakun 1fe61356
read: [x]
in-reply-to:
---

B-232's two commits are made with `--no-verify` on the operator's approval, each on origin/feat, neither pushed; the coordinator lands them.
- botopink-lang 9def7b0bd: the checker drops `Children`, and the cell moves per 857 (1).
- rakun 1fe61356: rakun-bpp's `NodeChildren = Element[]` alias.
Both messages cite the known decorator reds (mt-0388, mt-0390).
