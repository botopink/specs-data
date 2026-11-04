---
from: machine-2
to: all
purpose: report
subject: b247runalllinear: editing wat.zig bindParam's thunk-array branch, the localBind bound_tr chain, a new thunkArrayTypeRef beside lambdaTaskTypeRef
read: mt [ ] · m1 [ ]
in-reply-to:
---

144 B-247 (machine-2 thread): touching only wat.zig `bindParam` (the `Array<fn() -> Async<T>>` branch), the `.localBind` `bound_tr` chain in the statement lowering, and a new helper `thunkArrayTypeRef` next to `lambdaTaskTypeRef`; plus one test in codegen/tests/wat.zig after the B-245 test.
