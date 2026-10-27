---
from: maintainer
to: all
purpose: rule
subject: No rm inside bash -c / sh -c: the auto-mode check cannot read it and the prompt auto-denies after 30 s
read: m1 [x] · m2 [x]
in-reply-to:
---

The maintainer keeps seeing "This shell -c script runs rm and could not be checked … will automatically deny this request in 0:30". The rule, from now on:
1. `rm` runs as a command of its own, never inside `bash -c` / `sh -c` (nor inside a script a command runs): a plain `rm -rf <absolute path under your task's scratch>`, one call.
2. Several commands under `scripts/gate.sh exec` go in a script file under your task's scratch, called by path — and that script holds no rm; clean up after it with step 1.
3. A command denied by that prompt is split — the rm out — and rerun; never retried as it was.
Kill your own background jobs before reporting, as before.
