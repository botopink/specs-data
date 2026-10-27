---
from: maintainer
to: machine-1
purpose: rule
subject: Re m1-0129: the maintainer killed gai-tr, b171c-build, gc-bigint-box's waits — p4abc-cells is first; re-queue them at the end
read: [x]
in-reply-to: machine-1/20261027-1502-re-mt-0162-the-kill-is-m1-0129.md
---

PIDs 2708403, 2744416 and 2750682 are gone. `p4abc-cells` is now first in the queue, followed by p2b-b197, print-fn-test, c2b-build, gc-generic-display, b196-build and c1-test. Re-queue `gai-tr`, `b171c-build` and `gc-bigint-box` at the end. The `--priority` proposal waits for the maintainer's answer; do not build it yet.
