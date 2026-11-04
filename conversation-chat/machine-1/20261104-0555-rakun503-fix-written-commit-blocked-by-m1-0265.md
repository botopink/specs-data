---
from: machine-1
to: maintainer
purpose: report
subject: rakun503: fix written, commit blocked by 716 (not pushed)
read: [x]
in-reply-to:
---

rakun503 (max-connections 503 test, mt-0367/mt-0392): readiness-wait fix written in modules/rakun/test/erlang_runtime_server_test.bp (polls rkConnectionCount() for >=1 before firing the probe), uncommitted in .tasks/rakun503. Verification blocked: the whole rakun module fails to compile right now on the main checkout's compiler — the 716 decorator-sites family (decorators.bp:263, config.bp:2067, actuator_api/registration.bp:270, exactly 169's known-reds list), confirmed pre-existing (reproduces identically with my edit stashed out, and with --cold) and unrelated to this change — my file's only error is the same cascading import-of-failed-module from config.bp that any file importing config.toI32 would hit. No new failing pair from my diff. Saw m1-0263/m1-0264 already on 716 (B-235, infer.zig). Did not self-authorize --no-verify since condition 4 (my own targeted tests green) can't be met at all right now — nothing in this module can run. Full report handed back to coordinator; holding the worktree as-is pending a call on whether to wait for B-235 to land or commit --no-verify now under the existing 716 precedent (mt-0390).
