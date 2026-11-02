---
milestone: 1.0.12-beta
---
# Front 163 — meta-ci: the meta repository's CI, the pointers, the specs' upkeep — status

## L3 — ready to open now

### 163 meta-ci (medium)

- [x] 163 s13 — a small gate may pass older full-pool waiters while the pool is busy, one pass in flight (`scripts/gate-test.sh`) — landed
- [ ] 141 (`10-specs`) — steps 0–5 done (`../decisions-taken.md`'s 26 amended rows stated as in force, the central files, tracks 04, 06–09, the examples; F10 for 384, 385); left: step 6, the rule that keeps the specs from drifting · `141-a`

## Done — landed on `feat`

### 163 meta-ci (medium)

- [x] 138 — the five new repositories carry Node 22 and the glibc 2.35 note (actions 5b78ce8, http fe75240, log 220cfe2, routing 7e6a24f, validation bf0610f); their first CI run reads after this push
- [x] 138 (decision 326) — actions, http, log, routing, validation are repository/<pkg> submodules (history kept); the compiler embeds std alone (botopink-lang 541336e3); rakun, jhonstart, onze declare them
- [x] 138 rest — doc comments say "shared library" where they said "bundled library" (jhonstart, onze, routing, validation; rakun's starter-web `root.bp:3` rewritten: `validation` is declared by rakun core, the starter lists it nowhere); emilia, erika, jhonstart and onze `test.yml` on Node 22 with the `fs.globSync` note; onze-cli `build.bp:165`'s two T7 warnings gone at their cause — the `extraDeps` list is built in place, no variable lends its name as a label (chores patches, land with the coordinator; jhonstart 204+15, onze-bundler 42, onze-cli 31, routing 82, validation 246 passed, 0 failed, on commonJS and erlang)
- [x] 138 rest, rakun — "shared library" doc comments in rakun's sources, the four formerly non-canonical files included (after 128)
