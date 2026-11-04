---
scope: >-
  How code enters the compiler: the typed AST (`compiler.ast`, the `Node` records, `Fn` and the type
  nodes), where a tree's type error is located, the caller's code spliced as a `syntax` value, and
  std's mocks; code from a string (`compiler.build`) is gone. The `code` template, `compiler.text` and
  `compiler.lookup` are templates and compiler-module; `syntax` parameters are
  syntax-and-comptime-parameters.
terms:
  - '`compiler.ast`'
  - '`Node`'
  - '`Call`'
  - '`Arg`'
  - '`Fn`'
  - '`Lambda`'
  - '`ast.Expr`'
  - '`code.bp`'
  - '`compiler.lookup`'
  - '`compiler.build`'
  - '`mock`'
  - '`testing/mocks`'
  - '`compiler.buildTypeInline`'
  - '`HttpError.NotAllowedOnHost`'
  - '`spawnAll`'
  - '`race`'
  - 'B-149'
  - '`template_caller_code_as_syntax`'
related:
  - 'compiler-module'
  - 'templates'
  - 'syntax-and-comptime-parameters'
  - 'decorator-outputs-and-meta'
  - 'host-functions'
  - 'std'
open:
  - '335 (3): `testing/mocks` stays refused on wasm until `botopink test` runs the wasm column'
binds:
  - '`01-compiler/140`'
  - '`02/97` steps 11, 17'
  - '`machine-2/144` B-149'
  - '`machine-2/144` B-149 P1b, P4'
retired:
  - '`Call(fn: …)` (625 (2)''s sample)'
first-step: 71
last-step: 801
in-force: 5
superseded: 1
---
# typed-ast-code-and-mocks — `compiler.ast`, `Node`, `code` and `mock`

**Code never enters the compiler as a string: it is written (a `syntax` parameter, a template text) or built as the typed AST; `compiler.build(text)` is gone.**

(1) The `Node` records, `compiler.ast`, where a tree's error is located — 751, 752, 753.

(2) The caller's code as a `syntax` splice, the cells rewritten — 801.

(3) Mocks in the wasm module's memory, `fetch` on the `browser` host, `async` ordering — 335.

(4) Overtaken — 71 (by 644).

Steps: 71, 335, 625, 637, 638, 640, 644, 645, 751, 752, 753, 801, 802
Binds: `02/97` steps 11, 17 · `01-compiler/140` · `lib-test-runner` (the wasm column) · `machine-2/144` B-149, B-140 · `machine-1/165` s10, s11 · `machine-2/144` B-149 · `machine-1/165` s11 · `machine-2/144` B-148, B-149 · `machine-1/144` B-140

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 71 | 1.0.10-beta · (the maintainer, 2026-09-20) | Overtaken by 644 | `01-std` step 4 (`onze-migration.md`) | |
| 335 | 97-a · 97-b · 97-c | (1) `io/http`'s `fetch` is one contract with full control on every target; on the `browser` host a request it cannot make — a forbidden header (`Host`, `Cookie`, `Origin`, `Content-Length`, …), reading `Set-Cookie` — answers the typed `HttpError.NotAllowedOnHost(…)` naming what, never a header dropped in silence; the same request succeeds on wasmtime, Node and erlang; CORS stays the server's answer. (2) `async`: on every target the results and the order of the answers are the contract (`spawnAll` answers in input order, `race` the first to complete); the order of effects between concurrent tasks is contract on no target, and no test depends on it. (3) `testing/mocks`' registry lives in the wasm module's own memory — no host, the API (644) unchanged, alike on `wasi` and `browser` —, landing when `botopink test` runs the wasm column; until then the module stays refused on wasm with today's located message | `02/97` steps 11, 17 · `01-compiler/140` · `lib-test-runner` (the wasm column) | wasm_host_forbids_typed_error |
| 751 | b149-g · (the coordinator †, 2026-10-19; built as (a) by machine 2, reviewed by fable) | `Node` is a closed union alias of the vocabulary the parser has: `pub type Node = Name \| Lit \| Member \| Call \| Arg \| List \| Tuple \| Binary \| Unary \| If \| Lambda;` — one record per kind of the parser's `ast.Expr` (625 (2)); the `Syntax` node is removed (802); `Call(callee: …, args: …)` because `fn` is reserved and a field needs an identifier; no `Record` / `Field` / `Case` — the parser has no such kind, a construction is a `Call` with `Arg`s; `compiler.ast`'s argument is checked in the reply, not unified with `Node` | `machine-2/144` B-149 | ast_node_closed_union |
| 752 | b149-j · (the coordinator †, 2026-10-19) | A type error inside a tree `compiler.ast` builds is reported at the `ast` call — located at the caller's call, the message naming the library's `file:line:col` of the `ast` call and the node; a splice of the caller's code (a `syntax` value reached through `compiler.lookup`, 802) keeps the caller's own location; a tree carries no location of its own | `machine-2/144` B-149 | ast_tree_type_error_at_call |
| 753 | b149-m · (the coordinator †, 2026-10-19; fable's review of P1) | `Node` grows `Fn(params, ret, body)` — a typed parameter list, a return type, a statement body — and the type nodes, one record per kind of the parser's type grammar, measured off 644's mock member and the forms `code` must build; `Lambda(params: string[], body: Node)` stays for an untyped lambda; `` code @`fn(self: Self, ${params}) -> ${ret} { return … }` `` builds as a tree, so P1b (`code.bp`) and P4 (`mocks.bp`) need no text; no raw-text escape | `machine-2/144` B-149 P1b, P4 | ast_fn_node_builds_mock_member |
| 801 | 149-a · (the maintainer, 2026-10-20: chose (a), over (b) the cells retired with `compiler.build`) | The cells that build the caller's raw text as code are rewritten, not retired: the caller's code arrives as a `syntax` expression (719) and is spliced into `code` as written (802), located by 752 at the caller's own text; a build value that became code through a string becomes a hole of `code`. (1) 429's `template_built_code_diagnostic_located`: `pub fn located(syntax q: unknown) -> anyvalue { return code @`${q}`; }`, `located(boxes.map({ r -> r.d }))` refused `unknown field 'd' on type 'Box'` at the caller's `d`; the first expansion reading `r.w` accepted. (2) The same for 691's `template_hole_error_at_column`, 577's refused package, 578's `compiler_template_expr_return` and 515's `local_dependency` (`shapesdsl`). (3) The seven `bpp_*` cells' `markup` dependencies answer `code @`${compiler.text(t).length()}`` — a build value, a `Lit` —; `compiler.build(….toString())` is gone. (4) Each cell's expected location and its `docs.md` rewritten; what each proves is unchanged | `machine-2/144` B-149 | template_caller_code_as_syntax |
