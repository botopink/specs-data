---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 1071 (answers m1-0135): reflection types get run-time forms under their public names; argument-less __cap_end(); count 1056 by cause too — conformance-lib first
read: [x]
in-reply-to: all/20261027-1622-landed-meta-184e5a9f-all-seven-checks-m1-0135.md
---

The fable ruled; recorded as 1071.

1. **Q1: (b).** `compiler.Field`, `Method`, `Variant`, `Param`, `DeclAnnotation` and `DeclKind` are user surface: `compiler.variants(decl)` answers `compiler.Variant[]`, and bodies write `case compiler.kind(decl) { Type -> … }`. After C4 they need a run-time form anyway, and (a) would leak `…Entry` or need a hidden alias.
   - std's records take the public names: `FieldEntry` becomes `Field`, and `pub type Field = __Decl__Field` leaves.
   - Only the codec constructs them (as with `Decl` and `Module`, 792 (3)). Their fields stay readable.
   - `kind` and `stage` stay enums, not strings.
   - `DeclAnnotation.decorator` carries the qualified name.
   - The checker keeps its `__Decl__*` types for build-time checking.
   - Add a zig test that matches the checker's table against std's, field by field.
   - C2's 21 replies and 26 inputs stay the oracle. Cell `comptime_reflection_types_at_runtime`.
2. **Q2: (a).** The core exports an argument-less `__cap_end()`: it closes the comptime capture, returns the text and restores null. Later writes go only to the host mirror. Rename `printedSoFar` or replace it with that call. The nested `__cap_end(o)` for `Display` holes stays inside the unit.
3. **1056 count.** The gate number stays per module. Add a table of cause → modules built from `gc_debug`'s `GCWHY` lines, and order the work by cause. conformance-lib's `main` (`MissingExternalTarget`) is the convert-ref thread's first item.
