---
milestone: 1.0.12-beta
date: |-
  2026-10-11 (reorganized by repository, decision 433; the conformance order, decisions 457–480) · **Base** (each repository's `feat`): botopink-lang `11bde540` (135 s0: the snap library — 391, 402, 407) · rakun `d609f8c` · jhonstart `50514f1` · emilia `9c3e24a`
  · onze `783af40` · erika `8f88482` · vscode-extension `f041865`
---
# Order

**Fronts with open work:** 20, in three tiers (decision 433) — the old tracks' 72 fronts keep their numbers
and `## Done`; their open steps live in the fronts below. **144 B-00 (434) is done but for its last box, the seventh step of the
conformance order (L1, [`fronts.md`](order.md) § Execution order).** **New development is centred on front 164 wasm-gc — s1 (wasmtime) → s2 (WasmGC) → s3 (std-wasm in botopink and `.wat`) → s4 — the second front that edits botopink-lang (the maintainer, 2026-10-14; amends 433).**

| Tier | Partial | Not started | No open step left |
|---|---|---|---|
| Maximum | 144 botopink-lang (B-00 done but its last box) | 164 wasm-gc (machine 2: s1 wasmtime → s2 WasmGC → s3 std-wasm in botopink and `.wat` → s4) — where new development is centred | — |
| High | 145 query · 146 validation · 150 rakun (with the open steps of the former 148 styled, 149 jhonstart, 153 dbcontext, 154 emilia, 162 onze: s32 … s71) · 155 http · 156 log · 158 markdown | **165 rakun-workspace** (opens now, 2026-10-14: rakun, erika, emilia, styled, jhonstart, onze, dbcontext into one `rakun` workspace of 17 plug-and-play packages, erika outside as `query`; 150 pauses until its s1) · 151 json · 152 yaml · 157 routing · 161 vscode-extension | 147 css · 159 actions · 160 snap (consumer commits only) |
| Medium | 163 meta-ci · 135 snap (coordination) | 136 cardume · 105 i18n · 107 release · 98 packaging tail | — |

**Gate:** `scripts/gate.sh --cold` green on botopink-lang `576c8d17` (batch 3: every stage; test-libs
123 passed, 0 failed; language tests 2431 passed, 0 failed) — 7m54s wall against the 7m30s budget
under load 16–20, so 114 step 7 (≤ 450 s on an idle machine) stays open, measured in 163 s9. botopink-lang's
GitHub CI still owes a green run on `feat` (114 step 3).

Each line: `front/step — what is left · blocker`. Lanes: **L1** finish what is on `feat` · **L2**
the libraries' critical path · **L3** ready to open now · **L4** later, in the order of
[`fronts.md`](order.md) § Execution order · **L5** blocked on a decision · **Done** landed on `feat`. A lane
holds only open lines (`- [ ]`); a line that lands moves to Done in the landing commit. Inside a lane the lines are
grouped by tier and front (433); a line keeps its old id, which the front's alias table resolves.

## Execution order

0. **The conformance order — worked now, in this order.** 144's B-00 group (comptime on wasm, 434) is done but
   for its last box, the seventh step below.
   1. the step gate (decision 460, 144 B-29 step G) — landed;
   2. the commit hook's `scripts/gate.sh --no-conformance` (470, step I's first box) — landed;
   3. `botopink cell new` / `check` (464, 475) — landed; and 144 B-29 step H2 (step H's rest: `tests/language/`
      becoming `conformance/`, every cell in decision 457's shape with its own `botopink.json`) — in flight;
   4. 144 B-29 step I's rest: the reference into `conformance/`, `test.yml` calling `scripts/gate.sh` (461, 462, 466);
   5. 163 s7: `scripts/gate.sh` in every repository, the meta one the scheduler (463, 466, 469, 473);
   6. each library moves its `docs.md` and examples into `<lib>/conformance/` (the `conformance` steps of 145 and
      150 — 150 s46 and s69);
   7. closing B-00: B-00c's last box, each library's own hook on this compiler — `scripts/gate.sh libs` (473);
   8. 163 s8: each library's CI fetches its dependencies (474);
   9. 163 s9: the measurements, at the end, on a quiet machine — no step before it spends time measuring.
   Beside it, **144's cache group (B-57 … B-64, decisions 508–513)**, worked now: the libraries' gates are slow
   for want of it, and every later step's commit pays that time.
   After the cache group's Conformance step, **144's module-model group (B-69 … B-76, B-55-a (e))** continues it.
   144's steps paused on 2026-10-12 — B-24's Conformance step, B-39, B-41, B-43, B-51, B-52 — resume
   after the cache group's Conformance step.
1. **144 B-00 — comptime on wasm (434), first and alone.** Done but for the seventh step above; the fronts in
   flight when 434 was taken have landed (checker-s41, checker-s29, render-scope-388, bigint-139, comptime-14,
   import-129, typed-member-395's compiler half; its validation half waits in 146 s1 on B-10 G1).
2. **144's lanes**, in its README's order: the error contract (B-01–B-09), then the structural fixes the
   libraries wait on (B-10–B-19), then the rest (B-20–B-29). Lane A (checker) is serial; lanes B and C run
   beside it on disjoint files.
3. **The library fronts, in this order**, each opening when the 144 steps it names have landed: 145 query
   (B-18) · 146 validation (B-10 G1, B-16) · 147 css · 150 rakun, in its lanes by layer — data (150 s48 … s51, after
   145 s1), service and its optionals (waves A → B → C, then 123, 127; B-11, B-12, B-13, B-19), style / bpp /
   stylesheet (150 s32 … s58: B-10 G2, B-14, B-15, B-17; styled's 150 s32 before emilia's 150 s52), app / ssr last
   (150 s59 … s71; 150 s67 needs every other front) · 151 json (B-27) · 152 yaml · 155 http · 156 log (B-25) ·
   157 routing · 158 markdown · 159 actions · 160 snap · 161 vscode-extension (B-27).
4. **The medium tier**: 136 cardume (150's jhonstart section, 150 s41, 146), 105 i18n (155 s2), 107 release (`07-g`, 150 s7, 150
   s62), 163 meta-ci (s2 last), 98's closing check, 135's order; a decision-blocked step stays in its front
   and waits in `status.md`'s L5.

At most six worktrees at once; a front whose prerequisites have landed may take a thread freed early. The
chains that set the pace: B-00 → B-14 → 150 s39 (118) → s36 (26) → s38 (67) → 150 s23 (127); B-15 → 150 s40 (119) → s41 (120)
→ s43 (126); B-18 → 145 s1 → 150 s48 (153); 150 s1 (04) → s13 (22) → 150 s59 (49) → s67 (53).

### Dependency graph (old ids)

The graph inside the library tier, written with the old front ids; each resolves through the new READMEs'
alias tables (137 → 145 s1, 26 → 150 s36, 04 → 150 s1, …). Compiler steps are 144's.

| Front | Needs | Unblocks |
|---|---|---|
| **102** s1–2 | done (re-implemented in `repository/routing`) | 102 s3 · 117 · 122 |
| **102** s3 | s1–2 · 323 | 128 · 22 · 26 · 49 · 50 · 117 · 124 |
| **128** | the rakun commits of 102 s3 and 103 s2 · the 130 rule (339) | every rakun front |
| **143** | 137 s2 · 01-checker s29 · s3: 128 | 08 s7 |
| **27** | s1 box 2: 22 | 50 s6 · 126 · 53 |
| **67** | 26 · 103 s2 · 67-a | 53 · 127 |
| **136** | 26 · 120 · 125 · atm-c · s8: atm-d | 123 (locals) · 127 · 53 |
| **34** | s5 (first, 350): 119 s1 · s2: s5 · s3: 119 s1 · s4: none (401) | 135 s4 · 119 s5 |
| **33** s2 | — | 98 |
| **49** | 102 s3's `types.bp` (s2–s5; s1 and s6 open now) · s3: 26 s4, 17 · s4: 65 s1 · s5: 22 s4 · 49-e | 50 · 51 · 71 · 53 · 117 · 120 · 122 · 127 · 104 s5 |
| **50** | 102 s3's `scan.bp`, `chunk.bp` (s2–s7) · 49 s6 · s2: 50-b · s4, s7: std-d · s5: 71 s2 · s6: 27 s1 | 53 · 117 · 120 · 124 · 71 s5 |
| **51** | 49 s6 · s2, s5: 22 · s4: 52-a | 53 · 104 s5 |
| **71** s1–2 | 49 s6 | 50 s5 · 53 · 124 |
| **71** s3 · s4 | s3: 11, 04, 81 · s4: 22 | 53 · 107 |
| **71** s5 | 50 · 53 | — |
| **53** | 49 · 50 · 51 · 71 s1–4 · 26 · 27 · 67 · 22 · 12 · 65 · 135 s5 (s2–6) · s6: 50-b | 71 s5 · 121 s7 · 124 s5 · 120's and 126's browser boxes |
| **118** | s1's component spread: `01-checker` s34 (359) · s4: slots (360) | 26 · 119 · 120 · 126 · 121 s6 · 116 |
| **121** s1–2 · s3–6 · s7 | — · s3: 08-f, s6: 118, 117 · 53 | 117 · 124 |
| **119** | s1: the two repositories' first `feat` commit · s2: 118, 26 · s5: 34 s5 | 120 · 34 s5 (first, 350), s3 · 116 s6 (the style section's examples) |
| **120** | 118 · 119 · 117 · 26 · 22 · 49 · 50 | 122 · 126 · 127 · 124 |
| **122** | 26 · 49 · 102 · 118 · 120 | 124 |
| **126** | 27 · 118 · 120 | 127 · 124 |
| **124** | 50 · 71 · every other `08` front · s5: 116, 53 | — |
| **135** | s0: `botopink/snap` created (391) · s4: 34 · s1–4: s0 and the owning fronts' other steps | s5: 53 s2–6 |

## L1 — finish what is already on `feat`

### First — the conformance order ([`fronts.md`](order.md) § Execution order), and B-00's close

In order; the step gate (460, B-29 step G) and the hook's `--no-conformance` (470) have landed (Done).

- [x] 144 B-29 steps G, I, J landed; step H's last tail moved to front 170 (conformance-complete) s1
- [ ] 163 s8's last two boxes and 163 s9 — moved to front 170 (conformance-complete) s2, s3
- [ ] 163 s6 — a language tour (`botopink/tour`) generated from `botopink-lang/conformance/`, nothing duplicated · after 144 B-29 step I

### Second — the builtins group (decision 575): B-136 … B-140 and 165 s10, before every other open step (the maintainer, 2026-10-17)

In order across the two machines (144 README § Machines rule 9); nothing else new opens until B-140 lands.

- [ ] 144 B-137 — `compiler.init` (`compile` renamed, 615): a decorator's run-time code in the program's init list on every target; `compiler.name -> ?string`, `null` for a nameless expression (643, reversing 612); `decl` in an executor the declaration as code on every kind (613); `compiler.*` inside an executor folded at build, `syntax-captures-build` withdrawn (614); `expr` renamed `syntax`, `compiler.bp` with every arrival written (616); `@emit` / `@code` / `@expr` removed in B-139 (605) · landed: `init` and its cells on four targets, the 409 check, the init order (580), the typed handle (581 (2)), 612–616, `compiler.find` (581 (3)); open: `Declared<T>` / the run-time `@TypeInfo.all` removed (576 (7), (15)) after B-139 box 2 — machine 2
- [ ] 144 B-138 — `external` as one function over `Implementation` (`compiler.external`, 606), the `body:` cell with its three refusals (610), only `template` positional (621), `Node` → `JavaScript`, no `Typescript` in `Implementation`, `.d.ts` by `"typings": true` in `botopink.json` or `--typescript` (618–620), `declare-without-implementation`, the backends read `Implementation` alone, `print` by its cells · landed (610, 618–621 included) but 617 (with B-146), the cell `print_bound_by_cells` with `print`'s move to `io/terminal.bp` (B-139), the wasm half (164 s3) and the `.d.bp` / `types.bp`'s `Type` (the utilities) and `compiler.bp`'s `Field<T>` / `Info<T>` (624, 630) exemptions (B-139, B-140); the libraries' codemod is 165 s10's — machine 2
- [ ] 165 s10 — landed: rakun and query on B-136's and B-138's spelling, every `@emit` replaced (605), `rakun.d.bp` deleted, the templates parse their own holes; left: rakun-bpp's routes and the run-time `@TypeInfo.all` sites, with B-137's final package · B-137
- [ ] 144 B-139 — no `.d.bp`; no `#[builtin]` / `@name` (606): the prelude types and behaviors into `primitives.bp`, `print` in `io.terminal` and `panic` in `failure` imported, `typeInfo` / `embed` / `external` members of `compiler` (`embed` the link only, `Asset` in `asset.bp` over `io.fs`, 607), `compiler.Info<T>` in `types.bp`'s `Type` (the utilities) and `compiler.bp`'s `Field<T>` / `Info<T>` (624, 630), `println` / `todo` / `debug` / `src` removed, the codemod over the cells and the libraries; every builtin in its std module with its body, `compiler.bp` first and no `reflection.bp` / `result.bp` (608, 609); the removed builtins, `@emit` / `@code` / `@expr` gone with the file (605); nothing inside it waits on the maintainer · B-138, 165 s10 — machine 2 · first part landed (`@name` refused; `print` / `panic` imported; `#[compiler.external]`; the codemod over the cells and std; every library red until its own codemod run)
- [ ] 144 B-140 — `Type` in botopink in `types.bp`, its records `compiler.Field<T>` / `compiler.Info<T>` in `compiler.bp` (624, 630): `compiler.Field<T>(name, type, annotations)`, `compiler.buildType` / `fields` / `optional` / `required` · B-139 — machine 1
- [ ] 144 B-147 — erlang / beam / wasm defects: closed — run-time `Source(file, line, col)` on every target, wasm generic `R[]` of string / bool, wasm generic `?T` / `T` record answer, wasm narrowed optional fn call; left: the beam `for` lambda loop (not reproduced without rakun), wasm `e is fn() -> T` then `e()` (not reproduced), wasm generic method `-> ?T`, wasm `i32[]` printed as a pointer (not reproduced); new: a labelled `Holder(owner: Book, …)` over a run-time `type<T>` field breaks on erlang / beam / wasm
- [ ] 144 B-148 — the primitive widths are types, a behavior a contract with no cell: landed — `pub type i32 implement Signed`, the six empty behaviors and the four backends' chains gone (617), `Pair` / `Function` gone and `functions.bp` (738), a behavior's statics written `fn` with `default-on-static` (628), 639, `abs` per width (496), `external-on-behavior` with the numeric contracts' cells on the widths (617 (2), (3)); 799's contract for a primitive (`primitive_member_by_contract`); 800's `implement-signature-differs` on every member, 641's lowercase dissolution (`primitive_static_on_type`, `primitive_contract_dissolved`; every library respelled; questions 641-a … d); left: `implement-with-body` (641 landed); 871, 872 / 886, 873 landed · before B-140 — machine 2
- [ ] 144 B-149 — no code from text (625): the `Node` records in `compiler.bp`, `compiler.ast(node) -> anyvalue`, `compiler.build` removed, `buildType(name, fields)` and `buildTypeInline(fields)` (629); the std bodies (`Type.*`, `mocks.bp`) and the 113 template cells · after B-137's tail — machine 2; then 165 s11 (rakun-bpp's and rakun-style's generators) — machine 1 · P1 landed (the `Node` records, `compiler.ast`, `Syntax(e)`, since removed, 802); P1b waits on b149-m
- [x] 144 B-145 (part) — `#[name]` naming no decorator refused `annotation-not-a-decorator` (`annotation_not_decorator_{unbound,namespace,value}`), dotted paths through a namespace resolved (`annotation_dotted_through_mod`, `_through_import`, `_missing_in_import`); left: a missing segment through a `pub mod`
- [x] 144 B-150 — wasm: a type's method as a record-constructor argument resolves to the module's same-named `fn` (`init_executor_handle_not_module_name`) — landed
- [x] 144 B-151 — wasm: a namespace import of a std module (`import {io.terminal}`) links only what the program reaches — landed
- [ ] 144 B-155 — backend defects found by 166 s3's drafts: wasm comptime `Context used before it is bound` (css 594), wasm `?.name` receiver type unknown (actions 330), a module-qualified comptime call (markdown, http 594), erlang `?.` method on a `Dict` field (routing 330) · the comptime and erlang boxes landed; the two wasm boxes not reproduced alone; two new boxes (wasm `?.at`, beam `?.` over a lambda parameter); the wasm null rows landed (a `null` into a typed lambda parameter, `?.length()` on an absent `?R` local); two rows filed (beam `?.length()` over a present optional array, wasm `f?.(3)`); beam `?.length()` over a present optional array landed; two rows filed (commonJS untyped lambda `?.length()`, wasm typed lambda `null` → `8`); wasm `f?.(3)` on a lambda parameter landed — machine 2

### Across fronts — a decision's sites in several fronts

- [ ] decision 281 (references, not strings) — rakun 04 s6, 08 s4, 12 s4 · 130 s7 · 125 s11 · 120 s6 · 127 s5 · 126 s4 · 26 s9 · 53 s7 · each after 01-checker s24
- [ ] decision 282 (a role in the decorator) — 117 s6 · 53 s8 · 51 s8 · 121 s8 · after 01-checker s24
- [ ] decision 285 (the toolchain knows `bpp`, `html`, the prelude) — 116 s2 · 117 s1 · rakun 22 s7 · 26 s10
- [ ] decision 290 (no segment config; `revalidate`, `dynamicParams` in `#[page]`) — rakun 22 s8 · 26 s10 · 53 s9
- [ ] decision 291 (`use request()` / `use response()`; no `isPrerendered`) — 122 s1, s3 · 26 s8, s10 · 120 s4
- [ ] decision 292 (`#[reload]`, `#[history]`, navigation hooks, `ScriptStrategy`) — 126 s1–2 · 50 s10
- [ ] decision 293 (`use params<P>()`, `use pageData<D>()`; no page parameter) — 26 s11 · 01-checker s23 (type args) · 117 s7 · 53 s10 · 120 s7 · 121 s9 · 122 s4 · 123 s5
- [ ] decision 294 (`Cookie<T>` declared once; `use cookieValue(decl)`, `cookieSetter`) — 104 s6 · 26 s12 · 123 · 127 · 53
- [ ] decision 295 (atoms: cardume's `Atom<T>` (296), `use local` / `use atomSetter`; middleware `Component<Response>`, the request the root context `RequestContext` (354)) — 104 s6 · 123 s7 · 127 · 26 s12 · 53
- [ ] decision 298 (typed meta keyed by type: `setMeta(v)`, `meta(T)`) — 130 s8 built (botopink-lang `856bbc69`: `setMeta(v)` / `addMeta(v)`, `meta(T)` / `metaAll(T)`, code fields written `T` (576 (12)); 385 — a code field read elsewhere — and 395 — a typed member reading its type's meta — on feat, botopink-lang `9bfbed18`); left: the libraries' migration, the string form's removal · 26 s8 · rakun 08
- [ ] decision 299 (`#[config("…")]` typed records; 03r-b reversed) — rakun 04 s7 · 08 · 13 · 15 · 88
- [ ] decision 300 (typed theme entries, one `#[theme]`; the mechanism `rakun-style`'s, the values rakun-stylesheet's — 338) — 119 s1 · 34 s3
- [ ] decision 301 (`#[styled(..)]`, `rakun-style`'s since 338; rakun-stylesheet's tokens through `#[stylesheet(..)]` since 369) — 119 s4 · 53 s12 · after 34 s1 for the build-time sheet
- [ ] decision 338 (CSS in three layers — the repositories `css` and `styled`, rakun-stylesheet over `rakun-style`; `rakun-style`, `use` of a scoped style; `"bpp": "rakun-bpp"` (361 (4)); the header with no opening `---` and one `--- style ---` section; `rakun-stylesheet` the one package) — 119 s1–5 · 116 s1, s2, s5, s6 · 34 s3, s5 · 124 (scaffold manifest)
- [ ] decision 354 (`Component<R>`; contexts — `Context<T>`, `use provide` / `use context`, only in a render tree, checked at build through `compiler.hooks`, stage markers, the island seam, the `Scope` of 809; answers 134-f) — 134 s6 · 01-checker · 02–05 · 18 · codemod · 26 · rakun 128 · 119 s1 box 4 · 120 · 34 s5
- [ ] decision 357 (rules of hooks: `use` only at a `Component` body's top level — never in `if`, a loop, a lambda, `try`, after an early return; every `use` runs on every call, its arguments always given) — 134 s6 · 01-checker · 24 (guide § use) · every library body with a `use`
- [ ] decision 359 (spread: `Pessoa(..old, nome: n)` and `<Card {..p} featured />` (`...` refused, 529 (3), 864), the source any record whose fields match (629 (3)), left to right, complete at build) — the record half landed (144 B-14: parser, formatter, checker, the four targets, five cells); its Conformance step: three spread defects fixed, eleven cells, the table; left: the tag half · 118 s1; questions B-14-a, B-14-b, B-14-c (144 B-14)
- [ ] decision 360 (slots as Astro's: `<Slot />`, `<Slot name="x">fallback</Slot>`, a child `#[slot("x")]`, transfer, `use hasSlot("x")`, `Slot` / `slot` rakun-bpp functions with `comptime` parameters (302); never props; 193's `children` field goes) — 118 s4 · 130 s9 · 26 (`Slot`, `hasSlot`, prelude) · 01-checker · 120
- [ ] decision 361 (std's module `bpp`: `#[bpp.html]`, `#[bpp.htmlPrelude]`, `#[bpp.style]`, `#[bpp.stylePrelude]`; `jhonstart-styled` merged into the core; `"bpp": "rakun-bpp"`) — 116 s1 (the std module, the manifest, the roles) · 119 s2–5 (in the core) · 26 · onze · 124
- [ ] decision 362 (26 rewrites the native builders into props form in place, with the 78 hand-written callers; no second builder per tag) — 26 s13 · after 26 s0, 01-checker s28 and the props-filling lowering
- [ ] decision 363 (a browser-only cell is `#[clientOnly]`, no erlang twin; a server `Link` styled by `data-rakun-pending`) — 27 s1–3 · 26 (island cells) · 120 · 126
- [ ] decision 365 (a deferred `after()` failure through the core's logger is 17's step 4, not 128's) — rakun 17 s4 · after 128
- [ ] decisions 388, 389, 414 (a `Component` at run time is a lambda over an opaque `Scope` (809), `(scope, key)` (819), the render library runs it — replaces 354 (8), 374, 387; a component named as a value is a reached node, a value the checker cannot follow an edge with `callee: null`; boundaries and fills are nodes the renderer runs with the scope) — 134 s6 measurement and box 4b, 01-checker s23's 389 box and `05-jhonstart/26` step 14 landed as one change set (botopink-lang and rakun-bpp; erlang, beam, commonJS green, wasm refused at the first component — 354-wasm; rakun-bpp 208 / 0 on both rows); left: the other lowerings and wasm · 02–05, 18 · 119 s2–3
- [ ] decision 375 (`HookNode.async`; commonJS emits a synchronous component as a plain `function`) — 01-checker s23 and 04-js s12 (top-level functions): landed; `s23-j` is decision 725, `04s12-a` 593
- [ ] decision 302 (a tag's annotation = a decorator over `syntax decl`, no return, meta) — 130 s9 · 118 s5 · 119 · 120 · 126
- [ ] decision 303 (an action answers `Result<T, ActionError>`; no `ActionOutcome`) — 127 s1–s3
- [ ] decision 304 (a store answers `Result<T, StoreError>`; no `try*` twin, no raise) — rakun 08 s6 · 09 s6 · 65 s4
- [ ] decisions 311–313 (`declare fn` in a `type` is host-only; the template annotation `` #[f @`…`] `` (577); query queries a database — `from User`, holes bound, `limit 1` against `?T`; a repository is `#[repository] behavior` with `` #[query @`…`] `` (kept, 313) or `#[nativeQuery("…")]`) — 01-checker s29: the template annotation landed ( parser, checker, holes, `decl.params`, a method's typed meta read by its owner — `s29-a`/`s29-b` ★; `run/template_annotation`, `modules/template_annotation_imported`, five `reject/` cells; 425: a template call expands in a method body, a destructuring initializer, a field or parameter default — six `run/template_in_*` cells), the template method (397, 415) open · 16 s9 (the list form waits on box 1) · 137 · rakun 08 s7 · 130 s5
- [ ] decision 308 (`Field<T>` is `compiler.Field<T>` in std; `Type.keys(T)` and a field key at run time are gone, 599 (1), (2)) — 01-checker s24, s28 · 134 s2
- [ ] decision 307 (a derived type is a comptime function answering a new type: `pub val RecipeTitle = Type.pick(Recipe, .title);`, `Type` in std) — 01-checker s28 · 134 s2 · 125 s5
- [ ] decision 306 (`#[schema]` becomes `#[validated]`, the type is the only public schema; `Schema<T>` private; value-only forms become field markers) — 125 s12 · 121 s10 · 117 s8 · 127 s5

## L2 — the libraries' critical path

## L3 — ready to open now

### 151 json · 152 yaml · 158 markdown

- [ ] 142 (396) — `json`, `yaml`, `markdown`, one repository each: s0 done (the three repositories scaffolded, submodules), s1 std's `json.bp` out with the six consumers' imports, s2 `yaml` (rakun's reader its seed; 121 s3), s3 `markdown` (reader moved, tree of its own, rakun-ssr's content maps it to `Element` — patches await landing; open: the page's own component per node) · s1–2's rakun commits after 128

## L4 — later

The `(W<n>)` marks are the old waves, kept as relative order; the order in force is [`fronts.md`](order.md) § Execution order.

- [ ] 164 cli — a new library repository `botopink/cli` (decision 506): typed commands, style and prompts over std's new CLI primitives (144 B-27); the repository and its front open after the 144 front · after 144 B-27

### Across fronts — a decision's sites in several fronts

- [ ] decision 321 (qualified beans: `#[qualifier("label")]`, `ctx.resolveNamed(Type, "label")`, `resolveNamed(Type)` the primary, labels checked at build) — 130 s5 · rakun 04 s6
- [ ] decision 320 (string index: codepoints on every target; erlang leaves `string:length/1`; commonJS native when no surrogate pair) — 97 s14 boxes 2–3 (04-js s10, 02-erlang s15 done)
- [ ] decision 319 (`i64` is 64-bit on every target; commonJS a number below 2^53, a `BigInt` above; literal refused past the type's range everywhere; 176, 264 amended) — 04-js s9's rest · 01-checker s18 and its literal rows · 97 s13
- [ ] decision 318 (one decorator per role, rakun's names: `#[component]`, `#[repository]` on a behavior, `#[provides]`, `#[httpClient]`, `#[listen(dest)]`, `#[controller]`, wrappers; closes 130-c, erk-c) — 130 s5 · rakun 04 s8 · 08 s7 · 12 s6 · 13 s6 · 15 s8 · 19 s7 · 79 s4 · 91 s2 · 93 s4
- [ ] decisions 315, 714 (no module annotation; no decorator wraps its function — a proxy type or a function around the call, 316 overtaken by 714) — rakun 12 s5 · 15's example

## L5 — blocked on a decision

Full text in [`../decisions-pending.md`](../decisions-pending.md); confirmations (1.0.10 choices) in its
last section. Open: 140 questions, 6 contradictions, 100 implementation choices (the counts live at the top of
`../decisions-pending.md`).

**First — what blocks now** (`../decisions-pending.md` § Blocking now — machine 1 and front 165, 2026-10-15), in order:
- [ ] 434-b — 144 B-17 · 116-a — 116 s2 · 50-b — 50 s2, 53 s6

**Then — the error contract and comptime on wasm** (raised 2026-10-10, 433 / 434; each step also waits on B-00):
- [ ] 434-b — the at-build render path on one wasm runtime · 144 B-17

**Then — the botopink shape** (raised 2026-10-04):
- [ ] nat-d6…d9 — case by case (283; nat-d1 → 303, nat-d2 → 304, nat-d3 and nat-d4 → 306, nat-d5 → 307): `nav:` strings (26, 53), lifecycle (rakun 04), `use use…` (53), query's LINQ names (98)
- [ ] nat-f2…f4 — case by case (284): `rakun-ssr.json` keys (124, 271), `files`/`workspaces` (98), `RAKUN_SSR_PUBLIC_` (50, 53)

Then:
- [ ] 07-g — 107 whole
- [ ] 03r-ab — 09 s5 (and the scope of s1–4) · only the record
- [ ] 03r-ae — 79 s3
- [ ] 03r-af — 73 s3
- [ ] 03r-ak — 81 s3
- [ ] 03r-al — 15 s5
- [ ] 03r-am — 19 s3–4
- [ ] 03r-an — 92 s2 (boxes 1, 3)
- [ ] 67-a — 67 s1–3 · 53's write path · only the record
- [ ] 50-b — 50 s2 · 53 s6
- [ ] erk-b — `#[documentQuery]` under 313 (09 s4) 
- [ ] lg2-b … lg2-u — none opens a front; each opens a step when answered: 01-checker (q — reduced); the rakun boxes that name them — 13 · 65 · 92 (b), 22 (q) · answered: a (346 → 01 s32), e (347), j (343), o (342), w (341) → 14 s6, v (344) → 26 s6 / 98 s4 / 73, f, i (280), k (216, 253), r (311–313), t (314), m (315), c (316); g has no subject under 281
- [ ] C-14 — 07-residuals s9 (a 1.0.10 id)
- [ ] confirmations a step waits on — 49-e (49 s2) · 52-a (51 s4) · 29-a (26 s5; reduced: `registerRouteStarters` + `globals.starters`) · 03r-q (105) · 23-b, std-c (23; 23-a moot, 23-c → 317) · 24-c, 24-g (24; 24-g also 97 s5's surface; 24-a → 431, 24-b → 432)
- [ ] ctr-l — 26 s8's refusal list (only the record) · ctr-v — 34 / 33 opening before 118 (only the record) · ctr-w — 09 s3
- [ ] ctr-o — lem-c · ctr-p — 04's readers · 104 s5
- [ ] lg2-s — module-graph reflection

Closed on 9 Oct (no longer pending): 08-h → 285, 224 · 08-j → 295 · lg2-g → 281 · ctr-q → 281, 256 · ctr-m (= lg2-s) · ctr-n · ctr-r · 111-c → 228 · 03r-b (reversed), 03r-d → 299 · 95-e · 03r-o → 290 · 05emilia-h → 206 · 68-c → 280, 281. `#[schema]`'s free functions → 306 (ctr-u); `not-found.bpp` (213 against 221) → 289. own-a blocks nothing (`fronts.md` § Ownership's provisional rule).

## Done — landed on `feat`

Each line landed; a front's README keeps only its open steps. Grouped by front, in the lanes' order.
