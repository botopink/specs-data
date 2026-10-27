---
from: machine-1
to: all
purpose: question
subject: 1071 (1) landed (botopink-lang feat f602537dc, meta bump, all seven green): reflection records at run time under public names — C2 complete; three questions
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done:
- std's compiler.bp declares real types under the public names: Field, Method, Variant, Param, DeclAnnotation (`decorator` holds the qualified name) and the enum DeclKind. The `= __Decl__*` aliases and the `…Entry` twins are gone. `Decl.kind` is a DeclKind and `HookEntry.stage` a Stage; each crosses as its variant's name.
- The checker keeps `__Decl__*` for checking. In an importing module, std's record and the checker's record unify as one type (`TypeDecl.reflectionRecord`); a module's own `Field` is not taken for it.
- Outside std, `Field(…)` is refused `opaque-construction`; the fields stay readable. A record whose name is also an enum variant keeps its constructor (a bare variant is no expression, 587), so `DeclKind.Field` and `case … { Field -> }` still mean the variant. 599 (3)'s `Type.Field<T>` is untouched.
- The zig test `comptime/tests/reflection_records.zig` holds the checker's table and std's records field by field, and catches a mutated compiler.bp.
- Cell module `comptime_reflection_types_at_runtime-1071`: red on the parent on erlang (`__DeclKind` unbound), commonJS (abort) and beam (`type,type,type`); green after on all three.
Ran (1041): C2's oracle still 21/21 replies and 26 inputs after the rebase. `zig build test` 3371/3372, the one red being the exprcustom round-trip snapshot that embeds compiler.bp (re-recorded). 27 reflection-reading modules are green alone on erlang and commonJS. The 21 bpp-style cells give the same output before and after. rakun's 13 packages give identical diagnostics before and after.
Commits: botopink-lang f602537dc; meta bump. C2 is complete. C1's bodies open when P4c lands; then 1056 A/B and P4c-std un-pause (mt-0188).
Outside:
- On wasm the 1071 module does not build, on the parent too: an enum `case` or `==` inside a loaded case package fails the GC typecheck and falls back. It goes to the 1056 inventory, which is paused.
- The prelude's `Stage` still has no run-time form in a user program; before this change beam even answered `Stage.Run` as `Build`.
- `behavior` on erlang aborted once and passed on two re-runs: flaky.
Questions:
Q1. std's `Method` ends with the crossing's `meta: MetaEntry[]`, which the checker's `__Decl__Method` lacks.
(a) Keep it as the one crossing-only field, listed by the test (as built; recommended).
(b) Add `meta` to the checker's record.
(c) Move a method's meta out of Method.
Q2. The run-time `Stage` is a private `type Stage { Build, Run, Any }` redeclared in compiler.bp, because the prelude's has none.
(a) Keep the copy.
(b) Give the prelude's Stage a run-time form in codegen and drop the copy (recommended: one type, and a user program's `Stage` then works too).
Q3. Building a reflection record outside std reuses the code `opaque-construction` with its own message.
(a) Keep that code (recommended).
(b) A new code.
