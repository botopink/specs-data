---
scope: >-
  Decides a page's render stage (comptime / server / client, read off the hooks list through
  `#[serverOnly]`, `#[clientOnly]`, `#[page]`, `#[client]`), `#[page]`'s arguments, the `use params` /
  `pageData` / `request` / `response` hooks, route handlers, server-island props and `rakun-ssr.json`,
  navigation signals and the render's `Result<void, string>`. Atoms and cookies are
  request-state-and-cookies; `.bpp` markup is markup-and-rakun-bpp.
terms:
  - '`#[page]`'
  - '`#[serverOnly]`'
  - '`#[clientOnly]`'
  - '`#[client]`'
  - '`#[route]`'
  - '`use params<P>()`'
  - '`use pageData<T>()`'
  - '`use request()`'
  - '`use response()`'
  - '`revalidate`'
  - '`dynamicParams`'
  - '`rakun-ssr.json`'
  - '`SsrConfig`'
  - '`RAKUN_SSR_KEY`'
  - '`"islands"`'
  - '`NavSignal`'
  - '`notFound()`'
  - '`redirect(url)`'
  - '`allowedRedirects`'
  - '`renderStream`'
  - '`ChunkWriter`'
related:
  - 'markup-and-rakun-bpp'
  - 'request-state-and-cookies'
  - 'rakun-ssr'
  - 'contexts-and-components'
  - 'actions-http-log-routing-i18n'
  - 'library-split'
open:
  - '927 (2): a line number in `rakun-ssr build`''s config error waits on `json`''s `decode` exposing positions (a `machine-1/151` row)'
  - '130: a typed `RenderError` may replace `E = string` later without breaking readers of the string'
binds:
  - '`01-checker` step 23'
  - '`04-rakun/22` step 8'
  - '`05-jhonstart/26` step 10'
  - '`05-jhonstart/26` step 11'
  - '`05-jhonstart/26` steps 8, 10'
  - '`07-onze/51` step 8'
  - '`07-onze/53` step 8'
  - '`07-onze/53` step 9'
  - '`machine-1/150` s13 (rakun-app)'
  - '`machine-1/150` s36 (then s63, s67)'
  - '`machine-1/150` s36 step 8'
  - '`machine-1/150` s66 step 1'
  - '`machine-1/157` (routing)'
  - '`machine-1/165` (rakun-bpp)'
  - '04-rakun/22'
  - '05-jhonstart'
  - '05-jhonstart/26 step 8'
  - '08-bpp/117 step 2'
retired:
  - 'onze and its eight members; the `onze` CLI (`onze create-key`); `onze.json`'
  - '`pub val prerender`, the `output` key; Next''s `dynamic`, `fetchCache`'
  - 'A `pages/` tree'
  - '`route: PageContext`, `paramsOf`, `StaticPath.data: Json`, `isPrerendered()`'
  - 'A route handler exported by the build (`<outDir>/rss.xml`)'
  - 'The `"signed"` island mode'
  - '`notFound()` / `redirect()` as a raise with a `nav:` string; `signalReason`, `isSignalReason`, `signalPrefixes`, `raiseReason`, `isSignal`, `notFoundReason`, `redirectReason`, `signal_runtime.mjs`, `rkNavSignal`'
  - '`islandKeyEnv` (a key renaming the island key)'
  - '`responseStatus` / `responseHeader` as plain calls'
  - '`pageData(route, schema)`'
  - '`navigation.bp`''s `-> i32` (rakun-app''s status from the signal)'
first-step: 130
last-step: 979
in-force: 15
superseded: 1
---
# pages-routing-and-stages — `#[page]`, the render stage, request and response, islands

**A page's stage is a compile-time fact read off the hooks list; no role is declared by an export's name and no segment configuration exists; a page reads its route through hooks; a route handler is always server.**

(1) The stage read off the hooks list; two refusals, no third — 979, 202, 947.

(2) Roles, settings and the routing convention — 282, 290, 203.

(3) Reading the request: `params`, `pageData`, `request`, `response` — 293, 291.

