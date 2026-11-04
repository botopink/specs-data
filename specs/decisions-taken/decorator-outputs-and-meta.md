---
scope: >-
  Decides what a decorator may produce — typed meta (`compiler.setMeta` / `addMeta`, read through
  `compiler.typeInfo(T).meta(M)` / `metaAll`), a typed member (`compiler.addMember`) and an associated
  type (`compiler.addType`), each under the type's path — and where the names in meta and members
  resolve. The executor and the registry are registry-and-init; built types and `compiler.Field<T>`
  are derived-types-and-fields; `?T`'s operators sit here only as row 330.
terms:
  - '`compiler.setMeta`'
  - '`compiler.addMeta`'
  - '`compiler.addMember`'
  - '`compiler.addType`'
  - '`compiler.meta`'
  - '`compiler.metaAll`'
  - '`compiler.typeInfo`'
  - '`compiler.lookup`'
  - '`decorator-meta-twice`'
  - '`typeinfo-meta-several`'
  - '`typeinfo-meta-type`'
  - '`decorator-member-duplicate`'
  - '`decorator-member-local-not-literal`'
  - '`compiler-output-outside-decorator`'
  - '`templatePrivateKey`'
  - '`@emit`'
  - '`?T`'
  - '`??`'
  - '`Check<T>`'
related:
  - 'registry-and-init'
  - 'derived-types-and-fields'
  - 'decorators'
  - 'templates'
  - 'compiler-module'
  - 'syntax-and-comptime-parameters'
binds:
  - '`01-checker` step 31'
  - '`01-compiler/01-checker` step 35'
  - '`01-compiler/01-checker` step 35 box 3 (the member)'
  - '`01-compiler/130`'
  - '`01-compiler/130` step 7'
  - '`01-compiler/130` step 8'
  - '`01-compiler/130` step 8 (the meta)'
  - '`01-compiler/134` step 2'
  - '`03-bundled-libs/125` step 7'
  - '`04-rakun/04` step 6'
  - '`04-rakun/08` step 4'
  - '`04-rakun/12` step 4'
  - '`05-jhonstart/26` step 8'
  - '`05-jhonstart/26` step 9'
  - '`07-onze/53` step 7'
  - '`machine-1/144` B-140'
  - '`machine-1/165` s10, s11'
  - '`machine-1/165` s11'
  - '`machine-2/144` B-137'
  - '`machine-2/144` B-148, B-149'
retired:
  - 'The builtin `result` namespace; methods on `?T`'
  - 'The string `addType(name, source)`'
  - '`typeinfo-meta-expr-elsewhere`'
  - '`decorator-member-fn-imported-name`'
  - '`rule.text()` (an argument''s source text spliced into a string output)'
first-step: 216
last-step: 759
in-force: 13
superseded: 3
---
# decorator-outputs-and-meta — members, associated types and typed meta

**A decorator produces typed meta, a typed member and an associated type — each under the type's path, never a free module-level name, never source text — and a name resolves where it was written.**

(1) Typed meta: keyed by the record's type, set once or added, read after every annotation ran — 298, 418, 420.

(2) The typed channels; no code identifier as a string; `@emit` retired — 281, 370, 373.

(3) Members and meta resolve where written; `compiler.lookup` the one way to the caller's scope — 384, 385, 669.

(4) A member reading its own meta; body locals inside a member — 395, 759.

(5) `?T`'s operators; a type declared in a type is its associated type — 330.

(6) Ownership of B-149 / B-148 — 640.

(7) Superseded: 216 (575), 413 (642), 698 (665).

