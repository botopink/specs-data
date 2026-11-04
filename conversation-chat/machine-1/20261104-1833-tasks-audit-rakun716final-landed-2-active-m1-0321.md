---
from: machine-1
to: maintainer
purpose: report
subject: .tasks audit — rakun716final landed, 2 active worktrees, 5 144 rows filed per mt-0425/mt-0426
read: [x]
in-reply-to:
---

Full audit of /home/ericfillipe/develop/projects-m1/.tasks/ right now:

**Active task worktrees:**
- `rakun503` (repository/rakun, branch front/rakun503) — resumed, running: rebasing/re-verifying its readiness-wait fix against rakun's now-compiling main module.
- `rakun716followup` (repository/rakun, branch front/rakun716followup) — running: the same decl.X() read-back rewrite across rakun-cli/plugins.bp, rakun-data/orm/entity.bp, rakun-messaging/markers.bp, rakun-scheduling/markers.bp + jobstore/markers.bp, rakun-service/convention.bp, rakun-websocket/endpoint.bp, plus the one-line DbHealthIndicator `implement HealthCheckOwner` gap.

**Just landed and removed:** rakun716final → rakun 0929fc05, meta 25864d72 (both verified via merge-base).

**Main checkout:** repository/botopink-lang at 9e825f0dc (built, current). repository/rakun detached at 0929fc05 (current).

**Filed per your mt-0425/mt-0426 queue, front 144-backends-tooling, all unassigned/machine-2's:**
- B-248: Bytes/Async/AsyncIter print vs decision 1111 (sonnet)
- B-249: prototype #[managed]'s new() "expected X, got function" — rakun-only repro (opus)
- B-250: behavior-as-type<T> argument "unbound variable" — standalone repro (sonnet)
- B-251: beam internal-consistency-check in config.bp/autoconfig_registry, unmasked by 716(1) (opus)
- B-252: generic-lambda-returned bool prints 1 not true on wasm (sonnet)

**Stale, non-worktree scratch directories (unchanged, still pending your own rm -rf):** `analysis/`, `b116p3-logs/`, `b168probe/`, `fc-scratch/`, `patches/`, `tx.log`.

Remaining from your queue: items 2 (DbHealthIndicator) and 4 (decl.X() follow-up) are both inside rakun716followup now, bundled since they're both one-line-to-small mechanical --repo rakun work. P5-g/B-238 (item 5) are already landed from earlier today, not re-opened unless you want a specific next site named.
