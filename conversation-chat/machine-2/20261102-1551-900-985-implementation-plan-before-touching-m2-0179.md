---
from: machine-2
to: maintainer
purpose: question
subject: 900/985 implementation plan, before touching code — narrower than it first looked, but real struct-layout + equality risk
read: [ ]
in-reply-to:
---

Narrowed it further before writing anything. Good news: `mapValues` itself (and by extension insert/delete/merge/etc.) already compiles and runs fine in GC mode with no refusal — tested directly (`Dict.empty<string,i32>().insert(...).mapValues({v -> 2.0}).size()` on wasm: compiles, runs, answers 2). The ENTIRE gap is the print/display path alone: `gcDeclPrinter`'s "a generic record's display" refusal fires unconditionally whenever a generic record has a custom `display()`, even when the call site's own static type is fully concrete (`Dict<string, f64>` here) — it checks only whether the record DECLARATION has generic params, never whether THIS call already knows them. So the blast radius is genuinely just the print/display dispatch, not generic method calls broadly — matches why commonJS's own gap was equally narrow (JS already handles every runtime value correctly except "is this number a float," which only matters for printing).

Plan, following decision 900/985's own "built as" text exactly:
1. Add one GC struct field per type parameter to a generic record's type (`Dict<K,V>` gains `shape_K`, `shape_V`: i32 tags, mirroring `__bp_s`'s `$K`/`$V`). Touches `gcStructFieldVts`/`gcBuildTypes` (struct layout) and every `record_generics`-keyed call site that builds a struct's field list or reads a field by index (grepped: ~20 sites reference `record_generics`; most are generic-dispatch bookkeeping unrelated to field layout, but I haven't individually cleared each one yet).
2. Stamp the new fields at construction: a generic constructor call (`Dict(pairs: …)` directly, and static constructors like `Dict.empty<K,V>()`) writes the shape tag for each bound type argument, same as B-114's `typeArgShapes`/`shape_subst` already computes for commonJS — I'd reuse the same computation, just write it to a struct field instead of building a JS object.
3. Methods answering "a new value of the type" (insert, delete, merge, mapValues, …) copy the fields forward from `self`; `mapValues<W>` additionally takes `W`'s shape as a trailing parameter at the call (985's own piece, `noteMethodTypeArgs`-driven) and writes it into the new value's `shape_V` instead of copying `self`'s.
4. `gcDeclPrinter`'s refusal becomes a read of `v.shape_$T` and a call to the record's `display()` (or the structural printer, passing the shapes down) instead of refusing.
5. **Real risk I haven't resolved yet: structural equality.** `$__unk_eq` (and whatever drives `==` between two records of the same type) walks fields positionally/by declaration — it needs to skip the new shape fields, or two `Dict`s with identical pairs but reached through different construction paths could compare unequal. commonJS's `__bp_eq` presumably already excludes `__bp_s` from comparison (I haven't confirmed how) — wasm's equivalent needs the same exclusion, and I haven't located where that decision gets made in wat.zig yet.

This is still real opus-tier representation work — new struct fields on every generic record ripple through layout, construction, forwarding and equality, not just the print path's own code. Wanted to send the concrete plan before spending the implementation hours, per your bar today. Go ahead on this, or want me to resolve the equality question first and report back before starting on the struct change itself?
