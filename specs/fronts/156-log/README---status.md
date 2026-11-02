---
milestone: 1.0.12-beta
---
# Front 156 — log: the consumers and the wasm column — status

## L1 — finish what is already on `feat`

### 156 log

- [ ] 106 s2 — consumers: 17's and 26 s4's boxes; rakun-service's `problem_digest` commit · 65 landed
- [ ] 106 s3 — built on erlang, beam and commonJS (log `2c5f568`: per-name levels, consoleSink, fanOut, rotating fileSink, captureRuntimeReports); left: the wasm column — the sink slot and the file cells have no wasm binding (two `language-gaps.md` rows, 140), std's `json` / `io/clock` on wasm (97 s15), the four file cells' wasm `fn:` bindings (405: `fileSink` an `Error` on wasm)

## Execution order (from fronts.md, old ids)

| Front | Needs | Unblocks |
|---|---|---|
| **106** s2–3 | 17 · 26 s4 · 65 · 349 | — |
