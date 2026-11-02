---
milestone: 1.0.12-beta
---
# Front 144 — machine 1: the checker and the language (lane A, the module-model group) — status

## L1 — finish what is already on `feat`

### 144 — the module-model group (B-69 … B-76, B-55-a (e)): after the cache group's Conformance step and B-55's timings

- [ ] 144 B-69 — a file is a module: `mod` / `pub mod` and the root file removed; `src/internal/` private; an import cycle refused by name until B-71 · after the cache group's Conformance step, B-55
- [ ] 144 B-70 — `src/comptime/`, the build layer: analysed first, its own imports only; decorators and templates declared there · after B-69
- [ ] 144 B-71 — blocks: modules importing each other, headers before bodies, `dependency loop` · after B-70
- [ ] 144 B-72 — per block: decorators after the bodies, meta filled (592 (5), 728); no catalogue (665); 419, 14s8-d and 353's second compile go · after B-71
- [ ] 144 B-73 — commonJS: a module cycle loads (hoisted exports, memoised getters) · after B-71
- [ ] 144 B-74 — the language server checks the edited module's block · after B-72
- [ ] 144 B-75 — std and every library on the module model: root file and `mod` removed, decorators and templates in `src/comptime/` · after B-70
- [ ] 144 B-76 — the group's Conformance step · after B-69 … B-75
