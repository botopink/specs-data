---
from: maintainer
to: all
purpose: rule
subject: The maintainer: open more threads on both machines — parallel worktrees on the independent items, up to the pool's capacity
read: m1 [ ] · m2 [x]
in-reply-to:
---

The maintainer asks both machines to run more threads in parallel (meta AGENTS.md § "Keeping the threads honest and the machine busy" — no idle slot, up to ~5 threads as pool and memory allow; each thread in its own worktree, `scripts/thread-rules.md` first, heavy commands through `scripts/gate.sh exec`, model per § "Which model a thread runs on", kill its own background jobs before reporting; the coordinator lands). Split by files so threads never touch the same area.

machine-1 — suggested threads now:
1. (you) land the root-package fix (sibling loaded packages' names) once its tests pass.
2. sonnet: 1018 (two leftover cells into cases/) + 1017 (5) (`build --target wasm` writes only the entry; the 13 never-run units leave).
3. opus: 1015's codegen — commonJS / TypeScript flat `<pkg>@<path>` names and requires (crossModule.outputStem, commonJS.requirePrefix, typescript.zig, .mjs sidecars, the loaded-package require-cache purge).
4. opus: the leftover conversion (379 leftover cases, ~94 old-shape dirs), module by module, each proven as before.
5. fable (Plan, read-only): 1017's plan — canonical GC type section, shared panic tag, the linear fallback's end (B-170's GC gaps), the linker / composition tool, the browser loader; pieces + cells. Post it to me before any piece starts.
(P5 / T5 wait on machine-2's P1.)

machine-2 — suggested threads now:
1. (you) 1006 P1 with 1007 / 1009 / 1020 (3), (5) — finish and land.
2. sonnet: 1020 (7) — remove the five CLI-behaviour cell dirs, move their proof into tests/runtime_reuse.sh / tests/beam_reuse.sh, and give decision-cells.ts (check 7) the rule for rows proven by a CLI script.
3. opus: 1015's workspace folder part — one `out/<target>/` at a workspace root, dependencies written once per key (temp + rename), the duplicate `<pkg>@<path>` refusal — independent of machine-1's naming codegen until they meet.
4. sonnet, after P1 lands: 1008 T1 (target-folder key, run only executes, wasmtime cache under .botopinkbuild).
Report each thread's landing as usual; say in `doing` how many threads run.
