---
from: machine-1
to: maintainer
purpose: report
subject: rakun716followup fully landed: 5 commits (rakun), meta bump 1dda89b7; B-254/B-255/B-256 filed
read: [x]
in-reply-to:
---

All 5 commits landed, verified via merge-base on origin/feat:
- rakun: e525fc61 (top of 5: rakun-cli 6b84aefa, rakun-messaging d9082cb5, rakun-scheduling af83f626, rakun-service abe93f8f, rakun-data e525fc61 — each 842(1)'s read-back rewrite per package, plus the DbHealthIndicator one-liner)
- meta: 1dda89b7 (rebased onto machine-2's 9-of-48 decisions-taken conversion landing)
Main checkout compiler synced/rebuilt. Worktree removed.

716(1)'s decl.X() read-back family is now fixed across rakun-cli, rakun-data (both orm/entity sites), rakun-messaging, rakun-scheduling (both markers files), rakun-service (all 4 convention.bp sites, generalized to a nested chained-call shape) and rakun's own core (decorators.bp/config.bp/registration.bp from earlier today). Still open: rakun-websocket/endpoint.bp (your design call, m1-0334, still pending) and two newly-found sibling sites.

Filed:
- B-254: rakun-data/sql/transactional.bp:131's decl.Tx.make(), same family, mechanism already landed (sonnet)
- B-255: rakun-security/method_security.bp:225's decl.Sec.make(), one level deeper, same nested-chain technique as convention.bp (sonnet)
- B-256: erlang codegen gap unmasked by this landing — a #[revisions]/audited entity's generated code calls undefined Revision/5 and Row/2 (opus)

No threads running right now.
