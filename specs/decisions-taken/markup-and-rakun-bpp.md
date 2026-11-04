---
scope: >-
  Decides `rakun-bpp`'s markup: what a `{expr}` hole accepts (`Node`), the `View` alias, a tag's
  attributes as its component's props, slots, directives as tag annotations (`#[clientOnly]`,
  `#[serverDefer]`), browser-only cells, typed native elements, and track 05's rendering choices
  (compose, `Suspense`, navigation signals). The `.bpp` file is bpp-files; pages are
  pages-routing-and-stages; components are contexts-and-components.
terms:
  - '`Node`'
  - '`View`'
  - '`Slot`'
  - '`#[slot("…")]`'
  - '`#[clientOnly]`'
  - '`#[serverDefer]`'
  - '`#[clientVisible]`'
  - '`Hydrate`'
  - '`Defer`'
  - '`#[reload]`'
  - '`#[history(.Replace)]`'
  - '`ScriptStrategy`'
  - '`GlobalAttrs`'
  - '`AriaAttrs`'
  - '`AnchorProps`'
  - '`el(…)`'
  - '`prelude.bp`'
  - '`elements.bp`'
  - '`fake_dom.mjs`'
  - '`registerRouteStarters`'
  - '`NavSignal`'
  - '`UiSegment`'
  - '`RenderPlugin`'
related:
  - 'bpp-files'
  - 'pages-routing-and-stages'
  - 'contexts-and-components'
  - 'rakun-ssr'
  - 'styling'
  - 'library-split'
open:
  - '351 (5): an event attribute (`onClick`) stays refused at its name until a front declares typed events'
  - '362: the native-builder rewrite opens only after 26 step 0, `01-checker` s28 and the props-filling lowering; until then `<a hreff="/x">` renders as written'
  - '964 (1): the `router_runtime.mjs` and `fake_dom.mjs` sidecar form changes when 150 s36 reaches it'
binds:
  - '`01-checker` s28'
  - '`05-jhonstart/26` (`elements.bp`, `prelude.bp`)'
  - '`05-jhonstart/26` (the `#[client]` check)'
  - '`05-jhonstart/26` (the island cells)'
  - '`05-jhonstart/26` step 13'
  - '`05-jhonstart/26` step 8'
  - '`05-jhonstart/27` steps 1–3'
  - '`07-onze/50`'
  - '`07-onze` (27 callers)'
  - '`machine-1/150` s36, s41'
  - '`machine-1/150` s38 steps 1–3'
  - '`machine-1/165` s5'
  - '05-jhonstart'
retired:
  - '`JhonstartNode`, `Children`'
  - 'Astro''s `prefix:name` directives (`client:load`, …)'
  - '`#[isGlobal]`, `#[defineVars]` (style-section directives)'
  - 'a `slot="fallback"` child of an island'
  - 'the string link / script instructions left after 278 (a hand-written reload / history attribute; `<Script>`''s strategy as `Hydrate`)'
  - '`#(string, string)[]` attribute pairs in the native builders; a custom element or an unlisted SVG tag in markup; an event attribute (`onClick`)'
  - 'the `(children, attrs:)` native builder form'
  - 'a server twin of a browser-only cell (`sidecars/jhonstart_link.erl`''s `linkStatus`, `sidecars/jhonstart_island.erl`)'
  - 'the per-name `registerStarter`; the page as a thunk `{ -> Page() }`; `__jhPushBoundary` (a `Suspense` registered with the render); `payload()` answering `array<#(string, Json)>`'
first-step: 113
last-step: 964
in-force: 11
superseded: 3
---
# markup-and-rakun-bpp — tags, holes, slots, directives, native elements

**A tag's attributes are its component's props; a hole accepts the closed list the template decides; a component's content is its default slot; directives are annotations inside the tag; a native tag is typed as React types its intrinsic elements.**

(1) Holes, the `Node` type, the `View` alias — 191, 223, 276.

(2) Directives, island fallbacks, link and script instructions, browser-only cells — 278, 287, 292, 363.

(3) Native elements and their builders — 351, 362.

(4) The DOM-side forms test; track 05's choices (compose, `Suspense`, navigation signals) — 940, 964.

(5) Overtaken: the library split (113, by 724) and the task type (120, by 553).

