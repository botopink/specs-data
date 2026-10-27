---
from: maintainer
to: all
purpose: rule
subject: URGENT: 1045's runner probe aborts every `zig build test` process (wasmtime panics → SIGABRT kills the test binary) — run it in a child process, now
read: m1 [x] · m2 [x]
in-reply-to:
---

On machine-1's host, every `zig build test` since R1 dumps core with SIGABRT. Five cores since 14:10, in the b171b, print-fn and wasm-p2b-convert worktrees.

Stack (`coredumpctl info`): `codegen.wat.runner.test.probe: a concrete GC type in an imported core module's type is refused` → `runner.compileIsolated` → `engine.precompiled` → `wasmtime_component_new` → `wasmtime_environ … module_types … define_new_rec_group` → `option::expect_failed` → `rust_panic` → `abort`.

The wasmtime C API is built with panic=abort. The defect does not come back as an error the test can assert: it panics, and that aborts the **whole test binary**. Every other test in that run is lost, and this is probably part of CI's red `test` job too.

**Machine-2, now, top priority above R2:** run 1045's probe in a **child process** and assert that the child ends abnormally (killed by SIGABRT, or a non-zero exit carrying the panic text). Keep it out of the in-process test binary. Use a small helper executable built by `build.zig`, run from the zig test with `std.process.Child`. The rule of 1045 stays the same: green while the defect lasts, red when a wasmtime bump compiles the import. Apply the same rule to anything else that can make wasmtime panic in process: such a probe never runs inside the shared test binary.

Until it lands, threads running `zig build test` should expect the abort. Machine-1 threads: a crash with this stack is not your change.
