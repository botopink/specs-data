---
milestone: 1.0.12-beta
---
# Front 150 — rakun: the 16 members' fronts, middleware and typed actions — and, refiled by 165 s8, styled, jhonstart, dbcontext, emilia and onze — status

## L2 — the libraries' critical path

### 150 rakun

- [ ] 150 s25 — moved to front 170 (conformance-complete) s13

- [ ] rakun-messaging — one erlang test failed once in the pre-commit gate under load 26 (90 passed, 1 failed; the hook log did not name it) — not reproduced: 39 runs at c0e991c, 91 passed, 0 failed each, under load 21–74 (up to four copies of the suite side by side, rakun-websocket's beside them, CPU hogs) and once pinned to a third of one core; every runtime test ends in under 0.5 s against its 2–3 s bounds even starved, so no bound is near. Candidates left: the three fixed windows followed by a positive assertion (`ack: auto settles a Done once`, `ack: batch settles …`, 200 ms; `jms: a queue send reaches one of two …`, 300 ms) and the seven `build_test.bp` cells (a compiler run each, comptime `EVAL_TIMEOUT_MS` 10 s wall clock). The hook prints only the tail of a red member's log, so the next red names nothing either · the failing test's name (a red log kept whole)
- [ ] 103 — the action secret from rakun-app's `#[config("rakun.actions")]` record, not `rkProp` · rakun 04 s7 (299; no `#[config]` record in rakun yet)
- [ ] 130 ↔ 128 — 128 does not wait on 130; no 130 rakun commit while 128 is open; after it, each is a decision-188 consumer commit · decision 339
- [ ] rakun group A (W4–W5) — 04 (s1 the tag epoch on `feat`, rakun `d609f8c`; s2 on) · 74 · 08 (s1 after 04 s4) · 15 · 79 · 81 · 93 · 73 · 19 s1 · 128 landed
- [ ] rakun group B (W5–W7) — 13 · 12 (19 s1) · 22 (04 s5) · 17 (13 s2) · 11 (22) · 65 · 09 (19 s1, 13) · 91 (15) · 92 (74, 15) · the A step each names
- [ ] rakun group C (W8) — 88 (81, 93, 92, 04 s4, 73) · 19 s2–5 (15 s1, 04 s4) · group B
- [ ] rakun-websocket — `rakun_websocket.erl`'s `handshake/10` writes 101 before `run/4` registers the session, so a caller that reads the sessions right after the handshake can find none; register first, then answer 101 (a sidecar change, not a test bound) · 128 landed
- [ ] rakun-stylesheet on `rakun-style` first (decision 350) — 34 s5: the two text boxes and the class box done (367: `e_` + `contentHash` of the class's rules, fixture `e_f51c2501`, every reader re-recorded — not landed yet); boxes 1–3, 6 wait on 34-d (a family answering `StyledProperty` does not compile), box 4 on 34-e, 34-f and 119 s4, box 5 on rakun-stylesheet: `comptime className(…)` cannot evaluate on the comptime runtime (wasm alone since 434; `contentHash` at comptime, 01-compiler/14 s6/s8) — `className` still reaches `register`, which has no `.Wasm` cell (369's run-time API leaving) — the two toolchain rows (a nested-section enum value at comptime, rakun-stylesheet's dispatcher at comptime) landed in botopink-lang `856bbc69`, box 8 on box 1 — 119 s1's two open boxes (a component with no run-time hook computed at build; the theme mechanism, 300) → 34 s5 (rakun-stylesheet over `rakun-style`, output byte-identical) → 34 s2 (the five families in `styled`'s literal) · through 352 / 354 (registration by `use context(styledContext)` (722), 379), 134 s6 (box 4), box 5 on `01-compiler/130` s10 (353, row 134) — measured on `d7c71405`, see L5 (`css` done, `styled` landed)

## L3 — ready to open now

### 150 rakun

- [ ] 150 s29 — rakun's wrappers without `wrapWith` (144 B-11; 316 overtaken by 714): the publish-retry example as a function around the call (`retry(policy, { -> issue() })`), its marker and the gap row gone; the 318 wrappers as proxy types or functions around the call · nothing
- [x] 150 s28 — two consumer rows from 144: `rakun_runtime.erl`'s keyed counters to `counts.bump(k, n)` (B-26, 340) — no site, the registry's counters are the sidecar's own Erlang; `tryQuery`'s stale comment removed (B-13, 304)
- [ ] 150 s34 — `Sheet.add` over what `toStyled()` answers, a component (144 B-10 G2) · 144 B-162's call box (791)
- [ ] 27 s2 box 2 — `use linkStatus()` outside `#[client]` refused · 26 s8 (`#[clientOnly]`, `src/stage.bp`) on 01-checker s23 (`compiler.hooks`)
- [ ] 143 (398) — `dbcontext`, botopink's JPA (now `rakun-data`, over `query`): s0 done (`botopink/dbcontext` scaffolded, a submodule, since absorbed, 724); s1 entities and `DbContext` over a `Driver`, s2 `#[repository]` / `#[query "…"]` / `#[nativeQuery]`, s3 rakun-data over it · 137 s2 · 01-checker s29 · s3 after 128

## L4 — later

### 150 rakun

- [ ] 123 (W7) — `locals`, `sequence`, `actionContext` · 04 · 65 (s1 box 3: 08-j closed → 295/296, `use local(atom)`, the store `rakun-cardume`'s)
- [ ] 127 (W10) — actions typed by a schema · 125 s6 · 103 · 22 · 67 · 49 · 117 · 120 · 126 · s4: 123
- [ ] 118 (W1) — the template language, tag annotations (278), `prelude.bp`, the node type: what it builds alone is done (s0–6's parts, 351's html-side rules, 338's `<style>` refusal); left, each on another front: s1's component spread (359) — the record spread landed (144 B-14), s1 open now; s4's slots (360) and s5's 302 arm · 130 s9 (a tag's declaration handle); s6's `-> View` and the `Component` alias · 01-checker (`-> View` erased, 852); `compiler.custom(ast)` (576 (4)) for the LSP snapshot · 01-compiler/26; native props · 26 s13 (362). 26 s0 and 119 s2 need nothing more of it; ctr-r closed: 118 goes first, org-3 holds
- [ ] 27 s1 box 2 (W7) — the route-kind flag read · 22
- [ ] 67 (W4) — the DOM-side forms boxes, the wire names handed in · 26 · 103 s2 · 67-a (only the record) (s4 needs only 103 s2)
- [ ] 119 s2–5 (W3) — `rakun-style`: the style section, `use`, run-time holes, `#[styled(..)]`, the one sheet; rakun-stylesheet the one package (338) · s1 · s2: 118, 26 · s5: 34 s5
- [ ] 120 (W8) — hydration strategies as `#[client…]` / `#[serverDefer]` annotations (278), server islands · 118 · s1: 26 s8 (`clientOnly`) · 119 · 117 · 26 · 22 · 49 · 50
- [ ] 122 (W9) — page-side status and headers, `rewrite`, `site` · 26 · 49 · 102 · 118 · 120
- [ ] 126 (W9) — view transitions, `#[transition…]` annotations (278) · 27 · 118 · 120
- [ ] 34 s3 — Tailwind's theme values over `styled`'s mechanism (338); the theme always declared (358) · 119 s1 · 34 s5
- [ ] 150 s70 — rakun-ssr's content field marker as a type decorator over `decl.fields` (306; 144 B-10 G5) · nothing
- [ ] 49 s2–5 (W3 → W7) — query, headers, dispatcher; the digest's sink; the public root; the dynamic mark · 102 s3 · s3: 26 s4 + 17 · s4: 65 s1 · s5: 22 s4 · 49-e
- [ ] 50 s2–7, s9 (W3 → W8) — `dev`, `prerender/`, the signal, the `rakun-ssr` CLI, the bundler tail, the defaults table; the `@/` alias gone (218) · 102 s3 · s2: 50-b · s4, s7: 506 · s5: 71 s2 · s6: 27 s1
- [ ] 51 s2–6 (W7) — single flight and the route, the prop table, the metrics generator, the OG defaults · 22 · s4: 52-a
- [ ] 71 s1–2 (W3) · s3–4 (W7) · s5 (W10) — ERTS copy and the `rakun-ssr` CLI; shutdown over real cells and static export; the four gate boxes over the blog · 49 s6 · s3: 11, 04, 81 · s4: 22 · s5: 50, 53
- [ ] 53 (W8) — the blog's `alias` gone, the acceptance script's second half, the browser · 49 · 50 · 51 · 71 s1–4 · 26 · 27 · 67 · 22 · 12 · 65 · 135 s5 (the runner) · s6: 50-b
- [ ] 117 (W7) — `.bpp` / `.md` app files, `staticPaths`, `paginate`, partials · 102 · 22 · 49 · 50 · 121 s1–2 · s1: 293
- [ ] 121 s3–6 (W9) · s7 (W10) — frontmatter, collections, references and RSS, `.md` pages; the blog reads Markdown · s3: 142 s2 (396's `yaml`) · s6: 118, 117 · s7: 53
- [ ] 124 s1–4 (W10) · s5 (W11) — the commands, the config keys, the `.bpp` scaffold (08-h closed → 285, 224) · every other 08 front · s5: 116, 53
- [ ] 135 s5 (W7) — rakun-ssr: the E2E runner (five harness functions), the release tree as a path table, 107's README names the two snapshots · 390, 391 (s0 first) · before 53 s2–6

## Done — landed on `feat`

### 150 rakun

- [x] 128 (W3) — the nine merges, alone in rakun: 25 members → 16, 1 819 tests before and after, every starter and example building (rakun `00d4fcc`…`343a55c`, eleven commits)
- [x] rakun-websocket `test/limits_test.bp:48` — the 1013 test read `rkWsSessionIds()` before the connection had registered its session (101 is written before `run/4` inserts the row: 19 of 200 handshakes under load 31 found none, so every frame went to no one and the close code was 0), then slept 3 s for the close; it now waits on the session's row and on its close-log entry (test-side Erlang helpers; chores patch, rakun test file only, rebase after 128) — 7 runs green under load 20–37 beside rakun-messaging's suite
- [x] rakun track — removed the workarounds the compiler made deletable (patches in review: each repro green on the pinned compiler; rakun-data 181, rakun-messaging 131): rakun-data `rows.bp`'s `longOf` (C2 fixed), `runtime.bp`'s row-89 named fn (row 28 fixed), `orm_host.bp` → `src/orm/host.bp` (26 s2) · `04-rakun` RX-14
- [x] rakun track — latent `i32` clocks widened to `i64` (rakun 442, actuator 103, data 181, mail 32, messaging 131): `migration_host.cellNowMs`, the test-only monotonic `nowMs` in `rakun-mail`, `rakun-rsocket` and `tls_listener_test`, `Duration.millis` · `04-rakun` RX-15
- [x] rakun track — stale `__rkMake_` text in rakun's `AGENTS.md` · `04-rakun` RX-16
- [x] rakun track — the server test measures `Content-Length` in bytes (320's follow-up) · `04-rakun` RX-17
- [x] 162 s11 — onze-cli's CSS accessors test creates its app as `cssapp`, not `styled` (a package of jhonstart's closure); onze-cli's tests green on commonJS and erlang (from 144 B-80)
- [x] 114 — onze-cli `start_test.bp` asks the OS for each server's port (`freePort`, a listener on port 0) instead of 43101/43102; both cells green run side by side (onze-wave patch 05, lands with the coordinator)
- [x] 121 s1–2 — Markdown to `Element` in `onze-content` (onze `584f64a`, on `feat`): 714 / 714 on both rows at onze `05b7005`
- [x] 49 s1 · s6 — `config.bp` / `types.bp`'s `Type` (the utilities) and `compiler.bp`'s `Field<T>` / `Info<T>` (624, 630) on std's `Json` methods (`isString` stays — `49-g`); the six `onze-test` group stubs (onze-wave patch 02)
- [x] 50 s1 — `onze-cli` / `onze-bundler` read std's `Json` methods; no local `membersOf` / `itemsOf` / `textOf` (onze-wave patch 03)
- [x] 51 s1 — `onze-og` reads integers with std's `parseInt`; no `intOf` (malformed text still `0` — `51-a`) (onze-wave patch 04)
- [x] 27 s1 box 1 · s2 boxes 1, 3 · s3 — the reconcile driver (`applyTransition` over `DomOps`, question 27-b ★), `use linkStatus()` in a `#[client]` component (363), `data-rakun-pending`, the example (jhonstart `b25e959`)
- [x] 33 s2 — `emilia-card` emilia-only, the fifteen example READMEs (s1, s3, s4 are 135's)

## Execution order (from fronts.md, old ids)

| Front | Needs | Unblocks |
|---|---|---|
| **103** s1 | done (re-implemented in `repository/actions`) | 103 s2 · 127 |
| **103** s2 | s1 | 128 · 22 · 67 · 127 |
| **04** | 128 | 13 · 12 (s1) · 22 (s5) · 08 s1 · 19 s2–5 · 88 (s4) · 123 · 104 s5 · 71 s3 |
| **74** | 128 | 92 |
| **08** | 128 · s1: 04 s4 · s7: 137 s1–5, 01-checker s29 | — |
| **15** | 128 · s5: 03r-al | 19 s2–5 · 91 · 92 |
| **79** | 128 · s3: 03r-ae | 104 s5 |
| **81** | 128 · s3: 03r-ak | 88 · 107 · 71 s3 |
| **93** | 128 | 88 |
| **73** | 128 · s3: 03r-af | 88 |
| **19** s1 | 128 | 12 · 09 |
| **19** s2–5 | 15 s1 · 04 s4 · s3–4: 03r-am | 104 s5 |
| **13** | 04 s1 | 17 · 09 |
| **17** | 128 · 13 s2 | 49 s3 · 106 s2 |
| **22** | 04 s5 · 102 s3 / 103 s2's `rakun-app` commits · s4: decision 186 | 11 · 49 s5 · 51 · 53 · 27 s1 box 2 · 71 s4 · 117 · 120 · 127 · 104 s5 · 105 |
| **12** | 19 s1 · 04 s1 | 53 · 104 s5 |
| **11** | 128 · 22 (R11-7) | 71 s3 |
| **65** | 128 · s1: decision 201 | 49 s4 · 53 · 123 · 104 s5 · 106 s2 |
| **09** | 19 s1 · 13 · s4: erk-b · s5: 03r-ab | — |
| **12** s5 | 01-checker s30 | — |
| **91** | 15 · decision 274 | — |
| **92** | 74 · 15 · s2: 03r-an | 88 |
| **88** | 81 · 93 · 92 · 04 s4 · 73 | — |
| **123** | 04 · 65 | 127 s4 · 104 s5 |
| **127** | 125 s6 · 103 · 22 · 67 · 49 · 117 · 120 · 126 · s4: 123 | 124 |
