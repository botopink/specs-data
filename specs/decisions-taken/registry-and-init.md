---
scope: >-
  Decides how a decorator registers its declaration — `compiler.init(syntax executor: fn())` placing
  run-time code in the init list at the declaration's position, source then dependency order, an
  `async` executor only inside an `async` body — and the run-time registry each marker writes as the
  one way to gather marked declarations; no catalogue at build. rakun's beans and qualifiers sit here.
  A decorator's outputs are decorator-outputs-and-meta.
terms:
  - '`compiler.init`'
  - '`_bp_init_<k>`'
  - '`registry.modules()`'
  - '`rakun.boot()`'
  - '`T.make()`'
  - '`#[provides]`'
  - '`#[qualifier]`'
  - '`#[primary]`'
  - '`resolveNamed`'
  - '`#[component]`'
  - '`#[controller]`'
  - '`#[listen]`'
  - '`#[httpClient]`'
  - '`init-async-executor-outside-async`'
  - '`init-executor-value`'
  - '`Module.mainAsync()`'
  - '`runCase`'
  - '`is fn() -> T`'
  - '`find-imported`'
  - 'plug-and-play'
related:
  - 'decorator-outputs-and-meta'
  - 'compiler-module'
  - 'module-system'
  - 'syntax-and-comptime-parameters'
  - 'conformance-suite'
  - 'library-split'
open:
  - '998 (6): the refusal of `"cases/" + name` at a run-time call''s expansion is a defect still to fix, not a rule'
binds:
  - '`1-botopink-lang/144` B-137'
  - '`2-libraries/165` s10'
  - '`machine-1/144`'
  - '`machine-1/145`'
  - '`machine-1/150`'
  - '`machine-1/165`'
  - '`machine-1/165` s10'
  - '`machine-2/144`'
  - '`machine-2/144` B-137'
retired:
  - 'A `comptime` default that queries the catalogue (`boot(modules = …catalogue…)`)'
  - '`compiler.initAsync`, a valued executor'
  - 'jhonstart, jhonstart-html, -link, -forms, -test'
  - 'styled'
  - 'emilia, jhonstart-emilia'
  - 'onze and its eight members; the `onze` CLI (`onze create-key`); `onze.json`'
  - 'dbcontext (a repository)'
  - 'erika; `erika "…"`'
  - 'rakun-web, rakun-actuator'
  - '`rakun-starter-*`'
  - 'Each `*-test` package (`query-test` included)'
  - '`#[service]`, `#[managed]`, the core''s `#[repository]` on a type; `#[configuration]`, `#[bean]`; `#[httpExchange]`, `#[getExchange]`; `#[amqpListener]`, `#[kafkaListener]`, `#[redisListener]`, `#[streamListener]`, `#[listener]`; `#[restController]`'
  - '`rkRoutes`, `rkBeans`, `rkHooks`; `__rkMake_<T>`'
  - 'the hand-written proxies `<Type>Tx`, `<Type>Sec`'
  - '551'
first-step: 234
last-step: 998
in-force: 10
superseded: 2
---
# registry-and-init — `compiler.init`, the init list and the run-time registry

**A decorator registers its own declaration with `compiler.init`; the registry each marker writes is the one way to gather the declarations marked with it; no catalogue is read at build.**

(1) The executor: its position and order, a build value entering it as a literal — 580, 611.

(2) An `async` executor, `Module.mainAsync()`, one `runCase` — 998.

(3) rakun's beans and providers: injection by type, one decorator per role, qualifiers — 234, 318, 321.

(4) The catalogue-era rows, their `@TypeInfo.all` half named retired — 235, 254, 256.

(5) One `rakun` workspace of plug-and-play packages — 724.

(6) Superseded: 662, 664 (665).

