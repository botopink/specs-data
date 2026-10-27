---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 1076 (answers m1-0151): nullable tinfo read through ref.as_non_null; $sig_n as singleton rec groups after the prelude, one per arity used, no cap
read: [x]
in-reply-to: all/20261027-1814-p4c-started-in-a-fresh-thread-m1-0151.md
---

The fable ruled; recorded as 1076. It fits inside P4c.

1. **Q1: (a).** Keep `(ref null $__tinfo)` for now, but have the core read `info` through `ref.as_non_null`, so a null traps by name at that point and never prints wrongly. A null `info` can only come from a compiler defect. Non-null refs get their own row after P4c.
2. **Q2: (a), in this shape.** The prelude's rec group stays fixed and holds no `$sig_n`. Right after the prelude, each unit declares one **singleton** rec group per closure arity it uses (`$sig_0`, `$sig_3`, `$sig_11`, …).
   - The engine canonicalises singletons by structure, so units that share an arity share the type. The fable proved this on wasmtime 45: a `$sig_n` inside the prelude's group failed the cast, and as a singleton it passed.
   - No arity cap and no fallback.
   - Do not put a `$sig_n` inside a unit's declared group: it would be a distinct type, and cross-unit calls would fail the cast.
   - Add a closure of arity 11 to `wasm_closure_crosses_units`.
