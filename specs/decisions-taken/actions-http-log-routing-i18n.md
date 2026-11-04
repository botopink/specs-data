---
scope: >-
  Decides the small shared libraries: `http` (the one cookie reader and q-value parser, `Cookie<T>`,
  malformed chunks; std's `io/http.fetch`), `log` (levels, `errorDigest`, `Logger`, the sinks,
  per-module imports), `routing` (the neutral bundled library, the file-kind conventions, the late
  navigation signal), `i18n`'s BCP 47 subset and `actions` (`Result`-answering actions, the action
  id). Cookie hooks are request-state-and-cookies; pages are pages-routing-and-stages.
terms:
  - '`cookie`'
  - '`accept`'
  - '`Cookie<T>`'
  - '`fetch`'
  - '`Request`'
  - '`HttpError`'
  - '`errorDigest`'
  - '`Logger`'
  - '`logError`'
  - '`fileSink`'
  - '`consoleSink`'
  - '`captureRuntimeReports`'
  - '`conventions.fileKinds`'
  - '`conventions.classify`'
  - '`kindLetter`'
  - '`matchPath`'
  - '`nav:redirect`'
  - '`ActionError`'
  - '`deriveActionId`'
  - '`isActionId`'
  - '`querystring.parse`'
related:
  - 'request-state-and-cookies'
  - 'pages-routing-and-stages'
  - 'rakun'
  - 'rakun-ssr'
  - 'std'
  - 'result-and-failure'
open:
  - '915 (2): `cookieFromHeader`''s last-wins stays 181''s defect until rakun''s "consume http" step (150, rakun 04 step 5) lands'
binds:
  - '`01-std/04-routing-lib` (the library, its embedding, its tests); jhonstart front 26 (the router importing `routing`), 30 (the late-signal markup, `globals.signal`), 31 (`redirect`); rakun fronts 22 (`file_router.bp` importing `routing`, `rakun.appDir`) and 24 (`rakun.actions.bodyLimit`); onze fronts 49 (the four keys at boot) and 53 (the pages'' imports)'
  - '`03-bundled-libs/102` step 3'
  - '`03-bundled-libs/103` step 2'
  - '`04-rakun/04` (`request_context.bp`)'
  - '`04-rakun/128` step 2'
  - '`04-rakun/17` step 4'
  - '`04-rakun/22`'
  - '`05-jhonstart/26` step 12'
  - '`05-jhonstart/67`'
  - '`07-onze/49`'
  - '`07-onze/53`'
  - '`07-onze/53` typed actions'
  - '`machine-1/144` B-25'
  - '`machine-1/150` (rakun 04 step 5)'
  - '`machine-1/150` (rakun, 776)'
  - '`machine-1/155`'
  - '`machine-1/156`'
  - '`machine-1/156` s1'
  - '`machine-2/166` s3 (log)'
  - '04-rakun/17'
  - '05-jhonstart/26 step 4'
  - '07-onze/49 step 3'
retired:
  - '`fetch(url)` and its `string` error'
  - '`log`''s leaf form `import {errorDigest, Logger} from "log"`'
  - '`ActionOutcome`, `ActionErrorCode`, `orError()`'
  - 'rakun-app''s action-id wrapper'
  - 'rakun''s four `Cookie:` readers, the three q-value parsers'
  - '`jhonstart:redirect:<url>` (the redirect reason)'
  - 'the `rakun-validation` boundary member'
  - 'the orchestrator (onze) translating `notFound` / `redirect` before the first chunk; `rakun.navigation.allowedHosts` for a late redirect'
  - '`rakun-session`''s `session_cookie` last-wins on a duplicated cookie name'
  - 'rakun-logging''s `errorDigest`, rakun-web''s `problem_digest` cell, the render library''s `digestOf`'
  - '`types.bp`''s `appFileKinds()` and `classifyAppFile()` (rakun-ssr)'
  - 'rakun''s five cookie readers (`decodeComponent`, `cookieValue`, `cookieFromHeader`, `cookieFrom`, `sessionIdOf`); `03r-e`'
  - '`fileSink` raising on a failed host call (106-c)'
first-step: 115
last-step: 921
in-force: 20
superseded: 0
---
# actions-http-log-routing-i18n — the small shared libraries

**`http` is the one cookie reader and q-value parser; `log` owns levels, records, the digest and the sinks; `routing` the file-kind conventions; `actions` the action id and the `Result`-answering action.**

(1) `http`: one cookie reader and q-value parser; first wins; strict q-values; `Cookie<T>`; malformed chunks — 196, 181, 182, 294, 915.

(2) `io/http.fetch`'s one typed surface — 623.

