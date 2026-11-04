---
scope: >-
  Decides the derived-type utilities — `Type.pick` / `omit` / `partial` / `required` / `merge`,
  statics of std's `Type` written in botopink over `compiler.fields` and `compiler.buildTypeInline` —,
  what a derived type carries, how a field's default travels, and `compiler.Field<T>` /
  `compiler.Info<T>` as build-time values. Spreads over records are records-and-props; the builders
  and the handle reads are compiler-module; a decorator's outputs are decorator-outputs-and-meta.
terms:
  - '`Type.pick`'
  - '`Type.omit`'
  - '`Type.partial`'
  - '`Type.required`'
  - '`Type.merge`'
  - '`types.bp`'
  - '`compiler.Field<T>`'
  - '`compiler.Info<T>`'
  - '`defaultValue`'
  - '`compiler.fields`'
  - '`compiler.buildTypeInline`'
  - '`derived-type-source-not-record`'
  - '`comptime/derived_types.zig`'
  - '`HookUse`'
  - '`#[index(.state)]`'
  - '`isClosedDefault`'
  - '`Type.keys`'
related:
  - 'compiler-module'
  - 'records-and-props'
  - 'decorator-outputs-and-meta'
  - 'validation'
  - 'typed-ast-code-and-mocks'
  - 'types-enums-and-patterns'
open:
  - '424: a type application (`Type.pick(Box<i32>, .item)`) or an alias followed through its module as a derived type''s source — a later step when a front needs it'
binds:
  - '`01-checker/examples/decorator-arguments-280.md`'
  - '`01-checker` s24, s28'
  - '`01-checker` s28'
  - '`01-checker` step 28'
  - '`1-botopink-lang/144` B-14, B-140'
  - '`1-botopink-lang/144` B-140, B-10'
  - '`1-botopink-lang/144` B-16 (closed), B-140'
  - '`2-libraries/146` s3 (`#[check]`, the optional field)'
  - '`2-libraries/150`'
  - '`machine-1/144` B-140'
  - '`machine-1/144` B-17, B-137'
  - '`machine-1/150` s23'
  - '`machine-1/165` s11'
retired:
  - '`hasDefault: bool`'
  - 'validation''s `#[pick]`, `#[omit]`, `#[partial]`, `#[required]`, `#[extending]`'
  - '`Type.keys`, `Field.of`, `Field.all`; a field key matched by `case`'
  - 'the compiler-side bodies of `Type.*` (keyed on the std declaration)'
  - 'the cells `field_key_runtime`, `field_key_case_missing`, `field_key_unknown_field`, `type_keys_outside_val`, `field_key_under_annotation`; `recipe.get(key)`'
  - '`isClosedDefault`, the derived-type refusal of a non-closed default, `imported_field_default_not_derived`'
first-step: 307
last-step: 726
in-force: 10
superseded: 3
---
# derived-types-and-fields — `Type.*`, `compiler.Field<T>` and `compiler.Info<T>`

**A derived type is an inline type named by its `val`, built by a botopink body over `compiler.fields` and `compiler.buildTypeInline`; a field's default travels with it; `compiler.Field<T>` is a build-time value with a run-time form.**

(1) The five utilities; what a derived type carries; its sources — 307, 422, 423, 424.

(2) `compiler.Field<T>`: a build-time value, its `defaultValue` — 308, 598, 599.

(3) A derived type's identity (600, as 629 amends it); a default travels where it was written — 600, 671.

(4) `compiler.Info<T>` in a `HookUse` — 726.

(5) Superseded: 699 (422), 700 (423), 701 (424).

