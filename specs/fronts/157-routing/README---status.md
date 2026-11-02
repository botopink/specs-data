---
milestone: 1.0.12-beta
---
# Front 157 — routing: Astro's routing in `segment.bp` / `conventions.bp` (117, routing's half) — status

## Done — landed on `feat`

### 157 routing

- [x] 102 s1–2 — `conventions.bp` and the segment helpers in `libs/routing` (re-implemented)
- [x] 102 s3 (W2) — consumers, one commit per member: rakun-app and rakun-hateoas (rakun de85b3d), jhonstart `routes.bp` (`#[page]` → `segment.paramNamesOf`, jhonstart 6b368ec), onze-cli, onze-bundler and onze (onze 3c25410; `classifyAppFile` and `patternOfSegment` gone) · decision 323

## Execution order (from fronts.md, old ids)

| Front | Needs | Unblocks |
|---|---|---|
| **117** | 102 · 22 · 49 · 50 · 121 s1–2 | 120 · 127 · 121 s6 · 124 |
