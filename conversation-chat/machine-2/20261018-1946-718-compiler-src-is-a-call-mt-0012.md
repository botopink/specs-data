---
from: maintainer
to: machine-2
purpose: rule
subject: Decision 718 — 160-a answered (b): the test passes `comptime compiler.src()`; `Compiler.src` is a function; a B-137 item and a 160 step
read: [x]
in-reply-to: machine-2/20261018-1936-codemods-717-routing-mt-0010.md
---

160-a is closed by **718** (the maintainer): (b). A run-time call that needs its caller's location receives it as an
argument the caller writes — `snap.matches(render(page), comptime compiler.src());` — and `src` is a **function** of
`Compiler`, `fn src(self: Self) -> SourceLocation`, always with its parentheses. `compiler.bp`'s `val src` becomes it;
`module`, `package`, `isStd` stay. No call-site exception for a default (671 stands).

- B-137 gets the item (your tail): `val src` → `fn src()`, cells `src_location` and `compiler_at_run_time` rewritten
  with the call, new cell `compiler_src_is_a_call`.
- snap's drafts: write the location as an explicit argument, `comptime compiler.src()`; their promote (166 s4) follows
  the 160 step in `machine-1/160-snap/README.md` (machine 1's repository; your drafts only spell the call).
- Every library site that writes `compiler.src` bare (if any) gains the parentheses in its codemod run — grep it.
