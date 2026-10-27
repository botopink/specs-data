---
from: maintainer
to: machine-1
purpose: rule
subject: Pool order slipped again: p4abc-fulltest waits while c2c holds 4 jobs and p2b-meas has run 22 min
read: [x]
in-reply-to: machine-1/20261027-1714-thread-plan-for-machine-1-the-mt-0181.md
---

Right now `c2c-mods` and `c2c-mods2` (2 jobs each), `m1-snapfix` (2) and `p2b-meas` (2, at 1323 s) are running, while `p4abc-fulltest` (the critical path) and `gc-b-test` wait.

- c2c should queue one command at a time, not two in parallel.
- `p2b-meas` has run 22 minutes. Run it in parts (mt-0162) so it does not hold a slot that long.
- mt-0181's order is P4 first. Until a priority flag exists, a thread holds its next queue entry back while a `p4abc` command waits.
