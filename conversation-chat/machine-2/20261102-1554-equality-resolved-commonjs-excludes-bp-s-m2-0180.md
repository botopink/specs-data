---
from: machine-2
to: maintainer
purpose: answer
subject: Equality resolved: commonJS excludes __bp_s "for free" via non-enumerable; wasm has the same free exclusion available
read: [x]
in-reply-to: machine-2/20261102-1552-resolve-equality-first-then-start-the-mt-0241.md
---

Found it, and it's good news — no special-case exclusion logic needed on either side, if I place the fields right.

commonJS: `__bp_s` is installed via `Object.defineProperty(instance, "__bp_s", { value: shapes })` (commonJS.zig ~7844-7849) — no `enumerable: true`, so it defaults to non-enumerable. The generic structural-equality fallback (`__bp_eq` in js_prelude.zig, line ~1370) walks `Object.keys(a)` to compare records it has no per-type equality for — `Object.keys` never lists a non-enumerable property. So `__bp_s` is excluded "for free," not by any deliberate skip in the equality code. I'd bet this is exactly why it was never called out as its own problem in B-115/900's text — it genuinely wasn't one.

wasm has an equivalent free exclusion, from how the equality code is already structured. `gcUnkEqStruct` (wat.zig ~9032) — the function that structurally compares two GC structs field by field — gets its field list from `gcStructFieldVts`, which has exactly one caller: `gcUnkEqStruct` itself. It is NOT used to build the actual struct type definition (that's `gcBuildDefs`, feeding `gcBuildTypes`) and NOT used by construction. So the real struct layout and what equality compares are already two independent sources, not one shared list threaded everywhere I'd have to patch.

So: if I add the new shape fields to the real struct definition (wherever `gcBuildDefs` lays out a record's fields) placed *after* the declared fields, and leave `gcStructFieldVts` alone (it keeps answering only the declared fields, from `record_field_typerefs`, unchanged), `gcUnkEqStruct` keeps comparing only indices `0..declared_field_count` and never touches the shape fields — the same "excluded because nothing asked about it" shape as commonJS's non-enumerable trick, just via two decoupled field-count sources instead of a property flag.

Haven't touched any code — this was read-only tracing to answer your question. Order constraint confirmed: shape fields go after the declared ones, matching what `gcStructFieldVts`'s existing field-index arithmetic already assumes. Want me to proceed to the struct-field change now?
