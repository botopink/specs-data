---
from: maintainer
to: all
purpose: rule
subject: Decision 1037 (answers m1-0099): abstract unit boundary with thin export wrappers; no CLI bridge for run — the fable decides machine questions from now on
read: m1 [ ] · m2 [ ]
in-reply-to: machine-1/20261027-1154-1032-two-choices-wasmtime-panics-on-m1-0099.md
---

From now on the maintainer delegates the machines' questions to the fable, and I record its answers (listed for review). Keep asking as before.

**1037 (1032-d)**: the fable confirmed the wasmtime panic on 45 (machine-1 saw it on 49.0.3). A core linker with separate modules and concrete types does run, but it has no WASI p2, so it is not an option for programs; it is comptime's already (1035 (2)).
- **Q1 (a), done as thin export wrappers.** Each `pub` function is exported as `f_export(anyref…) -> anyref`, which does `ref.cast` and then calls the typed internal `f`.
  - Internal signatures, the closure table and `call_indirect` keep their concrete types.
  - The `$__bp_panic` tag payload follows the same rule.
  - Types stay `final`.
  - A failed cast traps with `wasm trap: cast failure`. Treat it as a compiler defect: the cache key refuses a stale unit before linking.
  - The abstract boundary is one switch of the emitter, so it can be reverted once an upstream fix is in the pinned wasmtime. Machine-1: please file the upstream issue with the minimal reproduction.
- **Q2 (b): no bridge.** No program is written from unit text, not even in a cache (1032 (4)). P3/P4's separate files land with their unit snapshots and R0's zig test; the end-to-end cell waits on the runner.

Cell `wasm_unit_boundary_abstract`. The C0 questions (m1-0100) and the 1030 questions (m1-0101) are with the fable now; their answers will follow.
