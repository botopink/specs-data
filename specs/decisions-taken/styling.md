---
scope: >-
  Decides the CSS stack: `css` (the typed `Sheet`, its renderer, `scope`), rakun-style's `` styled
  @`…` `` / `` styledProperty @`…` `` literals — computed at build or at render, registered where used
  —, rakun-stylesheet's `#[stylesheet(…)]` tag decorator and its Tailwind 4.3.2 parity, and the
  `#[theme]` declaration. The `html` template, `.bpp` and `data-s` are markup-and-rakun-bpp; the
  registry `#[theme]` uses is registry-and-init.
terms:
  - '`styled`'
  - '`styledProperty`'
  - '`StyledProperty`'
  - '`#[stylesheet(…)]`'
  - '`#[styled(…)]`'
  - '`#[theme]`'
  - '`StyledMeta`'
  - '`Styleable`'
  - '`StyledContext`'
  - '`styledConstant`'
  - '`defaultTheme()`'
  - '`baseTheme()`'
  - '`extendTheme`'
  - '`contentHash`'
  - '`flush()`'
  - '`Token`'
  - '`arbSel`'
  - 'Tailwind 4.3.2'
  - '`--tw-*`'
related:
  - 'markup-and-rakun-bpp'
  - 'templates'
  - 'registry-and-init'
  - 'stages-and-folding'
  - 'contexts-and-components'
  - 'library-split'
open:
  - '300: a decorator on a bare `comptime extendTheme(…);` expression waits on `lg2-u`'
  - '355: until `01-compiler/14` step 8 lands, a literal with any hole is computed at render'
binds:
  - '`01-compiler/130` step 10'
  - '`01-compiler/130` step 8'
  - '`01-compiler/14` step 8'
  - '`06-emilia/34` step 1'
  - '`06-emilia/34` step 3'
  - '`06-emilia/34` step 4'
  - '`06-emilia/34` step 5'
  - '`06-emilia/34` step 5 box 4'
  - '`06-emilia/34` step 5 boxes 1–3, 6'
  - '`06-emilia/34` step 5 boxes 3, 5'
  - '`06-emilia/34` step 5 boxes 5–6'
  - '`06-emilia/34` steps 2, 5'
  - '`07-onze/53` step 12'
  - '`07-onze/68`'
  - '`08-bpp/119` step 1'
  - '`08-bpp/119` step 1 (`styled`)'
  - '`08-bpp/119` step 1 (the reader, before 34 s5)'
  - '`08-bpp/119` step 4'
  - '`08-bpp/119` step 4 box 2'
  - '`20-snap`'
  - '`machine-1/150` (rakun, 776)'
  - '`machine-1/150` s52, s53, s72'
retired:
  - '`rakun-stylesheet`''s run-time entry points (`emilia(tokens)`, `className`, `cls`)'
  - '`#("--…", "…")` pairs and `""`-as-clear in a theme'
  - '`class={emilia(tokens)}` and the `fn xTokens() -> Token[]` helpers in templates'
  - '`fullTheme()` / `fullOptions()` as a second theme'
  - 'rakun-stylesheet''s own `Rule` / `Sheet` model and codec (`encodeSheet`)'
first-step: 81
last-step: 954
in-force: 16
superseded: 0
---
# styling — `css`, `rakun-style`, `rakun-stylesheet`, the theme, scoped styles

**Three layers — `css`, rakun-style, rakun-stylesheet — none knowing `.bpp`; rakun-bpp integrates them; a `styled` value registers in the render's sheet where it is used; rakun-stylesheet runs at compile time only; the theme is always declared.**

(1) `styled` / `styledProperty` literals: build vs render, registration by use — 355, 377, 381.

(2) rakun-stylesheet's `#[stylesheet(…)]` decorator, its tokens and `StyledMeta` — 301, 369, 382, 383.

(3) Class identity and source order — 367, 368.

(4) Tailwind 4.3.2 parity, the nine choices, the token set — 350, 401, 954, 81.

(5) The theme — 300, 358, 82.

