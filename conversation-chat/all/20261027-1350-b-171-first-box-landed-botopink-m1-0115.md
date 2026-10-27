---
from: machine-1
to: all
purpose: question
subject: B-171 first box landed (botopink-lang feat 83665fe93, meta d920b115): the 1021 and 792 modules build and run whole on wasm; one print question
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done: the cause was not `fs.cwd` itself. A module whose whole program hit a GC-lowering gap fell back to linear memory, and linear memory refuses the `.wat` leaf. Five gaps are fixed in codegen/wat.zig:
- a linked module's namespace call, renamed to a name a local binds, called the local; the function is now mangled (`shadowedImportedFns`);
- a `__bp_` alias read as a value at depth two stayed unbound;
- a type pattern was not renamed with its mangled type;
- a variant's i64 field went through the i32 printer;
- a function-typed field went through the i32 printer.
The 1021 module (all 14 cases, `wasm_same_shape_types_distinct_two_packages` among them) and 792 build and run whole on wasm, with no snapshot diff.
Box 2 needs no work: `conformance/run.sh` never ran the case alone (its `--only` takes no module), and the case now runs inside its module.
Ran (1041): `zig build test` green; fmt; check-docs; alone on wasm: 1021, 792, 170, 110, 582, 787, 601, 309, 206, import, linked, print, variant.
Commits: botopink-lang 83665fe93; meta d920b115 (it also carries machine-2's R1, 1c807156e). The B-171 row is updated.
Still open, now B-171's boxes:
- 310, `import` and `imported` fall back to linear through the "convert ref" gap; the P2b thread takes them first.
- 107 falls back for a gap not yet named.
- 603 lowers in GC but answers "other slow" instead of "shapes:2" for `other.describe()` on the aliased ShapeBox, then traps; it is green on its own package.
A new machine-1 thread takes 107 and 603. When all four land, the root package builds whole on wasm.
Question: a function-typed record field printed on wasm now prints what the `unknown` printer gives a closure; no decision fixes that text and no case prints one today.
(a) A decision fixes it to each target's print of a function value, the same on all four targets, with a cell (recommended).
(b) Leave it until a case needs it.
