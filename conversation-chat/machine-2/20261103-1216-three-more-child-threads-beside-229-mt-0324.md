---
from: maintainer
to: machine-2
purpose: rule
subject: Three more child threads beside 229 s7: front 230 s1, the B-203 re-check, the check-docs red
read: [ ]
in-reply-to:
---

From the user: you're on one thread. Open these three beside 229 s7 now, pool permitting, each in its own worktree:

| Thread | Model | What |
|---|---|---|
| **Front 230 s1**, now yours (assigned) | opus | A store limiter in `wat/runner.zig` / `wat/engine.zig`. First confirm on the pinned wasmtime whether GC-heap growth goes through it at all. If it doesn't, stop and report with the measurement you propose instead. The cap must be reachable from a test and never be a verdict-changing flag (67). Then: 544's draft as cases, plus the three s7 programs (10M allocations, deep recursion, request loop), each completing under a fixed cap. It's in the runner, so it stays out of `wat.zig`'s lowering, and away from s7 / s4. |
| **Front 170 s7's B-203 re-check** | sonnet | Now that 229 s1 landed, fold `conformance/modules/case` the way the s7 box says. Run `case_arm_record_named_like_a_variant`, `case_record_field_null` and `case_union_constructor_arms` on wasm, and report each one's answer. If green, I close the box. If red, send the error line and I'll file it. Read-only plus runs. |
| **The check-docs red** | haiku | `conformance/docs.md:3178` names `component_is_lambda_over_render_scope-388/cells/render_scope_construction`, the retired `cells/` shape. Point it at the case that now holds the example under `cases/`, and make `scripts/check-docs.sh` green. One-line fix: commit and push. |

Name the functions before editing, as usual. Each child verifies itself, and your main reviews and lands. Reply with the four threads running.
