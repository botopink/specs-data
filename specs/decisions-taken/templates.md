---
scope: >-
  Decides template functions: the one call form `` name @`…` `` (also a method `` recv.name @`…` ``
  and an annotation `` #[name @`…`] ``), the `syntax q: string` signature and its refusals, what a
  body reads (`compiler.text`, `compiler.lookup`, `compiler.bindings`), the return `T` / `anyvalue` /
  `anytype`, what a hole writes, name hygiene, where built code is located. The typed AST and `code`
  are typed-ast-code-and-mocks; `syntax` / `comptime` parameters are syntax-and-comptime-parameters.
terms:
  - '`syntax q: string`'
  - '`anyvalue`'
  - '`anytype`'
  - '`compiler.text`'
  - '`compiler.lookup`'
  - '`compiler.bindings`'
  - '`compiler.note`'
  - '`compiler.custom`'
  - '`syntax-call-outside-syntax`'
  - '`template-signature`'
  - '`template-annotation-only`'
  - '`template-annotation-without-decl`'
  - '`typeinfo-meta-at-build`'
  - '`behavior Display`'
  - 'template method'
  - 'expansion id'
  - 'hole'
  - '`{expr}`'
  - 'DSL hygiene'
related:
  - 'syntax-and-comptime-parameters'
  - 'typed-ast-code-and-mocks'
  - 'query-and-rakun-data'
  - 'markup-and-rakun-bpp'
  - 'strings-bytes-and-text'
  - 'compiler-module'
open:
  - '190: the compiler owes a typed embedded expression reaching the template with its type and position (a `language-gaps.md` row)'
  - '691: a later step may locate hole leaves exactly where a sub-language records them, the word-copy rule otherwise'
  - '520: a printed form of `bytes` chosen by the static type is a later decision'
binds:
  - '`01-checker` step 29'
  - '`01-checker` step 40'
  - '`01-checker` step 41'
  - '`01-checker` steps 29 (the template method) and 39'
  - '`01-compiler/134` step 2 (`build<R>`, `note`)'
  - '`04-rakun/137` step 2'
  - '`04-rakun/137` step 3'
  - '`04-rakun/137` step 4'
  - '`04-rakun/137` steps 2, 4'
  - '`04-rakun/143`'
  - '`05-jhonstart` (`html.bp`)'
  - '`08-bpp/116` step 4'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` B-136'
  - '`2-libraries/165` s10'
  - '`machine-1/144` B-136'
  - '`machine-1/144` B-18'
  - '`machine-1/145`'
  - '`machine-1/150`'
  - '01-compiler'
  - '05-jhonstart/26'
  - '08-bpp/118 step 2'
  - '14-comptime-on-beam step 2'
retired:
  - '`-> @Expr<T>`, `-> @ExprCustom<T>`, `-> syntax T`, `-> expr`'
  - 'A bare type-position `type`'
  - '`compiler.holes(t)` (the caller''s `${…}` as `syntax` values)'
  - '`compiler.parts`, `Part`'
  - 'Template calls `name "…"`, `name """…"""`, `name("lit")`, `#[name("lit")]`'
  - 'a template reading the expected type (`q.expected()`)'
  - 'the padded expansion (`q.build(pad + code)` in `query.bp` / `html.bp`) and its `// LANGUAGE GAP` markers'
  - 'erika; `erika "…"`'
first-step: 27
last-step: 696
in-force: 15
superseded: 0
---
# templates — `name @`…``, template methods and annotations, holes and types

**A template is a function whose first parameter is `syntax q: string`, called one way — its name before a raw template text `` @`…` `` —, returning an ordinary type, `anyvalue` or `anytype`; the code it answers is built, never parsed back from a string.**

(1) The call form, the signature, annotations and methods — 577, 696, 685, 425.

(2) The call's type and the return — 426.

(3) What a body reads; name hygiene — 112, 237, 415, 190.

(4) What a hole writes — 530, 520, 204, 27.

(5) Where built code is located — 429, 691.

Steps: 27, 112, 190, 204, 237, 311, 415, 425, 426, 429, 520, 530, 532, 576, 577, 578, 636, 637, 669, 685, 686, 691, 696, 719, 802
Binds: 08-bpp/118 step 2 · 01-compiler · 05-jhonstart/26 · 118 · 14-comptime-on-beam step 2 · `01-checker` step 29 · `16-formatter` step 9 · `04-rakun/137` step 5 · rakun 08 step 7 · `01-checker` steps 29 (the template method) and 39 · `04-rakun/137` steps 2, 4 · `docs.md` § Template functions · `04-rakun/137` step 2 · `04-rakun/143` · `01-checker` step 40 · `01-compiler/134` step 2 (`build<R>`, `note`) · `04-rakun/137` step 3 · `01-checker` step 41 · `04-rakun/137` step 4 · `05-jhonstart` (`html.bp`) · `08-bpp/116` step 4 · `language-gaps.md` · `1-botopink-lang/144` · `1-botopink-lang/144` B-136 · `2-libraries/165` s10 · every library declaring or calling a template · `1-botopink-lang/144` B-136, B-140 · every library declaring a template · `machine-2/144` B-149 · `machine-1/165` s11 · `machine-1/144` B-18 · `machine-1/145` · `machine-1/144` B-136 · `machine-1/150`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 27 | 1.0.5-beta · (the maintainer, 2026-09-18) | `01-checker` declares `behavior Display` in `libs/std`, in its step 11 (decision 8 in the sources); `libs/std` implements `Display` for `Dict` (decision 8 § 7); the § 7 step of `02-erlang`, `03-beam`, `04-js` and `05-wasm` reads that one declaration | the §7 step of `02-erlang`, `03-beam`, `04-js` and `05-wasm` — four fronts reading one missing declaration |  std_declares_display_behavior |
| 112 | 5-a · (the maintainer, 2026-09-26) | DSL hygiene: each name in template-built code resolves in the scope of whoever wrote it — the library writes the frame, the user the raw text (`compiler.text(q)`); the compiler marks each span with its author, the DSL author writes nothing extra. (1) Text the library writes resolves in the library's module, private names included, carrying that declaration's identity `<lib>@<path>@@<Decl>` (109). (2) The user's text resolves at the call site, as any code of the consumer's module: its imports, aliases (110), locals. (3) `compiler.lookup` resolves at the call site and answers the declaration's identity, never the alias; the library's own names need no lookup. Example: lib `shapesdsl` with `pub fn area(w: i32, h: i32) -> i32 { return w * h; }`, a private `fn double(x: i32) -> i32 { return x * 2; }` and a template building `double(` + the user's text + `)`: `` shapesdsl @`area(4, 5)` `` prints 40 (`double` the lib's, `area` the call site's); with `import shapesdsl, {area as surface} from "shapesdsl";`, `` shapesdsl @`surface(4, 5)` `` resolves `surface` → `area` at the call site; a consumer's own `fn double(x: i32) -> i32 { return x + 1; }` is never captured (40, not 21); `lookup("surface")` answers `shapesdsl@shapesdsl@@area`, where hover, go-to-definition and the `CustomNode` point. Unchanged: 109's identity; 110's alias rule, which `lookup` applies. Cells: three `run/` cells under `tests/language` (private helper, alias, the consumer's own `double`), each printing 40; no `reject/` cell | front 01 (`00-compiler-carry-over/01-checker`) — name resolution by span author in the generated text, `e.lookup`; front 12 (`00-compiler-carry-over/12-language-tests`) — three `run/` cells under `tests/language` (private helper, alias, consumer's own `double`), each printing 40; no `reject/` cell |  dsl_names_resolve_in_author_scope |
| 190 | 08-c | The library decides which types an embedded expression may have: the template accepts or refuses it with a comptime error located at the expression; the compiler fixes no list. The compiler owes an embedded expression of any type reaching the template with its type readable at comptime and its source position, and a located comptime error the template can raise (a `language-gaps.md` row, 01-compiler). The surface is `{expr}`; until then 118 step 2 reads `{expr}` out of the literal's raw text and re-emits it (a wrong type is the checker's error at the template call), moving to the typed form without changing the surface | 08-bpp/118 step 2 · 01-compiler | template_decides_embedded_types |
| 204 | props-b | A hole of type `?T` is a comptime error at the hole (`error: a hole of type ?string — write {subtitle ?? ""}`), even when `T` is accepted (191); the author writes what an absent value shows | 05-jhonstart/26 · 118 | optional_hole_refused |
| 237 | 14-a | A template capture carries only the bindings whose name appears as a word in the captured text (`<Card title="x"><Badge/></Card>` → `[Card, Badge]`; `"cfg-0"` → `[]`); a `lookup` / `bindings` of a name not a word of the text is a located comptime error; the same declaration always gets the same answer | 14-comptime-on-beam step 2 | template_capture_word_bindings |
| 415 | 137-b | `` self.db.query @`…` `` is assembled wholly at build: receiver and text are `syntax` parameters; `compiler.lookup` answers the call site's declaration as a read-only handle whose data meta is read at build. (1) `pub fn query<E>(syntax self: QueryContext<E>, syntax q: string) -> Result<unknown, E>` — the receiver (`self.db`) is the call site's code, spliced as `q`'s text is (112). (2) In the body `User` is text of the literal, not a name of query's module; `compiler.lookup(q, "User")` resolves it where the call stands and answers the declaration (`null` when none of that name is in scope), read through `compiler.*` (name, kind, module, fields, meta, metaAll); the handle is read-only — `setMeta` / `addMeta` / `addMember` / `addType` on it refused. (3) `compiler.meta(decl, QueryTable)` answers what `#[entity]` recorded when the meta's type is data (380); a meta with a run-time field (404's `Check`) is refused at the read, naming the field; a meta read through `compiler.typeInfo(X)` in a template body stays `typeinfo-meta-at-build`; the read declaration's decorators run before the template body. (4) `val decl = compiler.lookup(q, ast.from) ?? compiler.fail("…"); val table = compiler.meta(decl, QueryTable) ?? compiler.fail("User is not an entity — annotate it with #[entity(…)]");`, each field of the text checked against `table.columns` (`compiler.fail("`User` has no field `ativo`", at: f)`); the SQL rendered at build into the answered code over the context's `runOne` / `runMany` (426, 427): the program holds the SQL as a constant, computing only the holes. query names no library | `01-checker` steps 29 (the template method) and 39 · `04-rakun/137` steps 2, 4 · `docs.md` § Template functions | query_template_assembled_at_build |
| 425 | 137-d | A template call expands wherever an expression may stand — a type's method body, a destructuring initializer (`` val #(n, total) = query @`select count(*), sum(amount) from sales`; ``), a lambda, an argument, a field default, a `case` arm — as a `fn` body does, one cell each; a template call left unexpanded anywhere is a compiler error, never a run-time `undefined` | `01-checker` step 29 · `04-rakun/137` step 2 · `04-rakun/143` | template_call_expands_any_expression |
| 426 | 137-c | A template call's type is the type of the code it built, computed at build; the signature is a bound; the call unifies with the type expected where it stands. (1) The call's type is the built code's — the type the expansion infers to (134's `build<R>`), no free `T` left; (2) the signature's answer is a bound the built type must fit (`-> Result<unknown, E>`), else an error in the template at its build; (3) the call unifies with the expected type as any expression — `` val n: i32 = query @`…` `` is `expected i32, got string[]` at the call, `` val nomes = query @`select name from cities`; `` infers `string[]`; (4) `compiler.note(message)` attaches the template's reason to an error at its call; the template never reads the expected type, so what it builds is decided by its text (312). query appends `.runOne(…)` (`Result<?Row, E>`) under `limit 1`, `.runMany(…)` (`Result<Row[], E>`) otherwise, the row type the entity `compiler.lookup` found (415): `` fn errado(self: Self) -> Result<?User, StoreError> { return self.db.query @`select * from User`; } `` is `expected Result<?User, StoreError>, got Result<User[], StoreError>` with `note: query answers a list — add limit 1 for ?User`; the repository annotation `` #[query @`…`] fn find(…) -> Result<?User, …> `` is checked against the method's declared answer the same way | `01-checker` step 40 · `01-compiler/134` step 2 (`build<R>`, `note`) · `04-rakun/137` step 3 | template_call_type_is_built_code |
| 429 | 137-f | Template-built code is located by its expansion: each expansion carries an id; a built node's location is (expansion id, offset in its built string), read by every plan keyed by location (the default-argument plan, C-04; the erlang field-access and lambda plans; the diagnostic location, still mapped to the literal for the reader); a module with two alike expansions needs no padding on any target. On landing, `query.bp` and `html.bp` drop their padding, their three `// LANGUAGE GAP` markers go and `language-gaps.md`'s row closes. Priority: `01-checker` step 41 opens ahead of its other open steps; `04-rakun/137` step 4's erlang cells and any front needing the padding wait for it — no new padding is written | `01-checker` step 41 · `04-rakun/137` step 4 · `05-jhonstart` (`html.bp`) · `08-bpp/116` step 4 · `language-gaps.md` | template_code_located_by_expansion |
| 520 | B-12-a | `bytes`' refusals of step 32 stay, except that a `bytes` value may exist at build as a build constant, carried in the artifact as an Erlang binary, a JS `Uint8Array`, a wasm data segment (an embedded asset's bytes need it, 607). Still refused: `bytes` widening to `unknown` (so `print(b)`), a `bytes` template hole, `is` and a type pattern on `bytes` (on Erlang a `bytes` and a `string` are the same binary at run time), ordering (`<`, `>`; `==` stays), `+` between `bytes` and `string` (346). Printing is written: `b.length()`, `b.toUtf8()`. A printed form chosen by the static type (`<<104, 105>>` on every target, no widening) is a later decision that only accepts what is refused today | `1-botopink-lang/144` | bytes_build_constant_only |
| 530 | B-53-a | A template hole writes the text `print` writes for every value — a record, an array, a tuple, `null`, an enum — on the four targets, and a string writes itself; commonJS and wasm call the helper erlang and beam share, never the JS `toString` nor an address; a type implementing `Display` writes its `display()` in a hole as in `print`. Unchanged: a `bytes` hole stays refused (520), a `?T` hole of a rakun-bpp template stays an error (204) | `1-botopink-lang/144` | template_hole_writes_print_text |
| 577 | 14s8-a · (the maintainer, 2026-10-17) | A template is called one way: its name before a template text `` @`…` ``, raw. (1) The template text `` @`…` `` is a token of its own: it may span lines, holds its bytes as written — no escape sequences but `` \` `` for a backtick, no interpolation —, the only literal a template takes; `${…}` and `{…}` inside it are the sub-language's own syntax, parsed by the template from its raw text; a hole's expression is spliced into the code the template answers and typed in the caller's scope, its value never read by the template. (2) A template — first parameter `syntax q: string` (616) — takes exactly that text; as an annotation a second `syntax` parameter, the annotated declaration the compiler fills (576). (3) Called only as `` name @`…` `` (in run-time code or inside a tree) or `` #[name @`…`] ``; `name "…"`, `name """…"""`, `name(…)` (with a `syntax q: string`; 719), `name<T>(…)`, `#[name(…)]` and the template taken as a value are refused `syntax-call-outside-syntax` (narrows 575 (4)'s three places). (4) Any other parameters: refused at the declaration (`template-signature`) — an ordinary function, or the input taken as the text. (5) `Part`, `Part.Interp` and `compiler.parts` removed (no hole is the language's); `compiler.text(e)` answers the raw text; amends 576 (2), (5), 237 and 355 where they read a language hole. (6) The codemod rewrites the retired `name "…"` / `name """…"""` / `name("lit")` / `#[name("lit")]` → `` name @`…` `` / `` #[name @`…`] `` with escapes resolved to raw bytes; shapes it cannot rewrite are listed and migrated by hand (std and `conformance/` in B-136, the libraries in 165 s10) | `1-botopink-lang/144` B-136 · `2-libraries/165` s10 · every library declaring or calling a template | template_called_with_raw_text |
| 685 | B-18-a · (confirmed as built, the maintainer's batch, 2026-10-18) | A template method is found by a name in the call site's scope: `` value.method @`…` `` resolves `method` as a template whose `syntax self: R` receiver takes the receiver (577 (3), 578 (1)); a receiver's type never imports code by itself — query's `` self.db.query @`…` `` needs its import like every name | `machine-1/144` B-18 · `machine-1/145` | template_method_by_name_in_scope |
| 691 | 577-a · (confirmed as built, the maintainer's batch, 2026-10-18) | An error in template-built code is located by the word it copies from the template text (the first occurrence after the previous match); a sub-language records nothing for it — `parseCodeTextAt` (`copiedAt`); cells `template_hole_error_at_column`, `_on_later_line`, `_far_in_built_code`. A later step may add hole leaves located exactly where a sub-language records them, the word-copy rule otherwise — with 625's typed AST the built code is nodes, and that step states what a node's location is | `machine-1/144` B-136 | template_hole_error_at_column |
| 696 | s29-a · (confirmed as built, the maintainer's batch, 2026-10-18) | A template function is an annotation only when its signature declares the annotated declaration as its second parameter (578 (1): `syntax q: string`, then `syntax decl: unknown`); called as `` f @`…` `` it is `template-annotation-only`, and a template without that parameter at `` #[f @`…`] `` is `template-annotation-without-decl`; the signature says which form a function takes, the two uses are two functions (rakun-data's `` #[query @`…`] ``, query's template method; 311, 398, 578) | `machine-1/144` B-18 · `machine-1/145` · `machine-1/150` | template_annotation_called |