Steps: 113, 114, 117, 120, 140, 190, 191, 192, 193, 204, 220, 223, 276, 278, 287, 292, 351, 360, 362, 363, 414, 504, 529, 530, 594, 666, 679, 705, 724, 940, 953, 964
Binds: 08-bpp/118 step 2 · 01-compiler · 118 step 2 · 05-jhonstart · 118 · 05-jhonstart/26 · 05-jhonstart/26 step 4 · 106 · 118 step 6 · 116 step 2 · `05-jhonstart/26` (the `#[client]` check) · 118 steps 2, 5, 6 · 119 · 120 steps 1–3 · 126 steps 1, 4 · `05-jhonstart/26` step 8 · 120 steps 1, 2, 4 · 126 steps 1–2 · `07-onze/50` · 120 · 118 steps 1, 4 · `05-jhonstart/26` (`elements.bp`, `prelude.bp`) · 119 (`class` with `#[styled]`) · 118 step 4 · `01-compiler/130` step 9 (a tag's `@Decl`) · `05-jhonstart/26` (`slot.bp`: `Slot`, `slot`, `hasSlot`; the prelude) · `05-jhonstart/26` step 13 · 118 step 1 · `07-onze` (27 callers) · `01-checker` s28 · `05-jhonstart/27` steps 1–3 · `05-jhonstart/26` (the island cells) · 126 · `01-compiler/134` step 6 box 4b (lands with it) · `05-jhonstart/26` step 14 · `08-bpp/119` steps 2–3 · `1-botopink-lang/144` · `machine-1/144` · `machine-1/150` s36, s41 · `machine-1/165` s5

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 113 | 94, 100, 101 · (the maintainer, 2026-09-25) | Overtaken by 724 | jhonstart front 30 (`render.bp`, `plugin.bp`, `globals.bp`, the marker and global spellings, and the `jhonstart-emilia` member); rakun fronts 04 and 23 (the erlang core and the render leaving `ssr.bp`); onze fronts 49, 68 and 69 (the wiring, the entry, the plugin registration) | |
| 120 | D-C · (the maintainer, 2026-09-26) | Overtaken by 553 | front 24 steps E1 (`@Task<T>` in `builtins.d.bp`), E3.4, E4 (`for await`'s channel) and E5 | |
| 191 | — | `rakun-bpp`'s templates accept in `{expr}` a closed list: a `string`; a number of any numeric type and a `bool`, each as its `toString()` text, the same on every target; a component the template renders (a `Component<Element>` value, 354); a list of such components; and `Node` (223), the name of that set. Any other type — a record, an optional (204), a function, a component of another `R` — is a comptime error at the expression | 118 step 2 · 05-jhonstart | template_hole_closed_type_list |
| 223 | props-c | The node type — what a slot holds and what a hole accepts (191) — is `Node`, imported `import {Node} from "rakun-bpp";`; it replaces `JhonstartNode` and `Children`; every spec, example and doc writes `Node` | 05-jhonstart · 118 | jhonstart_node_type |
| 276 | view-a | `rakun-bpp` declares `pub type View = Component<Element>;` (354) in `element.bp` — a type alias (110), the same type under a shorter name: each accepts the other, the emitted code keeps the full type; no subtyping (a component stays any `Component<R>`, 354); methods for it, if ever needed, go in an `extend View { … }` block. The prelude imports `View`; a `.bp` component may write either spelling. A decorator that checks a component's return (`#[client]`) compares the resolved type, never the text | 118 step 6 · 116 step 2 · `05-jhonstart/26` (the `#[client]` check) | view_is_component_alias |
| 278 | dir-1 … dir-5 | Template directives are annotations written inside the tag, in the attribute zone: `<Carousel #[clientVisible("200px")] images={12} />`; Astro's `prefix:name` syntax goes; a tag annotation is a function resolved in the caller's scope like a tag name (112, the prelude 270), in 302's shape. Names keep the side as a prefix (dir-1): `clientLoad`, `clientIdle(timeoutMs)`, `clientVisible(rootMargin)`, `clientMedia(query)`, `clientOnly`, `serverDefer`, `transitionName`, `transitionAnimate`, `transitionPersist`, `transitionPersistProps`, `isRaw`, `isInline`. `#[clientOnly]` is one function with one meaning, only on the client (dir-2): on a hook declaration 186's marker; on a component tag the instance is never rendered on the server (fallback written, the browser renders it), recording `Hydrate.Only`; `html` generates no server call for it, so its component's nodes do not enter the page's `hooks`. What an annotation does is the typed meta it records (302; dir-4): `Hydrate` → an island, `Defer` → a server island, the transition and style metas → their arms; a library may declare its own annotation recording one of these types. `html` checks every `Hydrate`: the component carries `#[client]` (`compiler.same`, 666); a component whose `hooks` reach `#[clientOnly]` is refused under any `Hydrate` but `Only` and under no annotation — "use #[clientOnly]" (dir-3). Element directives (dir-5): a value becomes a value — `set:html={s}` → `{raw(s)}`, `set:text={s}` → `{s}`, `class:list={[…]}` → `class={classList([…])}`; an instruction becomes an annotation — `#[isRaw]`, `<style #[isInline]>` (`:global(…)` and run-time holes in the style section replace `#[isGlobal]` and `#[defineVars]`, 338) | 118 steps 2, 5, 6 · 119 · 120 steps 1–3 · 126 steps 1, 4 · `05-jhonstart/26` step 8 | template_directives_tag_annotations |
| 287 | ctr-aa | An island's fallback is an argument of its annotation: `serverDefer(syntax decl: unknown, comptime fallback: ?View = null)` (recording `Defer`) and `clientOnly(…, comptime fallback: ?View = null)` (recording `Hydrate`) — 302's shape, 364's parameters — `<Avatar #[serverDefer(fallback: <GenericAvatar size={48} />)] size={48} />`, `<Map #[clientOnly(fallback: <p>Loading…</p>)] zoom={3} />`. It is what the page shows until the component arrives, so it is comptime (280): static markup or a component without request data; one reading request data is refused at the argument. No `slot="fallback"` child; on a hook declaration `#[clientOnly]` takes no `fallback` | 120 steps 1, 2, 4 | island_fallback_annotation_argument |
| 292 | ctr-z | The string instructions left after 278 go, each to its own place. (1) A link's instructions are tag annotations: `<a #[reload]>` (a document load) and `<a #[history(.Replace)]>` (`History.Push \| Replace \| Auto`), recording `LinkReload` / `LinkHistory` (302), lowered to `data-rakun-reload` / `data-rakun-history` (898), never written by hand. (2) The five navigation events are `#[clientOnly]` hooks with typed events: `use onBeforePreparation(…)`, `onAfterPreparation`, `onBeforeSwap`, `onAfterSwap`, `onPageLoad`; the `jh:` DOM event names stay the runtime's wire. (3) `<Script>`'s strategy is its own enum prop, `strategy={.LazyOnload}` (`ScriptStrategy { BeforeInteractive, AfterInteractive, LazyOnload, Worker }`), not the islands' `Hydrate` | 126 steps 1–2 · `07-onze/50` · 120 | link_instructions_tag_annotations |
| 351 | props-d | A native tag's attributes are typed as React types its intrinsic elements, in botopink's own shapes; `prelude.bp` is the intrinsic table. (1) Each native tag is a `rakun-bpp` builder whose first parameter is the element's props record — the rule of a component (192), `html` lowering a native tag as it lowers a component tag: `<a hreff="/x">` is a comptime error at `hreff`, `<input tabIndex="abc">` at the value, content inside a tag whose props declare no `children` (a void element) at the tag. (2) The props are records with defaults layered with `Type.merge` (307): `GlobalAttrs` (`id`, `class`, `style`, `title`, `lang`, `dir`, `hidden`, `tabIndex`, …), `AriaAttrs`, and each element's own — `pub val AnchorProps = Type.merge(Type.merge(GlobalAttrs, AriaAttrs), AnchorAttrs);`. A field is `?T = null` (absent when null) or a `bool` (written bare, absent when false); a number is `i32` / `f64`, a closed set an enum (`target={.Blank}`, `type={.Email}`), the rest `string`; a native element's content is its builder's `children` field. (3) Names: a one-word attribute keeps HTML's name; a multi-word one is camelCase as in React (`tabIndex`, `readOnly`, `httpEquiv`, `acceptCharset`), the renderer writing HTML's (`tabindex`, `http-equiv`); `aria-*` are typed fields of `AriaAttrs` (`aria-label` is `ariaLabel`); `data-*` is the one open family, any suffix, a `string` value. (4) Declared through the prelude (270, 361): a native tag exists in markup only when the prelude names its builder; a tag it does not name — a custom element (`<my-widget>`), an SVG tag not yet listed — is an error at the tag, written as an app's own component or `el(…)` in a hole; a new tag is its builder, its props and one prelude line. (5) Spread on an element takes a value of that element's props type or of a type derived from it (307), with 359's order and completeness rules (`<a {..linkProps} class="x">`); the `#(string, string)[]` pairs leave the builders (`el(…)` keeps them, the escape hatch). An event attribute (`onClick`) is refused at its name until a front declares typed events | 118 steps 1, 4 · `05-jhonstart/26` (`elements.bp`, `prelude.bp`) · 119 (`class` with `#[styled]`) · 120 | native_tag_props_typed |
| 362 | 118-a | `05-jhonstart/26` rewrites the native builders into 351's props form, in place, and the hand-written callers with them — one builder per tag, never two. 118 lands with the html-side rules it enforces (351's names: camelCase rendered in HTML's spelling, `data-*` a `string`, any other kebab-case and `onClick` refused at the name; no pair spread on an element). 26, owner of `elements.bp` (and of `element.bp`'s eight, unfrozen for this step), turns every `(children, attrs:)` builder into `pub fn a(props: AnchorProps) -> Element` — props layered with `Type.merge` (307), content in the element's `children` field, the spread typed (359), exported through the `#[bpp.htmlPrelude]` module (361) — and rewrites the 78 hand-written callers (51 in rakun-bpp, 27 in rakun-ssr; a consumer commit per library, 188) in the same landing; the `(children, attrs:)` form leaves (`el(…)` stays the escape hatch). It opens after 26 step 0, `01-checker` s28 (`AnchorProps` as a parameter type) and the props-filling lowering; until then `<a hreff="/x">` renders as written — no temporary second builder per tag | `05-jhonstart/26` step 13 · 118 step 1 · `07-onze` (27 callers) · `01-checker` s28 | native_builders_one_per_tag |
| 363 | 27-a | A browser-only cell is `#[clientOnly]`: called only where the client runs, never given a server twin. (1) A host cell bound only for the browser (commonJS in the page) — `linkStatus()`, the island cells (`propsFor()`, the starters' reads) — is reached only through a `#[clientOnly]` hook (186): `use linkStatus()` is legal only inside a `#[client]` component, refused anywhere else at the `use`. (2) A component that reaches a `#[clientOnly]` hook renders only in the browser (278's `clientOnly` reading), with its annotation's fallback (287); the server build never emits it nor the cell. (3) The erlang twins answering the server's empty truth are removed — `sidecars/jhonstart_link.erl`'s `linkStatus`, `sidecars/jhonstart_island.erl` deleted; a cell a two-target member calls from code the server renders is bound on every target the member declares (349). (4) A server-rendered `Link` reads no hook: its pending state is an attribute the client router sets on the active link (`data-rakun-pending`, 898), styled with CSS (`[data-rakun-pending]`, a rakun-stylesheet / rakun-style variant) — no island per link | `05-jhonstart/27` steps 1–3 · `05-jhonstart/26` (the island cells) · 120 · 126 | client_only_cell_never_server |
| 940 | 67-a · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `fake_dom.mjs` (`rakun-bpp-dom-test`, 762) has no `<form>`, `<input>`, `FormData` or `submit`; `botopink test` has no DOM; 150 s38 steps 1–3 are written for (a); rejected: (b) only in the ssr's browser run — a box asserted by no gate (160); (c) a real DOM library as a dev dependency) | (a): `fake_dom.mjs` gains `<form>`, `<input>`, `FormData` and `submit`; the five DOM-side forms boxes are asserted in `forms_dom_test.bp` of `rakun-bpp-dom-test` now, and again in the ssr's browser run (150 s67). (1) `fake_dom.mjs` is edited by one step at a time (org-6), 150 s38 owning this change; `forms_dom_test.bp` is 150 s38's. (2) Cell `forms_dom_boxes` (rakun-bpp-dom-test, commonJS), red on the parent | `machine-1/150` s38 steps 1–3 · s67 | forms_dom_boxes |
| 953 | 05-jhonstart (9) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured on `rakun` feat: `rakun-bpp/src/router_runtime.mjs`, `client.bp` (`registerStarter`, `registerRouteStarters`, `globals.starters`), `plugin.bp` (`payload: fn() -> Async<array<#(string, Json)>>`), `render.bp` (`compose(chain, route: PageContext, page: fn() -> …)`), `suspense.bp` (`Boundary(id, fallback, child: fn() -> Component<Element>)`, `__jhPushBoundary`), `routes.bp` `UiSegment`, `streaming.bp` `app(…, lang = "en")` over `isLangTag`, `error_boundary.bp` (`notFound() -> string`, `isSignalReason`), `jhonstart-dom-test` over `fake_dom.mjs`; rejected: the page as a thunk kept — under 504 (d) a call of a component already makes its lambda, so `{ -> Page() }` is a second spelling of the deferred form (67); `Suspense` registering its boundary through a host cell — 414 / 504 make it a node the renderer resolves; 31-a's `-> noreturn` decided here — it is `nat-d6`'s and `lg2-l`'s) | Replaced by 964 | `machine-1/150` s36, s41 · `machine-1/165` s5 |  |
| 964 | 953-fix · (the fable, at the maintainer's delegation — the review triage of 814–955, 2026-10-26) | The nine implementation choices of track 05 stand under `rakun-bpp`'s name (724): 26-a, 30-b, 30-e, 30-f and 30-g confirmed, 29-a reduced, 30-c and 30-d read under 504 / 414, 31-a under 924 — the navigation signals are tree nodes, nothing raises; restates 953 with 924 and 929 folded in, replacing it. (1) Confirmed. 26-a: every router cell is dual-target (commonJS and erlang); its `router_runtime.mjs` twin is a sidecar file — the form § library-split retires for an inline cell (117 (7), 575 (6)); the form changes when 150 s36 reaches it, the rule does not. 29-a, reduced: the island starter table is the registry's `globals.starters`, filled per route by `registerRouteStarters(pattern, load)` (a route pattern a URL string, 281), a second loader for one route failing; the per-name `registerStarter` goes — each `#[client]` registers its starter through its `compiler.init` executor into the run-time registry (665; `@TypeInfo.all` is retired, 576 (7)). 30-b: `RenderPlugin` is a record of async functions, `chunk(id)` running in the boundary's own process; `payload()` answers `Async<?#(string, Json)>`, one pair or none, once after `close` (114 (2), (3)) — the built `array<#(string, Json)>` is respelled, `[]` → `null`. 30-e: the segment record is `UiSegment`. 30-f: `app(…, lang = "en")`, one checked language per app, `isLangTag` until 105's `i18n.wellFormedTag` (180); a per-request `PageInput.lang` from rakun-app's `htmlLang()` stays additive. 30-g: the browser half is asserted in `rakun-bpp-dom-test` (762), commonJS only; `fake_dom.mjs` a sidecar under the same rule. (2) Under 504 / 414. 30-c: `render` / `renderStream` / `App` in `streaming.bp`; `compose(chain, Page())` runs the layouts first and takes the page as a component value, never a thunk — under 504 (d) a component's call only makes its lambda (791 (1)), `{ -> Page() }` a second spelling (67); `route: PageContext` goes with 293, the page `component fn() -> Component<Element>` (276, 553 (1), 852). 30-d: `Suspense(Boundary(id, fallback, child))` is a tree node holding a component value, `child: Component<Element>` (809 (7)), resolved by the renderer's `renderSuspense` while descending (504, 414); no `__jhPushBoundary`, no registration with the render; the page returns only the tree. (3) 31-a under 924: `notFound()` and `redirect(url)` no longer raise — each answers a `Component<Element>` whose node is `NavSignal(outcome: NavOutcome)`, read by the renderer as it descends (924 (1), (2)); no host cell raises, no boundary catches, no `nav:` string, no `noreturn` (929 (3)); `raiseReason`, `isSignalReason`, `notFoundReason`, `redirectReason`, `isSignal` and `signal_runtime.mjs` with its erlang twin are removed (924 (3)); 953 (3)'s "the mechanism is confirmed" is withdrawn. (4) Cell `compose_page_value_and_suspense_node` (rakun-bpp): a page composed as a value through layouts and a `Suspense` node resolved by the renderer, red on the parent | `machine-1/150` s36, s41 · `machine-1/165` s5 | compose_page_value_and_suspense_node |