Steps: 81, 82, 300, 301, 338, 350, 352, 355, 356, 358, 367, 368, 369, 377, 381, 382, 383, 401, 661, 665, 724, 862, 889, 954
Binds: `06-emilia/34` step 3 · 119 step 4 · `07-onze/53` step 12 · `06-emilia/34` step 1 · 08-bpp/116 steps 1, 2, 5, 6 · 08-bpp/119 every step · 118 (`<style>` refusal) · 124 (scaffold manifest) · `06-emilia/34` steps 3, 5 · `07-onze` (onze imports `jhonstart-styled`) · `contracts.md` § 6a · `06-emilia/34` steps 2, 5 · 35–45 · 119 step 1 box 4 · 119 steps 2, 5 · `06-emilia/34` step 5 · `01-compiler/134` step 6 · backend fronts 02–05 (with 134-f) · `01-compiler/14` step 8 · `01-compiler/130` step 10 · 119 step 1 box 5, step 4 · `01-compiler/14` step 8 (355's `val` read) · 119 step 1 box 5 · emilia's examples · `contracts.md` § 4 · `06-emilia/34` step 5 boxes 5–6 · `20-snap` · `07-onze/68` · `08-bpp/119` step 1 (the reader, before 34 s5) · `06-emilia/34` step 5 boxes 3, 5 · `08-bpp/119` step 4 · `onze-cli` · the examples · `08-bpp/119` step 1 · `08-bpp/119` step 1 (`styled`) · `06-emilia/34` step 5 boxes 1–3, 6 · `06-emilia/34` step 5 box 4 · `08-bpp/119` step 4 box 2 · `01-compiler/130` step 8 · `06-emilia/34` step 4 · 314 · 350

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 81 | 1.0.10-beta · (the maintainer, 2026-09-20) | Front 34 declares `Important(inner: Token[])` in the modifier section; front 46 the unit variant `AccentAuto` beside `Accent(color)` |  | |
| 82 | 1.0.10-beta · (the maintainer, 2026-09-20) | Dark mode is Tailwind v4's (`prefers-color-scheme`; the class strategy the documented override), decided in front 54, consumed by 34; 34's breakpoint functions read the theme record 54 threads, so a `--breakpoint-*` override works, never parsed and ignored (67) |  | |
| 300 | nat-c7 | The theme is CSS's flat entry list, typed, declared once with `#[theme]`: `#[theme] pub val appTheme = comptime extendTheme(defaultTheme(), [entry(.Breakpoint, "md", Rem(40.0)), clear(.Breakpoint, "lg")]);` — `entry(ns, name, value)` typed by the namespace, `clear(ns, name)`, `clearNs(ns)`, `clearAll()`; a name inside a namespace stays a string (281); `#("--…", "…")` pairs and `""`-as-clear retired; the mechanism rakun-style's (338), `defaultTheme()` rakun-stylesheet's. The one `#[theme]` is found through the registry (665); two are an error, none a compile error (358). A token naming a cleared or absent breakpoint is a compile error where the token list is comptime-known. A bare `comptime extendTheme(…);` is no registration (216 (4), 282); a decorator on it waits on `lg2-u` | `06-emilia/34` step 3 | theme_typed_flat_entries |
| 301 | (emilia on jhonstart) | rakun-stylesheet reaches markup as its own tag annotation, `<h1 #[stylesheet(.Text.Size.X3xl, .Text.Bold)]>` (369, 382), recording `StyledMeta` (383). `#[styled(syntax decl, comptime ..items: Styleable[])]` is rakun-bpp's (338, 361), takes the application's `styled` components only (369) and records a `ClassName(names: string[])` meta (302) that `html` merges into the tag's `class`, naming no rakun-stylesheet (113). Tokens are comptime (280): their order — the class's identity (`contracts.md` § 4) — fixed by construction, the theme check (300) always applied, class and rule computed at build. `class={emilia(tokens)}` and `fn xTokens() -> Token[]` helpers retired from templates; a run-time choice picks among annotated branches | 119 step 4 · `07-onze/53` step 12 · `06-emilia/34` step 1 | emilia_tag_annotation |
| 350 | 05emilia-l | rakun-stylesheet renders what Tailwind 4.3.2 compiles, written with `styled` (338): a family whose output differs from 4.3.2 moves whole to upstream's form, one helper per shape (`w-1/2` → `calc(1 / 2 * 100%)`, `-rotate-12` → `calc(12deg * -1)`), never two conventions in one family; the five families out of parity (`06-emilia` EM-8: transition presets, `backdrop-opacity-*`, `-webkit-backdrop-filter`, `border-spacing-*`, `divide-*`'s `border-*-style:var(--tw-border-style)`) move under it, each new literal asserted against 4.3.2's output quoted in its test. A family is Tailwind's `@utility` in Tailwind's own CSS syntax (`` styledProperty @`padding: --spacing(${n});` `` with the upstream `@utility` quoted beside it), so parity is read off the literal; the rebuild on `styled` comes first, the five families moving once, in `styled`'s literal | `06-emilia/34` steps 2, 5 · 35–45 | emilia_renders_tailwind_output |
| 355 | 119-c | A `styled` literal is computed at build when every hole is known at build, at render only when one is not; the rule is the hole's value, never the literal's text. Known at build: a literal, a `comptime` value, a `val` whose initializer is known at build — another `styled` / `styledProperty` with no run-time hole (`` pub val tab4 = styledProperty @`tab-size: 4;`; pub val code = styled @`${tab4} color: red;`; `` emits `styledConstant("s_…", ".s_…{tab-size:4;color:red}")`) —, a call of an `Any` function with build-known arguments (376, 380). A hole naming a parameter or any run-time value makes a render-hole literal: built at build into a template with slots, filled at render, registered where used (377). Needs, owned by `01-compiler/14` step 8: a template reading another expansion's value, a `comptime` record lifted as its constructor, a `comptime` reaching a template expansion, `contentHash` at comptime (T19); until then a literal with any hole is computed at render, the same CSS | 119 step 1 box 4 · `01-compiler/14` step 8 · `06-emilia/34` step 5 | styled_literal_computed_at_build |
| 358 | 05emilia-e | The theme is always declared: an application expanding a `styled` literal has exactly one `#[theme]`; none is a compile error (no implicit default) at the first literal reading the theme, naming the fix `#[theme] pub val appTheme = comptime defaultTheme();` (rakun-stylesheet's) or `= comptime baseTheme();` (rakun-style's) — a registered `val` (665), never a `use`: the theme is read while a template expands, where there is no render tree (354 (3)). `defaultTheme()` is the whole Tailwind theme, palette included; `fullTheme()` / `fullOptions()` retired as a second theme. A token reading an entry the declared theme lacks (`.Bg.Red.500` over `baseTheme()`) is a compile error at the token, as a cleared breakpoint is (300). `flush()` renders with the declared theme; every rakun-stylesheet example and test program declares one | `06-emilia/34` step 3 · 119 step 1 box 5 · `01-compiler/130` step 10 · emilia's examples | theme_always_declared |
| 367 | 34-b | Contract 4 follows 338: a rakun-stylesheet class is the layer's prefix plus `contentHash` over its rules as `styled` renders them, one class rule per component — `class = "e_" + hash.contentHash(<rules>)`; the codec payload (`encodeSheet`) retired with the sheet model (338 (3)). The shared fixture is re-derived once, in 34 step 5 (`className(cardTokens(), defaultTheme()) == "e_f51c2501"`), every reader re-recorded in the same landing, before `20-snap` records a class | `contracts.md` § 4 · `06-emilia/34` step 5 boxes 5–6 · `20-snap` · `07-onze/68` | emilia_class_content_hash |
| 368 | 34-c | (1) `styled`'s reader keeps source order: a declaration written after a nested rule opens a new rule of the class (CSS Nesting's nested-declarations rule) — `` styled @`${bg} &:focus { ${gray} } ${pad}` `` renders `.k{background:#ffffff}.k:focus{…}.k{padding:…}`, never `.k{background:…;padding:…}.k:focus{…}` —, so token order is class identity (contract 4 clause 2) and rakun-stylesheet's output stays byte-identical. (2) rakun-stylesheet composes a list's tokens in order, each token's component in turn. (3) `Sheet.render()` stays the `@layer <name>{…}` blocks; `flush()` writes the document frame around it — `<style>`, `@layer theme, base, components, utilities;` (and `@layer properties;`), the theme's `:root{…}`, the base rules, the `@keyframes` (deduplicated, outside every layer), the `@property` fallback under `@supports`, the `prefix` / `important` / `layers: false` options; its own `Rule` / `Sheet` model and codec retired (338 (3)) | `08-bpp/119` step 1 (the reader, before 34 s5) · `06-emilia/34` step 5 boxes 3, 5 · `contracts.md` § 4 | styled_reader_keeps_source_order |
| 369 | 34-a (revised) | rakun-stylesheet runs at compile time only — a tag decorator `#[stylesheet(…)]` over tokens typed `Token`, class and rules computed at build; no component, no `Async` at run time. (1) `pub fn stylesheet(syntax decl: unknown, comptime ..tokens: Token[])` (382) returns nothing (302), the list read as its `comptime` value: `<div #[stylesheet(.Pad.All.4, .Bg.White)]>`; `Token` resolves the leading-dot paths (`docs.md` § Sections of an enum). (2) It computes the class (367) and rules (368) at build and records `StyledMeta` (383), one per tag; rakun-bpp's `html` reads it beside `ClassName`, its sink writes the rules in the stylesheet layer; rakun-stylesheet imports rakun-style and std only, naming no framework (113). (3) A family is a compile-time function answering the record `StyledProperty` (381), never a component. (4) No run-time entry point: `emilia(tokens)`, `emiliaWith`, `className`, `styled` / `styledWith`, `cls`, `clsWith`, `named` retired; a class outside a template is `comptime className(.Pad.All.4)`. (5) `#[styled(…)]` keeps the application's `styled` components only: `<button #[styled(btn)] #[stylesheet(.Pad.All.4)]>`, two annotations (286). Replaces 366 | `06-emilia/34` step 5 · `08-bpp/119` step 4 · `07-onze/68` · `onze-cli` · the examples | emilia_compile_time_tag_decorator |
| 377 | 119-f · (styled) | `styled` builds at build what is known at build, fills the rest at render, and registers in the render's sheet where used, never where made. (1) Each hole carries the compiler's mark — `p.hole.known`, else the reason `p.hole.why` (`n` is a parameter, `agora()` reads the clock) — from 376's stages; the library never guesses. (2) A literal whose holes are all known is a constant (`styledConstant`); one with render holes is parsed, checked and its known holes computed at build into a template with slots — `` styled @`font-family: mono; ${padAll(2)} color: ${cor};` `` emits `padding:calc(var(--spacing) * 2)` written and one slot for `cor` —, the render only filling slots, hashing, registering. (3) A `styled` value holds its class and rules, registered by its use (`use x`, `#[styled(x)]`), so creating one reads no context: a module `val` holding a `styled` literal is legal whatever its holes (one holding an `env(…)` read is computed at module load, registered where a render uses it). Amends 352, 355 | `08-bpp/119` step 1 · `01-compiler/14` step 8 · `machine-1/150` (rakun, 776) | styled_builds_known_at_build |
| 381 | 34-d | `` styledProperty @`…` `` answers the record `StyledProperty` — declarations as a value, never a component; `StyledPropertyView` retired. A property has no class and is only inlined into a `styled` (Tailwind's `@apply`), so building one reads no context and registers nothing (377): `` fn padAll(n: i32) -> StyledProperty { return styledProperty @`padding: --spacing(${n});`; } `` — `padAll` is `Any` (376), `padAll(2)` computed at build (380). A `${p}` hole of a `StyledProperty` inlines its declarations. A `StyledProperty` used alone (`use p`, `#[styled(p)]`) is refused at the use, naming the fix ("a property has no class — put it in a `styled`") | `08-bpp/119` step 1 (`styled`) · `06-emilia/34` step 5 boxes 1–3, 6 | styled_property_is_record |
| 382 | 34-e | `#[stylesheet(…)]`'s tokens are an expression, as every `comptime` parameter (364): `pub fn stylesheet(syntax decl: unknown, comptime ..tokens: Token[])`, the list read as its `comptime` value (a `Token` is data, 364 (2)), a report at the argument through `compiler.fail(…, at: tokens)`; the variadic's spelling is 412's; each leading-dot path still resolves against `Token`; no exception to 364 (4) for a decorator's variadic | `06-emilia/34` step 5 box 4 · `08-bpp/119` step 4 | emilia_tokens_are_expression |
| 383 | 34-f | `#[stylesheet(…)]` records `StyledMeta(layer: Layer, className: string, rules: string)`, one per tag — declared by rakun-style beside `Styled`, `layer` typed with its `Layer` (281): `compiler.setMeta(StyledMeta(layer: .Utilities, className: c, rules: r));`. rakun-bpp's `html` reads it by type beside `ClassName`, merges the class name into the tag's `class` in annotation order, its sink writes `rules` in the meta's layer — neither names rakun-stylesheet (113); another style library may record the same type for another layer. `setMeta`, not `addMeta`: one `#[stylesheet]` per tag, a second refused at it (302); the tokens in one list, whose order is the class (367) | `08-bpp/119` step 4 box 2 · `06-emilia/34` step 5 box 4 · `01-compiler/130` step 8 | emilia_records_styled_meta |
| 401 | 05emilia-n | rakun-stylesheet adds negative translate and named groups / peers; the named `has` / `not` / ARIA / data / `in` variants and `@theme inline` stay deviations, written with `arbSel`. (1) `TranslateX.Neg` / `TranslateY.Neg` beside `Rotate.Neg` (314's convention): `-translate-y-2` is `.Transform.TranslateY.Neg.2`, rendering upstream's `--tw-translate-y:calc(var(--spacing) * -2)` and the composed `translate`, in 350's `calc(… * -1)` form. (2) Named groups and peers as top-level payload variants `GroupNamed(name, inner)` / `PeerNamed(name, inner)` — `group/card`, `group-hover/card:underline` render `.group\/card:hover .e_…` —, each measured against 4.3.2. (3) `:has()` / `:not()` / ARIA / data-attribute / `in-[…]` keep `arbSel` (`arbSel("&:has(img)", [.Pad.All.4])`); `@theme inline` is not added — both in `docs.md` § Deviations | `06-emilia/34` step 4 · 314 · 350 | emilia_negative_translate_named_groups |
| 954 | 06-emilia (9) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured on `rakun` feat: `rakun-stylesheet/src/emilia.bp` (`filterChain`, `backdropFilterChain`, `selectionVariants`), `tokens.bp` (`BackdropFilter`, `Selection`), `output.bp` (`propertiesFallback`, the `properties` layer declared first and written last), `theme.bp` (`Ns.InsetShadow` → `--inset-shadow-`), `spacing.bp` (`spacingHalf`, `spacingNegHalf`); rejected: respelling the `--tw-*` variables under 862 — they are CSS Tailwind emits, not botopink identifiers; re-deciding any family here — 350 fixes each to 4.3.2's output, asserted in its test) | The nine choices of track 06 stand under rakun-stylesheet's name (724, 889): each is Tailwind 4.3.2's output (350), holding as the literal's text across 150 s52's move onto `styled`'s literal. (1) 05emilia-a — the filter reader is upstream's inline chain (`filterChain()`, `backdropFilterChain()`), not `var(--tw-filter)`; -b — the backdrop section is `BackdropFilter`; -c — `drop-shadow-none` follows upstream (`--tw-drop-shadow: ` and the reader); -d — snap strictness is the fallback `var(--tw-scroll-snap-strictness, proximity)`; -f — `--inset-shadow-*` entries drop upstream's leading `inset`; -g — `space-*` / `divide-*` follow upstream's selector and reverse-aware margins; -i — the `--tw-*` transform variables are `@property` blocks in upstream's `properties` layer, declared first and written last after the utilities, `translate-*`, `skew-*` and `scale-*` alike; -j — a selector-list modifier (`marker:`, `selection:`) is a list of one-`&` variants; -k — the negative half step is `spacingNegHalf(n)`, `spacingHalf` refusing a negative `n`. (2) The `--tw-*` names and the `properties` layer are CSS Tailwind emits, outside 862; `emilia.bp` renamed `stylesheet.bp` (889 (3)). (3) Under 150 s52 each family becomes a `` styledProperty @`…` `` literal (338, 350): the choices fix the literal's text, asserted against 4.3.2's output quoted in its test, not the function that built it; a family whose output differs from 4.3.2 moves whole to upstream's form (350) | `machine-1/150` s52, s53, s72 | |
