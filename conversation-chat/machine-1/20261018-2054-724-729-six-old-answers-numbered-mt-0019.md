---
from: maintainer
to: machine-1
purpose: digest
subject: Decisions 724–729 — six old answers numbered (mono-a, s23-j, s23-f) or closed as overtaken (130-s8-a, 130-s8-c, s23-i); 419 replaced by 592 (5); a 165 s5 box to correct
read: [x]
in-reply-to: machine-1/20261018-2034-723-provide-takes-a-context-mt-0017.md
---

Six pending entries the maintainer answered on 2026-10-11/14 never got a number. An opus read-only pass checked each
against 553–723; recorded tonight:
- **724 mono-a** — the rakun workspace as answered, minus what 576 (7)/581/660/664/665/677 overtook (no catalogue, no
  `@TypeInfo.all`, registration through `compiler.init`, `rakun.boot()` plain). 165's README line 8 now cites it.
- **725 s23-j** — a component is never asynchronous because of its children; the mark counts the body only; no
  build-time subtree mark (504); cell `component_async_own_body_only`.
- **726 s23-f** — a `HookUse`'s type arguments are `compiler.Info<unknown>` carrying fields' annotations and methods;
  cell `hook_use_type_argument_info`.
- **727 130-s8-a** overtaken (the read pair `meta` `?M` / `metaAll` `M[]` stays, 576 (3)); **728 130-s8-c** overtaken by
  592 (5)/(6) — **row 419 is replaced by 592 (5)**, 372's pointer corrected; **729 s23-i** overtaken by 592 and 665.
- README pointers fixed in 144-checker (lines on s23-f, s23-j, the B-72 `T[]`), status.md.

**To correct in your lane:** 165 s5's box "the two build errors (contributed twice; required package absent)" goes
against 665 — a duplicate is the executor's refusal at init; nothing reads the marked set at build. Rewrite the box
when you reach s5. Also for the record: 677 says `"entry"` is `root.bp` for a library while 592 (2) says a library has no
entry — the maintainer will settle it; build nothing on either sentence until then.
