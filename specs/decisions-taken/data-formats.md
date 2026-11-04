---
scope: >-
  The three data libraries: `json` (the `Json` value and its number variants, `decode` / `encode` as
  the one way, `quote` / `unquote` / `arrayOf` / `object`, `isString`), `yaml` (the subset read into
  `Json`) and `markdown` (its node tree and how a page renders a node through `toElementWith`).
  `Decimal` and number arithmetic are std's and numbers-and-arithmetic's; where `json` lives as a
  repository is library-split.
terms:
  - '`Json`'
  - '`decode`'
  - '`encode`'
  - '`quote`'
  - '`unquote`'
  - '`arrayOf`'
  - '`object`'
  - '`JsonError`'
  - '`Int`'
  - '`BigInt`'
  - '`Dec`'
  - '`isString`'
  - '`isObject`'
  - '`MdNode`'
  - '`MdDoc`'
  - '`toElementWith`'
  - '`toElement`'
  - '`NodeChild`'
  - '`json_is_string`'
related:
  - 'std'
  - 'library-split'
  - 'numbers-and-arithmetic'
  - 'rakun-ssr'
  - 'markup-and-rakun-bpp'
open:
  - '941: `isString` is written in std''s `json.bp` only until 151 s1 moves the `Json` type into `json`'
  - '916 (3): 158 s1''s open box (the page-rendered markdown node)'
binds:
  - '`02/97` step 15'
  - '`05-wasm` step 5'
  - '`machine-1/144` (std `json.bp`, until 151 s1)'
  - '`machine-1/150` (rakun-ssr content)'
  - '`machine-1/150` s59'
  - '`machine-1/151`'
  - '`machine-1/151` s1'
  - '`machine-1/158` s1'
retired:
  - '`json.parse`, `json.stringify`'
  - '`rakun-ssr/src/config.bp`''s own `isString(v: Json)` and `types.bp`''s import of it'
first-step: 336
last-step: 941
in-force: 4
superseded: 0
---
# data-formats — `json`, `yaml`, `markdown`

**Three libraries of their own; std knows nothing of JSON; `Json` reads numbers like Jackson's strict configuration; `decode` / `encode` are the one way.**

Steps: 332, 336, 396, 500, 778, 916, 941
Binds: `01-compiler/139` · `02/97` step 15 · `03-bundled-libs/125` · `04-js` step 9 · the 13 files with a `case` over `Json` · `05-wasm` step 5 · `03-bundled-libs/142` · `02/97` (std loses `json`) · `08-bpp/121` step 3 · rakun (`config.bp`) · the six consumers · `1-botopink-lang/144` B-24, B-27 · `2-libraries/151` s1

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 336 | 05w-j | `json.parse` / `json.stringify` removed; `json.decode` / `json.encode` are the one way, every target, both wasm hosts (in the `json` library, 396). The host round trips (`JSON.parse`/`JSON.stringify` on Node, `json:decode`/`json:encode` on erlang) are deleted; `decode` (strict: duplicate member, overflow, unpaired surrogate are `Error`; members in document order) and `encode` (document order, numbers exact by 332) are botopink bodies, so `json` compiles on wasm under `wasi` and `browser` with no host | `02/97` step 15 · `05-wasm` step 5 | json_decode_encode_only |
| 778 | 396-a (json) · (the coordinator †, 2026-10-19; m2-0024) | json's helpers (396 (1)): `unquote(s: string) -> Result<string, JsonError>` reads a JSON string literal back to its text, `quote`'s inverse; `arrayOf(items: string[]) -> string` (873 renamed `array`) and `object(members: #(string, string)[]) -> string` join texts that are already JSON values into one JSON text, no escaping of the parts; a part that is not a JSON value is the caller's error, not checked. "Decided, not built" until json's `src/`. | `machine-1/151` | json_quote_unquote_array_object |
| 916 | 396-a (onze-content) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; (a), typed by 804 and 809 (7); rejected: (b) a record of one optional function per node kind — 21 fields to keep in step with the tree; (c) the page walking `MdDoc` itself — the default mapping's bookkeeping in every page) | `rakun-ssr`'s content offers `toElementWith(doc: MdDoc, render: fn(node: MdNode, kids: NodeChildren) -> ?NodeChild) -> NodeChild` beside `toElement(doc) -> Element`: the page's function sees each node with its already-rendered children and answers the node to place — a component value (`<MeuTitulo nivel={depth} id={id}>{kids}</MeuTitulo>`, a `Component<Element>` the renderer resolves, 809 (7)) or `null` for the default element. (1) One function, one typed `case` over `MdNode`'s kinds (281: the kind is the variant, never a string); `Item`, `Row` and `Cell` are nodes offered by their parents; a tight list's paragraphs keep their `tight` rendering when the hook answers `null`. (2) `element.bp`'s `toElement`, `blockElement`, `inlineElement`, `itemElement`, `tableElement`, `rowElement` thread the hook; `markdown`'s `MdNode` stays public and names no framework (396 (3)). (3) 158 s1's open box. | `machine-1/158` s1 · `machine-1/150` (rakun-ssr content) | markdown_node_rendered_by_page_component |
| 941 | 49-g · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: std's `json.bp` has `isObject` and `kindName`, no string test; `repository/json` holds no `src/` yet (151 s1); `rakun-ssr/src/config.bp:98` keeps `isString(v: Json)`; rejected: (a) the ssr's own; (c) `kindName() != "a string"` — a diagnostic text as a type test) | (b): `Json` gains `pub fn isString(self: Self) -> bool` beside `isObject`, in std's `json.bp` (retired home, 396 (1)) only until 151 s1 moves the type into `json`, travelling with it; `rakun-ssr` deletes its own. (1) `config.bp`'s `isString` and `types.bp`'s import go: `if (v.isString() == false) throw wrongKind(…)`. (2) Cell `json_is_string`, four targets, red on the parent. | `machine-1/144` (std `json.bp`, until 151 s1) · `machine-1/151` s1 · `machine-1/150` s59 | json_is_string |
