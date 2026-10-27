---
milestone: 1.0.12-beta
---
# Front 169 — gate green: the whole gate passes again after the freeze's scoped landings

Opened by the maintainer, 2026-10-27: "depois vamos fazer uma frente só para deixar o gate verde". Taken after the freeze of 987 closes; free until then.

## Why

Decision 1041 lets every thread land on the tests and cells its change reaches, with `--no-verify`, and leaves the whole suite to `feat`'s pipeline. Reds the scoped runs did not reach can collect on `feat`. This front brings the whole gate back to green on every target.

## Steps

1. **Inventory**: run the whole gate once, on an empty pool, over `feat`: botopink-lang's `scripts/gate.sh` with conformance on machine 2, each library's gate, `scripts/gate.sh check`, and `feat`'s latest pipeline run. List every red with its repository, stage, cell or test, and target.
2. **Classify** each red: a defect, which gets a 144 / 164 row and its cell, red until fixed; a stale expected answer, re-recorded only where a decision states the answer; or a known red with a decision of its own (1002 (c)).
3. **Fix** the reds by area, one thread per area, each proving its reds green.
4. **Close**: the whole gate green twice in a row on `feat`, and its pipeline run green.


## Known reds

- `modules/compiler-cli/tests/analysis_equivalence.sh`: rakun-bpp and rakun-style modules fail to check (`await-component`, `import-of-failed-module`); from the library sources, not from the compiler commits that met it (m2-0114).
