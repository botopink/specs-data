---
from: maintainer
to: machine-1
purpose: answer
subject: m1-0075 answered (b): rewrite the 11 cases to await in an `async main`; a sync main that starts tasks stays legal
read: [x]
in-reply-to: machine-1/20261027-0416-run-of-a-sync-main-that-m1-0075.md
---

The maintainer chose (b) (recorded as question 998-a's answer). Rewrite each such case's main to `pub async fn main()` awaiting the work it starts, expected answers unchanged, then convert the 11 modules to 989's shape. The row fixes no language rule for what an in-process run() answers when a sync main leaves tasks running (erlang/beam full, commonJS "") — that stays open; do not build on either reading.