Steps: 234, 235, 253, 254, 256, 318, 321, 575, 576, 580, 581, 611, 613, 614, 615, 625, 642, 660, 662, 664, 665, 676, 677, 680, 716, 724, 998
Binds: 130 step 5 (rakun) · 130 · 134 · 130 step 5 · rakun 04, 08, 12, 13, 15, 19, 79, 91, 93 · rakun 04 step 6 · `1-botopink-lang/144` B-137 · `2-libraries/165` s10 · `1-botopink-lang/144` B-136, B-137 · `2-libraries/165` s5, s10 · `machine-1/165` s10 · `machine-2/144` B-137 · `machine-1/165` s5 · `machine-1/144` B-137 · `machine-1/165` s5, s10 · `machine-2/144` B-137, B-139 · `machine-1/144` B-19 · `machine-2/144` · `machine-1/144` · `conformance/`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 234 | dec-d | Constructor injection resolves a field by its type (281): a stereotyped type's factory is its member `T.make()` (216); a field `clock: Clock` is resolved by the type `Clock`, the field's type fixing the answer's type; the registry is what each marker's `compiler.init` executor writes (665; `@TypeInfo.all` retired) and `#[provides]` functions (318); no generated function name is a contract (`__rkMake_<T>` retired); two providers of one type are told apart by 321's label; a missing bean is a boot failure | 130 step 5 (rakun) | constructor_injection_by_type |
| 235 | dec-b | Retired with the catalogue (665): `@TypeInfo.all(with: [component, service, repository])`, one list in one order (module path, then declaration order), a declaration carrying two of them once | 130 | typeinfo_all_with_list |
| 254 | dec-e | `@TypeInfo.all(…)` declared `-> Declared<unknown>[]` is retired with the catalogue (665). In force: `x is fn(<params>) -> T` is a real run-time check; rakun's resolver narrows a stored factory with `is fn() -> T` and fails the boot naming the bean and the expected type (the registry's key: 281, 321); `#[provides]` on a free function stays; `__rkMake_<T>` is retired; a wrongly typed bean is a boot failure, not a build error | 134 · 130 | typeinfo_all_declared_type |
| 256 | — | A provider is keyed by its type and its label (321), never by a name string (281); a bean registered twice is the registering executor's refusal at init, before `main` (665, 724). Retired with the catalogue (665, 576 (7)): the registry as one `Dict` built at comptime at the entry point from `@TypeInfo.all(with: [stereotypes…])` and `@TypeInfo.all(with: provides)` in a `comptime { … break d; }` block, its located build failure for a twice-registered bean, `Declared`'s `returnTypeName: string`. A registry in a library's own comptime `val` filled by decorators is refused (343) | 134 · 130 | bean_registry_built_at_comptime |
| 318 | nat-e · 130-c · erk-c | One decorator per role, in rakun's own names; Spring's synonyms are retired. rakun's decorators take botopink's four forms — registration, a generator on a `behavior`, a wrapper (316, 714), meta (298). (1) One type stereotype: `#[component(lazy: …, scope: …)]`; `#[service]`, `#[managed]` and the core's `#[repository]` on a `type` retired (a hand-written repository type is a `#[component]`). (2) `#[repository]` is only `dbcontext`'s generator on a `behavior` (313, 398); the core keeps none (closes `erk-c`). (3) One way to provide a bean: `#[provides]` on a free function reading 299's typed config (`#[provides] fn clock(cfg: AppConfig) -> Clock`); `#[configuration]` and `#[bean]` retired (closes `130-c`); qualified beans are 321. (4) The HTTP client is a generator on a behavior, as the repository: `#[httpClient(EchoConfig)] behavior EchoService { #[get("/users/${id}")] fn user(self: Self, id: string) -> Result<User, HttpError>; }` — the group a typed config record (299), path holes the method's parameters (311's template form where the spelling needs it); `#[httpExchange]` / `#[getExchange]`… retired. (5) One listener: `#[listen(orders)]` on a method of a `#[component]`, the destination declared once and typed — `pub val orders = Destination<OrderPlaced>("order-events")` (the broker's name a string, 281) — the transport from 299's typed config; `#[amqpListener]`, `#[kafkaListener]`, `#[redisListener]`, `#[streamListener]` and the type-level `#[listener]` retired. (6) One controller: `#[controller]`; the return type decides the answer — a `View` is HTML, a record JSON, a `Response` as is; `#[restController]` retired. (7) Added behaviour is a wrapper (316): `#[transactional]`, `#[secured(…)]`, `#[retryable(…)]`, `#[useCache]` on a function or method; the hand-written proxies (`<Type>Tx`, `<Type>Sec`) go as each owning front reaches them. (8) rakun speaks botopink: test and security names are rakun's own, chosen by fronts 19 and 79 — the name says the role in botopink (`MockMvc`, `@MockBean`, `UserDetailsService` retired); no Spring alias anywhere | 130 step 5 · rakun 04, 08, 12, 13, 15, 19, 79, 91, 93 | rakun_one_decorator_per_role |
| 321 | 130-b | Two providers of one type are told apart by a label, checked at compile time: `#[qualifier("reports")]` gives a provider a free label of the author's choosing (not the function's name — `fn reportsDb()` may be `"reports"`), recorded as typed meta (`Qualifier(name: …)`, 298); the registry keys a provider by its type and its label. A bean is asked for with the type itself, never its name in text: `ctx.resolveNamed(Database, "reports")`; with no label `ctx.resolveNamed(Database)` answers the `#[primary]` provider, or the only one. A constructor field takes the same marker: `type ReportJob(#[qualifier("reports")] db: Database)`. The label is a `comptime` argument checked against the registry at build: an unknown label (`"mian"`) is an error naming the labels that exist; two providers of one type with one label, two `#[primary]`, or an unlabelled request among several providers with no `#[primary]` are errors at build. One method, `resolveNamed`; no resolution by a function's name | 130 step 5 · rakun 04 step 6 | provider_qualifier_label |
| 580 | b137-a · (the maintainer, 2026-10-17) | An executor is a statement of its module's body at its declaration's position: one init list, source order. A `compiler.init` executor runs where the annotated declaration stands — a module's `val`s, `var`s, `_` statements and executors in one order (140's "declaration order" and 575 (3)'s "source order" are one order); modules in dependency order; a declaration's `init` calls in order. The hidden `val _bp_init_<k>` is placed at the declaration's index, never appended to the module. In `compile_init_order_modules` a `val seen = names();` written below `#[registered] pub fn own()` answers `["second", "first", "later", "own"]`; cell `compile_executor_module_val_order`. No flag chooses the order (67) | `1-botopink-lang/144` B-137 · `2-libraries/165` s10 | executor_runs_in_source_order |
| 611 | 165-c · (the maintainer, 2026-10-18) | A build value an executor needs may be read in the decorator's body and enter the executor as a literal — `val declName = compiler.name(decl); compiler.init({ -> rkRegisterX(declName, decl); });` (cells `compile_executor_before_main`, `compile_executor_handle_typed`) — or, per 614, be written inside the executor, `compiler.*` there evaluated at build (611's refusal of that form withdrawn); 605 (1)'s example and 165 s10's box use the first form and stay valid | `machine-1/165` s10 · `machine-2/144` B-137 | executor_build_value_literal |
| 662 | b137-e, b137-h · (the coordinator, 2026-10-18; names and a comment) | Overtaken by 665 | `machine-2/144` B-137 | |
| 664 | b137-f · 564-a · (the maintainer, 2026-10-18) | Overtaken by 665 | `machine-2/144` B-137 · `machine-1/165` s5, s10 | |
| 724 | mono-a · (the maintainer, 2026-10-14; numbered 2026-10-18 with what stands after 576–677) · (process) | One `rakun` repository, a botopink workspace (512) of plug-and-play packages; erika outside as `query`. rakun, emilia, styled, jhonstart, onze and dbcontext are `botopink/rakun`: one directory per package under `modules/`, the package named by its directory, each with its own `botopink.json`, `src/`, tests and `AGENTS.md`, the cells under `conformance/<package>/`, one version and tag, one gate, hook and CI. The packages by layer, each depending on lower layers only (a cycle refused): `rakun` · `rakun-data` (dbcontext + rakun-data) · `rakun-restclient` · `rakun-style` (styled) · `rakun-bpp` (jhonstart, -html, -link, -forms, -test) · `rakun-stylesheet` (emilia and jhonstart-emilia, renamed) · `rakun-service` (rakun-web, rakun-actuator) · `rakun-scheduling` · `rakun-session` · `rakun-cache` · `rakun-security` · `rakun-websocket` · `rakun-metrics` · `rakun-messaging` · `rakun-mail` · `rakun-app` · `rakun-ssr` (onze and its eight); the packages a target set keeps apart are 165-b's. erika is a repository of its own, `query` (front 145); `css`, `actions`, `routing`, `validation`, `snap`, `markdown`, `http`, `log`, `json`, `yaml` stay external. `rakun-starter-*` retired; each `*-test` is its package's `testing/` module. Plug-and-play: adding a package to `botopink.json` is all a program does — every module of a declared dependency is in the program (660, 677); a package's module registers itself through its decorator's `compiler.init` executor (581 (2)), the init list in dependency order (580, 660), with its defaults and the program's typed overrides (`#[rakun.config]`); `rakun.boot()` is a plain run-time function over the registry (664); no catalogue is read (576 (7), 665); a thing registered twice is the executor's refusal at init (665). History kept by `git subtree add`; the six repositories archived; their fronts' open steps refiled under 150. Amends 326, 338, 391, 398, 433 (rakun's front is 150, with lanes by layer) | `machine-1/165` · `machine-1/150` · `machine-1/145` | |
| 998 | 989-c · (the maintainer, 2026-10-26: asked where an async `run()` is awaited; proposed `compiler.init` answering its body's value ("ele devolve anyvalue"), sent to the fable, which found it reverses 808 (1), 986 (2) and 788 (4) and still leaves `await` per case in `main`, and proposed one `-> void` helper reading the case's kind at build; the maintainer: "concordo c", with the marker inside the brace — "deveria ser compiler.init({async ->" —, and, shown the marker could be left to the enclosing body, "nesse caso precisa do async"; over two helpers (runCase / runCaseAsync), a separate `compiler.initAsync`, an init list that awaits (b) and a blocking `run()` (c), 2026-10-26) | An executor may be an `async` lambda — `compiler.init({ async -> … })`, the marker inside the brace (584) — only where 808 (2) writes its body into an `async` body; `Module.mainAsync()` is read at build; `compiler.init` stays one function answering `void`, a valued executor refused; one `runCase` serves every case of 989 (9); amends 575 (3), 615, 786 (1), 808 (1)–(2), 989 (9). (1) `init(self: Self, syntax executor: fn())` takes a plain lambda `{ -> … }` or `{ async -> … }`; an `await` in an executor needs the `async` marker, as in any lambda (553 (1), 791 (4)); no `initAsync` (67). (2) An `async` executor stands only at a call expanded inside an `async` body (808 (2)) — its statements written there, its `await`s that body's; at a declaration (580), in a top-level `comptime` block (788), in a body that is not `async`, or in 808 (4)'s block inside such a body, it is refused at the `async`, `init-async-executor-outside-async`, the message naming the plain form; nothing awaits at program start, the init order unchanged (660); in the function's own module (808 (1)) it is checked as an `async` lambda. (3) `compiler.init` answers `void` at every use (575 (3), 788 (4), 808 (1)); an executor whose body ends in a value is refused at the tail, `init-executor-value` — no `Result` dropped, no `Async` left running. (4) `Module.mainAsync() -> bool`: `true` when the loaded package's `main` is `async` (`run()`'s type follows it, 989 (2)), read at build as `path()` is; `if (comptime loaded.mainAsync())` keeps one branch at expansion (562). (5) The helper: `fn runCase(comptime name: string) -> void { val loaded = try comptime compiler.load("cases/" + name) catch { r -> compiler.init({ -> run.refused(name, r); }); return; }; if (comptime loaded.mainAsync()) { compiler.init({ async -> run.ran(name, await loaded.run()); }); } else { compiler.init({ -> run.ran(name, loaded.run()); }); } }`, called `runCase("<case>");` per case in the suite's `pub async fn main()`; the codemod chooses nothing per case. (6) `"cases/" + name`, `name` a `comptime` parameter, is known at build at a run-time call's expansion as at a block's (788, `foldedPath`); its refusal there today is a defect, no rule. (7) Cells: `init_async_executor_in_async_body` (one helper over a sync and an async case, four targets), `init_async_executor_outside_async_refused`, `init_executor_value_refused`, `module_main_async_read_at_build`; `module_run_answers_output` loses its `async { }` / `async.delay` workaround | `machine-2/144` · `machine-1/144` · `conformance/` | init_async_executor_in_async_body |
