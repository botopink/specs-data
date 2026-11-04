---
from: maintainer
to: all
purpose: rule
subject: From the user: answers to m1-0290, m1-0293, m1-0295 and m2-0303, and the next slots
read: m1 [ ] · m2 [ ]
in-reply-to:
---

**m1-0290 / the decorators.bp:263 red.** Front 169's known red, "the decorator sites refused by 716 (1)", has to land first; no compiler commit fixes it. machine-1 opens it now (opus, --repo rakun): at decorators.bp:263, config.bp:2067 and actuator_api/registration.bp:270, a decorator that adds a member uses it from the value it built, never read back through `decl`. Front 169's README fixes this shape, so no design is needed. Top priority: it is also the `analysis_equivalence.sh` red in botopink-lang's test-cli, the one that pushed m2-0303's commit to `--no-verify`. rakun503 resumes once it lands.

**m1-0295 / client_app_test's commonJS cycle.** Fix it on both sides.
- machine-1 (sonnet, --repo rakun): break the indirect cycle in rakun-bpp at prelude.bp's `import {render.raw}`, so routes → element → prelude → render → routes no longer reenters. client_app_test's 4 reds go green.
- machine-2 files a new row in front 144 and owns it: the commonJS codegen places auto-injected requires differently in a `botopink test` file than in an entry or library file, and the one-shot destructure at require time does not survive a cycle (a live binding would). The cell is the minimal two-module cycle in a test file, red on commonJS. sonnet, measured repro.

**m1-0293 / shape A.** Option (a). machine-2 files a new B-147-class row and owns it (opus): a `compiler.ast`-built closure that calls a static method by name (`Member(Name(owner), "make")`), held as a value, handed to `compiler.init` and called from another module, crashes `undef` on erlang. Use machine-1's minimal repro. Shape A's injected-field `make()` pauses on that row (rule 9). No restructure of context.bp.

**m2-0303 / P5-c box 1.** machine-2 takes the one `$box_u64` arm in `gcUnkPrint`, tested before `$box_i64`. Announce the function before you edit; machine-1 is in wat.zig for P5-g. Box 3's dead `lowerEnumCtor` check stays until P5-h deletes the linear refusals. B-238 is machine-2's, opus, once a slot frees.

**`--no-verify`.** It stays off for botopink-lang (thread-rules). Until 716's rakun-side fix lands, a landing that truly cannot wait may still use it, but only when the one red is that `analysis_equivalence.sh` red at decorators.bp:263. Name it in the commit message and in the report, as m2-0303 did.

Next slots, in order:
- machine-1: 716 rakun-side, the rakun-bpp cycle, 170 s1, P5-g.
- machine-2: the `gcUnkPrint` arm and P5-c box 1, P5-f, the erlang `undef` row, the commonJS row, B-238, B-209/P-C, and P5-a re-measured after each landing.
