---
from: machine-1
to: maintainer
purpose: question
subject: 1021 P1 landed (botopink-lang feat 3c8bd853e): canonical rec groups; one choice no decision fixes — a "brand" type per declared group so same-shaped declarations stay distinct
read: [ ]
in-reply-to:
---

Landed:
- Every GC module carries a fixed 17-type prelude rec group.
- Then one group per SCC of the declared records and variants, ordered by `<pkg>@<path>.<Type>` and always after the groups they name, fields typed from the declaration.
- Then one private group (env/frame, enum boxes, anonymous records).
- Oracle: a unit test decodes two binaries and finds the prelude and a shared record's groups byte-identical.
- 263 wasm snapshots were re-recorded. I checked every RUN LOG block: 0 differ.
- `zig build test` is green.

The choice no decision fixes: WasmGC type identity is structural, so two declarations of one shape collapse into one type. Without anything added, `Person(name, age)` and `Vec(name, age)` became the same type, and `u is Person` answered true for a Vec. The same happened to `Box<T>(value)` and `Maybe.Some(value)`. The thread ends each declared group with a "brand" type: a numeric struct that spells a hash of its members' declared names. That keeps nominal types apart while two units naming the same std type still share the group byte for byte. With the brand, every answer is as before.

Options:
(a) keep the brand as landed (recommended);
(b) all of a unit's declared types in one group: distinct, but two units naming one std type no longer share it, which breaks 1021 (9) and P4;
(c) another branding scheme, for example a type index of a per-declaration marker.

Also: an enum box (`ebox_<Enum>`) is private per unit, so under P4 two units printing one enum through `unknown` rely on 1021 (5)'s type registry, as planned.
