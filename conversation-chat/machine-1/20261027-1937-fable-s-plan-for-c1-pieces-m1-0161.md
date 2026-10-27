---
from: machine-1
to: maintainer
purpose: question
subject: fable's plan for C1 pieces 1–2 (P0–P5); P0–P2 start now (they depend on no open question); four questions
read: [x]
in-reply-to:
---

Plan (fable, read-only; kept in machine-1's scratch area):
- Bodies are KEPT, not re-parsed. The four eval sites in infer.zig already hold each body's lowerable form, with the checker's rewrites. They are recorded once per declaration in `OkData.comptime_bodies` {id per 1083, kind, index, support, types, located}, so the id enters the unit key for free.
- The unit program is: transformed + bodies + support + types + a synthesized tail. The tail holds:
  - one `__bp_body_k` per body: `decl` as the opaque Decl, `compiler.X(decl)` as field reads, block values lifted per static type;
  - the contributions pushed on a unit-local var (fresh instance per evaluation);
  - `__bp_dispatch` on the body id, an unknown id trapping (1083);
  - the one export `__bp_comptime_eval`, built on runtime_unit's marshal and constants (1059 (1)).
- std/compiler comes by need (1082).
Pieces, each landing green or not at all (1081):
- P0 (sonnet): `comptime_bodies` recorded; stdNeedsOf pulls std/compiler.
- P1 (opus): the export and dispatch contract; an echo unit through comptime_host; an unknown id is a raise naming it.
- P2 (sonnet): a shadow harness that runs each COMPTIME REPLY both ways and counts N/19 (0/19 at first, the count its own proof).
- P3 (opus): blocks, the 5 distinct block snapshots.
- P4 (opus): templates, about 10.
- P5 (opus): decorators, 4 → 19/19, plus decorator_invocation's canonical replies through the shadow.
P0–P2 depend on no open question and start now. P3–P5 also wait on 1081's thread (compiler.bp in GC).
compiler.fail (1035-u, with Eric): the Erlang path throws and drops the contributions, and the 19 snapshots and the decorator fail tests record that abort. Only P5's fail arm depends on the answer: "go on" would re-record those tests.
Questions:
Q1 (C4, design now so P0's record fits): a decorator used in its own module is evaluated mid-inference, before the module's transformed program exists.
(a) Build that module's unit from a comptime slice (bodies, support, reached types: P0's record) at the first evaluation that needs it (recommended).
(b) Analyse the module in two passes.
(c) Decide at C4.
Q2 Non-local exits (`need` from lookup, template fail, `__bp_failArg`) from a helper function.
(a) wasm exception handling through 518's throw/attempt adapter, the same depth semantics as Erlang's throw (recommended).
(b) Result threading in the body only, refusing lookup/fail in helpers.
Q4 `compiler.src()` is one Erlang module per place today, which one unit per module cannot be.
(a) The Input gains `src: ?SourceLocation`, which C2's codec writes and C1 reads (recommended).
(b) Another form.
Q5 Contribution state.
(a) A unit-local synthesized module var; 1080's `val:`/`set:` accessors work in units (recommended).
(b) A std/compiler module var, which std-wasm says a std module cannot hold.
