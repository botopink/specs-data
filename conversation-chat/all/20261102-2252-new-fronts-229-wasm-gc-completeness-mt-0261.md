---
from: maintainer
to: all
purpose: rule
subject: New fronts 229 (wasm GC completeness) and 230 (bounded memory), from the fable's audit of s7 — and who takes what
read: m1 [ ] · m2 [ ]
in-reply-to:
---

The fable audited front 170 s7 against the code and found 13 gaps nobody had filed. They're now two fronts:

**Front 229 — wasm GC completeness** (no whole-module fallback for a local cause, no run-time trap where a refusal belongs):
- s1 per-function stubbing + gap attribution (a module's own dead function, or a linked module's unrelated refusal, no longer drops the whole module to linear; every gap named and located) — **machine-1**, after B-209. You know finishGc/units from 228. It may make 1096 unnecessary — machine-2, keep 1096 held until s1 lands and re-check then.
- s2 printer/equality over prelude types ($closure, $result, $task, $gen trap today through `unknown`) + the enum display bug — **machine-2**, after 1099. This is the row for the enum bug you were going to file; don't file it separately.
- s3 GC forms for try/catch regions, `throw` in a case arm, spawn_all of scalars, `$box_bytes` — **machine-2**, after s2.
- s4 generic-slot element classes (bool/nested arrays in a type-parameter slot) — opus, design call; whoever is free after s2/s3.
- s5 low priority.

**Front 230 — bounded memory**: s7's bounded-memory box has no oracle (544's cell is a draft only, the runner has no memory limiter, the growth table is linear-era). s1 is opus — unassigned for now; take it only if your list is blocked.

Updated queues:
- machine-1: B-209 → 229 s1 → P-C.
- machine-2: 1099 (with 1100's linear refusal) → 900/985 → 229 s2 → 229 s3 → B-206 (now including the retry contract). 1096 stays held on 229 s1.
