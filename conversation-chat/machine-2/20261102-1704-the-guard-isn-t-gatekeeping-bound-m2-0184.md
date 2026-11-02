---
from: machine-2
to: maintainer
purpose: question
subject: The guard isn't gatekeeping "bound vs unbound" at all — it's shielding the whole module from B-207's unrelated gcFail
read: [ ]
in-reply-to:
---

Read the actual test bodies before touching anything again. Here's what I think is really going on — want your read before I build:

**The "bound vs unbound" hypothesis doesn't hold.** The refused test (`wat.zig:2319`, "a generic body reached with nothing bound is refused at the concrete call") has `Box<T>(value:T) implement Display` calling `shown(self.value)` from `Box.display()` — `self.value:T` is unbound inside `Box.display`'s own generic body. That's structurally identical to decision 900's real target, `Dict<K,V>.display()` calling `shown(p._0)` where `p._0:K` is equally unbound inside `Dict.display`'s own generic body. Both are "nothing concrete bound" cases. So that axis can't be what separates "must stay refused" from "must work."

**What I think is actually happening:** `gcDeclPrinter`'s guard isn't gatekeeping decision 900's dispatch bug specifically — it's preventing B-207's *unrelated* gap from forcing a MODULE-WIDE GC→linear fallback. B-207's refusal ("a lambda parameter nothing types", wat.zig:23776) is a `gcFail`, and `gcFail` aborts the whole `.gc` attempt for the ENTIRE module, not just that one call. `Dict.display()`'s `for self.pairs {...}` hits that gap. So the moment the guard is lifted, ANY program that merely imports/links `collections.Dict` — whether or not it ever prints one — gets its auto-printer machinery opportunistically attempt `Dict.display()`, hit B-207, and fall the WHOLE module to linear. That's why the regression hit tests that never print a Dict at all (`Dict.empty().insert(...).at(...).size()`, no `print(d)` anywhere) — they just link Dict in, and Dict's unused `display()` dragged the whole module down.

If this is right: making the guard "conditional on a bound type argument" wouldn't fix anything, because Box and Dict are the same shape on that axis. The real unlock is landing B-207 first (so `Dict.display()` stops hitting `gcFail` in GC mode at all) — only then can the guard be safely narrowed or dropped, because at that point attempting it either succeeds or fails for reasons actually local to what's printed.

**Proposed scope for today, unblocked either way:** land only the narrow fix you approved in mt-0244 — `shown<T>`'s generic/erased body doing a dynamic `ref.test` chain instead of assuming `box_i32` — entirely inside `gcPrintArg`'s handling of a `.ref=.unknown` repr. This never touches `gcDeclPrinter` or its guard, has no B-207 dependency (confirmed: it's exercised by the already-passing `wat.zig:2293` test, a top-level generic fn, no record involved), and is real forward progress on the actual crash bug. It does NOT close 900's or 985's wasm cells — those stay red until B-207 lands regardless. Want me to build and verify that now, and leave `gcDeclPrinter`'s guard untouched until B-207 is someone's active work?
