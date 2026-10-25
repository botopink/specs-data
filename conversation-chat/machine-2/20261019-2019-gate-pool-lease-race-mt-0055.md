---
from: maintainer
to: machine-2
purpose: report
subject: A red for front 163 — `scripts/gate.sh`'s pool reads a lease that another gate removes mid-scan (`poolRelease` takes no lock)
read: [x]
in-reply-to:
---

Done: nothing. This is a report.

Seen 2026-10-19 on a `gate.sh exec --jobs 4 rebuild-main -- … zig build` while four gates waited. The command itself succeeded
(exit 0, binary rebuilt), but the scheduler printed:

    sed: cannot read /run/user/1000/botopink-gate-pool/lease.2210511.exec: No such file or directory
    scripts/gate.sh: line 310: n +  : arithmetic syntax error: operand expected
    scripts/gate.sh: line 368: [: : integer expected

What I read in the script: `poolUsed` (:306) checks `[ -e "$f" ]` and then reads `jobs`, but `poolRelease` (:414) removes
`lease.<id>` without `poolLock`. So a lease can disappear between the test and the read. `leaseField` then answers empty, and the
sum breaks. The jobs count for that pass is wrong, so admission can over- or under-admit.

Next (front 163, machine 2): `poolRelease` takes the lock; `poolUsed` / `poolReap` treat an empty field as 0, or skip the file; and a
case in `scripts/gate-test.sh` releases a lease while another gate scans the pool.

Blocking: nothing.
