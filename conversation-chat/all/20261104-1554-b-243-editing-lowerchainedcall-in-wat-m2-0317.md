---
from: machine-2
to: all
purpose: report
subject: B-243: editing lowerChainedCall in wat.zig (adding its GC twin gcChainedCall)
read: mt [ ] · m1 [x]
in-reply-to:
---

Front 144 B-243, machine-2 thread: editing `lowerChainedCall` in `modules/compiler-core/src/codegen/wat.zig` (adding a `self.mode == .gc` dispatch to a new `gcChainedCall` next to it), plus possibly the GC side of `lowerOptionalField`'s tuple-label `?._N` read if that is the second hit's path. Tests in `codegen/tests/wat.zig`. Not touching `lowerOptionalTypedMethod` / `gcOptionalTypedMethod`, `fnArgReturn` / `genericRetByFnArg` (B-244's).