Steps: 307, 308, 422, 423, 424, 578, 598, 599, 600, 606, 625, 628, 629, 630, 631, 640, 645, 669, 670, 671, 699, 700, 701, 726
Binds: `01-checker` s28 · `134` s2 · std `types.bp` · 125 s5, s11 · `language-gaps.md` (derived record row) · `01-checker` s24, s28 · `01-checker/examples/decorator-arguments-280.md` · rakun 08 s4 · `01-checker` step 28 · 307 · `1-botopink-lang/144` B-140, B-10 · `2-libraries/146` s3 (`#[check]`, the optional field) · `1-botopink-lang/144` B-16 (closed), B-140 · `libs/std` `compiler.bp` (630) · `conformance/docs.md` · `2-libraries/150` · `1-botopink-lang/144` B-14, B-140 · `machine-1/144` B-140 · `machine-2/144` B-149 · `machine-2/144` B-139 · `machine-2/144` B-148, B-149 · `machine-1/165` s11

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 307 | nat-d5 | A derived type is a compile-time function answering a new type, bound by a `val`; the five are statics of std's `Type`: `import {types.Type} from "std";` then `pub val RecipeTitle = Type.pick(Recipe, .title);`, `Type.partial(Recipe)`, `Type.omit(Recipe, .description)`, `Type.merge(Dog, Breed)`, `Type.required(T)` (422). Each is a `comptime` function — every parameter `comptime` (364), fields as `compiler.Field<T>` references (`.title`, 308; a string refused) — run only at compile time (266), so the call needs no `comptime` keyword; `Type` is declared in std's `types.bp`, its bodies written in botopink over `compiler.*` (599 (3), 629; the compiler-side bodies retired); `partial(…)` without `Type.` is unbound. The answer is a new type named after its `val` (an inline type, structural: 629), usable in every type position, exported and imported like any type, annotatable (`#[validated] pub val RecipePatch = Type.partial(Recipe);`, 302); the source fields' markers come with them (fields and annotations only, 423). A plain alias (`type Id = i32`) stays transparent (118). validation's `#[pick]`, `#[omit]`, `#[partial]`, `#[required]` and `#[extending]` are retired | `01-checker` s28 · `134` s2 · std `types.bp` · 125 s5, s11 · `language-gaps.md` (derived record row) | derived_type_static_methods |
| 308 | (types) | `Field<T>` is std's `compiler.Field<T>`: declared in `compiler.bp` (630; once an associated type of `Type` in `types.bp`), imported where named (`import {compiler.Field} from "std";`); in a decorator signature `comptime at: ?compiler.Field<T>`, `comptime ..fields: compiler.Field<T>[]` (412); its values are the fields of `T`'s declaration, the `.name` shorthand unchanged; the reflection record `compiler.fields(d)` hands out is `compiler.Field<unknown>` (598). The run-time key is retired by 599 (1): `Type.keys(Recipe)` (`pub val RecipeKey = Type.keys(Recipe);`, the same type, never a second enum), a `compiler.Field<T>` as a run-time value — `case key { .title -> …; … }` exhaustive over the fields, `key.name` → `string`, `RecipeKey.of(text) -> ?RecipeKey`, `RecipeKey.all()` in declaration order; no `recipe.get(key)` | `01-checker` s24, s28 · `134` s2 · std `types.bp` · `01-checker/examples/decorator-arguments-280.md` · rakun 08 s4 | field_type_from_std_types |
| 422 | s28-b | `Type.required` removes a field's `?` and its `null` default together, no other (671): `Type.required(Recipe)` answers `description: string` | `01-checker` step 28 · 307 | type_required_removes_optional_default |
| 423 | s28-c | A derived type carries the fields and their annotations only — `Type.pick(Recipe, .title)` is `T(title: string)` without `Recipe`'s methods or `implement` clauses, behaviour written on it; the `val`'s own annotations go on the type | `01-checker` step 28 · 307 | derived_type_fields_only |
| 424 | s28-d | A generic record or an imported alias is no derived-type source: `Type.pick(Box, .item)` with `Box<T>` is `derived-type-source-not-record` at the argument. Revisited when a front needs a type application (`Type.pick(Box<i32>, .item)`) or an alias followed through its module | `01-checker` step 28 · 307 | derived_type_source_plain_record |
| 598 | B-10-a · (the maintainer, 2026-10-17) | `compiler.Field<T>` carries a field's default as `defaultValue`: the default as written, `null` when the field has none. `compiler.Field<T>(name: string, type: anytype, annotations: DeclAnnotation[], defaultValue: ?anyvalue)` in `compiler.bp` (630; `default` is a keyword and no field takes a keyword's name). The member holds the default's code as a tree (575 (4), 576 (12)), read at build through `compiler.*` (`compiler.text(f.defaultValue!)` answers `0`, `null`, `clock.now()`), never a value computed at build (281): a default is evaluated where the record is built, at run time. `f.defaultValue != null` is the one test for "has a default" (not a `hasDefault: bool` alone, which leaves validation's decode without the fallback it writes). Cells `typeinfo_field_default_value` (a default read and spliced by a decorator), `typeinfo_field_default_none`. Amends 308 | `1-botopink-lang/144` B-140, B-10 · `2-libraries/146` s3 (`#[check]`, the optional field) | field_default_value |
| 599 | B-16-a · B-16-b · (the maintainer, 2026-10-17) | The run-time field key goes; `compiler.Field<T>` is a build-time value; what is built at comptime is built through `compiler.*`, in botopink. (1) 308's run-time half is removed: `Type.keys`, `Field.of`, `Field.all`, a `compiler.Field<T>` as a run-time value (631 later gives it a run-time form); `compiler.bp` (630) keeps `compiler.Field<T>(name, type, annotations, defaultValue)` (598) and the derived-type functions; the cells `field_key_runtime`, `field_key_case_missing`, `field_key_unknown_field`, `type_keys_outside_val`, `field_key_under_annotation` go with `conformance/docs.md`'s run-time key paragraph; B-16-a and B-16-b lose their object. (2) The build-time key stays: `.field` written where a `compiler.Field<T>` is expected in a decorator's argument (`#[index(.state)]`, 280 example 6), checked against `T`'s fields — rakun-data's `index` / `unique` (150). (3) The rule from here on: a type or a value assembled at comptime is assembled by a botopink body over `compiler.*` — `compiler.fields(T)` to read, `compiler.buildType` to build (578), `compiler.addType` / `addMember` to attach — never by a compiler-side special case: `Type.partial` and its siblings (`required`, `merge`, `pick`, `omit` — kept as the type-building utilities, TypeScript's `Partial`, `Pick`, `Omit`) are std functions written that way in B-140, and `comptime/derived_types.zig` keeps only the record's materialisation and the two `val` rules (575 (7)); a new need of that kind is a std function over `compiler.*` first, a compiler change only where `compiler.*` cannot express it. Amends 307, 308; 359 (2) and 422 unchanged | `1-botopink-lang/144` B-16 (closed), B-140 · `libs/std` `compiler.bp` (630) · `conformance/docs.md` · `2-libraries/150` | field_build_time_value |
| 600 | B-14-c · (the maintainer, 2026-10-17) | A derived type carries no lineage: `pub val Patch = Type.partial(Pessoa); pub val Nome = Type.pick(Patch, .nome); pub val Full = Type.required(Patch);` declare three types of their own, unrelated to `Pessoa`'s construction; `Type.required` restores nothing; a derived type's value is built by its own name — `Patch(nome: "Ana")`, `Nome(..patch)`, `Full(nome: "Ana", idade: 3)` — never through `Pessoa`. The nominal reading (a value of `Type.pick(Type.partial(R), …)` or `Type.required(Type.partial(R))` no spread source for `R` — `Pessoa(..nome, idade: 3)` and `Pessoa(..full)` refused at the `..` as any record of another type, 359 (2)) is amended by 629: a derived type is an inline type typed by structure, a spread accepted when the fields match (`Pessoa(..nome, idade: 3)` with `nome: Nome`) and refused at the `..` where a type differs (`Pessoa(..patch)`: `?string` is not `string`). Cells `record_spread_derived_partial` and `record_spread_required` (headers naming this decision, B-140). Confirms 307 | `1-botopink-lang/144` B-14, B-140 | derived_type_is_nominal |
| 671 | b140-d · s28-a · (the maintainer, 2026-10-18) | A field's default travels with the field into every derived type and resolves where it was written (669); there is no "closed" default (amends 421). `pub type Link(href: string, rel: string = defaultRel())` in `links.bp`: `Type.omit(Link, .href)` in another module or package copies `rel` with its default, and `NoHref()` answers `rel = "noopener"` as `Link(href: "/x")` does — the default's code is `links.bp`'s, `defaultRel` and what it reads stay private there, the generated code calls it qualified (the target exports what a default reaches; 421's `defaultRel/0 undefined` was a codegen defect). `compiler.Field.defaultValue` always holds the default as written (598), a node bound to its module (B-149), `null` only for a field with no default; a decorator that rebuilds a type hands it on unchanged (`Field(f.name, f.type, default: f.defaultValue)`). The one limit is 669's: a default names only what its own module sees. `isClosedDefault` and the derived-type refusal of a non-closed default are retired; cells `derived_type_default_travels` (a private function of the source module, four targets), `derived_type_default_module_val`, `derived_type_default_across_packages`; `imported_field_default_not_derived` is rewritten as the first of them. 421 is `Amended by 671`; s28-a closes with it | `machine-1/144` B-140 · `machine-1/165` s11 | derived_type_field_default_travels |
| 699 | s28-b · (confirmed as built, the maintainer's batch, 2026-10-18) | Overtaken by 422 | `machine-1/144` B-140 | |
| 700 | s28-c · (confirmed as built, the maintainer's batch, 2026-10-18) | Overtaken by 423 | `machine-1/144` B-140 | |
| 701 | s28-d · (confirmed as built, the maintainer's batch, 2026-10-18) | Overtaken by 424 | `machine-1/144` B-140 | |
| 726 | s23-f · (the maintainer, 2026-10-11; numbered 2026-10-18 with what stands after 575–630) | A type argument's `compiler.Info<unknown>` in a `HookUse` carries the type's whole declaration: the type arguments of a `use` (`use params<BlogParams>()` → `[BlogParams]`) are `compiler.Info<unknown>` (606 (3), 630), each with every field's annotations and the type's methods as `compiler.fields(d)` / `compiler.methods(d)` give them (576 (8)) — `fields[0].annotations` lists `#[validated]`; the build session publishes each module's type declarations, so an empty list never means "not carried". A field is `compiler.Field<T>(name, type: anytype, annotations, defaultValue)` (598); a type is a type value, never a name string (575, 578); the answer's `TypeInfo<unknown>` with `kind: TypeKind` and `args`, and its `builtins.d.bp` records, are retired (575, 578, 598, 606, 630). An annotation's arguments are read through the typed meta (697) | `machine-1/144` B-17, B-137 · `machine-1/150` s23 | hook_use_type_argument_info |
