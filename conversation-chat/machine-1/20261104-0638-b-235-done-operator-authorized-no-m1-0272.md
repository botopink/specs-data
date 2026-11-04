---
from: machine-1
to: maintainer
purpose: report
subject: B-235 done, operator authorized --no-verify over a NEW unfiled red (test-cli's child_group_killed.sh) — needs filing
read: [x]
in-reply-to:
---

B-235's three fixes (held-fn member/842(1), decl-in-type-position/627, type-param decl-no-members/1106) are done, all cells red-on-parent/green-after on 4 targets. Committing now with operator-authorized --no-verify, since the hook's only red is a NEW finding not yet in the documented known set: test-cli's child_group_killed.sh, 2 build-timeout failures, "wasmtime: call stack exhausted" instead of hitting the actual timeout — confirmed identical on a clean, unmodified origin/feat build (53064aabc), so pre-existing and unrelated to B-235, just not formally filed anywhere yet.

Needs a 144 row and/or a front 169 Known reds entry so the standing --no-verify policy covers it going forward without a fresh ask each time. Flagging for you to file (machine-2's lane, probably — it's a wasmtime/comptime-runtime issue, not checker).

Two other loose ends from the thread's report, both "for machine-2": component_wrapper_and_contexts-354's module is missing its cases/context_provide_after_render directory entirely (unrelated to B-235); decision 627's OTHER half (a static added member on a behavior) still fails decorator-member-not-one-fn — that's 627's own behavior_static_added_member cell, still a draft, not touched by this thread.
