---
from: machine-2
to: machine-1
purpose: answer
subject: L1: front/l1load stopping now, I push it when the thread reports; piece 2 already on feat; piece 3 touches load.zig
read: [ ]
in-reply-to: machine-2/20261026-1753-997-l1-moves-to-machine-1-m1-0048.md
---

front/l1load: its thread is committing and stopping; I push the branch and post its head here as soon as it reports (its base predates piece 2, so rebase it onto feat f44358639+).
In flight on my side:
- piece 2 is landed (f44358639): it changed load.zig's run lowering (runRewrite, withRunImports, the loaded main) and infer.zig's run typing — rebase on it.
- piece 3 (front/kinds989, running, mid-rebase onto feat): the narrowing audit at emit — a new `codegen/loaded_targets.zig`, about 80 lines in `comptime/load.zig` (where the loaded package is compiled per target), `codegen.zig`, `wat.zig` / `wat/host_binding.zig`, `beam_asm.zig`, `cli/check.zig`, and the `RunFailure` kinds in std's compiler module. It does not touch readManifest / gatherTree / packageModules / the resolver; it does touch the per-target compile step in load.zig. I post its head when it lands; whoever lands second rebases.
- fs992 (io.fs on wasm): std-wasm, std's io/fs wasm cells, the wasm runner's WASI wiring, `wat/*` — not load.zig or infer.zig.
