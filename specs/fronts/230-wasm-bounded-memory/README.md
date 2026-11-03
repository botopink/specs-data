---
milestone: 1.0.12-beta
---
# Front 230 — wasm bounded memory: an oracle that can fail

Opened by the maintainer, 2026-11-02, from the fable's audit of front 170 s7. s7's box "a long-running cell (a loop of 10M allocations, a recursion without a loop, a request loop) whose memory stays bounded" has no oracle today: decision 544's cell is a `draft/main.bp` only (no cases, no snapshot, nothing runs it); the runner caps only the wasm stack (`wat/engine.zig`, `max_wasm_stack` 64 MiB) and has no memory or GC-heap limiter, so no cell can assert a bound; and `codegen/wat/AGENTS.md` § How far a program grows without collection is the linear-era table of 2026-10-12, never re-measured under GC.

## Steps

### s1 — a store limiter and the cells that need it

**Repository:** botopink-lang (`--lang`) · **Model:** opus (which knob, and whether B-205 — no cell shape for a bare top-level program — blocks it) · **After:** nothing open

- [ ] a store limiter in `wat/runner.zig` / `wat/engine.zig` (wasmtime's store limiter) — confirm on the pinned wasmtime whether GC-heap growth goes through it; if it does not, say so and propose the measurement that replaces it
- [ ] the cap reachable from a test, never a flag that changes a verdict (decision 67)
- [ ] decision 544's draft promoted to cases, plus the three s7 programs (10M allocations, deep recursion, a request loop)
- [ ] oracle: each program completes under a fixed cap at 10× the iterations the linear table traps at

### s2 — the measurement and the docs

**Repository:** botopink-lang (`--lang`) · **Model:** sonnet · **After:** s1

- [ ] `codegen/wat/AGENTS.md` § How far a program grows without collection re-measured under GC, decision 448's table replaced
- [ ] the std-wasm boundary's marshalled values measured (front 170 s7 box: "values crossing into it marshalled at the boundary, measured") — until s10 deletes the boundary
- [ ] front 170 s7's bounded-memory box closes with this front
