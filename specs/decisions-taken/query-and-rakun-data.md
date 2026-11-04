---
scope: >-
  Decides `query`'s database side and `rakun-data`'s repositories: a query written on the
  `QueryContext`, `from User` reading a type's `QueryTable` meta at build, typed `QueryParam` holes,
  the strict aggregates, the `#[repository]` / `#[query]` / `#[nativeQuery]` and
  `#[documentRepository]` / `#[documentQuery]` generators, and the grammar as the one public spelling
  over an array. The grammar itself (312), template mechanics (577, 696, 802) and the stores are
  templates and rakun.
terms:
  - '`QueryContext`'
  - '`QueryTable`'
  - '`QueryParam`'
  - '`#[repository]`'
  - '`#[query]`'
  - '`#[nativeQuery]`'
  - '`#[documentRepository]`'
  - '`#[documentQuery]`'
  - '`#[entity]`'
  - '`DbContext`'
  - '`StoreError`'
  - '`runMany`'
  - '`runOne`'
  - '`/actuator/sql`'
  - '`count(*)`'
  - '`group by`'
  - '`Query<T>`'
  - '`single()`'
  - 'LINQ'
related:
  - 'templates'
  - 'rakun'
  - 'library-split'
  - 'result-and-failure'
  - 'typed-ast-code-and-mocks'
open:
  - '933 (3): `#[documentRepository]` (`rakun-data/src/nosql/`) is written after 150 s48 … s51 land the SQL shape it copies'
binds:
  - '`01-compiler/01-checker` step 29 (the template method)'
  - '`04-rakun/137`'
  - '`04-rakun/137` step 2'
  - '`04-rakun/137` step 4'
  - '`04-rakun/143` step 1'
  - '`machine-1/145` s2'
  - '`machine-1/150` s17 step 4 (after s48 … s51)'
retired:
  - '`Query<T>`''s LINQ-named public methods (`where`, `select`, `selectMany`, `orderByDescending`, `toList`), `query.of(xs)`'
  - 'rakun-data''s old `#[query]`, its `<m>Sql()` members, `rkRegisterQuery`'
  - '`run(sql, params: Array<string>)` on `QueryContext`'
  - '`count(f)` on a non-optional field; `select *` with `group by`; `order by` / `limit` on an ungrouped aggregate'
first-step: 313
last-step: 933
in-force: 6
superseded: 0
---
# query-and-rakun-data — `query`'s grammar, the database context, repositories

**One grammar, two targets, picked by the source; a database query is written on the context, `from User` names a type; a repository is a `behavior` annotated `#[repository]`; parameters are typed values.**

(1) SQL repositories: `#[repository]`, `` #[query @`…`] ``, `#[nativeQuery("…")]`, `/actuator/sql` — 313.

(2) The database context: `QueryContext<E>`, `QueryTable` meta, `from User` resolved at build, the template method — 397.

(3) Bound parameters as typed `QueryParam` values — 427.

(4) The aggregates' strict reading — 428.

(5) Over an array the grammar is the one public spelling; LINQ names private — 914.

(6) Document repositories: `#[documentRepository]`, `` #[documentQuery @`…`] `` — 933.

(7) Rows elsewhere this group leans on: the grammar and holes 312, `compiler.lookup` 415, the call's type 426, template annotations 696, the workspace 724 / 398, `T[]` 641.

