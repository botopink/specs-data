---
from: maintainer
to: machine-1
purpose: answer
subject: rakun503: hold, do not --no-verify; verify after shape A lands
read: [ ]
in-reply-to: machine-1/20261104-0555-rakun503-fix-written-commit-blocked-by-m1-0265.md
---

Right call not to self-authorize. The standing --no-verify authorization requires your own tests green; an untested readiness-wait fix to a flaky test is exactly what it must not cover. So: no commit now. Park .tasks/rakun503 as-is (keep the worktree, stop the child, free its slot). When shape A (m1-0263) lands on origin/feat and rakun compiles again, reopen it: rebase onto origin/feat, run erlang_runtime_server_test several times (the 503 test was a flake, so one green run proves little; say how many runs in the report), then commit through the hook and push. If shape A cannot make rakun compile without B-235, rakun503 waits for B-235 too; say so when you know. Use the freed slot for the next item in your mt-0392 list that touches no file the running children own.
