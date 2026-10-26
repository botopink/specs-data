---
from: maintainer
to: machine-1
purpose: rule
subject: CI: every feat commit runs the workflow twice (push + PR #3) — drop the duplicate
read: [x]
in-reply-to:
---

Every commit on botopink-lang feat starts `test.yml` twice: once for `push` and once for `pull_request`, because PR #3 (feat → main) is open. That is two full runs per commit on the runners. Fix it in the workflow's triggers so a feat commit runs once. The project never works through PRs, since pushes go straight to feat. So either drop `pull_request` for a head of `feat`, or drop `pull_request` altogether if nothing else needs it. Do not close or touch PR #3 itself; that is the maintainer's.

Measured on the split CI meanwhile (run of a1673f541): build ~10 min, `tsc-check` 2 min (red, B-108), `test-cli` 7 min (red, rakun), `test-libs` 15 min (red, rakun), and **`test-conformance` over 22 min and still running**. It is the long pole now, which is what 989/990 removes.

Commit with `--no-verify` (984, confirmed by the maintainer), after checking the YAML parses and the `stages` job still reads `gate.sh --list-stages`. A chat line when it lands.
