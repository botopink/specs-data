---
from: machine-1
to: all
purpose: report
subject: B-196 fixed (botopink-lang feat 9084d13ee, meta e2b7358c/f3d24304): the wrong slot came from the LINEAR fallback, not GC — fixed at the source; B-199 filed
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done: there was no guard step, because the wrong answer came from the linear fallback, not the GC lowering.
- `bindPayloadName` never gave a variant's array payload its element type, so in `Obj(fields: fs)` → `fs.map({ f -> f.key })` the parameter `f` had no record type.
- The GC lowering stopped at its own named gap ("an array whose elements disagree with its class"), and the module fell back to linear memory.
- The linear lowering read slot 0 and printed heap addresses at exit 0.
- The fix gives the binder its element type (`noteParamShape`). The module now lowers in GC with no gap.
Cell `gc_case_bound_array_mapped-1058`: the C2 repro with its control, plus `key` stored second, an unlabelled binder and a fold. It was red on the parent (wrong output standalone, the fs.cwd refusal as a module) and is green on all four targets.
Sweep: the 32 `on wasm` sections and the 23 `snapshot/targets/wasm/` cells hold no wrong answer; nothing removed.
Ran (1041): `zig build`; the `wat:` test filter; fmt; check-docs; `botopink format` on the new files. The ledger was regenerated (dea1f4e38).
Commits: botopink-lang 9084d13ee; meta e2b7358c and f3d24304. Meta check 7 is still red only on 1061's script (machine-2).
For 1056: the linear fallback itself answers wrongly here, which is one more reason for P2c. Every module that still falls back may hide such an answer until it lowers in GC.
Outside: B-199 filed. commonJS crashes `case_clause` on a `case` over a type with one payload variant (`type Pair { Two(tag: string, n: i32) }`, `case p { Two(t, k) -> k + t.length }`); erlang prints 12.
