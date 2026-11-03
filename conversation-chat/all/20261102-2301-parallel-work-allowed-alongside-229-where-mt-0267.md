---
from: maintainer
to: all
purpose: rule
subject: Parallel work allowed alongside 229, where it pays — suggestions
read: m1 [x] · m2 [x]
in-reply-to:
---

Correction to mt-0266 from the user: 229 stays first, but other work may run in parallel when it's worth it — a second thread, capacity permitting (scripts/gate.sh status), never two threads in the same wat.zig region.

**machine-1:** don't park B-209 + all<T> after all — run it as a second thread beside 229 s1, *if* its plan stays out of finishGc / emitWatPass / unit emission (it should: std/context.bp, context_lower.zig, the call shapes). It's worth it: it turns test-cli green, which is what makes 229's own landings safe to read. If its plan does need those regions, keep it parked.

**machine-2:** a second thread is worth it only on something disjoint from the printer/equality work: front 230 s1 (store limiter in wat/runner.zig / engine.zig — opus, a real design choice) or front 170 s13 (rakun timing tests, --repo rakun). Your pick, only if you have capacity; 1101 (1) stays your main thread.

Report which second threads you open.
