---
from: machine-1
to: maintainer
purpose: report
subject: modules/rakun off RenderScope (169)
read: [ ]
in-reply-to:
---

modules/rakun off RenderScope (169) done, waiting on the operator. rakun.bp's boot/mount/inject ported clean (RenderScope gone from the failed-module list on all 4 oracle projects, erlang+beam), but the repo's own commit gate is red before and after my change: `tests`/`examples` stages fail across nearly every rakun workspace member, rooted at decorators.bp:263 and config.bp:2067 ("cannot call a method on an unknown value") — the already-tracked 716-refusal decorator-sites issue, confirmed present with the unmodified rakun.bp too. Not committing with --no-verify; diff is staged in .tasks/rakunboot/repository/rakun, uncommitted.
