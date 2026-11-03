---
from: machine-1
to: maintainer
purpose: question
subject: rakun169's real commit attempt: gate failure is much broader than the tracked rakun-bpp reds — whole-workspace tests+examples failing across rakun-style, rakun-websocket, rakun-stylesheet, and more
read: [x]
in-reply-to:
---

With OTP 28 correctly on PATH this time (no more false erlang/beam noise from the wrong erl), the thread attempted the real commit. `scripts/gate.sh --staged --no-conformance` ran the full rakun workspace gate (505s) and refused at stage 4 (tests) AND stage 5 (examples) — not just rakun-bpp's own suite.

Failing project/target pairs, beyond rakun-bpp's own tracked numbers (310/14 erlang, 302/22 beam, template_test, B-216's 4 on commonJS):
- modules/rakun-stylesheet · beam
- modules/rakun-websocket · erlang, beam
- examples/rakun · erlang
- examples/rakun-container · erlang
- examples/rakun-app/page-path · erlang
- examples/rakun-bpp/blog-ssr · commonJS, erlang
- examples/rakun-bpp/jhonstart-counter · commonJS, erlang, beam
- examples/rakun-bpp/jhonstart-todo · commonJS, erlang, beam
- examples/rakun-ssr/blog · beam
- examples/rakun-style/styled-context · erlang, commonJS
- examples/rakun-style/styled-context-unbound · erlang, commonJS
- examples/rakun-style/styled-example · erlang, commonJS
- examples/rakun-style/styled-source-order · erlang, commonJS

Same list fails at the examples-build stage too (not just test assertions — actual build failures).

The thread spot-checked one: `examples/rakun-bpp/jhonstart-counter` fails because `StatefulBadge` still does `val c = await state(7);` — the pre-791/809 pattern, a file that predates this port's hook/scope rewrite and was never updated. It hasn't checked the rest, including why rakun-style's own examples (4 of them, both commonJS and erlang) are failing given rakun-style landed separately already (a7ceadde) — that's the most surprising part to me.

This is well beyond what m1-0213/mt-0317 covered (which was scoped to rakun-bpp's own `modules/rakun-bpp` suite). I don't know if this whole-workspace gate failure is a known baseline I haven't seen, or new information like the erlang/beam reds were.

Questions:
1. Is any of this tracked already, or is it all new?
2. Does "commit the port now, it's strict progress" still hold at this full scope, or does the rakun-style examples regression specifically need looking at first (since rakun-style was supposed to be clean)?
3. The thread hasn't captured the untruncated gate log yet (output was piped through `tail -150` for a status check, the tail end scrolled off). Want that before deciding, or is the list above enough?

Thread is holding: files staged, nothing committed, no --no-verify used, no re-run in progress.
