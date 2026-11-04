---
scope: >-
  Decides what a decorator is and how it runs: a function over `syntax decl`, its comptime / syntax
  arguments, the handle's declared type as the contract, `decl` as the annotated declaration's code
  inside every tree it writes, independence and order of invocations, members added once with errors
  at the annotation, tag annotations, and the removal of `@emit` / `@code` / `@expr`. The `compiler.*`
  reads and outputs are compiler-module and decorator-outputs-and-meta; the registry is
  registry-and-init.
terms:
  - '`syntax decl`'
  - '`compiler.setMeta`'
  - '`compiler.addMember`'
  - '`compiler.addType`'
  - '`compiler.hooks`'
  - '`compiler.owner`'
  - '`compiler.same`'
  - '`compiler.src()`'
  - '`compiler.tagDecl`'
  - '`decorator-member-duplicate`'
  - '`decorator-hooks-output`'
  - '`decorator-meta-twice`'
  - '`#[check]`'
  - '`#[refine]`'
  - '`#[validated]`'
  - '`#[page]`'
  - '`#![…]`'
  - '`#[ns.d]`'
  - '`DeclKind.Val`'
  - '`std_decorator_leaf_import_runs`'
related:
  - 'compiler-module'
  - 'decorator-outputs-and-meta'
  - 'registry-and-init'
  - 'syntax-and-comptime-parameters'
  - 'templates'
  - 'validation'
open:
  - '372 is provisional: a second splice for the outputs of a `compiler.hooks(d)` reader is weighed on a concrete case'
  - 'a `DeclKind.Var` is added, without breaking a program, when a use is measured (710)'
binds:
  - '`01-checker` step 24'
  - '`01-checker` step 24 (example 1 of `decorator-arguments-280.md`)'
  - '`01-compiler/01-checker` (example 1 of `decorator-arguments-280.md`)'
  - '`01-compiler/01-checker` (the row)'
  - '`01-compiler/01-checker` step 23'
  - '`01-compiler/130`'
  - '`01-compiler/130` step 10'
  - '`01-compiler/14` step 6'
  - '`01-compiler/14` step 8 (355''s `val` read)'
  - '`01-compiler/16-formatter` step 9'
  - '`01-compiler/16`'
  - '`03-bundled-libs/125` step 7'
  - '`03-bundled-libs/125` steps 7, 8'
  - '`05-jhonstart/26` step 8'
  - '`06-emilia/34` step 3'
  - '`07-onze/53`'
  - '`08-bpp/117`'
  - '`08-bpp/127`'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` B-137, B-139'
  - '`1-botopink-lang/144` B-19'
  - '`2-libraries/150`'
  - '`2-libraries/165` s10'
  - '`machine-1/144`'
  - '`machine-1/144` B-140'
  - '`machine-1/144` B-15'
  - '`machine-1/144` B-17'
  - '`machine-1/150`'
  - '`machine-1/150` (`#[page]`)'
  - '`machine-1/150` s23'
  - '`machine-1/165` s10'
  - '`machine-1/165` s10, s11'
  - '`machine-1/165` s11'
  - '`machine-2/144` B-116'
  - '`machine-2/144` B-137'
  - '`machine-2/144` B-149 P4'
  - '01-checker'
retired:
  - '`.d.bp` declaration files (`builtins.d.bp`, `builtins_fns.d.bp`, `rakun.d.bp`)'
  - '626 (2)''s structural reading of `syntax decl: B`'
  - 'A decorator reading an added member through `decl`'
  - 'The string `addType(name, source)`'
  - '`std-decorator-leaf-import`'
  - '`@expr(v)`'
  - '`@emit`'
  - '`@code`'
  - '375 (1)''s "what the checker cannot follow" clause; the answer''s `subtreeAsync`'
  - '`#[check]` on a field'
  - 'the `Name.Http` type and the inferred return of rakun-restclient''s generated client'
  - '655'
  - '626 (2)'