(3) `log`: the digest, `Logger`, `logError`, the sinks, per-module imports — 194, 195, 220, 365, 763, 921.

(4) `routing`: the bundled library, the late navigation signal, `rakun.*` keys — 115; the conventions — 171, 172, 173, 323.

(5) `i18n`'s BCP 47 subset — 180.

(6) `actions`: `Result`, `ActionError`, the action id — 303, 324.

Steps: 114, 115, 116, 171, 172, 173, 180, 181, 182, 194, 195, 196, 220, 294, 303, 323, 324, 349, 365, 405, 623, 732, 763, 915, 921
Binds: 102 · 105 · 104 step 1 · 104 step 2 · 106 · 05-jhonstart/26 step 4 · 04-rakun/17 · 07-onze/49 step 3 · 104 · 104 step 6 · `05-jhonstart/26` step 12 · 123 · 127 · `07-onze/53` · 127 s1–s3 · `07-onze/53` typed actions · `libs/actions` · `03-bundled-libs/102` step 3 · `07-onze/49` · `03-bundled-libs/103` step 2 · `04-rakun/22` · `05-jhonstart/67` · `03-bundled-libs/106` step 3 · `04-rakun/17` · `07-onze/49` step 3 · 128 · `04-rakun/128` step 2 · `04-rakun/17` step 4 · `04-rakun/04` (`request_context.bp`) · `03-bundled-libs/106` step 3 (box 1's wasm column, box 3) · `language-gaps.md` (the file-system row) · `machine-1/144` B-25 · `machine-1/155`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 115 | 1.0.10-beta · (the maintainer, 2026-09-26) · (process) | Routing is a bundled library; a signal after the first chunk is markup; the render library (rakun-bpp, then jhonstart) gains `redirect`; rakun's keys are `rakun.*`. Amends 113 (consequence 3), 114 (items 1, 7); 116's and 117's amendments folded in. (1) The routing code server and browser share is the bundled library `routing` at `repository/botopink-lang/libs/routing/`, neutral like std — names no library, speaks no HTTP, keeps no state, declares no host cell; `"targets": ["erlang", "commonJS"]`. Modules: `segment` (`SegmentKind`, `Segment`, `parseSegment`, `parsePath`, `patternOf`, `slotOf`); `table` (`RouteEntry`, `parseTable`, `writeTable`, `kindLabel` — the route table's wire, `contracts.md § 1`); `match` (`RouteMatch`, `matchPath`, `layoutChain`, `paramOf`); `route_kinds` (`RouteKind`, `parseKinds`, `writeKinds`, `routeKindOf` — the `k` blob); `slot_states` (`SlotState`, `parseSlotStates`, `writeSlotStates` — the `z` blob); `url_rules` (`PathRules`, `canonicalize`, `clientHref`, `RedirectRule`, `parseRedirectTable`, `writeRedirectTable`); with 116, `navigation` (the signal vocabulary, the `n` codec) and `pattern` (the `:param` grammar). rakun (the server) and rakun-bpp (the browser router and `Link`) both `import {…} from "routing"` — a neutral library is no edge between the two (113): `rakun-ssr ──► rakun-bpp ──► routing ◄── rakun ◄── rakun-ssr`; the browser router imports `parseTable` and `matchPath` and reads the table from the payload's `t` itself, the orchestrator building no `match` for it (front 26). No `rakun-routing` member (114 item 1); `rakun-validation` ended with 116 — validation is the bundled library `validation`. `from "routing"` resolves as std's import does: bundled with the compiler, never in a manifest's `dependencies`; atoms per 109 (`routing@match`, `routing@match@@RouteMatch`, `routing@url_rules@@PathRules`). The library, its embedding and tests: front `01-std/04-routing-lib`; the formats stay specified by rakun fronts 22, 60, 61 and 65, each server half importing the codec. (1) After the first chunk a navigation signal is markup and the status stays 200. Before the render's first `write`, `notFound` / `redirect` leave the render as its outcome, translated into rakun's 404 / 307 by rakun-bpp itself (117). Once a chunk is written the headers are gone: the render writes the signal into the stream as markup its own client executes, writes no further fill and ends, the response closing with 200 — `<template data-rakun-g="redirect" data-rakun-to="/login"></template><script>__bp2()</script>`, `<template data-rakun-g="not-found">…the nearest not-found boundary's markup…</template><script>__bp2()</script>` (898: `data-jh-*` retired); the client navigates with `location.replace` for `redirect` and for `not-found` replaces the content of `data-rakun-root` with the template's; `data-rakun-g` joins the marker registry (`contracts.md § 2`), `__bp2` is a third global, `globals.signal`, from the registry of `__bp0` / `__bp1` (113 item 6). rakun's redirect checks (`contracts.md § 5b`: a relative target in the route table, an absolute one in `rakun.navigation.allowedHosts`) cannot run once the stream has started, so the check is rakun-bpp's, the same before and after the first chunk (117): a relative target is written only when `routing`'s `matchPath` finds it in the table the render was handed, an absolute one only when listed in `allowedRedirects`, else the render fails (67). (2) rakun-bpp gains `redirect(url)`, a signal like `notFound` (front 31), raising the reason `nav:redirect:<url>` of `contracts.md § 5b` (116; `jhonstart:redirect:<url>` retired), never translated by rakun-ssr (117). A page, layout or template — code the render runs — imports `notFound`, `redirect` and `cookies` from `"rakun-bpp"` only; `cookies` is front 28's reader over the `RequestData` handed in (114 item 8). A server action or a route handler is rakun's code and keeps rakun's signals (front 63); a server action's `redirect` is rakun's (117). (3) rakun reads `rakun.*` keys only: `rakun.actions.bodyLimit` (default 1 MiB, floor 4 KiB), `rakun.appDir` (`app` when unset), beside 114's `rakun.actions.field` / `rakun.actions.header`; rakun-ssr writes all four into rakun's configuration at boot (front 49); no rakun front reads the orchestrator's (then `onze.`) keys. (4) The names 114's sweep chose stay: `rkAppRegisterEntry`, `rkAppRegisterPage<R>`, `servePage`, `setImageRenderer`, `PathRules`, `assertPageDispatch`, `jhRegisterPage` and its siblings, the `jhonstart_routes` sidecar, `enterRequest` / `leaveRequest`, `Payload.extras`, `PageContext.params` / `query` as pair lists, `formMount(actionHeader)`. Unchanged: the route table's wire and precedence (contract 1), the `k` and `z` blobs (fronts 60, 61), the URL rules (65), the signal reasons (contract 5b), the action id and envelope (contract 3), the stylesheet library's API | `01-std/04-routing-lib` (the library, its embedding, its tests); jhonstart front 26 (the router importing `routing`), 30 (the late-signal markup, `globals.signal`), 31 (`redirect`); rakun fronts 22 (`file_router.bp` importing `routing`, `rakun.appDir`) and 24 (`rakun.actions.bodyLimit`); onze fronts 49 (the four keys at boot) and 53 (the pages' imports) | |
| 171 | Q-102-1 | `routing`'s `conventions.fileKinds()` is in the order the kinds wrap a page, outermost first: `layout`, `template`, `error`, `loading`, `not-found`, `page`, then `default` and `route` | 102 | routing_file_kinds_order |
| 172 | Q-102-2 | A file kind's wire letter is `conventions.kindLetter(kind)` in `routing`, the inverse of `table.kindLabel`; rakun-app keeps no private map | 102 | routing_kind_letter_inverse |
| 173 | Q-102-3 | `conventions.classify(appDir, path) -> ?ConventionFile` takes one path; a list is `conventionConflicts(entries)`'s; no `classifyAll` until a consumer needs one | 102 | routing_classify_one_path |
| 180 | 07-c | † `i18n` owns one BCP 47 subset: a language of 2–3 letters, an optional 4-letter script, an optional region of 2 letters or 3 digits, case normalised; a tag outside it is refused, never passed through | 105 | i18n_bcp47_subset |
| 181 | 07-d | † A duplicated cookie name: first wins, everywhere (RFC 6265 § 5.4); `rakun-session`'s `session_cookie` changes from last-wins | 104 step 1 | duplicate_cookie_first_wins |
| 182 | 07-e | † One strict q-value grammar for media, encoding and language: at most three decimals, digits only; anything malformed reads as 0 | 104 step 2 | strict_q_value_grammar |
| 194 | 31-b | One error-digest scheme, one implementation: the first 16 hex of `strongHash` over `module\|errorClass\|message\|topFrames`, frames normalised (the first three, line numbers stripped), `errorDigest(module, errorClass, message, topFrames)` in `log` (195), pinned by one known-answer fixture on every target; rakun-logging's `errorDigest`, rakun-web's `problem_digest` cell and the render library's `digestOf` are deleted; one call both logs and answers the digest a fallback shows | 106 · 05-jhonstart/26 step 4 · 04-rakun/17 · 07-onze/49 step 3 | error_digest_one_scheme |
| 195 | 07-f | `log` — `import {digest.errorDigest} from "log"; import {logging.Logger} from "log";` (763) — levels, `LogRecord`, four renderers, `errorDigest`, a `Logger` whose sink is injected, target-agnostic, used by rakun-bpp and rakun; its sinks and the runtime-report capture are 349's. No `RenderHooks.onError`: the render library's boundary calls `log`'s error-logging function (220), writing the record through the injected sink and answering the digest; with no sink set the default sink (erlang `logger` / node `console`) receives it; `106-log` precedes `05-jhonstart/26` step 4 and `07-onze/49` step 3 | 106 | log_logger_injected_sink |
| 196 | 07-a | `http` — `import {cookie, accept} from "http";` — one cookie reader, one q-value parser, one home for the header codecs, target-agnostic, consumed by rakun and the SSR server; rakun's four `Cookie:` readers (`request_context.bp`, `csrf.bp`, `i18n.bp`, `session_cookie.bp`), the SSR server's and the three q-value parsers are deleted for it; 181, 182 | 104 | http_one_cookie_reader |
| 220 | log-a | The runtime hands the error boundary the caught error's class and frames (erlang: `Class` and the stacktrace; node: `err.name`, `err.stack`); the boundary calls `log`'s `logError(module, errorClass, message, topFrames, fields)`, `module` the boundary's route segment (`"app/blog/[slug]/page"`); frames normalised by `log`'s rule (194) | 05-jhonstart/26 step 4 · 106 · `machine-1/150` (rakun, 776) | error_boundary_logs_class_frames |
| 294 | nat-c2 | A cookie is declared once, typed: `pub val sessionCookie = Cookie<SessionId>("session", httpOnly: true, secure: true, maxAge: days(30));` — the browser's name (281) and the attributes written once; its hooks are 400's (`cookieValue` → `?SessionId`, `#[serverOnly]`, 186; `cookieState`, `cookieSetter`, `cookieReset`); middleware, route handlers and actions write and clear it with the declaration's attributes; a render writes none (122). `Cookie<T>` lives in the `http` package (104), reached by rakun-bpp and rakun alike (113); `T` is one it can encode (string, number, `bool`, enum, one-field record); the pair jar and `pairValue(jar, "…")` leave page code | 104 step 6 · `05-jhonstart/26` step 12 · 123 · 127 · `07-onze/53` | cookie_declared_once_typed |
| 303 | nat-d1 | An action answers `Result`; `ActionOutcome` is removed: `#[action] pub fn signup(input: Signup, ctx: ActionContext) -> Async<Result<Subscribed, ActionError>>` answers as any `Result` function (118: `return v` is `Ok(v)`, `throw e` an `Error(e)` value); the caller gets the same `Result<T, ActionError>` (`callAction`, `actionResult`), read with `case` / `try`. `ActionError` is a sum type, its cases the outcomes, each an HTTP status on the wire: `Input(fields: Dict<string, string[]>)` (written by the wrapper; the function never runs), `BadRequest`, `Unauthorized`, `Forbidden`, `NotFound`, `Conflict`, `TooManyRequests`, `Internal`, each `(message: string)`; `ActionErrorCode` and `orError()` are removed. The envelope's `{data}` / `{error}` JSON is protocol only, never reaching bp code | 127 s1–s3 · `07-onze/53` typed actions · `libs/actions` | action_answers_result |
| 323 | 49-d | `chainFor(patterns)` keeps taking the ancestor patterns rakun's layout chain names for the matched route (rakun-ssr derives no chain), and rakun-ssr consumes `routing.conventions` for what an app file is: `types.bp`'s `appFileKinds()` and `classifyAppFile()` are replaced by `conventions.fileKinds` / `conventions.classify`; rakun-ssr imports `routing` (`07-onze/modules.md` gains onze → `routing`) | `03-bundled-libs/102` step 3 · `07-onze/49` | onze_uses_routing_conventions |
| 324 | 103-a | One function derives an action id: `actions.id.deriveActionId(secret, module, name, buildId)`; `isActionId(id)` for the grammar (163: a bundled package takes no name a framework exports); rakun-app's `actionId(module, name, buildId)` is deleted — its callers (`resolveAction`, the registration in `actions.bp`, `actions_test.bp`) call `deriveActionId` with the secret from the `#[config("rakun.actions")]` record (299), never `rkProp`; the forms library checks with `isActionId` | `03-bundled-libs/103` step 2 · `04-rakun/22` · `05-jhonstart/67` | derive_action_id_one_function |
| 365 | 128-a | A deferred `after()` failure reaching the core's logger is `04-rakun/17` step 4, after 128 (which moves files and changes no body): `drainAfter` in 04's `request_context.bp` reports each deferred function that raised or overran through the core logger — `logger("rakun.request.after").error("after: failed " + id + " " + reason)`, the request id the correlation id — `afterLog()` kept as the request's own record; a cell captures the line; never deleted (67) | `04-rakun/128` step 2 · `04-rakun/17` step 4 · `04-rakun/04` (`request_context.bp`) | deferred_after_failure_logged |
| 623 | B-25-b · (the maintainer, 2026-10-18) | `io/http`'s `fetch` has one typed surface; `fetch(url)` is removed in the same commit: `pub type Request(method: Method, url: string, headers: Header[] = [], body: ?bytes = null)`, `pub type HttpError { NotAllowedOnHost, Network(message: string), Timeout }`, `pub fn fetch(req: Request) -> Async<Result<Response, HttpError>>` (334, 393; 606's prelude names; `Task<…>` reads `Async<…>`, 732); `val r = await fetch(Request(method: .Get, url: u));` — a short GET is the record with its defaults, never a second signature whose `Error(e)` is a text or an enum by the argument's type (67); `Method { Get, Post, … }` and `Header(name: string, value: string)` declared in `io/http`; `fetch(url) -> Result<Response, string>` goes with its `string` error — one error type, matched by variant. Cells: `http_fetch_request` on every target binding `io/http` (B-25 binds wasm), `http_fetch_url_removed` refused by the checker's own `expected Request, got string` | `machine-1/144` B-25 · `machine-1/155` | fetch_one_typed_surface |
| 763 | 195-a · (the coordinator †, 2026-10-19) | log's names are imported each from the module that declares it — `import {digest.errorDigest} from "log";`, `import {logging.Logger} from "log";`; 195's `import {errorDigest, Logger} from "log";` is an example of its time, respelled in the subject file: a package's leaf form names what its default module declares, no re-export (592 (1), 582 (3), 337 (3)), and log's root held `pub mod` lines only (retired, 592 (1)), so the leaf form resolves nothing; the draft `log_logger_injected_sink-195` keeps this spelling (mt-0010) | `machine-1/156` · `machine-2/166` s3 (log) | log_import_each_name_from_its_module |
| 915 | ctr-p · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; `std-a` confirmed, `03r-e` lapses; rejected: `03r-e` kept — a component "as written" that hides a malformed escape (67)) | A query component or a cookie chunk whose escape is malformed, is not UTF-8 or decodes to a control character is refused, never kept as written: `querystring.parse` / `parseForm` answer `Error`; `http`'s `cookie.parse` / `get` answer the chunk as absent, the refused chunk still claiming its name (181: first wins); `03r-e` lapses, rakun's own readers go with 196. (1) `std-a` stands as built (`libs/std/src/querystring.bp`). (2) rakun's `queryDict` already reads through `querystring.parse`; its five cookie readers — `request_context.bp` `decodeComponent`, `rakun-security`'s `csrf.bp` `cookieValue`, `rakun-session`'s `session_cookie.bp` `cookieFromHeader`, `rakun-app`'s `i18n.bp` `cookieFrom`, `rakun-service`'s `exchanges.bp` `sessionIdOf` — are deleted for `http`'s one reader in 150's "consume http" step (rakun 04 step 5), rakun declaring the dependency (242); `cookieFromHeader`'s last-wins is 181's defect until then. (3) Cell in `http`: a cookie header with a chunk decoding to a control character answers that name absent and the well-formed neighbours; the same bytes through `querystring.parse` answer `Error`; four targets | `machine-1/150` (rakun 04 step 5) · `machine-1/155` | malformed_cookie_chunk_absent |
| 921 | 03-bundled-libs (4) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: 106-c's "a failed host call raises" — a sink that raises is not 431's) | `log`'s four choices stand: `consoleSink` writes one line per record on standard output through `terminal.print` on every target (606 (2)); `fileSink` rotates as OTP `logger_std_h` does and on a failed host call answers `Error` of `log`'s own error enum, never a raise (431, 486, 495); per-name levels as `levels.bp` has them; `captureRuntimeReports()` observes and never handles, a no-op binding on wasm (481). (1) The four file cells (`appendLine`, `fileBytes`, `moveFile`, `removeFile`) carry `result: true`; `fileSink` / `appendRotating` map `HostError` into `log`'s enum; 156 rewrites `sink.bp`'s header line still naming `@print` and `logfile.bp`'s "raises" (retired forms). (2) Cell in `log`: a rotation over `maxBytes` with `maxFiles` 2 leaves `<path>`, `<path>.0`, `<path>.1`; a write to an unwritable path answers `Error`; four targets | `machine-1/156` s1 | log_file_sink_answers_error |
