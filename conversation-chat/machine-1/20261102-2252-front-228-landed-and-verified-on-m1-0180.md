---
from: machine-1
to: maintainer
purpose: report
subject: Front 228 landed and verified on CI (430e8de30 / 8722d93b) — test-cli's level_b is green again
read: [x]
in-reply-to:
---

Front 228 s1 done. Root cause: `unitBoundary` in wat.zig registered a cached dependency unit from its *face* (every function its lowering exported — a generic `pick<T>` and `total` included, exported only through decision 1037's wrapper), and imported any face export whose type matched — while a unit emitted fresh in the same build only offers what `crossesUnit`/`memberCrosses` let cross. So `crowded@main.wasm` inlined `shelf@tools`'s `pick`/`total` under `--cold` and imported them on a cached build: the importer's bytes depended on cache-hit state, not the dependency's own closure (509 (3)).

Fix: `linkedCrosses(l, bare, member)` re-applies the same crossing rule to the linked module's own declarations before a cached-face import, so inline-vs-import is a pure function of the dependency's declarations either way. Bisected: introduced by d389b3a45 (2026-10-27 18:40, "wasm: units on for build, run, test…"); unreported because test-cli was already red before that commit on an unrelated rakun/await-component gap (decisions 791 (4), 822 — documented in language-gaps.md), so a new failure inside an already-red job changed no verdict, and the in-process analysis-equivalence twin never turned wasm units on so it couldn't catch it either. Fixed that too: its fixtures now compile with `build.wasm_units` set, so it's a real regression test for this going forward.

Landed: botopink-lang 430e8de30, meta 8722d93b. Checked CI directly (run 41560838314, job 125674474944): every level_b/closure-key check passes on all 4 targets now; the only test-cli failure is the exact same 21-failure/12-module rakun set as before (unchanged file list), confirming it's the pre-existing gap, not something this touched. Hook's own `--no-verify` was for that same pre-existing gap — user authorized fresh, per usual.

Told machine-2 (m1-0179): her 1096 regression (structref/arrayref GC type-index shift) is a different mechanism from this one (nothing about unit-boundary crossing), so not blocked on 228 anymore — she's clear to investigate independently.

Next: P-C (B-162 P1's own, after b162wasm-e/B-209 — wait, re-checking the queue: P-C was scoped to wait on b162wasm-e landing, not front 228). Confirming queue order before starting.
