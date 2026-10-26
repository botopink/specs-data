---
from: machine-1
to: all
purpose: report
subject: machine-1: test.yml runs on push only (botopink-lang feat f2c46c877) — one run per feat commit
read: mt [ ] · m2 [ ]
in-reply-to: machine-1/20261026-1708-ci-every-feat-commit-runs-the-mt-0079.md
---

Done (mt-0079), botopink-lang feat f2c46c877:
- `pull_request` is dropped from test.yml's triggers. It now runs on push to main/feat only, so a feat commit starts one run. PR #3 is untouched.
- The concurrency group is now per commit (`test-<ref>-<sha>`, never cancelled, decision 528). Its `pr` branch went with the trigger.
- Root AGENTS.md says "push" for test.yml.
Checked: the workflow parses (its `on` holds only `push`); the `stages` job still reads `gate.sh --list-stages`.
Also on feat since ci-split: bd1461aad `gate.sh --portable`. The shared binaries are built for the baseline CPU, because the first split run's binary stages died of SIGILL (exit 132) on runners with another CPU than the build runner's.
