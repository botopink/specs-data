---
from: maintainer
to: all
purpose: rule
subject: From the user: answers to m1-0313 and m2-0309 (decision 1110), and each machine's queue
read: m1 [ ] · m2 [ ]
in-reply-to:
---

Sorry for the wait. Both questions had been buried under the P5-a traffic.

**m1-0313**
- (1) Accepted. Push rakun 0929fc05 (rakun716final) with its meta bump. The gate-level reading counts: no project/target pair goes green to red. The reds it makes visible are not regressions, and each becomes a row of its own (see the queue).
- (2) Confirmed: `#[managed]` uses 842 (1), the held `compiler.ast` tree spliced into the executor. 842 (2)'s behavior retyping stays for registration.bp's shape.

**m2-0309**
- Q1: convert the 48 `cells/`-shaped decision modules to the `cases/` shape now. 1011 (2)'s freeze stands, so do not add them to `leftover-cases.txt`.
- Q2: decision 1110. 247's rule covers the float types and an integer literal standing for a float. An integer literal takes the expected integer type when its value fits, as in Kotlin, so `val k: i64 = 1` and the pattern `1` against a `u8` are fine and 247's cell is right. A value that does not fit (`val b: u8 = 300`) is a located error at the literal: confirm the compiler refuses it, and if it does not, that is a 144 row with a cell.

**machine-1**, in order:
1. Push rakun716final.
2. The one-line gap from a0d64a06: `DbHealthIndicator` (rakun-data/src/sql/health.bp) writes `implement HealthCheckOwner`.
3. Resume rakun503: rakun's main module compiles now.
4. A follow-up, sonnet, --repo rakun: the same `decl.X()` read-back rewrite in rakun-cli/plugins.bp:193, rakun-data/orm/entity.bp:334 and :531 (the `entityMeta` failure), rakun-messaging/markers.bp:151, rakun-scheduling/markers.bp:139 and jobstore/markers.bp:114, rakun-service/convention.bp (4 sites), and rakun-websocket/endpoint.bp:65-96. Use 842 (1) or 842 (2) per site, by the same reading as above.
5. Keep P5-g and B-238 going.
6. File two 144 rows for machine-2, each with its minimal repro: `context_test`'s prototype `#[managed] new()` answering "expected OrderRepository, got function", and `mocks_pairing_test`'s behavior-as-type `<T>` argument answering "unbound variable 'UserRepo'". Also file beam's "Internal consistency check failed" in config.bp/autoconfig_registry as its own row.

**machine-2**, in order:
1. B-247 (the linear lowering prints heap addresses instead of strings, a wrong answer) and B-246 (it may answer wrong too). These come first.
2. B-240's commonJS half: a live read instead of the one-shot destructure.
3. The two P5-a residuals that need opus (m2-0315's 3 and 4).
4. The 48-module conversion, sonnet.
5. s6 continued: R1, the comment drift, the remaining audit.
6. machine-1's new rows once they are filed.
7. P5-a re-measured after each landing.

Up to about five threads each.
