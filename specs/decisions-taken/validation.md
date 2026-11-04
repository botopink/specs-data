---
scope: >-
  Decides the `validation` library: `#[validated]` as the one schema (its parse members, field
  markers, `#[check]`, unknown keys, coercion, the `ValidationReport`, the injected message lookup,
  JSON Schema checking) and 116's placement of `actions`, `validation`, `routing`'s `navigation` /
  `pattern` and std's JSON writers. Derived types (`Type.pick`, …) are derived-types-and-fields; the
  action protocol's use is actions-http-log-routing-i18n.
terms:
  - '`#[validated]`'
  - '`#[check]`'
  - '`#[refine]`'
  - '`#[each]`'
  - '`#[codec]`'
  - '`#[stripUnknown]`'
  - '`#[rest]`'
  - '`#[coerce]`'
  - '`ValidationReport`'
  - '`MessageSource`'
  - '`unrecognizedKey`'
  - '`invalidType`'
  - '`Player.parse`'
  - '`jsonSchema`'
  - '`json.quote`'
  - '`escape.scriptJson`'
  - '`NavOutcome`'
  - '`ActionEnvelope`'
  - 'Zod'
  - 'Ajv'
related:
  - 'derived-types-and-fields'
  - 'actions-http-log-routing-i18n'
  - 'data-formats'
  - 'library-split'
  - 'std'
  - 'decorators'
binds:
  - '`01-std/04-routing-lib` (`navigation`, `pattern`), `01-std/05-actions-lib` (the library), `01-std/06-validation-lib` (the library and the move), `01-std/07-std-json-writers` (`json.quote` and the writers, `escape.scriptJson`); rakun fronts 14 (the member removed), 24 (the envelope through `actions`), 63 (the vocabulary imported), 07 (the matcher through `routing`), 23 and 05 (std `json`), 62 (std `encoding`); jhonstart fronts 26 (`signalFromWire`, std `encoding`, the `a b` cell), 30 (`escape.scriptJson`, the late signal through `signalFromReason`), 31 (the `nav:` reasons), 67 (`actions`); emilia front 56 (`contentHash`); onze fronts 68 (`contentHash`, emilia''s build-time function) and 69 (front 82 configured)'
  - '`03-bundled-libs/125` step 9 box 3'
  - '`03-bundled-libs/125` steps 4–12'
  - '`03-bundled-libs/125` steps 6, 8, 9, 12'
  - '`08-bpp/121` s10'
  - '07-j'
retired:
  - 'rakun''s JSON writers `jsonString` / `jsonStrings` / `jsonPairs` / `jsonTriples`, the two `jsonEscape`s, `config.bp`''s hand scanner'
  - 'rakun''s `request_context` codec; jhonstart''s `decodePairs` / `encodePairs`'
  - 'emilia''s `hashHex`'
  - 'jhonstart''s private `payloadEscape`'
  - '`Schema<T>`, `Codec<A, B>`, `schemas.*`, `checks.*` (public); the module-level functions named after a type'
  - '`jhonstart:redirect:<url>` (the redirect reason)'
  - 'the `rakun-validation` boundary member'
  - '`#[schema]`'
  - 'the `union2…5` / `tuple2…5` families; a loose value checked ad hoc'
  - 'the `jhonstart:` navigation-reason prefixes'
  - 'rakun-web''s middleware matcher and the CORS preflight''s `routeMatches` (two more path grammars)'
first-step: 116
last-step: 399
in-force: 8
superseded: 0
---
# validation — `#[validated]`, the field markers, coercion, JSON Schema

**The type is the only schema: `#[validated]` both checks and parses; what only a value could say is a field marker; every failure is a `ValidationReport` with each violation at its path.**

(1) The decorator, its members, field markers — 306, 327, 325.

(2) Unknown keys, the report, coercion — 144, 257, 183.

(3) Placement, message lookup, `actions`, `navigation`, JSON writers — 116.

(4) JSON Schema checked in tests — 399.

