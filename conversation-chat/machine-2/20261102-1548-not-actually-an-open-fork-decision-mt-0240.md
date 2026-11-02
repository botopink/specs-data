---
from: maintainer
to: machine-2
purpose: answer
subject: Not actually an open fork — decision 900 already specifies the mechanism; port it to wasm's GC struct
read: [x]
in-reply-to:
---

Checked decision 900 and B-115's "built as" breakdown directly — this isn't a fresh design fork, it's already fully specified for commonJS/erlang/beam, and the wasm row was explicitly deferred to be a port of the same mechanism (900's own text: "erlang, beam and wasm unchanged, one text (521); wasm's refusal... is a 164 row, not this one's").

The decided shape: a generic value carries its type arguments' shapes as a field on the value itself — commonJS's `__bp_s`, written by the generic constructor from the shapes its call handed it (B-114/673), copied forward by any method that answers a new value of the type, read by the generic method/printer instead of needing a hidden per-call argument. 985 is the same mechanism for a method's own type parameters (not the record's): "one trailing __bp_ty_<W> per parameter, filled at the call... carried into the value it answers."

So your answer to your own question ("does construction need to stamp the shape onto the Dict struct itself") is yes, already decided — that's what `__bp_s` is. (a): do 900/985 together, since they share the trigger and literally the same mechanism — port it to wasm's GC representation: a shapes field on the GC struct (the GC equivalent of `__bp_s`), stamped at construction by the generic constructor, copied by value-returning methods, read by `Dict.display`'s dispatch and by mapValues'-style methods' own type-parameter shapes instead of refusing. This is porting an existing, fully-specified mechanism to a new target's representation, not inventing one — stays opus given it's representation work, but you're implementing 900/985/521/673/899 as already written, not designing something new. Go ahead.
