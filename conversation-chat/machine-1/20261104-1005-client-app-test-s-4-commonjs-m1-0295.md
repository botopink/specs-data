---
from: machine-1
to: maintainer
purpose: question
subject: client_app_test's 4 commonJS reds: a distinct commonJS circular-require defect, not B-216 — who owns it, new row?
read: [ ]
in-reply-to:
---

Bisected per m2-0302. Root cause found and verified via instrumented generated JS (not symptom-guessing) — confirmed distinct from B-216.

Mechanism: client_app_test.bp's decorators make the compiler inject the `RouteSegment` scaffolding require near the TOP of the compiled test file, before the file's own trailing auto-injected `styled`/`globals`/`prelude` requires. That ordering makes routes.js's first load reentrant: routes.js → element.js → (injected) prelude.js → render.js → routes.js again, mid-load. Node returns routes.js's partial, cached exports, so render.js's one-shot destructure of `segment` binds to undefined permanently. Any later clientApp(...).start() call hits "segment is not a function", caught by std's attemptTask and surfaced only as the bare "(assertion failed)" seen in test output.

Confirmed NOT B-216 (6d5b84086, already landed, already an ancestor of current HEAD, still reproduces): B-216's fix targeted a reached enum's require specifically; here `RouteSegment` is a plain record type, and the cycle shape differs (routes→element→injected-prelude→render→routes vs whatever B-216's shape was). A minimal standalone consumer (plain `build`, no test-file decorator scaffolding) does NOT reproduce — its injected requires land at the top of the file instead, so routes.js completes its first, non-reentrant load before anything destructures `segment`. The deciding factor is purely where the compiler places auto-injected registration requires relative to a file's own imports, which differs between an entry/library file and a `botopink test` file.

Latent, not a regression: rakun-bpp's git history for prelude.bp/routes.bp/client_app_test.bp shows no recent change in the relevant imports — consistent with the reds being constant across my whole 8-commit StyledContext bisect range.

Split ownership, needs your call:
1. Compiler-side: commonJS codegen's placement of auto-injected styled/globals/prelude requires differs by file kind, and/or the one-shot destructure-at-require-time binding is unsafe across a cycle (a live-binding read would survive the reentry). This is the robust, general fix.
2. rakun-bpp-side: there's a genuine indirect cycle — routes.bp → element.bp → (injected) prelude.bp → render.bp → routes.bp — that render.bp's own docstring says the package deliberately avoided directly ("a UiSegment in render.bp would make this module and that one [routes] import each other") but missed via prelude.bp's `import {render.raw}`. Breaking that indirect cycle in rakun-bpp would also fix it without a compiler change.

Questions: (1) which side fixes it, or both; (2) does this get its own new row distinct from B-216 (144 or 169), and who's number/owner — I was told not to file one myself given the split ownership. Thread's worktree (clientapptestbisect) removed, no commits (diagnosis only).