(4) Route handlers — 222, 273.

(5) Server islands and `rakun-ssr.json` — 224, 271, 272, 927.

(6) Navigation signals; the render's failure — 924, 130.

Steps: 115, 117, 130, 186, 202, 203, 222, 224, 236, 271, 272, 273, 282, 290, 291, 293, 403, 725, 726, 924, 927, 947, 979
Binds: 01-checker · 05-jhonstart/26 step 8 · 07-onze/49 step 5 · 04-rakun/22 step 4 · 08-bpp/117 step 2 · 124 · 117 step 1 · 117 step 4 · 05-jhonstart · 04-rakun/22 · 120 step 4 · 130 steps 5–6 · 124 steps 1 and 3 · surface.md · 117 step 6 · `07-onze/53` step 8 · `07-onze/51` step 8 · 121 step 8 · `04-rakun/22` step 8 · `05-jhonstart/26` step 10 · `07-onze/53` step 9 · 117 · 122 steps 1, 3 · `05-jhonstart/26` steps 8, 10 · `05-jhonstart/26` step 11 · `01-checker` step 23 · 116 · 53 · 120 · 121 · 122 · 123 · `01-compiler/01-checker` (the row) · rakun 22 · `08-bpp/117` · `07-onze/53` · 285 · `machine-1/150` s36 step 8 · `machine-1/165` (rakun-bpp)

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 130 | 24 open point 8 · (the maintainer, 2026-09-26) | A failing render carries `E = string`; the writers stay infallible (117 (1) under 120, 121). (1) `renderStream(…) -> Async<Result<void, string>>`; rakun's `PageRenderer = fn(req: Request, out: ChunkWriter) -> Async<Result<void, string>>`; rakun-ssr's boot closure stays `return ui.renderStream(…)`. (2) `ChunkWriter.write` / `close` and rakun-bpp's `Response.write` / `close` stay `Async<void>` (120): a write never fails as a value; a write after `close`, or `setStatus` / `setHeader` after the first `write`, is misuse and raises (67). (3) rakun's dispatch treats a failed render like an untagged raise of the renderer: 500 when nothing was written, else the response is closed; the message logged under a correlation digest, never on the wire; `servePage` stays `Async<i32>` (the status written). A typed `RenderError` can come later without breaking readers of the string — `RenderPlugin.close`, the one fallible piece, is already `Result<void, string>` and the render forwards the same `E`; rakun names no rakun-bpp type (114 (5)). Amends 117 (1): the failure is a `Result` value inside the task | rakun front 23 step 1 (`ChunkWriter`, `PageRenderer`, `servePage`, the dispatch), jhonstart front 30 (`renderStream`'s signature), onze front 49 (the boot closure) |  render_failure_error_is_string |
| 202 | 08-g | No page declares or forces its stage: rakun-bpp's `#[page]` reads off the hooks list (186) whether the page reaches a `#[serverOnly]` hook by `use` — none: prerendered at comptime by that decorator; one: rendered per request. `pub val prerender` and the `output` key retired; nothing forces a page reaching no server hook to render per request (290) | 08-bpp/117 step 2 · 124 · 05-jhonstart/26 step 8 | page_stage_from_server_hooks |
| 203 | 08-b | `app/blog/[slug]/page.bpp` is the one routing convention — a `.bpp` valid where a `page.bp` is, beside `layout`, `loading`, `error`; the `pages/` tree is retired | 117 step 1 | bpp_page_routing_convention |
| 222 | bpp-d | A route handler is always server: a `#[route]` handler (`route.bp`, answering a `Response`, every method, `GET` included) runs per request as if `#[serverOnly]`; never prerendered nor exported by the build, nothing it reaches evaluated at the build; prerendering is `#[page]`'s alone (202, 273) | 117 step 4 · 05-jhonstart · 04-rakun/22 | route_handler_always_server |
| 224 | 08-e | Server-island props are secret, sealed by default — `GET /_island/Profile?p=<AES-256-GCM>`, the visitor neither reads nor alters them; the key is `RAKUN_SSR_KEY` or one generated at build (`rakun-ssr create-key`) (271); the mode is chosen per project in `rakun-ssr.json` (`"islands": {"props": "sealed"}`), no per-request or per-environment override; the modes are 272's | 120 step 4 · 124 | server_island_props_sealed |
| 271 | ctr-a | No `islandKeyEnv` key: the server-island key is always the environment variable `RAKUN_SSR_KEY` (or the one `rakun-ssr create-key` / the build generates); a renamed key is configuration that weakens the rule (67). `rakun-ssr.json`'s keys: `trailingSlash`, `redirects`, `markdown`, `islands`, 122's `site` (927 adds `allowedRedirects`) | 124 steps 1 and 3 · 120 step 4 | island_key_is_onze_key |
| 272 | 08-e2 · ctr-b | `rakun-ssr.json`'s `"islands": {"props": …}` names only modes keeping the props secret: `"sealed"` (default — AES-256-GCM in `?p=…`, 224) or `"server"` (props stored server-side under a random id, nothing in the URL, the shell not cacheable across instances); `"signed"` and any mode the visitor can read are retired; an unknown value is a config error | 120 step 4 · 124 steps 1 and 3 | island_props_modes_secret |
| 273 | ctr-c | 222 holds whole: a route handler is never a build export; `app/rss.xml/route.bp` is served per request and `rakun-ssr build` writes no `<outDir>/rss.xml`; a feed that must be a static file is a page-kind file, prerendered (202) | 117 step 4 · surface.md | route_handler_never_exported |
| 282 | nat-0 (rule 2) · nat-b | No role is declared by an export's name: what a function or value is for (the pages to prerender, the page's head, a partial page, an OG image's size and type, a content collection) is said in a typed decorator (280) — an argument of the one already there, `#[page("blog/[slug]", paths: allPosts, head: postHead, partial: true)]`, or its own, `#[ogImage(…)]`, `#[collection(…)]`; the framework never looks a function up by name (`staticPaths`, `generateMetadata`, `generateStaticParams`, `partial`, `size`, `contentType`, `collections`); one left in a module is an error naming the decorator form. Route file names stay the routing convention (203) | 117 step 6 · `07-onze/53` step 8 · `07-onze/51` step 8 · 121 step 8 | role_declared_by_decorator |
| 290 | ctr-x | No segment configuration: Next's `dynamic` (forcing a stage) and `fetchCache` are removed — `S` / `D` comes from the hooks list (186, 202, 277), nothing forces it; `registerSegmentConfig("<route>", SegmentConfig(…))` and the layout-to-page inheritance are removed (281). A page's settings are `#[page]` arguments beside `paths:`, `head:`, `partial:` (282): `#[page("blog/[slug]", revalidate: hours(1), dynamicParams: true)]` — `revalidate: ?Duration` (std's `io.clock`) regenerates a prerendered page, `dynamicParams: bool = true` renders a parameter outside `paths` on demand | `04-rakun/22` step 8 · `05-jhonstart/26` step 10 · `07-onze/53` step 9 · 117 | page_settings_are_page_arguments |
| 291 | ctr-y | A page reads the request and writes the response through two hooks: `val req = use request();` (URL, headers, cookies) and `val res = use response();` (`res.status(404)`, `res.header(name, value)`; methods, values immutable), both `#[serverOnly]` (186), so a page using either is `D` (277); `responseStatus` / `responseHeader` as plain calls are removed. Status and headers are legal until the response head is written, a located run-time error after (as `redirect`). A fixed header of an `S` page is a `#[page]` argument (`headers: [#("Cache-Control", "…")]`, 290). `isPrerendered()` is removed: the stage is a comptime fact in the page's typed meta (298) | 122 steps 1, 3 · `05-jhonstart/26` steps 8, 10 · 120 step 4 | request_response_hooks |
| 293 | nat-c1 · nat-c3 · bpp-g | A page reads its route through hooks, never a parameter: `val p = use params<BlogParams>();` (the URL's segments as a record) and `val post = use pageData<Post>();` (what `paths:` handed this path, 282); a page function takes none (`component fn() -> View`; a `.bpp` header needs no `Props(route: …)`), and any component below may read them. Both hooks are unmarked — known at build for a prerendered page, they make no page `D` (`searchParams` stays `#[serverOnly]`). `#[page]` checks over the hooks list (277, carrying each `use`'s type arguments): `P`'s fields are the pattern's segments, parsed to their types (`id: i32` — `/produto/abc` answers 404 unrendered); `D` is `paths:`'s; a mismatch is an error at the page naming the chain. `route: PageContext`, `paramsOf`, `StaticPath.data: Json` and `pageData(route, schema)` are removed | `05-jhonstart/26` step 11 · `01-checker` step 23 · 117 · 116 · 53 · 120 · 121 · 122 · 123 | route_read_through_hooks |
| 924 | nat-d6 · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `rakun-bpp`'s `notFound()` / `redirect()` answer `-> string` and raise a `nav:`-prefixed reason through a host cell (`error_boundary.bp` `raiseReason`), `rakun-app`'s `rkNavSignal` the same, and `routing`'s `navigation.bp` already types the signal as `NavOutcome(kind: NavKind, location, status)`; rejected: the proposal's `NavOutcome` raised through a host cell under `-> noreturn` — 527 (5) and 554 made the signals data the renderer reads, never a raise; (b) the string under a wrapper; (c) `-> string`; a page typed `Component<Result<Element, NavOutcome>>` — every page's signature rewritten for a value the renderer, not the caller, consumes) | A navigation signal is typed data, never a raise (527 (5), 554, 504): `notFound()` and `redirect(url)` answer a `Component<Element>` whose node is `NavSignal(outcome: NavOutcome)`, read by the renderer while it descends — no `nav:` string in code, no `noreturn`. (1) rakun-bpp declares the node `NavSignal(outcome: NavOutcome)` beside `ErrorBoundary`, `NotFoundBoundary` and `Suspense` (414 (1)); `notFound() -> Component<Element>`, `redirect(url) -> Component<Element>`, `permanentRedirect(url)` and `redirectWithStatus(url, status)` answer that node as a component value, never a raise; a page or component writes `return notFound();` and ends its path as any `return` does. (2) The renderer, meeting a `NavSignal` while descending, answers as 115 (2) and 117 (1) fix: before the first chunk the status and headers on the generic `Response` (404 with the nearest `NotFoundBoundary`'s view, `location` for a redirect); after it the late-signal markup the client runs (`data-rakun-to`, 898), status 200; `renderErrorBoundary` never meets one, `renderNotFound` finds its boundary by node, not by catching. (3) `NavOutcome` stays `routing`'s (server and browser read it); `signalToWire` / `signalFromWire` remain the wire spelling of the late markup and the client payload (281); removed: `signalReason`, `isSignalReason`, `signalPrefixes`, rakun-bpp's `raiseReason`, `isSignal`, `notFoundReason`, `redirectReason`, `signal_runtime.mjs` with its erlang twin; removed too: rakun-app's `rkNavSignal` and `navigation.bp`'s `-> i32`; rakun-app answers the status rakun-bpp's render wrote (130). (4) A server action redirects through the `actions` envelope's `n` (115 (3), 117 (4)); `ActionError` unchanged (303). (5) `language-gaps.md`'s "navigation signals do not return `noreturn`" row closes — no signal returns; `31-a` (Part 3) reads this row. (6) Cells under `conformance/rakun-bpp/`: `nav_signal_before_first_chunk` (404 with the boundary's view, 307 with `location`), `nav_signal_after_first_chunk` (markup, status 200), `nav_signal_in_nested_component` (a child's `return notFound()` reaches the page's boundary); red on the parent | `machine-1/150` s36 (then s63, s67) · `machine-1/150` s13 (rakun-app) · `machine-1/157` (routing) · `machine-1/165` (rakun-bpp) | nav_signal_is_a_tree_node |
| 927 | nat-f2 · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `rakun-ssr/src/config.bp`'s `loadConfig` / `applyKey` / `configKeys` is a hand-written typed loader holding `allowedRedirects` alone and refusing an unknown key; 271 fixes `trailingSlash`, `redirects`, `markdown`, `islands`, `site`; the file is `rakun-ssr.json` and the record `SsrConfig` (724, 889); rejected: (b) a typed record in the app's code — two homes for what 271 / 272 / 224 put in the file; (c) as is; 299's `#[config]` binder — not built in rakun) | `rakun-ssr.json`'s keys are read at build into one typed record `SsrConfig(site, trailingSlash: TrailingSlash, redirects: RedirectRule[], markdown: MarkdownOptions, islands: IslandProps, allowedRedirects: string[])`, every key typed and refused when wrong; amends 271's key list with `allowedRedirects`. (1) The six keys are the whole file: an unknown key, a wrong kind, an unknown variant (`trailingSlash: "sometimes"`) or a bad value (a `redirects` entry whose source is also a page, a relative URL in `allowedRedirects`) is an error at `rakun-ssr build` naming the file, the key path and the expected type (49-c, 299, 67); the record's defaults are the one source of `rakun-ssr --help`'s table. (2) The loader stays `config.bp`'s own (`loadConfig` / `applyKey` / `configKeys`; `OnzeConfig` renamed `SsrConfig`, 889); `url_rules`' `PathRules` reads `trailingSlash` and `redirects`, `MarkdownOptions` `markdown`, `IslandProps` `islands` (272); a line number in the error waits on `json`'s `decode` exposing positions (a `machine-1/151` row), the key path until then. (3) Cell `ssr_config_typed_keys` (rakun-ssr): the six keys read, one unknown key and one wrong variant refused naming the path; red on the parent | `machine-1/150` s66 step 1 · s59, s60, s67 · s72 (`SsrConfig`) | ssr_config_typed_keys |
| 947 | ctr-l · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: 186's third refusal kept with a case nobody can write) | Overtaken by 979 | `machine-1/150` s36 step 8 |  |
| 979 | 186-fix · (the fable, at the maintainer's delegation — the review triage of 814–955, 2026-10-26) | A page's stage is a compile-time fact read off the hooks list — two refusals, no third; restates 186 with 947 folded in (202 read with it), replacing both. (1) Stages, in order: comptime (the build, where a page is prerendered) → server (request time) → client (the browser). A hook with no marker may run at any stage; a marker only restricts it; the compiler validates the `use` of a marked hook through 277's hooks list (`compiler.hooks(d)`), read by `#[page]` and `#[client]` against the decorators they import. (2) `#[serverOnly]` — the server at request time (`searchParams`, cookies, headers, a per-request query): a page reaching one renders per request, the definition of a dynamic page; a `use` or a call with no known target makes the page per-request too (277). `#[clientOnly]` — the browser only, legal only inside a `#[client]` component; on a component's tag it renders that instance only on the client (278); on a `val` it marks an atom an island alone may read (943). (3) Refused at compile time, at the `use`: a `#[serverOnly]` hook inside a `#[client]` component; a `#[clientOnly]` hook outside one. 186's third refusal ("a `#[serverOnly]` hook in a page that declares itself prerendered") has no case: under 202 no page declares or forces its stage (`pub val prerender` and the `output` key retired; nothing forces a page reaching no server hook to render per request, 290). (4) The route's kind is written by the build (`routing`'s `k` blob, `pattern\|S\|D`) and rakun only reads it; `markDynamic`, `rakun_ssr.erl`'s implicit mark and every channel between them are removed. (5) Cell `page_stage_hook_refusals` (rakun-bpp): the two refusals, a page reaching a `#[serverOnly]` hook marked `D`, one reaching none marked `S`; red on the parent | `machine-1/150` s36 step 8 · `machine-1/165` (rakun-bpp) | page_stage_hook_refusals |