Steps: 216, 281, 298, 330, 370, 373, 384, 385, 395, 404, 413, 418, 420, 575, 576, 578, 605, 626, 627, 640, 642, 644, 669, 680, 697, 698, 716, 727, 728, 759, 840, 887
Binds: 01-compiler/130 · `04-rakun/04` step 6 · `04-rakun/08` step 4 · `04-rakun/12` step 4 · `01-compiler/130` step 7 · 125 steps 7, 11 · 120 step 6 · 127 step 5 · 126 step 4 · `05-jhonstart/26` step 9 · `07-onze/53` step 7 · `01-compiler/130` step 8 · `05-jhonstart/26` step 8 · rakun 08 · `01-compiler/01-checker` step 35 box 3 (the member) · `01-compiler/130` step 8 (the meta) · `03-bundled-libs/125` step 7 · 281's fronts · every front writing a decorator · `01-compiler/130` · `01-compiler/01-checker` step 35 · 125 step 7 · the libraries' migrations to 370's member channel (rakun, jhonstart) · 370 · 376 · 384 · 385 · `01-compiler/01-checker` (example 1 of `decorator-arguments-280.md`) · `01-checker` step 35 · 298 · `1-botopink-lang/144` B-136 · `2-libraries/165` s10 · `machine-1/144` B-140 · `machine-1/165` s10, s11 · `machine-2/144` B-148, B-149 · `machine-1/165` s11 · `machine-2/144` B-137 · `machine-2/144` B-149 · `machine-1/144` · `machine-1/150`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 216 | comp-a | Overtaken by 575 | 01-compiler/130 | decorator_four_output_places |
| 281 | nat-0 (rule 1) · nat-a | No code identifier passes as a string: a function, a type, a field, an enum variant, an event, a hook or an action is referred to by the thing itself — a function value, a `type`, a `compiler.Field<T>` / `.name`, a variant — checked where it is written (280), never by its name in text; tables once keyed by such names (islands and starters, actions, beans, event listeners, deferred components) are built from the registry (665; the `@TypeInfo.all` catalogue is retired); a name of another system stays a string — an SQL table or column, a URL or route pattern, a cache name, an Erlang function, a config path, a wire spelling, text for a user; a qualified bean is 321's | `04-rakun/04` step 6 · `04-rakun/08` step 4 · `04-rakun/12` step 4 · `01-compiler/130` step 7 · 125 steps 7, 11 · 120 step 6 · 127 step 5 · 126 step 4 · `05-jhonstart/26` step 9 · `07-onze/53` step 7 | identifier_never_passed_as_string |
| 298 | nat-c5 | A decorator's meta is a typed value keyed by its type: `compiler.setMeta(Entity(table: "cities"))` stores one value per type per declaration (a second of one type refused at it), `compiler.addMeta(Index(…))` appends what repeats; one type is set or added, never both (418); read `compiler.typeInfo(City).meta(Entity)` → `?Entity`, `.metaAll(Index)` → `Index[]`, on a handle `compiler.meta(d, M)` / `compiler.metaAll(d, M)` (576 (11), 840). The key is the record's type (281, 297), not the decorator's name: a renamed decorator changes no reader, two decorators may write one type, one decorator several, who may read is who sees the type. Comptime only (280 (0)) | `01-compiler/130` step 8 · `05-jhonstart/26` step 8 · rakun 08 | decorator_meta_keyed_by_type |
| 330 | 134-e (1, 2) | `?T` is read with TypeScript's operators and has no methods; a type declared in a type is its associated type. (1) `??`, `?.`, `?.[i]`, `?.(args)` and the postfix `!` are the whole surface of `?T` (`Option<T>` is never a spelling); `map`, `flatMap`, `unwrapOr` leave `?T` and stay on `Result`; no `??=`. (2) An operator over a value never `null` is a compile error (`s?.length()` with `s: string`; the left side of `??` never null). (3) `?.` flattens: a member answering `?U` through `?.` is `?U`, never `??U`. (4) `??` beside `&&` / `\|\|` without parentheses is a compile error. (5) `x!` is checked at run time: a `null` aborts alike on every target, with the location and the expression (`value is null — nome! at main.bp:3:13`) — a program error like `panic`, never a `Result`. (6) The builtin `result` namespace is retired: `r.map(f)`, `r.flatMap(f)`, `r.unwrapOr(x)`, `r.isOk()`, `r.isError()` on `Result` are the one spelling. (7) A type declared in the body of a type is that type's associated type, so std writes `compiler.Field<T>` (308) as `pub type Type { pub type Field<T>(…) { … } … }`. A migration script per repository rewrites `.unwrapOr(d)` on a `?T` to `?? d` and `result.*` calls to methods | `01-checker` step 31 · `01-compiler/134` step 2 · 02–05 (the lowering of `!`, `?.[]`, `?.()`) · every repository (the migration) | optional_typescript_operators |
| 370 | s35-a | A decorator hands a parameter's code (a `syntax` parameter's tree) on to the program through two typed channels, never source text. (1) Typed meta (298), for information another reader takes: a record whose code-holding fields are written `T` — `pub type Check<T>(message: string, rule: fn(v: T) -> bool)`, `compiler.addMeta(Check(message: message, rule: rule));` —, built in the reading program with each expression spliced where it was written (385). (2) Typed member, for behaviour the decorator adds to the type: `compiler.addMember("validate", fn(self: T) -> Violation[] { … });` — a function value whose body uses the parameters, each tree spliced where it was written, every other name resolved where it was written (384); checked like any function, an error located at the argument; it reads only what 642 / 759 allow (413 replaced). (3) Refused: an argument's source text (`rule.text()` stays `expr-param-method`) spliced into a string output (281) | `01-compiler/01-checker` step 35 box 3 (the member) · `01-compiler/130` step 8 (the meta) · `03-bundled-libs/125` step 7 · 281's fronts | decorator_expr_typed_channels |
| 373 | (emit) | `@emit` is retired — no new site: a decorator writes only under a type's path (a member `Account.validate`, an associated type `City.Columns`, typed meta; 216's fourth place, the catalogue, retired too, 665), never a free module-level name; the sites left (rakun 67, jhonstart `routes.bp` 1, validation `decorators.bp` 1) are a closed list in `01-compiler/130`'s table, each going with its migration row, the count only shrinks; 130 step 6 makes `@emit` an error at zero | every front writing a decorator · `01-compiler/130` | decorator_writes_no_module_name |
| 384 | s35-g | A member a library's decorator writes resolves each name where it was written — the library's names in the decorator's module, the annotation's arguments in the annotated module (112's hygiene for members): in `#[check(senhasIguais, message: "…")] pub type Conta(…)` with `validation`'s `check` adding `validate`, the member's `Violation` and `mensagemPadrao` (a private helper) resolve in `validation`'s module, bound under an alias no source can spell and imported into the annotated module (112; `templatePrivateKey` for a private one), `senhasIguais` and the message in the user's module; the user imports nothing beyond `check`; a `Violation` of the user's own is never captured; `decorator-member-fn-imported-name` is retired | `01-compiler/01-checker` step 35 · 125 step 7 · the libraries' migrations to 370's member channel (rakun, jhonstart) | member_names_resolve_where_written |
| 385 | 130-s8-b | A meta field holding code (written `T`, filled from a `syntax`) read in another module resolves its names where the annotation wrote them (384's rule for meta): `compiler.typeInfo(signup.Signup).metaAll(Check)` in `main` answers `Check(message: "…", rule: <signup's passwordsMatch>)`, each name bound under an alias no source can spell and imported into the reader, a private one travelling as a template's private does (`templatePrivateKey`); the catalogue-query half is retired with `@TypeInfo.all` (665); `typeinfo-meta-expr-elsewhere` is retired; a same-named function of the reader is never captured | `01-compiler/130` step 8 | meta_expr_names_resolve_where_written |
| 395 | 130-s8-e | A typed member reads its own type's typed meta through the decorator's type parameter, checked twice. In `fn validated<T>(syntax decl: T) { compiler.addMember("validate", fn(self: T) -> Violation[] { … for (comptime compiler.typeInfo(T).metaAll(Check)) { c -> … c.rule(self) … c.message … } … }); }`: (1) pre-comptime — `compiler.typeInfo(T).metaAll(Check)` is accepted and typed as the read's type (`Check<T>[]`), the rest of the body checked against it; (2) post-comptime — rendered into the annotated type's module, `T` is the type (`Conta`), the read answered with the metas its decorators set, the member checked again; (3) the read is a resource of build (376), so in a run-time member it is written under `comptime`: the list a constant of build, the loop and the rules at run time; each `Check`'s code fields resolve where the annotation wrote them (385). No `typeInfo(Self)`: the decorator's `T` names the annotated type | `01-compiler/130` step 8 · `03-bundled-libs/125` step 7 · 370 · 376 · 384 · 385 | typed_member_reads_own_meta |
| 413 | s35-f | Replaced by 642 | `01-checker` step 35 | member_fn_reads_no_decorator_local |
| 418 | 130-s8-a | One meta type is set once or added, never both; `meta(T)` over several values is refused: `compiler.setMeta(Entity(table: "a")); compiler.addMeta(Entity(table: "b"));` is `decorator-meta-twice` at the second (`reject/meta_twice`); `compiler.typeInfo(City).meta(Index)` over two `Index` is `typeinfo-meta-several` at the read (`reject/meta_several`), read with `metaAll`; `metaAll(T)` answers a set-once value as a one-element array; on a handle `compiler.meta(d, T)` answers the first | `01-compiler/130` step 8 · 298 | meta_set_once_or_added |
| 420 | 130-s8-d | A generic meta record is read through `compiler.typeInfo(X).metaAll(Check)` (`run/meta_expr_field`; 395, 404); reading it through a catalogue entry — `typeinfo-meta-type` at the argument (`reject/meta_catalogue_generic`) — is retired with the catalogue (665, 698) | `01-compiler/130` step 8 · 298 | generic_meta_not_read_via_catalogue |
| 640 | b149-a, b149-e, b149-f, b148-d · (the coordinator, 2026-10-18; process, the queues' order) | Ownership and landing windows of B-149 and B-148, each the plan's (a). (1) b149-a: B-149 (machine 2) owns the two builders' surface — `buildType` / `buildTypeInline` in `compiler.bp` and `compiler_surface.zig` —, `mocks.bp` and the cell `build_type_from_fields`; B-140 (machine 1) owns `Type`'s bodies in `types.bp`, `compiler.fields` and the reduction of `comptime/derived_types.zig` (629); each machine keeps its files. (2) b149-e: `compiler.addType("Columns", compiler.buildType("(id: string)"))` is replaced by `compiler.addType("Columns", type(id: string))` — written code, 625 (3) —, the 14 `decorator_add_type*` cells rewritten in B-149's P3 with `build`'s removal. (3) b149-f: B-149 admits `compiler.ast` in a decorator body too (627's `val client = compiler.ast(…)`), with a cell; 165 s11 is a library step and changes no compiler (433). (4) b148-d: `default-on-static` (628) lands in B-148's fifth piece in one window with rakun's and query's one-line commits (one `default fn` without `self` each), machine 1 told the hash; no front waits | `machine-2/144` B-148, B-149 · `machine-1/144` B-140 · `machine-1/165` s11 | |
| 669 | 165-f · (the maintainer, 2026-10-18) | Code a decorator writes resolves in the decorator's module, a type it builds included; the one way to a caller's names is `compiler.lookup`. The names in a tree a decorator hands the compiler — an executor (581), an `addMember` member, a wrapper's proxy type (714), the fields and implements of `compiler.buildType` / `buildTypeInline` (625, 629) — resolve in the module that calls `compiler.*`: `Field("clock", Clock)` in rakun-data's `transactional.bp` names that module's `Clock` whether or not the annotated module imports it; a decorator writes no qualified name and leaks nothing into the host. What the user writes in the annotation (`#[transactional(clock: myClock)]`) resolves in the annotation's module (206). Reaching the caller's scope by name is never implicit: a template reads a value of the module that expands it with `compiler.lookup(e, name)` (576 (2)), nothing else resolves there. Cells `built_type_names_decorator_module` (a built field typed by a type the host does not import, four targets), `built_type_host_name_unbound` (a host-only name in the tree refused at the decorator) | `machine-1/144` B-140 · `machine-1/165` s10, s11 | decorator_code_resolves_in_decorator_module |
| 698 | 130-s8-d · (the maintainer's batch, 2026-10-18) | Overtaken by 665 | `machine-1/144` | |
| 759 | b137-k · (the coordinator †, 2026-10-19; fable's review of B-137's 716 piece) | `decorator-member-captures` is retired (716 made the handle itself legal); a body local whose value is no literal (a record, a handle-valued local) read inside an added member or an executor is refused `decorator-member-local-not-literal`, located at the read, naming the local — 575 (4): only literals enter a tree; `conformance/docs.md`'s sentence follows. Cell `decorator_member_local_not_literal` (reject) | `machine-2/144` B-137 | decorator_member_local_not_literal |
