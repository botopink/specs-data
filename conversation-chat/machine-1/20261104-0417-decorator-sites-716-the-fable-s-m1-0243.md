---
from: machine-1
to: maintainer
purpose: question
subject: Decorator sites (716): the fable's verdict can't be built on today's compiler — 3 real blockers, 3 questions
read: [ ]
in-reply-to:
---

The decorator-sites thread stopped before editing anything — neither of the fable's two shapes (mt-0341 point 3) compiles on today's compiler, so no commit was possible. Full findings:

The real site count is much bigger than the 7 I'd listed: ~30 decl.<member>() executor sites across rakun (decorators.bp:263/349/427, context.bp×5, autoconfig.bp:581, config.bp:2067, registration.bp×3), rakun-service (convention.bp×4), rakun-cli, rakun-messaging, rakun-scheduling (markers.bp×2), rakun-data (entity.bp×2, transactional.bp), rakun-security, rakun-websocket. `botopink check` on modules/rakun stops at 3 of them (registration.bp:270, decorators.bp:263, config.bp:2067) which cascade into 44 failing modules.

Almost every site ultimately needs `make` — the stereotype's constructor over the type's fields — often called from a DIFFERENT decorator than the one that added it.

Three concrete blockers, each confirmed on the main checkout's compiler with a disposable test project:
1. A member can't be handed over as a held value: `val f = fn() -> Meta {...}; compiler.addMember("x", f);` refuses with decorator-member-not-fn (decision 370 (2), "the member as a function expression written at the call") — exactly the form 842 (1) prescribes.
2. `fn() -> decl` is refused inside a decorator-local fn literal ("'decl' is a value, not a type") — 842 (1)'s own example.
3. `compiler.ast` is refused in a decorator body (even inside a member's fn literal) — needed to build make/bindProperties/new as code per 625 (1). This looks like it's gated on B-149's open box (machine-2's, "compiler.ast admitted in a decorator body with a cell, 640 (3)").

One correction to my own brief: I had it backwards — mt-0341 and 625 (1) both say rkRoutes/rkSchedules/rkJobs GO, with each method marker registering itself and the runtime registry grouping by owner; I'd written it as the registration moving TO those collections. The thread caught this and followed the decisions, not my prompt.

A fourth form DOES compile but the thread didn't use it: `<T>(syntax decl: T)` lets decl.make().check() run. 716 (1) allows syntax decl: T, but 716 (2) says every tree is checked once against the declared type — so this may itself be a defect, and it's exactly the per-site-contract shape the fable's verdict ruled out.

Questions:
1. Does 842 (1)'s held-value addMember(name, f) + fn()->decl need its own 144 row, or does 842's example itself need correcting?
2. Does this whole piece (165 s10 rows 234/236) actually wait on B-149's 640 (3) box landing first (compiler.ast in decorator bodies)?
3. Is <T>(syntax decl: T) admitting decl.make() intended under 716, or a checker defect needing a 144 row?

Nothing committed. Worktree (.tasks/rakundecorators) is clean, held for your answer.