Steps: 116, 144, 183, 257, 306, 325, 327, 332, 399, 404, 406, 598, 735
Binds: 125 · 127 · 125 step 6 · 125 step 2 · 125 s12 (s4, s7–s9 narrowed) · `08-bpp/121` s10 · `117` s8 · `127` s5 · 130 (`#[schema]` row) · 07-j · `03-bundled-libs/125` steps 4–12 · `03-bundled-libs/125` steps 6, 8, 9, 12 · `surface.md` · 120, 121, 127, 136 · `03-bundled-libs/125` step 9 box 3 · `03-bundled-libs/125` step 7 · `01-compiler/01-checker` (example 1 of `decorator-arguments-280.md`) · `01-checker` step 24 (example 1 of `decorator-arguments-280.md`) · `03-bundled-libs/125` steps 7, 8 · `01-compiler/16` · `1-botopink-lang/144` B-140, B-10 · `2-libraries/146` s3 (`#[check]`, the optional field)

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 116 | 1.0.10-beta · (the maintainer, 2026-09-26) · (process) | **Code two libraries both run is neutral: `routing` gains navigation and `:param`, `actions` and `validation` are bundled libraries, std writes JSON.** Amends 113 (consequence 8), 114 (item 7), 115 (rules 1, 3). A bundled library names no framework and is no edge between rakun-bpp and rakun; the list: `std`, `routing`, `actions`, `validation` (repositories of their own, ordinary dependencies, since 326). (1) `routing` gains the module `navigation`, pure: `pub type NavKind { None, NotFound, Redirect }`, `pub type NavOutcome(kind: NavKind, location: string, status: i32)`, `signalToWire(out: NavOutcome) -> string` (`""` · `"N"` · `"R\|307\|/login"`), `signalFromWire(wire: string) -> NavOutcome` (garbage reads `None`); the four verbs' statuses — `notFound()` 404, `redirect(loc)` 307, `permanentRedirect(loc)` 308, `redirectWithStatus(loc, 303)` 303 — their raise-based reasons retired by 924 (`signalReason`, `signalFromReason`, `isSignalReason`, `signalPrefixes`, the `nav:` / `jhonstart:` prefixes; a signal is a `NavSignal(outcome: NavOutcome)` node the renderer reads). rakun front 63 keeps the server's part only: the throw host cell `rakun_navigation`, the capture (`captureSignals`, `takeSignal`, `peekSignal`), the redirect-target checks and `rakun.navigation.allowedHosts`, the response composition (`statusFor`, `locationHeaderFor`, `boundaryFor`); rakun-bpp (fronts 26, 30, 31) imports the vocabulary, no copy. (1) The server-action protocol is the library `actions` (`"targets": ["erlang", "commonJS"]`; imports std and `routing`), every text both sides read or write: `state` — `ActionState(ok, message, redirectTo, fields)`, `newActionState`, `writeState`, `parseState`, the grammar (`message`, `f.<name>`) percent-encoded by std's `encoding`; `envelope` — `ActionEnvelope`, the v1 envelope `{"v":1,"ok":…,"state":…,"revalidated":[…],"redirect":…,"n":…,"payload":…}`, `writeEnvelope` (`v` first, `redirect` from `n` through `signalFromWire`), `flattenEnvelope` (the flat querystring form), `readEnvelope`, `parseActionState(envelope)`; `rpc` — `RpcCall(id, args)`, `writeRpcBody`, `parseRpcBody`, the body `{"v":1,"id":…,"args":[…]}`, an unknown `v` an `Error`; `refresh` — `refreshValue()`, the header value `refresh` asking a re-render with no action. No field and no header named: `actionField` / `actionHeader` come from rakun-ssr (114 item 7); rakun front 24 writes the envelope and reads the RPC body, rakun-bpp front 67 the reverse (the browser's one writer), front 26's `refresh()` sends `refreshValue()`; the golden `state` literal is asserted once, in `actions`, both targets; JSON read through std's `json.decode` (117). (1) std `json` writes JSON: `json.quote(s)` (a JSON string literal escaping `"`, `\` and every control character below 0x20 — `\b` `\f` `\n` `\r` `\t` by name, the rest `\u00XX`), its inverse `json.unquote(s)`, and the writers over already-encoded values `json.arrayOf(items: string[])` (873's name) and `json.object(fields: #(string, string)[])` (keys quoted by the writer); rakun's own writers and scanner (`jsonString` / `jsonStrings` / `jsonPairs` / `jsonTriples`, both `jsonEscape`s, `config.bp`'s string reader) are deleted; the JSON configuration reader checks with `json.decode` (117) and reads string tokens with `json.unquote`; the envelope, the RPC body, rakun-bpp's payload and `RenderPlugin.payload` (114 item 2) use the same functions. (2) std `encoding` is the one percent and form codec on both sides (`percentEncode`, `percentDecode`, `formParse`, `formStringify`); rakun's `request_context` codec and rakun-bpp's `decodePairs` / `encodePairs` are deleted when that front lands; the payload's `m` / `q` are read decoded — front 26's cell: `?q=a%20b` reads `a b`, written back `q=a%20b`. (3) Validation is the library `validation` (`"targets": ["erlang", "commonJS"]`; imports std only): rakun front 14's `modules/rakun-validation` moved whole (constraints and markers, `#[validated]` and its two emitted functions, the constraint SPI, the violation report, the constraint table, typed coercion, the message templates with interpolation). The message lookup is injected: `pub type MessageSource(locale: fn() -> string, template: fn(key: string) -> string)`, `pub fn setMessageSource(source: MessageSource) -> i32`; the library tries `<locale>.<code>`, then `<code>`, then the built-in text (no source: the built-in); rakun sets it at boot over `rakun.validation.locale` / `rakun.validation.messages.*`, rakun-ssr sets the browser's in its generated entry. The library spells no `rakun.` key and imports nothing of rakun's (`messages.bp`'s `rkProp` import removed); rakun, rakun-ssr and application code `import {…} from "validation"`; the `rakun-validation` member is removed from rakun; the boot refusal text (`boot.bp`, "rakun config: … will not start") stays rakun's beside front 05's binder; its two host tables (the constraint registry, the per-request binding accumulator) are inline `#[compiler.external(…)]` templates, the bundled registry embedding `.bp` files only; every rakun manifest, `rakun-test` included, is `["erlang"]` (117) — 113 item 8's exception and 115's "one boundary member" end. (4) rakun-ssr configures rakun-service's static-file server (rakun front 82) instead of specifying one: `contentTypeOf`, `resolveAsset`, the ETag / `304` rule and the path-traversal guard leave rakun-ssr front 69's spec; rakun-ssr hands front 82 its roots, URL prefix and cache policy at boot. (5) rakun-stylesheet and rakun-ssr hash with std's `hash.contentHash`: the stylesheet's `hashHex` is deleted; rakun-ssr front 68's recomputation of "both folds" calls the same function (contract 4 clause 3 compares one implementation compiled twice) and reaches the stylesheet's rules at build through a function rakun-stylesheet exports for it — a direct import, not the render-plugin bridge. (6) std `escape` gains `scriptJson` — JSON inside a `<script>` element, escaping `&`, `<`, `>` (`\u0026`, `\u003c`, `\u003e`) and U+2028 / U+2029 (`\u2028`, `\u2029`), what neither `escape.html` nor `escape.jsString` gives; rakun-bpp front 30's payload writer uses it, its private `payloadEscape` leaves. (7) `routing` owns the `:param` path grammar too: rakun-service's middleware matcher (a literal segment, `:param`, a trailing `:param*`, else refused by name) and the CORS preflight's `routeMatches` become calls into `routing`'s module `pattern` (`parsePattern`, `matchPattern`, `patternProblem`), which keeps the refusal; the file-convention grammar (`[slug]`, `[...rest]`) and the `:param` grammar stay two grammars in one library with one test suite. Unchanged: the route table's wire and precedence (contract 1), the payload's keys (contract 2), the action id and the envelope's keys (contract 3), the class-name scheme (contract 4), the request context (contract 5), the `n` wire forms and contract 5b's four verbs (only their prefix), the stylesheet's API. Front 07's writers are steps of `01-std-lib-enablement` (117) | `01-std/04-routing-lib` (`navigation`, `pattern`), `01-std/05-actions-lib` (the library), `01-std/06-validation-lib` (the library and the move), `01-std/07-std-json-writers` (`json.quote` and the writers, `escape.scriptJson`); rakun fronts 14 (the member removed), 24 (the envelope through `actions`), 63 (the vocabulary imported), 07 (the matcher through `routing`), 23 and 05 (std `json`), 62 (std `encoding`); jhonstart fronts 26 (`signalFromWire`, std `encoding`, the `a b` cell), 30 (`escape.scriptJson`, the late signal through `signalFromReason`), 31 (the `nav:` reasons), 67 (`actions`); emilia front 56 (`contentHash`); onze fronts 68 (`contentHash`, emilia's build-time function) and 69 (front 82 configured) |  |
| 144 | 07-l | A `#[validated]` record (306) refuses an undeclared key: a violation coded `unrecognizedKey`, at the key's own path; `#[stripUnknown]` and `#[rest]` are the two located ways for a type to say otherwise, no setting changes the default (67); a framework adding fields to a form (`08-bpp/127`) drops them before the type sees the pairs | 125 · 127 | validated_refuses_unknown_key |
| 183 | 07-m | † `validation`'s coercion is a grammar per target type, the same on erlang and commonJS: `bool` reads the `stringbool` set; a number the integer grammar with a fraction and an exponent; `""` and `null` are absent; anything else `invalidType` | 125 step 6 | validation_coercion_grammar |
| 257 | 07-n | `#[validated]` (306) and its private schema machinery live in `validation` beside the constraint markers; every failure — a constraint or a decode — is a `ValidationReport`, each violation at its path; std knows nothing of validation (nor of JSON, 396) | 125 step 2 | validated_reports_violations_at_path |
| 306 | nat-d3, nat-d4 | **The type is the only schema; `#[schema]` is replaced by `#[validated]`.** `#[validated] pub type Signup(#[email] email: string, age: i32)` both checks (`validate()`, `constraints()`) and parses (327's members `parse`, `parseAt`, `decode`, `bind`, `encode`, `jsonSchema` — `Player.parse(doc)`); `Schema<T>`, `Codec<A, B>`, the `schemas.*` combinators and the `checks.*` functions are removed from the public API — `schemas.bp` stays private machinery the emitted decoders call. What only a value could say is a field marker: `#[each(email, lowercased)]`, `#[codec(decode: isoToMillis, encode: formatIso)]`, `#[map(f)]` / `#[tryMap(f)]`, `#[preprocess(f)]`, `#[refine(rule)]` (406); a one-field record encoded as its field: `#[validated(transparent)] type Email(#[email] value: string)`. An ad-hoc union or tuple is a declared type (the `union2…5` / `tuple2…5` families go); a loose value is checked by a declared type or the `constraints.v*` predicates; a `surface.md` row no declaration says naturally (`pipe`, `xor`, `both`, `lazy`, `custom`, …) is a field marker where one reads well, else `n/a (306)` with its reason. Another library takes the type, never a schema value — a `comptime` type parameter, refused unless `compiler.typeInfo(T).meta(Validated)` is present (298): `collection(BlogPost)`, `paginate(…, Astronaut)`, an action's input and output from its signature | 125 s12 (s4, s7–s9 narrowed) · `08-bpp/121` s10 · `117` s8 · `127` s5 · 130 (`#[schema]` row) · 07-j | validated_type_is_schema |
| 325 | 07-j · (process) | **Front 125 is all of Zod in 306's shape, every step in order.** Enums, unions, tuples, maps and sets as declared types (4); object policy and 307's derived types (5); coercion, transforms and the form binder `bind` (6); refinements as `#[check(…)]` (406) with function values and messages (7); codecs, `#[map]`, `#[preprocess]`, `#[each]` as field markers, and `encode` (8); reflection, error views (`flatten`, `tree`, `pretty`), metadata and `jsonSchema` (9); locales `en`, `ptBR`, `es` (10); `#[validated]`'s members are 327's; every `surface.md` row is a marker, a declared type or `n/a (306)` with its reason | `03-bundled-libs/125` steps 4–12 |  |
| 327 | ctr-u | **`#[validated]`'s parse half are members of the type, named without the type's name:** `Player.parse(doc)` (`Json` → `Result<Player, ValidationReport>`), `Player.parseAt(doc, at)` (violations under the path `at`), `Player.decode(text)` (JSON text), `Player.bind(pairs)` (form pairs, 325 step 6), `Player.encode(p)` (→ `Json`, step 8), `Player.jsonSchema()` (step 9) — beside `validate()` and `constraints()`, carried with the type to every importer (216); the module-level `parsePlayer`, `parsePlayerAt`, `decodePlayer`, `schemaOfPlayer` are removed; `Schema<T>` is private (306) | `03-bundled-libs/125` steps 6, 8, 9, 12 · `surface.md` · 120, 121, 127, 136 | validated_parse_members_on_type |
| 399 | 125-a | **`validation`'s JSON Schema documents are checked against the 2020-12 meta-schema by a vendored validator, in the tests only.** Ajv's standalone 2020 build (MIT) is vendored under `repository/validation/test/tools/`, entry `check-schema.js`; `test/json_schema_test.bp` runs `io.process.run("node", ["test/tools/check-schema.js", <document>])` on commonJS for every document the suite emits — `ok`, or the validator's error list fails the test; no network, nothing installed; version and hash in `repository/validation/AGENTS.md`; never in `src/`, never shipped (`files`), never imported by the library or its consumers; the sixteen literals against ZOD_DOCUMENTATION.md § 8 stay, both targets | `03-bundled-libs/125` step 9 box 3 | json_schema_checked_by_meta_schema |
