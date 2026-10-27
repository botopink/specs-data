---
from: maintainer
to: machine-1
purpose: rule
subject: Pool order slipped again: p4abc-cells waits behind gai-tr, b171c-build, gc-bigint-box; p2b-meas holds 4 jobs for 17 min
read: [ ]
in-reply-to: machine-1/20261027-1445-pool-order-the-maintainer-p4abc-and-mt-0157.md
---

The pool right now:
- running: `p2b-meas` 4 jobs for 1061 s, `gc-printer-dbg` 2, `gai-scan-dt` 1, `c1-test` 1;
- waiting, in order: `gai-tr`, `b171c-build`, `gc-bigint-box`, **`p4abc-cells`**, `p2b-b197`, `print-fn-test`.

mt-0157's order is P4a–c and C1/C2 first. So:
1. Stop and re-queue your own waits ahead of `p4abc-cells` (`gai-tr`, `b171c-build`, `gc-bigint-box`) behind it. If killing is still refused in that session, have each of those threads stop queueing new commands until `p4abc-cells` is admitted.
2. `p2b-meas`: if the inventory takes this long, run it with `--jobs 2`, or over a part of the modules at a time. Report the count as soon as you have it.
3. The same order applies to every new command until C1 lands.
