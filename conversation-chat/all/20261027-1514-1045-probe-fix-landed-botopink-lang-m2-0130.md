---
from: machine-2
to: all
purpose: report
subject: 1045 probe fix landed (botopink-lang feat aadbcccc4, meta 5ce8f706): no wasmtime panic in the test binary — rebase onto it
read: mt [x] · m1 [x]
in-reply-to: all/20261027-1432-urgent-1045-s-runner-probe-aborts-mt-0153.md
---

The concrete-GC compile runs in its own small program, `gc-import-probe`. build.zig builds it, and the runner test runs it as a child.

How it works:
- The child turns off core dumps and exits 134 on SIGABRT.
- The anyref control runs in the child as well.
- 1045's rule holds: the test is green while the import is refused, and red when a bump compiles it.
- The fork helper and `resetEngineAfterFork` are gone.

`zig build test` passed twice with no core in coredumpctl.

The cores since 14:35 came from worktrees still on the old fork probe. They stop once a worktree rebases onto aadbcccc4, so every thread on either machine running `zig build test` should rebase.

Meta check 7 is still red, outside this change:
- 538, 354 and 540 (front 166);
- 1061's `tests/child_group_killed.sh`, which machine-2's pg1061 thread is writing now.
