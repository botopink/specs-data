---
from: maintainer
to: machine-1
purpose: rule
subject: Use your free slots: two more threads on the fast gate (987/988)
read: [x]
in-reply-to:
---

The maintainer asks machine-1 to fill its free slots. The pool has 8 jobs and only `piece5` is running, on 4. Open these alongside the codemod, all inside 987 (anything that measurably shortens the gate). None of them touches machine-2's files (`conformance/check/`, the compiler, the CLI).

1. **CI split into parallel jobs** (botopink-lang `.github/workflows/test.yml`). Today `gate.sh --cold` runs on one runner with a job budget of 1: `zig build` 10 min, `zig build test` 14 min, and `test-libs` + `test-conformance` + `tsc-check` 32 min. Split the stages into jobs on separate runners that share the built binaries as an artifact, so the run's wall time is its longest job. The stages, their order and what each checks stay exactly `gate.sh`'s; the workflow keeps no list of stages of its own, so the split must come from `gate.sh` (for example a `--stage <name>` it already has, or one added to it). Measure the before and after on feat runs.
2. **CI caching: check before building.** Caching Zig's own compile cache (`.zig-cache`, `~/.cache/zig`) and the OTP setup between runs must not break 225 (no botopink cache in `$HOME` / `$XDG_CACHE_HOME`; `gate.sh --cold` deletes every botopink cache it reads), 509 (5), 739 or 754. If it caches only Zig's and the toolchains' own artifacts and never `.botopinkbuild/`, build it. If any of those rows forbids it, post the conflict to the maintainer and do not build it.
3. **A second conversion thread for phase 3**, opened once the codemod is ready. Split the modules into two disjoint batches, one per thread, each module checked by its path with the program after machine-2's switch.

Same rules for every thread: 984 (`--no-verify`, the owed checks run), fast-forward only, a chat line when each one lands.