Steps: 312, 313, 397, 398, 415, 426, 427, 428, 641, 685, 696, 724, 914, 933
Binds: `04-rakun/137` · rakun 08 step 7 · 09 (`erk-b`) · 11 (`/actuator/sql`) · 130 step 5 (`#[query]` leaves its list) · `04-rakun/137` step 2 · rakun `08` step 7 · `01-compiler/01-checker` step 29 (the template method) · 311 · 312 · `04-rakun/143` · `137` · 313 · 397 · `01-checker` steps 29 (the template method) and 39 · `04-rakun/137` steps 2, 4 · `docs.md` § Template functions · `01-checker` step 40 · `01-compiler/134` step 2 (`build<R>`, `note`) · `04-rakun/137` step 3 · `04-rakun/143` step 1 · rakun-data's drivers · `04-rakun/137` step 4 · `machine-1/144` B-18 · `machine-1/145` · `machine-1/150`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 313 | lg2-r | A repository is a `behavior` annotated `#[repository]`; each method declares its query (all three annotations `rakun-data`'s, 398). `` #[repository] behavior Users { #[query @`select * from User where id = ${id} limit 1`] fn find(self: Self, id: i32) -> Result<?User, StoreError>; } `` — `#[query]` checks the query against the entity at build, records its SQL and parameters as typed meta of the method (298), checked against the declared answer (426). `#[nativeQuery("select * from users where id = :id limit 1")]`: the driver's SQL as a comptime literal (280), handed over verbatim; `:name` placeholders matched by name against the parameters (an unanswered placeholder or an unused parameter is an error at the annotation); leading keyword checked (SELECT, INSERT, UPDATE, DELETE, WITH, CALL); rows decoded by column name; a `?T` answer meeting more than one row is the `single()` panic (304). `#[repository]` reads each method's meta and generates `Users.Sql(ctx)`, the factory `Users.of(ctx)` and the by-type registration in rakun's container; a method with neither annotation is an error at the method; a caller depends on the behavior, `mock(T)` (644) mocks it. rakun-data's old `#[query]`, `<m>Sql()` members and `rkRegisterQuery` are retired; the statement inventory (`/actuator/sql`) is read from the `#[query]` / `#[nativeQuery]` meta through 665's registry (253). Every method answers `Result<T, StoreError>` (304) | rakun 08 step 7 · 09 (`erk-b`) · 11 (`/actuator/sql`) · 130 step 5 (`#[query]` leaves its list) · `04-rakun/137` | repository_behavior_declares_query |
| 397 | erk-a | A database query in a method body is written on the context — `` self.db.query @`select * from User where active = true` `` — and `from User` names an entity whose table and columns `query` reads from the type at build. (1) `query` declares the behavior `QueryContext` (runs a statement — SQL text and bound parameters — answering `Result<…, E>`, `E` its parameter; runners 427) and the meta `QueryTable(name: string, columns: QueryColumn[])` (`QueryColumn(field, column)`); a persistence library implements the first and records the second (`rakun-data`'s `DbContext` implements `QueryContext`, its `#[entity]` sets `QueryTable`, 398); `query` names no library (113). (2) At build `from User` reads `User`'s `QueryTable` through `compiler.lookup(q, "User")` (415): table, columns and nameable fields come from the type; the SQL and its `$1…$n` parameters are built at build; no `QueryTable` → error at the query ("`User` is not an entity — annotate it with `#[entity(…)]`"); a field `User` lacks → error at the field. (3) The body form is a template method (311 (3)): `query` is the template method on every `QueryContext`, called `` value.method @`…` `` — in a `type Relatorio(db: DbContext)`, `` fn ativos(self: Self) -> Result<User[], StoreError> { return self.db.query @`select * from User where active = true`; } ``; one context serves every entity, injected by type (234). (4) The in-memory form over a `T[]` (`` query @`…` ``) needs no entity; the repository form (313) runs on the context its generated implementation holds | `04-rakun/137` step 2 · rakun `08` step 7 · `01-compiler/01-checker` step 29 (the template method) · 311 · 312 | query_on_database_context |
| 427 | 137-a | A query's bound parameters are typed values, `query`'s `QueryParam`, each built by the template from the type of the column its hole meets, checked at build. (1) `pub type QueryParam { Int(value: i64), Float(value: f64), Text(value: string), Bool(value: bool), Bytes(value: bytes), Null }`; `QueryContext<E>`'s runners (426): `fn runMany<T>(self: Self<E>, sql: string, params: QueryParam[], decode: fn(row: Row) -> Result<T, E>) -> Result<T[], E>;`, `fn runOne<T>(…) -> Result<?T, E>;`; `run(sql, params: Array<string>)` retired. (2) A hole compared with a column takes that field's variant (415): `where id = ${id}` with `User.id: i32` builds `QueryParam.Int(id)`; `bool` → `.Bool`, `string` → `.Text`, `bytes` → `.Bytes`, a `?T` field `x == null ? QueryParam.Null : <T's variant>(x)`; a hole after `limit` is `Int`. (3) The built code is typed (426): a hole of another type is an error at the hole at build — `fn porId(self: Self, id: string)` with `where id = ${id}` is `expected i64 (User.id: i32), got string`. (4) A value reaches the driver with its type (a real NULL, a real boolean, bytes undecoded); rakun-data's drivers (PostgreSQL, ETS), `SqlTemplate` and `rakun-data`'s `Driver` take `QueryParam[]` | `04-rakun/137` step 2 · `04-rakun/143` step 1 · rakun-data's drivers | query_params_typed_values |
| 428 | 137-e | `query`'s aggregates, one answer in memory and on the database: `count(*)`; `min(f)` / `max(f)` answer `?F`; an aggregate without `group by` answers one value (a tuple for several) and refuses `order by` / `limit` (`limit has nothing to cut`); a field beside an aggregate needs `group by` on it; with `group by` only the group field and aggregates are selected, `order by` names the group; `select *` with `group by` refused. (1) `count(f)` on a `?T` field counts the non-null rows; on a non-optional field refused, naming `count(*)`. (2) `sum(f)` over `i32` / `i64` answers `i64`, over `f64` `f64`; no rows answer `0` (SQL: `coalesce(sum(x), 0)`). (3) `avg(f)` over a numeric field answers `?f64`, `null` for no rows | `04-rakun/137` step 4 | query_aggregates_strict_reading |
| 914 | nat-d9 · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; (a) read with 312 and 577; rejected: (b) LINQ's names kept public as `query`'s identity — two public models of one read, against 170 and 283's case-by-case reading; (c) as is — three spellings of one read) | Over an array `query`'s one public spelling is the grammar `` query @`select name from xs where active order by name` `` (312, 577), std's `filter` / `map` / `flatMap` / `unique` the other read; `Query<T>`'s LINQ-named public methods (`where`, `select`, `selectMany`, `orderByDescending`, `toList`, …) and `of(xs)` are retired as public names, the template's private lowering targets; no fluent operator beside std's. (1) `xs.filter(p)` and `` query @`select * from xs where …` `` are the two reads; `query.of(xs).where(p)` is retired. (2) A rename and visibility pass in `modules/query/src/query.bp`, no compiler change; `examples/query-linq` and the tests rewritten to the grammar; helpers in `query`'s `testing/` module (882). (3) What std lacks (`groupBy`, the aggregates) exists only through the grammar (428) | `machine-1/145` s2 | query_array_grammar_is_the_one_spelling |
| 933 | erk-b · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: nothing of 150 s17 exists on feat (`documentQuery` is one comment in `sql/query.bp`); 313's `#[repository]` generator refuses a method it does not know; a template is an annotation when it declares the annotated declaration as its second parameter (696); a template parses its own text and resolves a `${name}` hole with `compiler.lookup` (577 (5), 802); rejected: (a) through the SQL `#[repository]`; (b) a document target of `query` — no measured need; (c) a member of the type (313 deleted that shape); the proposal's `:name` placeholders — a second hole syntax beside the template's `${…}`) | `rakun-data`'s `#[documentRepository]` on a `behavior` whose methods carry `` #[documentQuery @`…`] ``, the filter text handed to the store verbatim with its `${name}` holes bound to the method's parameters. (1) `` #[documentRepository] behavior Posts { #[documentQuery @`{"author": ${author}, "tags": {"$in": ${tags}}}`] fn byAuthor(self: Self, author: string, tags: string[]) -> Result<Post[], StoreError>; } `` — `documentQuery` is a template annotation (696: `syntax q: string`, then `syntax decl: unknown`); each `${name}` resolves against the method's parameters by `compiler.lookup` (577 (5), 802), a bound value never text (312), an unmatched name or an unused parameter an error at the annotation; the text otherwise reaches the store as written, as `#[nativeQuery]` hands SQL (313); documents decode into the declared answer by field name, a `?T` meeting more than one the `single()` panic (304). (2) `#[documentRepository]` reads each method's meta and generates `Posts.Document(store)`, `Posts.of(store)` and the by-type registration through `compiler.init`; a method without `#[documentQuery]` is an error at the method; every method answers `Result<T, StoreError>` (304); the statement inventory lists the templates (313). (3) Lives in `rakun-data/src/nosql/`, written after 150 s48 … s51 land the SQL shape it copies; 150 s17 step 4's boxes read this row. (4) Cell `document_repository_template` (rakun-data): holes bound, an unmatched hole refused at the annotation, red on the parent | `machine-1/150` s17 step 4 (after s48 … s51) | document_repository_template |
