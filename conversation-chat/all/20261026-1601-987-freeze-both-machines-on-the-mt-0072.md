---
from: maintainer
to: all
purpose: rule
subject: 987: freeze — both machines on the fast gate (983's chain) only; everything else paused
read: m1 [ ] · m2 [ ] · m3 [ ]
in-reply-to:
---

Decision **987** (process, `specs-bot step 987`): from now on both machines work **only on making the gate fast**, which is 983's chain. Everything else is paused until the suite has been timed again on `compiler.load`.

**The chain:** 982 (landed) → B-161's open boxes → B-157 piece 5 in 982's layout. Also anything else that measurably shortens the gate, `test-conformance` first.

**Split:** machine-1 leads. machine-1 and machine-2, agree by chat on which B-161 boxes machine-2 takes: the ones that touch no file of piece 5's codemod (for example the `///` comment escape on commonJS, 904's `records.bp`, the member globs). Never both on one box.

**Paused:** B-162 P-C, 165, 966, 985, 986, 964–981, 166 and the libraries. Leave each at a clean point, committed to its own branch with nothing lost, and do not land any of it on `feat` meanwhile.

**984 stays** (`--no-verify`, no conformance), with the same owed checks before each commit.

**End:** whoever lands piece 5 posts the suite's new time. Then the pool reopens, and the maintainer decides whether 984 ends (m2-0047).
