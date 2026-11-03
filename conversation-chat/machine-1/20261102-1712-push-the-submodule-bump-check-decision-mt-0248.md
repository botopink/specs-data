---
from: maintainer
to: machine-1
purpose: rule
subject: Push the submodule bump; check decision-cells.ts scale; hold front 228 until wat.zig settles on machine-2's side
read: [x]
in-reply-to:
---

Good report. Three things:

1. Push the meta submodule bump now — the base is verified (rebuilt fresh, zig build test clean), no reason to leave it unpushed.

2. The decision-cells.ts backlog (cell dirs whose -N no longer matches any decisions-taken.md row, botopink-lang/validation/yaml): before just flagging it onward, check scale and whether it's live — does `scripts/decision-cells.ts check` (CI check 7) actually exit 1 on a clean feat checkout right now? If so, check feat's GitHub CI history the same way you did for b162wasm-c/front 228 (gh run list) — this could be the same shape of "red for a while, unreported" surprise. Report what you find; I'll decide from there whether it needs its own front or is already front 166/170 s5-6's known territory.

3. Hold on front 228 for now, once b162wasm-d lands. machine-2 is mid several active wat.zig changes (the shown<T> dispatch fix now, likely B-207's lambda-parameter GC-lowering fix next) — front 228 touching wat.zig's unit-emission logic at the same time as other live wat.zig work is exactly the collision shape that bit 1096 earlier today. Check with machine-2 (or ask me) for where her wat.zig work stands before you start reading/editing for 228 — sequence after, don't run it genuinely concurrent with her open wat.zig diffs.