first-step: 236
last-step: 881
in-force: 29
superseded: 3
---
# decorators — a decorator is a function over the annotated declaration

**A decorator is always a function whose first parameter is `syntax decl`; its name at build is a declaration handle; each invocation is independent; a tag's annotation and a declaration's decorator are one thing.**

(1) The form: typed arguments, trailing defaults, both annotation spellings, namespaced and leaf imports, no module-level annotation — 280, 244, 406, 286, 386, 881, 315.

(2) The handle: its declared type is the contract; `decl` is the declaration as code in every tree; owner, methods, `val` and `var` — 613, 626, 627, 526, 347, 356, 710, 797, 842.

(3) Independence, order and meta reads: 343, 372, 680, 697.

(4) Location: `compiler.src()` legal, no route from a file's place — 403, 734.

(5) Added code: one member per name, errors at the annotation, library code fed by meta — 404, 567, 236.

(6) Tags and expression position — 705, 679 (302 overtaken by 576).

(7) `@emit` / `@code` / `@expr` removed, every output through `compiler` — 605.

(8) A component's asynchrony counts its own body only, read through `compiler.hooks(d)` — 725.

Steps: 236, 244, 280, 286, 302, 315, 343, 347, 356, 372, 386, 403, 404, 406, 419, 526, 567, 576, 604, 605, 613, 626, 627, 636, 655, 663, 665, 666, 679, 680, 697, 705, 710, 714, 716, 725, 728, 734, 797, 842, 881
Binds: 130 steps 5–6 · 01-checker · `01-checker` step 24 · 125 step 7 · `nat-a` · `01-compiler/16-formatter` step 9 · 118 (the template grammar) · `01-compiler/130` step 9 · 118 step 5 · 119 · 120 · 126 · `08-bpp/README.md` § Tag annotations · rakun 12 step 5 (the two markers) · `language-gaps.md` · nat-f3 · `01-compiler/14` step 6 · rakun 04 (R06-2), 05, 88 (R88-5), 92 (R92-5) · rakun 04 (R06-4), 06–10, 08 (R78-1), 29 · `08-bpp/127` · `01-compiler/130` step 10 · 119 step 1 box 5, step 4 · `06-emilia/34` step 3 · `01-compiler/14` step 8 (355's `val` read) · `01-compiler/01-checker` step 23 · `01-compiler/130` · `05-jhonstart/26` step 8 · 371 · every library decorator written `#[ns.d]` · `01-compiler/01-checker` (the row) · rakun 22 · `08-bpp/117` · `07-onze/53` · 285 · `03-bundled-libs/125` step 7 · `01-compiler/01-checker` (example 1 of `decorator-arguments-280.md`) · `01-checker` step 24 (example 1 of `decorator-arguments-280.md`) · `03-bundled-libs/125` steps 7, 8 · `01-compiler/16` · `01-compiler/130` step 8 · 372 · `1-botopink-lang/144` · `2-libraries/150` · `1-botopink-lang/144` B-19 · 216 · 281 · 404 · `1-botopink-lang/144` B-138, B-139 · `2-libraries/165` s10 · `1-botopink-lang/144` B-137, B-139 · `machine-2/144` B-137 · `machine-1/165` s10 · `machine-1/144` B-140 · `machine-1/165` s10, s11 · `machine-2/144` B-139, B-137 · `machine-1/144` B-145 · `machine-1/144` B-15 · `machine-1/144` · `machine-1/150` · `machine-1/144` B-11 · `machine-1/150` s29 · `machine-2/144` B-137, B-139

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 236 | dec-a | A function decorator's per-function code is generic library code fed by meta: `#[page]` records its route in typed meta, a page reads its segments with `use params<P>()` (293), checked against the route; no fifth place; pages stay functions; rakun's `#[middleware]` alike | 130 steps 5–6 | function_decorator_via_meta |
| 244 | ck2-c | A default is trailing everywhere — a parameter or field with a default is followed only by others with defaults: free `fn`, method, record fields, variant payload (`fn-param-default-trailing-only`, extended to records), decorators (406); `docs.md` and every library record with a leading default reorder their fields (named construction keeps call sites valid) | 01-checker | defaults_are_trailing |
| 280 | lg2-i · lg2-f · nat-a (the means) | Decorator arguments are typed comptime values. (0) Every parameter is `comptime x: T` (known at build, else refused at the argument) or `syntax x: T` (the code as written), the modifier written explicitly, else an error at the decorator's declaration (575 (4)); arguments exist only at build — run-time use comes from the decorator's outputs (216); a function or a type is passed on, never called or inspected. (1) An argument may be of any type — a function, a `type`, a `compiler.Field<T>` (308), an enum, a record — checked at the argument. (2) `syntax decl: T`: `T` is the annotated declaration's type, inferred when another parameter uses `T`, through a pattern too (`syntax decl: fn(e: E) -> unknown` binds `E`); unused, `unknown`. (3) `compiler.Field<T>` (308): a typed reference to a field of `T` carrying its name; `.name` resolves against the expected `T`, a missing field an error at the `.name`. (4) `.Name` (field or variant) resolves exactly as declared, case included (`.Custom`, never `.custom`); no output converts case — a name another system needs is an explicit string (281). Use cases: `01-compiler/01-checker/examples/decorator-arguments-280.md` | `01-checker` step 24 · 125 step 7 · `nat-a` | decorator_arguments_typed_comptime |
| 286 | fmt-ann (revision) | Both annotation forms are valid and printed as written: `#[a]` then `#[b]`, or `#[a, b]`, before a declaration and in a template tag (278); the formatter neither joins nor splits; in a list the trailing comma decides (166, 345); meaning identical — each item its own annotation, in written order, for `compiler.annotations(d)` and the registry; a comment between blocks stays where it is | `01-compiler/16-formatter` step 9 · 118 (the template grammar) | annotation_forms_printed_as_written |
| 302 | (annotations) | Overtaken by 576 | `01-compiler/130` step 9 · 118 step 5 · 119 · 120 · 126 · `08-bpp/README.md` § Tag annotations | tag_annotation_is_decorator |
| 315 | lg2-m | No module-level annotation: `#![…]` stays a parse error; an annotation annotates the declaration that follows. A behaviour wanted on several functions is chosen per function (`#[useCache] pub fn posts() -> string { … }`, 316) or bound once in a module-level `val` they call (`val cached = cacheWith(cachePolicy(…));`); `nat-f3`'s (b) loses its `#![internal]` spelling | rakun 12 step 5 (the two markers) · `language-gaps.md` · nat-f3 | no_module_level_annotation |
| 343 | lg2-j | Each decorator invocation is independent: its answer depends on its declaration alone; a module-level `var` written by a decorator body stays refused. A duplicate across declarations (two `#[provides]` of one type, two commands of one name, two handlers of one route) is the registering executor's refusal at init, before `main`, naming both (665) | `01-compiler/14` step 6 · rakun 04 (R06-2), 05, 88 (R88-5), 92 (R92-5) | decorator_invocations_independent |
| 347 | lg2-e | A method-level decorator sees its own method — name, parameters (280), return type, module; its owner through `compiler.owner` (526); the type-level decorator reads the type and every method with its parameters and annotations, and writes what joins them: `#[controller("/users")]` (318) builds `GET /users/{id}` from a method's `#[get("/{id}")]`; a generator checks each `findBy<Field>` against the entity's fields, refusing `findByCiudad` listing them. A method marker is placement; one no type-level decorator reads is caught, where a library wants it, at the entry point (343). Run order never changes an answer | rakun 04 (R06-4), 06–10, 08 (R78-1), 29 · `08-bpp/127` | method_decorator_sees_method |
| 356 | 119-e | A decorator on a `val` runs over a handle of kind `DeclKind.Val` (its name; its declared type as written, `""` when none): `setMeta` legal, `addMember` / `addType` refused at the annotation. The `val` is a registry entry (665): at an entry point its value is the `val`; in a template body its build value, lifted into the template's module as a literal when the initializer is `comptime`, else refused at the read (`typeinfo-all-template-value`) — `#[theme] pub val appTheme = comptime extendTheme(baseTheme(), [entry(.Breakpoint, "md", ThemeValue.Rem(52.0))]);`, read by `rakun-style`'s template as a `Theme` (52rem at build), a compile error with none (358). No closure of the program's functions crosses into a template module; a value is data. The same build value is what 355 reads for a `val` named in a hole | `01-compiler/130` step 10 · 119 step 1 box 5, step 4 · `06-emilia/34` step 3 · `01-compiler/14` step 8 (355's `val` read) | val_decorator_runs_catalogued |
| 372 | s23-e | Provisional (a second splice for a `compiler.hooks(d)` reader's outputs is weighed on a concrete case): a decorator reading `compiler.hooks(d)` runs last in its module and only records meta or refuses. Phases: (1) every decorator reading no hooks — those adding members and associated types (216); (2) the module's bodies are inferred, every member and type present; (3) each hooks reader (its body or a function it reaches, `hooks.readsMember`) runs over them, `setMeta` / `addMeta` / `fail` only — `addMember`, `addType` refused at the call (`decorator-hooks-output`); so `#[graph] fn Page() { return Account(…).validate(); }` above `#[check(…)] pub type Account(…)` compiles. A same-module typed meta read of its target is 592 (5)'s (419 replaced); `s23-i` lost its object (665) | `01-compiler/01-checker` step 23 · `01-compiler/130` · `05-jhonstart/26` step 8 | hooks_decorator_runs_last |
| 386 | s23-h | A decorator reached through a namespace import runs, whatever module declares it — `#[ns.d]` is `#[d]` imported by name: `import {markers};` registers `markers`'s body-carrying decorators under `markers.<name>`, as std's under `<handle>.<name>` (`infer.zig` `registerStdDecorators`); `#[markers.tag]` runs `tag`; `markers.serverOnly` is a declaration handle, compared with `compiler.same` (666). An annotation is never accepted and not run (67) | `01-compiler/01-checker` step 23 · 371 · every library decorator written `#[ns.d]` | namespaced_decorator_runs |
| 403 | lg2-q | A decorator's output never depends on where its file sits — narrowed by 734 to no route from a file's location (`compiler.src()` in a decorator is legal, the annotated declaration's location); `decl.loc` does not exist. A route reaches `#[page]` as an argument — written (`#[page("blog/[slug]", revalidate: hours(1))] pub fn BlogPost() -> View`, 289, 290) or from the route table generated from the `app/` tree at build (`page("blog/[slug]", BlogPost)`, 285) — so a `page.bpp` writes no route; a page reads its segments by hook (293). `compiler.fail(…, at: x)` reports at the annotation or the argument (575 (4)). `language-gaps.md`'s row is by design | `01-compiler/01-checker` (the row) · rakun 22 · `08-bpp/117` · `07-onze/53` · 285 | decl_has_no_source_location |
| 404 | s35-h | Two annotations never add one member name — a decorator adds, never merges or replaces (216); several annotations reach one member through typed meta. A second `compiler.addMember("validate", …)` on one declaration is `decorator-member-duplicate` at the second annotation. Each `#[check]` records a value — `compiler.addMeta(Check(message: message, rule: rule, at: at, code: code))`, `pub type Check<T>(message: string, rule: fn(v: T) -> bool, at: ?compiler.Field<T>, code: Code)` (370 (1)) — and one decorator owns the member: `#[validated]` writes the one `validate`, walking `compiler.metaAll(…, Check)` and appending `Violation(field: c.at?.name ?? "", code: c.code, message: c.message)` where `c.rule(self)` fails, checked pre- and post-comptime (395), its library names resolved in `validation`'s module (384) | `03-bundled-libs/125` step 7 · `01-compiler/01-checker` (example 1 of `decorator-arguments-280.md`) | decorator_member_added_once |
| 406 | s24-b | 244 holds for decorators: `#[check]`'s `message` comes first and is required; on a field the rule is `#[refine(rule)]`, a field marker like the others. (1) Type and function: `pub fn check<T>(syntax decl: T, comptime message: string, comptime rule: ?fn(v: T) -> bool = null, comptime at: ?compiler.Field<T> = null, comptime code: Code = .Custom)` (364, 411; 735); `#[validated, check("As senhas não batem", passwordsMatch, at: .confirm), check("Esse nome já é usado", handleFree, at: .handle, code: .Mismatch)] pub type Account(…)`; `#[check("A senha não pode conter o nome")] fn passwordNotHandle(a: Account) -> bool`; a check without text does not compile; no decorator exception to 244. (2) Field: `#[refine(isEven)] tables: i32` — `refine<T>(syntax decl: T, comptime rule: fn(v: T) -> bool)`, violation coded `custom`, text from the field's message order (`#[refine(isEven)] #[message("Deve ser par")] seats: i32`; none → the locale's `não é válido`); `#[check]` on a field refused, naming `#[refine]` | `01-checker` step 24 (example 1 of `decorator-arguments-280.md`) · `03-bundled-libs/125` steps 7, 8 · `01-compiler/16` | check_message_first_refine_on_field |
| 419 | 130-s8-c | Replaced by 592 | `01-compiler/130` step 8 · 372 |  |
| 526 | B-81-a | A member's handle names its owner, `compiler.owner(d)` (`null` at module level; a handle, not a string), set by the checker when it runs a member's decorator; a registration is named by the declaration's identity, the owner's name joined to the member's (rakun's `query.bp`: `__rkQueryReg_<Owner>_<method>`) — no collision, no hashing; `test/sql_build_test.bp:148` builds. Steps: a 144 step (the field; a cell with two same-named members of two types), then 150 s30 | `1-botopink-lang/144` · `2-libraries/150` | member_decl_names_owner |
| 567 | B-19-a | A type error inside code a decorator added is located at the annotation that added it (`#[maker]` of `#[maker] pub type City(name: string)`), as `decorator-member-duplicate` is; the message names the member or associated type by its owner's path (`City.make`, `City.Columns`) and the decorator's `addMember` / `addType` call with its file and line (281): `` error: expected string, got i32 — in the member `City.make` that `maker`'s `addMember` wrote (models/src/maker.bp:2) ``. No diagnostic of added code points past the file's last line or into the library alone; one decorator on several declarations gives one error per failing annotation | `1-botopink-lang/144` B-19 · 216 · 281 · 404 | decorator_member_error_at_annotation |
| 605 | b139-d · (the maintainer, 2026-10-17) | `@emit`, `@code` and `@expr` are removed with `builtins.d.bp` in B-139; nothing parked, 604 gains no exception; 165 s10 lands before B-139. Replacements: (1) a registration → `val declName = compiler.name(decl); compiler.init({ -> rkRegisterX(declName, decl); })` (575 (3), (4), 580, 581; corrected by 611); (2) a generated type → a template text `` @`…` `` answering a type (577, 578) handed to `compiler.addType` (576 (14)); (3) a generated function beside a type → a static member by typed `compiler.addMember` (576 (9)), its body over `compiler.ast` where it depends on the fields (625 (2)), the owner named `decl` (626): `Name.bindProperties(prefix)`, `Name.check()`, `Name.gated()`, `Name.new()`, `Name.http()`; (4) a generated function beside a `fn` (`<Name>Params`) → no compiler output, a run-time helper of rakun-bpp (`pageParams(route)`) over a schema the marker registers through `compiler.init`; (5) `@expr(v)` → `v`, the template's return typed (578); (6) the compiler-cli fixture and the cells rewritten over `compile`, or removed. Order: B-138 → 165 s10 (rakun and jhonstart migrated, machine 1) → B-139 (the file kind and the three builtins gone together, `unknown-builtin`; B-137's "after 165 s10" box folds in) → B-140; § Machines rule 9 amended. Amends 575 (8), 576 (15) | `1-botopink-lang/144` B-137, B-139 · `2-libraries/165` s10 | emit_code_expr_removed |
| 613 | b137-b · (the maintainer, 2026-10-18) | (d): what flows from build into an executor is always admitted — a `comptime` value as a literal, a `syntax` as its code, a run-time value as itself — only the reverse is impossible (611); so `decl` inside an executor is the annotated declaration itself, spliced as code and bound to it, on every kind, under the checker's ordinary rules, typed by `syntax decl`'s declared type (716). No refusal of the kind, no bare name: the splice names the declaration, never what the name resolves to in the module. A `fn` is the function value, a `val` its value (581 (2)); a type is the type in expression position — `decl.make()` is `Users.make()` (refused unless the type declares `make`, 797), `decl(repo)` its constructor, `rkRegister(name, decl)` where a value is expected the checker's `` `Users` is a type, not a value `` at the annotation with the `called from` line (567); a method is `Users.make` by its owner's path, a static one a function value, an instance one the unbound-method rule; a behavior is the behavior name; a field its owner's field (`Config.db`), legal only where a field path is. Build values are read before the executor (611); 165 s10's `decl.Tx.make()` / `decl.bindProperties(prefix)` registrations were rewritten by s11 (797 (2)). Cells: `compile_executor_handle_on_type`, `_on_method`, `_on_type_as_value` (refused), `_handle_not_module_name` | `machine-2/144` B-137 · `machine-1/165` s10 | executor_decl_spliced_code |
| 626 | 165-g · (the maintainer, 2026-10-18) | (a): inside an added member the owner is `decl`, the annotated declaration as code (613); `syntax decl` is typed by what the decorator requires. (1) 613 holds in every tree, a typed member included: an added member is a method of the annotated type whose body names the owner `decl` (its declared statics, `-> decl`); a `compiler.*` read inside it is evaluated at build and spliced (642); `Self` gains no new meaning — a receiver `self: Self` stays what it is, the owner's statics go through `decl`, its one spelling there; `Self.make()`'s parse error in a hand-written body is a defect, a 144 row; a member the decorator itself adds is held as a value, not reached through `decl` (797, 842). (2) The handle's type says what the decorator needs (575 (4), 280 (2); checked at the annotation): `syntax decl: unknown` for any declaration; a behavior when the decorator calls members — `pub behavior Configurable { fn make() -> Self; }`, `pub fn configurationProperties(syntax decl: Configurable, comptime prefix: string)`, `decl.make()` typed by it, a type without `make()` refused at the annotation naming the missing member; a function type for a `fn` (`syntax decl: fn() -> string`); met by `implement` written on the type (716 (1), 842 — the structural reading is gone); method resolution follows the type's `implement` clauses (617 (1)). 165 s10's `check` and `http` are written as (1). Cells: `decorator_member_owner_static`, `decorator_handle_behavior_typed` | `machine-1/144` B-140 · `machine-1/165` s10, s11 | added_member_owner_is_decl |
| 627 | 165-e · (the maintainer, 2026-10-18) | (a): a `behavior` takes a static member through `compiler.addMember` as a type does; inside an added member `decl` names the owner in a type position too — `fn() -> decl` is the annotated behavior. A behavior's static is where its `default fn` without `self` lives; by 617 a contract's member, never a cell. `decl` is the declaration as code wherever its kind fits — expression (`decl.make()`) and type (`-> decl`, `x: decl`); on a `fn` or a `val`, `decl` in a type position is the checker's own refusal. rakun-restclient: `pub fn httpClient(syntax decl: unknown, comptime base: string) -> void { val client = compiler.ast(…); compiler.addMember("http", fn() -> decl { return client.make(base); }); }` — `Api.http()` answers an `Api`; the generated `Name.Http` type and the inferred return go. Cells: `behavior_static_added_member`, `decl_in_type_position` (refused on a `fn`) | `machine-1/165` s10, s11 · `machine-1/144` B-140 | behavior_static_added_member |
| 655 | lg2-d · (the maintainer, 2026-10-18) | Overtaken by 316 | `machine-1/144` |  |
| 679 | B-15-b · (confirmed as built, the maintainer's batch, 2026-10-18) | A handle `compiler.bindings(e)` answers has no read of the decorator that annotated it; a template body tells annotations apart by the meta they recorded, read by type (`compiler.meta(d, RawBody)`, 302, 576 (11)); no `Decorator` type (666) — an annotation's `DeclAnnotation.decorator` handle is compared with `compiler.same`; B-15's `Decorator.same` row goes | `machine-1/144` B-15 | bindings_handle_has_no_decorator_read |
| 680 | B-15-c · (confirmed as built, the maintainer's batch, 2026-10-18) | Inside a decorator `compiler.meta(decl, T)` on its own handle is refused; a declaration's meta is read by the code consuming it, after every annotation ran (`comptime compiler.typeInfo(X).meta(T)` in a run-time body, 606 (3); a template body over `compiler.meta(d, T)`). Annotations never depend on their order: the body runs in annotation order and reads none of it. A `compiler.*` read inside the decorator's `compiler.init` executor is folded after every annotation ran (614, 642), so `compiler.meta(decl, Entity)` there (665's example) reads a settled value and is allowed | `machine-1/144` B-15 | decorator_meta_read_own_handle_refused |
| 697 | s29-b · (confirmed as built, the maintainer's batch, 2026-10-18) | A type's or a behavior's methods' decorators run before the owner's; a method's `compiler.setMeta` / `addMeta` is kept for its owner (one value per type and method, `decorator-meta-twice`), read in the owner's body through `compiler.methods(d)` — `compiler.meta(m, Query)` / `compiler.metaAll(m, Query)` (576 (8), 313, 298); a field's decorator records no meta; string meta on a method stays refused | `machine-1/144` · `machine-1/150` | template_annotation |
| 705 | lg2-u · (confirmed as built, the maintainer's batch, 2026-10-18) | Outside markup, expression-level work is a call (`traced(compute())`); a tag's annotation is the one expression-position decorator (278, 302, 369); `val x = #[deco] 1;` stays refused. (1), as built | `machine-1/144` | expression_decorator_outside_markup_refused |
| 710 | 116-c · (confirmed as built, the maintainer's batch, 2026-10-18) | A user decorator on a module `var` is refused at the annotation (`` `#[mark]` annotates the module `var` `count`, and a decorator runs on a `val`, never on a `var` ``; 356: a `var` has no build value); `#[compiler.beamMemory(…)]` is untouched; a `DeclKind.Var` is added, without breaking a program, when a use is measured | `machine-1/144` | val_decorator_on_var |
| 725 | s23-j · (the maintainer, 2026-10-11; numbered 2026-10-18 with what stands after 504, 553, 576) | A component is never asynchronous because of its children: 375's mark counts the node's own body only. A component answers its tree (388); composing another, a received value included, only puts its lambda in the tree (504). A node is asynchronous only when its own body writes `await` or `async { }`, `use`s an asynchronous hook, or calls a host function answering `Async<T>` or `Component<R>` (553 (2)); an `await` or `async { }` in a lambda written in the body counts (277); a botopink function answering `Async<T>` called with no written `await` does not; a target with no published node is asynchronous; a call through a function value or a method marks nothing (375 (1)'s "what the checker cannot follow" clause goes; 504, 720). A marked component answers a task of its tree (a state machine on wasm, 504), every other its tree directly. The root is always asynchronous: a `#[page]`'s render and `renderToString` walk the tree awaiting only the marked lambdas, finding while descending whether a subtree waits (504); no build-time subtree mark (`subtreeAsync` dropped). A decorator reads the mark through `compiler.hooks(d)` (576 (8)). Amends 375 (1) | `machine-1/144` B-17 · `machine-1/150` s23 · `machine-2/144` B-116 | component_async_own_body_only |
| 734 | ctr-z · (the maintainer, 2026-10-18) | (a): `compiler.src()` in a decorator body is legal, answering the annotated declaration's location (718, 575 (3)); 403 survives as no route from a file's location: an output may carry a location (a diagnostic, a snapshot, a meta), nothing of a file's place names a page — a route reaches `#[page]` as an argument, written or generated from the `app/` tree (403). `decl.loc` does not exist: the location is the compiler's member, not the handle's. Cell `decorator_compiler_src_is_declaration_location` (four targets; `compiler.src()` recorded as meta, read at run time) | `machine-1/144` B-17 · `machine-1/150` (`#[page]`) | decorator_compiler_src_is_declaration_location |
| 797 | 716-a · (the maintainer, 2026-10-20: chose (c), "só a remoção dos rk*", over (a) a structural check counting the members the decorators add and (b) `implement` written on every annotated type) | No new rule for `syntax decl`: a member a decorator adds is never counted in `decl`'s type — `decl` has only what the annotated declaration declares — and rakun's executors stop calling added members on `decl` as 165 s11 removes them (625 (1)); 716 stands. (1) `syntax decl: unknown` with `compiler.addMember(decl, …rkRoutes…)` then `compiler.init({ -> register(decl.rkRoutes()) })` stays refused at the decorator (`unknown` has no member `rkRoutes`); a behavior-typed `decl` is not met by a member the decorator adds. (2) rakun's 166 refused sites (`decorators.bp`, `config.bp`, rakun-data's `orm/entity.bp`, …) go with 165 s11's registrations through `compiler.init` (each marker registering itself, the run-time registry grouping by owner, the executor receiving what it needs as values); rakun stays red on `feat` until s11 lands — no bridge rule. (3) The added typed members a decorator's trees call (`make`, `check`, `entityMeta`, `Tx`, `bindProperties`) and whether a behavior-typed `decl` is met by `implement` or structurally (716 (1) against 626 (2)) were question 797-a, answered by 842 | `machine-1/165` s11 | decl_added_member_not_counted |
| 842 | 797-a · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 1" — decided by the fable at the maintainer's delegation; (2) answered by 716 (1), the later row, over 626 (2); rejected for (1): (b) a member counted inside the decorator that added it, (c) the typed members registered at run time) | A member a decorator adds and then needs is held as a value — written once, added, handed to its executor and its other members, never read back through `decl`; a behavior-typed `decl` is met by `implement` written on the type (716 (1)); 626 (2)'s structural reading goes. (1) `val make = fn() -> decl { … }; compiler.addMember("make", make); compiler.addMember("check", fn() -> string { return make().host; }); compiler.init({ -> register(make()) });` — a `fn` literal is a literal under 759, a tree spliced into a tree under 575 (4); `decl.make()` stays refused unless the type declares `make` (797). (2) `syntax decl: Configurable` admits only a type writing `implement Configurable`, its `make` checked by 800; rakun's 165 s11 sites (`configurationProperties`'s `make` / `check`, rakun-restclient's `http`, rakun-data's `entityMeta` / `Tx`) are written so | `machine-1/165` s11 · `machine-1/144` B-140 | added_member_handed_as_value |
| 881 | docs-b · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 2" — decided by the fable at the maintainer's delegation; rejected: (b) the refusal kept over every std decorator) | A std decorator imported as a leaf is annotated by that name, as a library's is; `std-decorator-leaf-import` goes with 644's landing. (1) `import {compiler.beamMemory} from "std"` makes `#[beamMemory(.Ets)]`, an alias its alias; `unknown-annotation` through a handle stays. (2) Removed in B-149 P4's commit; `retired.md` gains the code. (3) The cell `std/cells/std_decorator_leaf_import` becomes the run cell `std_decorator_leaf_import_runs`, four targets, red on the parent | `machine-2/144` B-149 P4 · docs item 16 | std_decorator_leaf_import_runs |
