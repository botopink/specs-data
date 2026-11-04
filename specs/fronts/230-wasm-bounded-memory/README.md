---
milestone: 1.0.12-beta
owner: machine-2
---
# Front 230 — wasm bounded memory: an oracle that can fail

Opened by the maintainer, 2026-11-02, from the fable's audit of front 170 s7. s7's box "a long-running cell (a loop of 10M allocations, a recursion without a loop, a request loop) whose memory stays bounded" has no oracle today: decision 544's cell is a `draft/main.bp` only (no cases, no snapshot, nothing runs it); the runner caps only the wasm stack (`wat/engine.zig`, `max_wasm_stack` 64 MiB) and has no memory or GC-heap limiter, so no cell can assert a bound; and `codegen/wat/AGENTS.md` § How far a program grows without collection is the linear-era table of 2026-10-12, never re-measured under GC.

## Steps

### s1 — a store limiter and the cells that need it

**Repository:** botopink-lang (`--lang`) · **Model:** opus (which knob, and whether B-205 — no cell shape for a bare top-level program — blocks it) · **After:** nothing open

- [x] a store limiter in `wat/runner.zig` (wasmtime's store limiter). On the pinned wasmtime (v49.0.3, the DRC collector) it bounds GC-heap growth, not only linear memory. This was measured with a standalone C program against libwasmtime before building on it. The cap applies per memory (each linear memory and the GC heap separately), not as one total per store
- [x] the cap reachable from a test, never a flag that changes a verdict (decision 67): `Options.memory_limit`, null by default, set in code only, reaches `wasmtime_store_limiter` through `Session.begin`. `botopink run --target wasm` stays unbounded, like the other targets' runtimes (the maintainer, 2026-11-03)
- [x] decision 544's draft promoted to a self-checking module with four cases: the draft, `ten_million_allocations`, `deep_recursion_rounds` and `request_loop`. Green on all four targets. B-205 does not block it: the oracle runs the cases' source directly
- [x] oracle (`codegen/tests/wat_memory.zig`): each case run as a bare program under a fixed 2 MiB cap completes at 10× the iterations the linear table traps at

### s2 — the measurement and the docs

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** s1

- [x] `codegen/wat/AGENTS.md` § How far a program grows without collection re-measured under GC, and decision 448's table replaced. All five of 448's shapes now stop at the engine's own 64 KiB instantiation floor, from 104× to 2685× less than the linear table. Two new permanent oracle cases in `tests/wat_memory.zig`, for the `@Async` loop and the page render: 448 named both shapes, but no case covered them
- [x] the std-wasm boundary's marshalled values measured: 47 std-wasm functions marshal on every call from a GC module, and 15 `.wat` leaves cross with no cost. Each call's instruction cost is derived from `wat_prelude.zig`'s conversion helpers. The section is marked as a stopgap: it is removed, not re-measured, when s10 deletes the boundary
- [x] front 170 s7's bounded-memory box closes with this front
