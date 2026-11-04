# Retired — what was discontinued and what replaced it

This page lists every form the language, the compiler, std, the libraries and the process have retired, with the form
that replaced each, so that nobody writes or reads an old form as current. It is derived from the record,
[`decisions-taken/`](decisions-taken/README.md) (one file per group: its rules in force, then its `## Record` table), and
every row cites the decisions it comes from; where two decisions differ, the later one wins and this page follows it. Each
group's metadata block lists, under `retired`, the rows of this page its decisions produced. A form listed here appears
legitimately only when named as retired — in a decision's own text that retires it, in a codemod's rule, or in a cell that
tests its refusal (`prelude_name_with_sigil` refuses an `@`-prefixed prelude name, for example); a decision never uses it as current.

## Language spellings

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `@Result<T, E>` | `Result<T, E>`, declared in `primitives.bp` | 606 (1), 609 | 2026-10-18 |
| `Option<T>`, `Optional<T>`, `optional<T>` (and the `@Option<T>` of 1.0.1), `.Some(v)` / `.None` over an optional | `?T`; absence is `null` | 2, 32, 44, 47, 54 | Each name is refused and the refusal names `?T`. The checker's internal `optional<T>` never reaches a hover (44) |
| The builtin `result` namespace; methods on `?T` | `r.map(f)`, `r.flatMap(f)`, `r.unwrapOr(x)`, `r.isOk()`, `r.isError()` on `Result`; `??`, `?.`, `?.[i]`, `?.(args)` and `!` on `?T` | 330 | |
| `Ok(…)` / `Error(…)` as constructors in an expression | `return v` / `throw e` | 208 | They stay `unbound variable` in an expression; they remain `case` patterns |
| `@Task<T>`; `Task` as a prelude name | `Async<T>`, with the `async` marker (`pub async fn f() -> Async<T>`) | 553 (2), 606 (1), 732 | 2026-10-15 (553), 2026-10-18 (732). 606 (1)'s `Task<User>` and 623's `Task<…>` read `Async<…>` |
| `map`, `then`, `mapError`, `catch` on a task | `try await … catch`, `case` on `await`'s `Result`, or an `async { … }` block | 523, 537 (3) | |
| `@Component<R>`; `@Component<C, R>` (the base parameter) | `Component<R>`, with the `component` marker (`component fn`) | 354 (1), 553 (2) | |
| `@Iterator<T>` | `Iter<T, R = void>`, with `iter fn` | 553 (2) | |
| `@Stream<T>` | `AsyncIter<T, R = void>`, with `async iter fn` | 553 (2) | |
| `@Hook` | `Component<R>`, read with `use` | 354 (1) | |
| `@Renderable`, `@Future`, `@Use` | `Renderable`, `Future`, `Use` (written bare, from `primitives.bp`) | 606 (1) | `Renderable` since removed (804 (2)) |
| `@Context<C>` (the context marker on a component's type) | — (removed): a `Component<R>` whose `R` implements `Renderable` is a component | 354 (1) | |
| `@embed("path")` — the `@` builtin call, in a program and as a printed form of the resolved program | `comptime compiler.embed("path")`, answering a `Link`, opened through `Asset(link).open()` (§ The `compiler` module and builtins) | 606 (1), 607 | 2026-10-18; no `@name` builtin remains. 835 (2)'s printing of a folded `Asset` as `@embed("path")` is a retired form too: a folded `Asset` prints `Asset(Link(path: "…"))` and bytes `bytes.fromHex("…")` (885, the maintainer, 2026-10-21) |
| `@getContext(T)` | `use context(themeContext)` | 269, 354, 379, 722 | 269 is `Replaced by 354 and 379` |
| `Context<T>()` | `createContext(value)` (std's `context` module) | 378 (1) | std's `Context<T>` remains a record holding `contextValue: T` (683) |
| `use context(T)`, a context read by a bare type name | `use context(themeContext)`, a context value the reader imports | 722, 723 | 2026-10-18 |
| `use provide(ctx, value)` | `use provide(ctx)`, the context value alone; another value is a new `createContext(…)` in the body | 723, 379 (2) | 2026-10-18 |
| `context-unbound` | — (removed): a read answers the nearest provider above, else the declared default | 378 (3), 723 | 354 (4)'s root check stays open as a contradiction (§ contexts-and-components (3)) |
| `@is(…)` | `x is T` | 322 | `@is(…)` is refused naming `x is T` |
| `@block` | `{ … }`, a block (a `{` without `->`) | 525 | 2026-10-14 |
| `comptime { break v; }`; a `case` arm's `break <value>` | the block's or the arm's tail, its last expression written without `;` | 525, 541 (2)–(4) | `botopink format` rewrites both (588) |
| The `runtime` keyword | — (removed): a line runs on the side of the body it is written in; `comptime` and `compiler.init` are the two crossings | 632 | 2026-10-18 |
| Any other marker order (`async pub fn`, …) | `#[…] [pub] [default] <marker> fn` | 572 | 2026-10-16 |
| `async { x -> … }`, `iter { -> … }`, `async iter { x -> … }`, `component { -> … }` (a marked lambda's marker before the brace) | `{ async x -> … }`, `{ iter -> … }`, `{ async iter x -> … }`, `{ component -> … }` | 584 (1), 794 | 2026-10-17. `async { … }` is the block and `iter loop { … }` the loop; a marker without its arrow is refused, `marker-without-arrow` (794) |
| `#[use]`, `#[future]`, `#[generator]`, `#[resultGenerator]` (effect annotations) | the body markers `component`, `async`, `iter`, `async iter` | 553, 606 (4) | Refused, `effect-annotation-removed` |
| A function whose return type is inferred from its body; `fn f(x: T) R`, the arrow-less shortform | the return type always written after `->`, `-> void` included | 622, 33, 846 | Refused, `fn-return-missing` |
| A lambda typed by its later calls | a lambda whose position fixes its type, or `fn(x: T) -> R { … }` | 583 | Refused, `lambda-untyped` |
| `mod m;`, `pub mod`, `lib.bp` | every `.bp` under `src/` is a module, its path its name | 592 (1), 337 (2) | |
| The shorthand import (an item with no `from` whose first segment names no module) | the brace form `import {a.b.c};` | 337 (1) | Refused, `shorthand-import` |
| `from "<a module of this package>"`, `from "<the package's own name>"` | the brace form with no `from` (`import {log.logger};`) | 206, 309 | Refused, `module-import-with-from`; std included |
| `from "std"` inside std | `import {path.relative};` | 309 | |
| The "prefix module wins" rule; `expandImports` | 582's namespace and item rules; a collision is `module-item-collision` | 582 | |
| `.d.bp` declaration files (`builtins.d.bp`, `builtins_fns.d.bp`, `rakun.d.bp`) | ordinary `.bp` modules; each declaration in the std module that owns it | 575 (1), 605, 606 | A file still ending `.d.bp` is a module named `x.d` |
| `Array<T>`, `String`, `Bool`, `BigInt`, `Bytes` | `array<T>` (spelt `T[]`), `string`, `bool`, `bigint`, `bytes` | 641, 617 (1) | Statics move to the type: `string.fromCodepoint(65)`, `array.range(0, 3)`, `bytes.fromUtf8(s)` |
| `I32`, `I64` (per-width contracts) | the types `i32`, `i64`; contracts are `Number`, `Integer`, `Signed`, `Float` | 641, 496 | |
| `Pair<A, B>` | the tuple `#(A, B)` (`#(a, b)`, `p._0`, `val #(a, _) = p`) | 738 | 2026-10-18. `prelude_has_no_pair_or_function` refuses `Pair.of` |
| `Function` (and its statics) | `fn(A) -> B` as the type; `identity`, `compose`, `flip`, `constant` from std's `functions.bp` | 738 | 2026-10-18 |
| `any` | `unknown`, narrowed with `is` | 31 | |
| `@src()`, `src` | `compiler.src()` (`comptime compiler.src()` in a run-time body) | 575 (4), 606 (2), 718 | |
| `...` as a spread | `..` (`Pessoa(..p, nome: "Ana")`) | 359 (1), 529 (3), 864 | Refused `spread-dot-dot-dot` naming `..`; nothing migrates it (864); `...` is the inclusive range alone |
| `for x in xs { … }` (553 (3)'s and 950's spelling of the collection loop) | `for xs { x -> … }`, `for (a, b) { x, y -> … }` (105); refused `for-in-loop` | 956 | 2026-10-21; 950 reversed |
| `p.f = v` (assigning a record field) | `Person(..p, f: v)` | 37 | |
| `<pattern> as <name>` | — (removed): a `case` binds through its variant pattern | 11 | |
| A `Range` value, `.rev()` | — (removed): `a..b` / `a...b` is syntax of a pattern, a loop or a slice | 105 | |
| `===`, `behavior Eq`, a user `equals` | `==`, structural; another sameness is a method with its own name | 211, 348 | |
| `use client;` (a module-level directive) | `#[client]`, a library decorator | 87 | |
| `is-type-parameter` on `v is X<T>` with `T` bound by `v`'s type | accepted, tested by `X`'s identity | 810 (1) | 2026-10-21 |
| `extend` on a primitive; `behavior string` | `Sym implement B for string {}` | 799 | 2026-10-20 |
| `opaque` before an enum, a namespace, a primitive or an alias | a record alone; `opaque-not-record` | 829 | 2026-10-21 |
| `opaque-method`; an opaque type's non-`pub` method type-private | `method-not-pub`, module-private for every type | 814 (2), 859 | 2026-10-21 |
| A type's non-`pub` method meeting another module's extension block | `pub`, or the same module, else `method-not-pub` at the block | 886 | 2026-10-21 |
| `val length: i32;` (a member added without `pub`) | `pub val length: i32;` | 887 | 2026-10-21 |
| An exhaustiveness refusal with no code | `non-exhaustive` | 858 | 2026-10-21 |
| `throw` or a propagating `try` in a `defer` body; cell `defer_try_and_throw_propagate` | `defer-throw`, `defer-try` | 866 | 2026-10-21 |
| 537 (2)'s `??` above `catch` | `catch` lowest, `??` tightest | 865 | 2026-10-21 |
| An alias of `Component<T>` kept in a declared return (118 rule 1) | erased: `Component<Element>` | 852 | 2026-10-21 |
| A module atom pair refused on erlang and beam only; cell `erlang_module_atom_pair_refused` | every target; `module_atom_pair_refused` | 890 | 2026-10-21 |
| 626 (2)'s structural reading of `syntax decl: B` | `implement` written (716 (1)) | 842 | 2026-10-21 |
| A decorator reading an added member through `decl` | the member held as a value | 797, 842 | 2026-10-21 |
| A lambda's parameter count fixed by its expected type | an untyped lambda may omit trailing parameters | 888 | 2026-10-21 |
| `effect-await-without-task`, `yield-without-generator`, `use-without-context-effect` | `await-without-async`, `yield-without-iter`, `use-without-component` (no alias) | 573 | 2026-11-04, found by the record rewrite |
| `component-lambda-not-lowered` | — (deleted): a `component` lambda compiles and runs as a `component fn` on every target | 574 | 2026-11-04, found by the record rewrite |
| `conformance/docs.md`'s equivalence `iter { x -> b }` ≡ `{ x -> iter loop { b; break; } }` | — (dropped): a marked lambda's body is a function body; the lowering is the compiler's own | 584 (2) | 2026-11-04, found by the record rewrite |
| `async fn f()` with no return type | refused `marker-type-mismatch`, 'write `-> Async<…>`' | 584 (3) | 2026-11-04, found by the record rewrite |
| `context-getcontext-anchor-violation` | — (removed): 354 (4)'s build check at the `use` naming the context | 354 (4) | 2026-11-04, found by the record rewrite |
| `component-value-to-generic` (a component value handed to generic code refused at build) | — (removed) once 388's lowering landed: `itens.map(Card)` answers lambdas | 388 (1), (6) | 2026-11-04, found by the record rewrite |
| a component call rendered in a component body (`inferComponentCall`, 104, 118, 128) | a call answers `Component<R>` wherever written; the tree or `use c` resolves it | 791 (1) | 2026-11-04, found by the record rewrite |
| `#[key(k)]` outside every function body | refused `key-outside-body`; keyed where the list is run, `use all(views.map({ v -> #[key(v.id)] v }))` | 960 | 2026-11-04, found by the record rewrite |
| `use context(StyledSheet)` (352's read by type) | `use context(StyledContext)` | 352 (via 722) | 2026-11-04, found by the record rewrite |
| `loop (xs) { x -> … }`, `loop (cond)`, `loop await` | `for xs { x -> … }`, `while (cond)`, `for await s { x -> … }` | 105, 956 | 2026-11-04, found by the record rewrite |
| `removedKeywordWhile` (the refusal of `while`); `for` as an idle lexer keyword | — (removed): `while` and `for` are keywords | 105 | 2026-11-04, found by the record rewrite |
| `break v` making a loop worth `[v]`; `yield` in a plain `fn` feeding "the loop's array" | — (removed): nothing evaluates to `[v]`; `yield` in a plain `fn` is refused; collecting is `xs.map(…)` / `filter(…)` or a `var` | 105 | 2026-11-04, found by the record rewrite |
| `#[@generator] loop`, `#[@resultGenerator] loop`, `#[@futureGenerator] loop` (the annotated loop as a generator) | the `iter` / `async iter` forms of body-markers-async-and-iter (118, 123, 125) | 105 | 2026-11-04, found by the record rewrite |
| `try-await-operand` | — (removed): `await` and `try` are prefix operators, `catch` the lowest infix | 537, 865 | 2026-11-04, found by the record rewrite |
| `refuseBeyondJsSafeInteger` | — (removed): an integer literal past its type's range is refused by the checker on every target | 319 | 2026-11-04, found by the record rewrite |
| `fn-expr-typed`, `reject/fn_expr_typed` | — (removed): the typed function expression `fn(x: T, …) -> R { … }` is legal in every position | 408 | 2026-11-04, found by the record rewrite |
| 950's `for-parenthesised` refusal and its formatter rewrite | — (do not exist): the formatter keeps `for`'s parentheses as written | 956 (4) | 2026-11-04, found by the record rewrite |
| `refuseUnimplementedDeclares`'s exemption for a `declare fn` whose first parameter is the declaration handle | `declare-without-implementation` for every bodyless `declare fn`; a marker is `pub fn page(syntax decl: unknown) -> void {}` | 604 | 2026-11-04, found by the record rewrite |
| `*` on a namespace import item (`collections*`) | refused `notAnExtension`; each extension activated by name (`collections: {ArraySets*}`) | 107 (5) | 2026-11-04, found by the record rewrite |
| the `import-alias-on-type` refusal | `as` binds a type leaf like any other (`import {collections.Dict as D} from "std"`) | 110 (1) | 2026-11-04, found by the record rewrite |
| `import {io} from "std"` (a folder imported as a namespace, 110 (2)) and the `comptime/std_namespace.zig` rewrite | refused, located, naming the leaf `import {io.fs} from "std"` (`folder_import_refused`), landing with B-69 | 919 (4) | 2026-11-04, found by the record rewrite |
| `module-var-holds-task` | `module-var-holds-async` | 905 | 2026-11-04, found by the record rewrite |
| a host spelling as a method of a primitive (`"abc".toUpperCase()`); the backend aliases `primNodeAliasIn`, wasm's `toUpperCase` / `toLowerCase` rows of `primCallRes` / `lowerStringMethod` | the declared method alone (`toUpper`), else `unknown-primitive-method` with a near-name hint | 136 | 2026-11-04, found by the record rewrite |
| an unmarked `fn load() -> Async<i32> { return 1 }` (the bare value returned from a `-> Async<T>` / `-> Component<R>` body) | `async fn` / `component fn`, or `return Async.resolve(1)`; refused as a type mismatch | 570 | 2026-11-04, found by the record rewrite |
| `default fn` on a behavior member without `self` | `fn` — a static of the behavior (bodied) or a required static each implementor provides (bodiless); `default-on-static` | 628 | 2026-11-04, found by the record rewrite |
| 416 (1)'s component / hook split by `R implements Renderable` | every `Component<R>` is one thing | 804 (3) | 2026-11-04, found by the record rewrite |
| 593 (2)'s lowering of the type form into `(props) => (scope) => …` (a record `Card__Self` and a `component fn Card`) | the type and its `compose` declared as such | 809 (2) | 2026-11-04, found by the record rewrite |
| `Component<Component<T>>` as a body's answer | a body answering a component resolves it before returning | 809 (4) | 2026-11-04, found by the record rewrite |
| `rewriteRecordUpdate`'s name-only source restriction | any expression as the source of `..`, evaluated once | 864 (2) | 2026-11-04, found by the record rewrite |
| `..props: R` beside a variadic; a default on a record parameter | refused `record-param-variadic`, `record-param-default` | 864 (4) | 2026-11-04, found by the record rewrite |
| a `comptime fn` form | a function whose every parameter is `comptime`, expanded at the call (139) | 788 | 2026-11-04, found by the record rewrite |
| a type parameter bound by the return type alone (`fn get<T>(self: Registry) -> ?T`) | `T` in a parameter's type or the token `comptime t: type<T>`; refused `type-parameter-unbound` | 668 | 2026-11-04, found by the record rewrite |
| a run-time write, a foreign package's write, or a host handle / `Async` in flight in a `comptime var` | refused `comptime-var-written-at-run`, `comptime-var-foreign-write`, `comptime-var-not-writable` | 807 (2), (3), (5) | 2026-11-04, found by the record rewrite |
| `x is Some(v)` (`is` carrying a pattern) | `case`, the only construct that binds; refused `is-variant-binding` | 25 | 2026-11-04, found by the record rewrite |
| one range spelling `..` in a pattern (decisions 20 and 36) | `...` inclusive in a pattern, `..` exclusive in a slice; `pattern-range-exclusive` recommends `1...9` | 53 | 2026-11-04, found by the record rewrite |
| `type-empty-field-list`; the brace-only record (`type X {}`, `type X { fn … }`, a bare `type X`, `type {}`) | `type X()` legal; the brace-only form `type-without-field-list` with fix-it `type Name()` | 138 | 2026-11-04, found by the record rewrite |
| a `fn` in an enum section body | refused `section-body-method`, naming the enum's own method list | 151 | 2026-11-04, found by the record rewrite |
| a signed numeric leaf (`.__N12`, `Rotate { 12, -12 }`, unary `-` on an enum path) | a `Neg { … }` sub-section, `.Rotate.Neg.__12` | 314 | 2026-11-04, found by the record rewrite |
| `Type()` (constructing a type with no field list) and a `self: Self` function in its body | refused: a namespace type has no value; its functions are associated | 329 | 2026-11-04, found by the record rewrite |
| 207's `inline-type-outside-parameter` on a record field | the field admitted, `Bp__<Owner>__<field>`; a return, a `val` annotation, a behavior member and a variant payload stay refused | 832 (1), (5) | 2026-11-04, found by the record rewrite |
| a `-> noreturn` body that can complete | refused at its name, `noreturn-falls-through` | 929 (2) | 2026-11-04, found by the record rewrite |
| an exhausted condition loop printing the loop's variable group (`3`, erlang), the atom `ok` (beam) or `0` (wasm) | `null` on every backend (decision 8 §10) | 52 | 2026-11-04, found by the record rewrite |
| `contextInfoFromReturn` unwrapping through `@Future<T>` to find a context owner (89); a wrapper effect activating hooks on its own (90) | no unwrap: only the `use`-granting return activates `use`; one flag `inContextFn == annotated` | 104 | 2026-11-04, found by the record rewrite |
| `@Generator`, `@ResultGenerator`, `@FutureGenerator`, `@Iterator<T, E>`; the annotations `#[@result]`, `#[@futureGenerator]` (with the four already listed) | `effect-type-removed` / `iterator-error-param-removed` / `effect-annotation-removed`, each with a fix-it; no compatibility mode | 127 | 2026-11-04, found by the record rewrite |
| the load-directory prefix on a source location's `file` (994 L3) | `file` package-relative always; the load directory in the new field `root` (`""` in the top-level package) | 1003 | 2026-11-04, found by the record rewrite |

## The `compiler` module and builtins

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `#[builtin]`, `@name` prelude names, `compiler.setBuiltin`, `builtin-twice`, `setBuiltin-outside-std` | the prelude `primitives.bp`, members of `compiler`, and two imported std functions | 606 (1) (replaces 575 (2)) | 2026-10-18 |
| `compiler` as a keyword | `compiler`, a value std declares (`import {compiler} from "std";`) | 579 | The codemod adds the import |
| `@print`, `print` from `io.bp` | `terminal.print` (`import {io.terminal} from "std";`) | 606 (2) | |
| `@panic`, `panic.bp` | `panic` from `failure.bp` | 606 (2) | |
| `@println`, `println` | `print(a, b, "\n")` | 606 (2) | |
| `@todo`, `todo` | `panic("not implemented")` | 606 (2) | |
| `@debug`, `debug` | — (removed): `print` | 606 (2) | |
| `@typeInfo` | `compiler.typeInfo(T)` (`comptime compiler.typeInfo(T)` in a run-time body) | 606 (3) | |
| `@embed`, `embed(path) -> Bytes`, `compiler.embed(…) -> Asset` | `compiler.embed(path) -> Link`, opened through `Asset(link).open()` | 607 | 2026-10-18 |
| `TypeInfo<T>`, `reflection.bp` | `compiler.Info<T>` in `compiler.bp` | 606 (3), 608, 630 | |
| `compiler.find`, `compiler.catalogue`, `@TypeInfo.all`, a catalogue filled at an entry point | the run-time registry each marker's `compiler.init` executor writes | 576 (7), 665 | 2026-10-18. The cells' refusal names (`find-imported`, …) remain where their cells do (662) |
| `Declared<T>`, `DeclaredMeta`, `DeclaredTypedMeta` | the registry (665) and `compiler.*` reads on a handle | 576 (7) | |
| A `comptime` default that queries the catalogue (`boot(modules = …catalogue…)`) | a plain `boot` over the registry, `registry.modules()` | 551, 664 | 551 is `Replaced by 581 (1)` |
| `compiler.compile(syntax executor)` | `compiler.init(syntax executor: fn())` | 615 | 2026-10-18 |
| `Compiler.name -> string` | `compiler.name(e) -> ?string` | 612, 643 | 2026-10-18; 612 `Reversed by 643` |
| `compiler.wrapWith` | a proxy type the decorator builds, or a function written around the call (`retry(policy, { -> issue() })`) | 714 | 2026-10-18 |
| `Compiler.implement(source)` | `compiler.external(comptime ..sources: Implementation[])` | 606 (3) | |
| `compiler.record(fields)` | `compiler.buildType(name, fields, implements)` / `compiler.buildTypeInline(fields, implements)` | 578 (3), 625, 629 | |
| `compiler.failAt` | `compiler.fail(message, at:, span:)` | 576 (2) | |
| The `Decorator` type, `behavior Decorator`, `Decorator.same`, `==` on handles | `compiler.same(a, b)` | 666 | 2026-10-18. 268, 371 and 591 overtaken |
| `Annotation`; a type or enum used as an annotation key (`type Mark(…) implement Annotation`) | a decorator function recording a meta record with `compiler.setMeta` | 663 | 2026-10-18 |
| `#[Stage.Any]`, `#[@Stage.Any]` | `#[stage(.Any)]`; `Build` / `Run` are never written | 663, 681 | |
| `#[BeamMemory.…]`, `#[@BeamMemory(…)]` | `#[beamMemory(.Ets)]`, `#[beamMemory(.PersistentTerm)]` | 663, 547 | |
| `keyed: true` and the per-process placement of a module `var` | — (removed): one value for the whole program; `Dict.bump` is a plain `Dict` method | 547 | |
| `Decl`, `Decl<T>`, `@Decl`, std's `Expr<E>` behavior | an opaque declaration handle (`syntax decl: unknown`) read through `compiler.*` | 576 (1), (3) | |
| `d.hooks`, `d.fields`, `d.methods`, `d.params`, `d.returnType`, `d.owner`, `d.annotations`, `d.variants` | `compiler.hooks(d)`, `compiler.fields(d)`, … | 576 (8) | |
| `decl.loc` | `compiler.src()` inside the decorator body | 718 | |
| `decl.setMeta`, `decl.addMember`, … (216's four places) | `compiler.setMeta`, `compiler.addMeta`, `compiler.addMember`, `compiler.addType` | 575 (3), 576 (9) | 216 replaced by 575 (3) |
| The string meta: `setMeta(key, value)`, `.meta.<decorator>.<key>` | typed meta: `compiler.setMeta(M(…))`, read `compiler.meta(d, M)` / `compiler.metaAll(d, M)` (`compiler.meta<M>(d)` is retired too) | 576 (11), 840 | |
| The string `addMember(name, source)` | the typed `compiler.addMember<F>(name, syntax member: F)` | 575 (3), 576 (14) | |
| The string `addType(name, source)` | `compiler.addType(name, compiler.buildType(…))` or a template text answering a type | 640 (2), 605 (2) | |
| `#[@Host]`; delegate forms | `#[compiler.external(…)]` | 575 (6) | |
| `#[stage(…)]`, `#[beamMemory(…)]` written bare | `#[compiler.stage(…)]`, `#[compiler.beamMemory(…)]` — members of `compiler`, as `external` | 774, 606 (4), 663 | 2026-10-19 |
| `-> anyvalue` / `anytype` only for a `syntax` fn | any written `T` | 841 | 2026-10-21 |
| `compiler.load -> Diagnostic[]` / `Result<void, Diagnostic[]>`; checked for the build's `--target` | `Result<Module, Refused>`; every manifest target | 786, 833 | 2026-10-21 |
| `Module.target` | `Module(name, path)` | 805 (4) | 2026-10-21 |
| `run() -> Result<void, Failure>` | `Result<void, RunFailure>` | 806 | 2026-10-21 |
| `bp_load__<path>`; the 3,000,000 synthetic line range | a marked lowering call; `__bp_` names refused `reserved-name` | 830 | 2026-10-21 |
| `BpInline__<…>` (207) | `Bp__<fn>__<param>` / `Bp__<Owner>__<field>` | 832 | 2026-10-21 |
| `<f>__type`, `__<Enum>__<Section>`, `__embed_<p>` | `__bp_<f>__type`, `Bp__<Enum>__<Section>`, `__bp_embed_<p>` | 836 | 2026-10-21 |
| `<dir>/<pkg>.runtime.bp` (798 (2)) | a `.bpr` per package and per std module; one `.bp` per module for `--emit-resolved` | 805, 834, 837 | 2026-10-21 |
| `.JavaScript("std:…")` host code | refused on every variant | 847 | 2026-10-21 |
| `std-decorator-leaf-import` | a leaf import annotates by name | 881 | 2026-10-21 |
| `compiler.init` of an expanded function as a program-start init, anywhere (788 (2)) | only in a top-level block | 808 | 2026-10-21 |
| `compiler.variants` as 576 (3) wrote it | `compiler.Variant[]` | 848 | 2026-10-21 |
| 833 (3)'s refusal at `emit` of a loaded package refused or excluded on a target | the loaded `run()`'s own answer: `RunFailureKind.Refused` (the refusal's text) or `.Excluded` (the case's manifest leaves the target out); a build refusing `load-excluded-target-compiles` otherwise | 989 (3), 1000 | 2026-10-26 |
| `@embedFile(comptime path: @Expr<string>) -> string`, `@embedBytes(comptime path: @Expr<string>) -> Bytes` (346) | `compiler.embed(comptime path: string) -> Link`, opened through `Asset(link).open()` | 342, 607 | 2026-11-04, found by the record rewrite |
| `@embedFile` / `@embedBytes` (342, 346) | `compiler.embed(comptime path: string) -> Link` (519's `@embed(…) -> Asset`, respelt by 607) | 519, 607 | 2026-11-04, found by the record rewrite |
| `parser/expr_params.zig`, `comptime/expr_param.zig` | `syntax_params.zig` / `syntax_param.zig` | 616 | 2026-11-04, found by the record rewrite |
| the cells `compile_executor_*`, `compile_init_order_modules`, `compile_output_outside_decorator` | `init_executor_*`, `init_order_modules`, `init_output_outside_decorator` | 615 | 2026-11-04, found by the record rewrite |
| `Type.Field<T>` / `Type.Info<T>` | `compiler.Field<T>` / `compiler.Info<T>` (`import {compiler.Field} from "std";`) | 630 | 2026-11-04, found by the record rewrite |
| `import {compiler.Type} from "std"` (624's placement of `Type` inside `compiler.bp`) | `import {types.Type} from "std"`, `Type` in `types.bp` | 624, 630 | 2026-11-04, found by the record rewrite |
| the `decorator-wrap-*` refusals; the `decorator_wrap*` / `*_wrap_with` cells | nothing — removed with `compiler.wrapWith` | 714 | 2026-11-04, found by the record rewrite |
| `decorator_type_names_decorators`, `decorator_same_identity`, `decorator_same_member`, the `decorator_argument_decorator_*` cells; `compiler.Decorator` imported by cells | rewritten over `compiler.same` or removed | 666 | 2026-11-04, found by the record rewrite |
| the `typeinfo_all_*` / `*_catalogue*` cells (87) | registry cells, or removed | 665 | 2026-11-04, found by the record rewrite |
| `typeinfo-meta-expr-elsewhere` | a meta field's names resolve where the annotation wrote them | 385 | 2026-11-04, found by the record rewrite |
| `hasDefault: bool` | `f.defaultValue != null` | 598 | 2026-11-04, found by the record rewrite |
| `@module()`, `@trap()`, `@field`, `@TypeOf`, `@makeRecord` with `RecordField`, `@RecordKeys`, `@comptimeError`, `@compilerError` | — (removed, no use anywhere); `compiler.fail` for the two error builtins | 575 (8) | 2026-11-04, found by the record rewrite |
| the backends' inline lowering of `Result`'s methods (`inferResultOptionMethod`, `comptime/builtins.zig`'s `methods` rows) | std's `case` bodies in `primitives.bp` | 609 | 2026-11-04, found by the record rewrite |
| `compiler.initAsync`, a valued executor | `compiler.init({ async -> … })`; `compiler.init` answers `void` (`init-executor-value`) | 998 (1), (3) | 2026-11-04, found by the record rewrite |
| `calledFrom` (the `Diagnostic` frames field) | `` `from` `` — `` pub type Diagnostic(…, `from`: string[]) ``, read `` d.`from` `` | 991 | 2026-11-04, found by the record rewrite |
| `BOTOPINK_COMPTIME_UNITS` | the `.comptime` stage always runs; refusals recorded in `out/wasm-comptime/refused.txt` until C4 | 1058 (3) | 2026-11-04, found by the record rewrite |
| `persistent_wat.interrupt()` | `runner.interrupt()`, `running()` asking the runner | 1059 (6) | 2026-11-04, found by the record rewrite |
| `FieldEntry`; `pub type Field = __Decl__Field`; `printedSoFar` | the public `compiler.Field`, `Method`, `Variant`, `Param`, `DeclAnnotation`, `DeclKind`; `__cap_end()` | 1071 (1), (2) | 2026-11-04, found by the record rewrite |
| `meta` on `Method`; compiler.bp's private `Stage` copy | a method's meta kept by the codec inside `Decl`; the prelude's `pub type Stage { Build, Run, Any }` | 1075 (1), (2) | 2026-11-04, found by the record rewrite |
| the `Compiler` doc's sentence "the body goes on" after `compiler.fail` | `compiler.fail` aborts the body; cell `compiler_fail_aborts_body` | 1094 | 2026-11-04, found by the record rewrite |

## `syntax`, `comptime`, templates and code

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `@Expr<T>` (a parameter of type expression) | `syntax x: T` | 575 (4), 576 (1) | |
| The `expr` parameter modifier | `syntax` | 616 | |
| `.value` on a captured argument; `x.fail(…)` | the `comptime` value itself; `compiler.fail(…, at: x)` | 575 (4) | 411's `expr-value-of-function` went with `.value` (735) |
| `comptime x: @Expr<T>` | `comptime x: T` | 575 (4) | |
| A meta record's field written `@Expr<T>` | `T`, holding a tree when filled from a `syntax` | 576 (12) | |
| `-> @Expr<T>`, `-> @ExprCustom<T>`, `-> syntax T`, `-> expr` | `-> T`, `-> anyvalue` or `-> anytype`; a custom tree through `compiler.custom(ast)` | 576 (4), 578 (1), (2), 577 (6) | |
| `@expr(v)` | `v` | 605 (5), 578 | |
| `type T` (a type parameter's spelling) | `type<T>` (`comptime t: type<T>`) | 575 (5) | |
| A bare type-position `type` | `anytype` | 578 (2), 577 (6) | |
| `@emit` | a registration in a `compiler.init` executor; a generated type through `compiler.addType`; a member through typed `compiler.addMember` | 605 | 2026-10-17 |
| `@code` | the typed AST (`compiler.ast`, `code`) | 605, 625 | |
| `compiler.build(text)` and every code-from-text form | `compiler.ast(node)` over the `Node` records, `` code @`…` `` (`code.bp`), `compiler.buildType` / `buildTypeInline` | 625, 637, 629 | 2026-10-18 |
| A `Hole(index)` node | `compiler.lookup(e, name) -> ?Node`; the template parses its own text | 625 (4), 637, 802 | |
| `compiler.holes(t)` (the caller's `${…}` as `syntax` values) | the template parses its text and resolves each name with `compiler.lookup(e, name) -> ?Node` | 802 (reverses 637's caller-hole half), 577 (5) | 2026-10-20 |
| The `Syntax(e)` node; `compiler.isSyntax(v)` | `compiler.lookup` answering the code a `syntax` value holds, spliced as written; `syntax` a modifier, never a type | 802 (reverses 638) | 2026-10-20 |
| `compiler.parts`, `Part` | `compiler.text(q)` (raw); the sub-language parses its own holes | 577 (5), 578 (5) | |
| `Renderable` / `Renderable<T>` (std's marker; 791's node parameter) | nothing — `Component<R>` alone; what a tree holds is the render library's types (rakun-bpp's `NodeChild`) | 804 (2), (3) | 2026-10-20 |
| A type component's `fn render(self: Self) -> Component<R>` | `fn compose(self: Self) -> Component<R>` | 804 (1) | 2026-10-20 |
| rakun-bpp's compiler-known `Children` and its coercions | `NodeChildren = NodeChild[]`, `NodeChild = Component<Element>` | 804 (4), 809 (7) | 2026-10-20 |
| `NodeChild = Element \| Component<Element>` (a union the renderer narrows) | `NodeChild = Component<Element>`, the builders `component fn`s, every child resolved | 809 (7) | 2026-10-20 |
| `Component<R>` as a type of its own; `type X implement Component<R> { fn compose(self: Self) -> Component<R> }` | `Component<T> = Composition<T> \| Composable<T>`; `type X implement Composable<R> { component fn compose(self: Self) -> Composition<R> }` | 809 (1), (2) | 2026-10-20 |
| 811 (2)'s `pub opaque type Composition<T>(source: …)`, `Composition.of`, `Composition.resolve` | `pub type Composition<T> = fn(scope: Scope) -> T \| Async<T>` again, std's `resolve` a function, `is fn(Scope) -> …` | 815 (reverses 811 (2)) | 2026-10-20 |
| A public `scope.child()` made by the renderer before each child | `scope.childAt(place, c)`, std keeping the tree of cells by place and identity | 817 (1) | 2026-10-20 |
| `{ component -> v }` written as a child (813 (1)); a render library's `key` prop (816 (5)) | `{ _ -> v }` for a ready value, a named `component fn` or the factory's call for one with hooks; one `#[key]` parameter or field | 817 (3), (4) | 2026-10-20 |
| A component's identity by its declaration with its type arguments (817 (2)); `#[key]` on a parameter or a field, `key-twice` (817 (4)); hooks' slots in the node's own cell (816 (1)) | the call that made it, numbered within its declaration; `#[key(expr)]` at the call; a child cell per `use` that answers a value | 818 | 2026-10-21 |
| `Composition<T> = fn(scope: Scope) -> T \| Async<T>`; 817's places `Use(n)` / `Tail` / `Index(i)` / `Key(k)` and the identity apart from the place | `fn(scope: Scope, key: Place) -> T \| Async<T>`; a `Place` of the call's number and the item's number or key | 819 | 2026-10-21 |
| `context-provide-after-render` (the first component `use` read as the body's render) | a `use provide` counting in the order written; `use c` with a child cell | 812 | 2026-10-20 |
| `render-scope-construction`; `Module`'s readable fields `mod.name`, `mod.path` | `opaque-construction` / `opaque-field`; `mod.name()`, `mod.path()` | 811 (3), (4) | 2026-10-20 |
| `RenderScope`, `RenderScope.root()`, `c.run(scope)`, `Rendered<R>`, string-keyed frames (`push` / `find`) | `Scope` (`scope.childAt(key)`, 817, 819), `resolve(c, scope, key)`, `run(c)` (819, 825), a persistent map keyed by the context's type | 809 (6), (8), 817, 819, 825 | 2026-10-20 |
| Template calls `name "…"`, `name """…"""`, `name("lit")`, `#[name("lit")]` | `` name @`…` ``, `` #[name @`…`] `` | 577 (1), (3), (6) | The codemod resolves the escapes to raw bytes |
| `syntax-captures-build` | a `compiler.*` call inside a tree is evaluated at build and spliced | 575 (4), 614, 642 | |
| `decorator-member-captures` | the same splice rule inside a member | 642 (replaces 413) | |
| `decorator-member-fn-imported-name` | a member's names resolve where they were written | 384, 669 | |
| `#[mockable]`, the associated `Mock` type, the `mock()` member, std's `#[mock]` writing `T.Mock(…)` | `mock(T)` from `testing/mocks.bp` | 644 | 2026-10-18 |
| validation's `#[pick]`, `#[omit]`, `#[partial]`, `#[required]`, `#[extending]` | `Type.pick`, `Type.omit`, `Type.partial`, `Type.required`, `Type.merge` (`types.bp`) | 307 | |
| `Type.keys`, `Field.of`, `Field.all`; a field key matched by `case` | `compiler.Field<T>`, `.field` written where one is expected | 599 (1), (2) | |
| An expanded `boot`; `d.value` | a plain function over the registry | 581 | 562's example withdrawn |
| `Component` in `context.bp` (809 (1)) | `primitives.bp`'s compiler section | 826 | 2026-10-21 |
| `return c` with the body's own cell (812 (2)) | a child cell | 816 (6) | 2026-10-21 |
| `run(c, Scope.root())`, `c.run(RenderScope.root())`; `close` a no-op off the BEAM | `await run(c)`, `scope: ?Scope = null`; `close` marks closed on every target | 822, 825 | 2026-10-21 |
| `Place.none()` under `use all` and for the renderer's child list | `Place.index(i)` | 884, 891 | 2026-10-21 |
| `component-compose-missing`, `component-use-outside-compose` | the general refusals (58 / 800, `use-without-component`) | 828 | 2026-10-21 |
| `implement Component<R>` | refused `implement-component-not-composable` | 828 (1) | 2026-10-21 |
| The `Children` cell `modules/children/` | `children_array_walk` under 804's module | 857 | 2026-10-21 |
| a method on a type-parameter `decl` in a decorator tree (`<T>(syntax decl: T)` + `decl.make()`), left unchecked | the checker's refusal, located at the call; a member read only through a declared type the tree is checked against (716 (2)) or from the value the decorator built (842 (1)) | 1106 | 2026-11-04 |
| `derived_types.zig`'s `derivedFrom` / `derivedPartial`; a derived type as a nominal type with a lineage (600) | an inline type named by its `val`, `compiler.buildTypeInline(fields)`; a spread typed by structure | 629 | 2026-11-04, found by the record rewrite |
| `rule.text()` (an argument's source text spliced into a string output) | typed meta or a typed member; `expr-param-method` | 370 (3) | 2026-11-04, found by the record rewrite |
| 375 (1)'s "what the checker cannot follow" clause; the answer's `subtreeAsync` | a call through a function value or a method marks nothing; no build-time subtree mark | 725 | 2026-11-04, found by the record rewrite |
| the compiler-side bodies of `Type.*` (keyed on the std declaration) | bodies written in botopink over `compiler.fields` / `compiler.buildTypeInline` | 307, 599 (3) | 2026-11-04, found by the record rewrite |
| the cells `field_key_runtime`, `field_key_case_missing`, `field_key_unknown_field`, `type_keys_outside_val`, `field_key_under_annotation`; `recipe.get(key)` | the build-time key `.field` in a decorator's argument | 599 (1), 308 | 2026-11-04, found by the record rewrite |
| `isClosedDefault`, the derived-type refusal of a non-closed default, `imported_field_default_not_derived` | a default travels with the field and resolves where it was written; `derived_type_default_travels` | 671 | 2026-11-04, found by the record rewrite |
| a `-> anytype` call anywhere but a module-level `val`'s initializer | refused `anytype-outside-type-val` | 670 | 2026-11-04, found by the record rewrite |
| a code-returning body applied as an annotation `#[f]` (its `return` stripped) | refused `syntax-fn-code-at-annotation`, naming `f(e)` | 962, 976 (2), 986 (3) | 2026-11-04, found by the record rewrite |
| a template reading the expected type (`q.expected()`) | `compiler.note(message)`; what a template builds is decided by its text | 426 (4) | 2026-11-04, found by the record rewrite |
| the padded expansion (`q.build(pad + code)` in `query.bp` / `html.bp`) and its `// LANGUAGE GAP` markers | locations keyed by (expansion id, offset) | 429 | 2026-11-04, found by the record rewrite |
| `Call(fn: …)` (625 (2)'s sample) | `Call(callee: …, args: …)` — `fn` is reserved and a field needs an identifier | 751 | 2026-11-04, found by the record rewrite |
| a cell's outside renderer helper `render(c, scope)` (388, 574, 584, 791's seven cells) | children resolved inside the providing body: `use c`, or `c(scope, Place.none())` / `resolve(c, scope, key)` in a `{ scope -> … }` lambda | 908 | 2026-11-04, found by the record rewrite |

## Host functions and targets

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `#[@External.<Target>(…)]`, `#[@external(.X(…))]`, `#[external(…)]` | `#[compiler.external(.Erlang(…), .JavaScript(…), .Wasm(…))]` with `import {compiler} from "std";` | 575 (6), 606 (4) | |
| `@External.Beam`, `.Beam(…)` | `.Erlang(…)`, which binds erlang and beam; `inline: true` declared by it alone | 437 | Writing `@External.Beam` is a located error |
| `Implementation.Node`, `.Node(…)` | `Implementation.JavaScript`, `.JavaScript(…)` | 618 | 2026-10-18 |
| The `Typescript` implementation; `JavaScript`'s `types:` field | `"typings": true` in `botopink.json`, or `botopink build --typescript` | 619, 620 | 2026-10-18 |
| `fn:` (the botopink-body label) | `body:` | 610 | 2026-10-18 |
| The prefixed strings `"fn:x"`, `"std:x"` | the labelled fields `body: x`, `std: "x"` | 481 | |
| `label = value` in the compiler's annotations | `label: value` | 305 | |
| `throws: true` | `result: true`, answering `Result<…, HostError>` | 490 | |
| `declare` inside a `behavior` | host code on the type; a behavior holds signatures and `default fn` bodies | 575 (6), 617 (2)–(4) | Refused, `declare-in-behavior` |
| `comptime-host-cell-unavailable` | a host function with a wasm form runs at build; one without is refused there, located | 633, 594 | |
| beam-to-wasm as a fallback at build; `modules/beam-to-wasm/` | a `std:` cell or a `.Wasm(body: f)`; the directory deleted with 164's B-84 | 452, 594, 544 | |
| The prebuilt `.wasm` library form (333 (B)) | — (removed): `Implementation.Wasm` is the enum's variant and nothing else | 333 (B), 731 (4) | |
| The BEAM comptime runtime (`persistent_beam.zig`, `runtime/beam/**`, the persistent `erl` spawn, `render_resident`'s erl step) | comptime on the wasm runtime only | 434 (1) | 2026-10-10. `persistent_erlang.zig` is never built |
| wasm3, `modules/wasm3/` | wasmtime (native), the page's `WebAssembly` (web) | 543 | 2026-10-14 |
| The linear-memory model of a wasm program; `std_wasm.wasm`, `heap.zig`, the Erlang term library | WasmGC values (`needs: [.Gc]`); std-wasm's logic in botopink, its leaves in hand-written `.wat` | 544, 550, 560 | 2026-10-14. The bump heap stands until B-83 lands; B-30 closed as superseded |
| The Zig-built wasm runtime (440, 442's split, `$__std_sp` 447, the heap per task 448/449/522/542, two tables 454) | hand-written `.wat` leaves read by the compiler's `.wat` reader | 544, 550, 560 | What survives is 442 (3)'s rule |
| `snapshots/codegen/{beam,wat}/<target>/` | `snapshots/codegen/<target>/` | 434 (1) | |
| The runner's `--import` abort guard on commonJS | the entry's own handler | 870 | 2026-10-21 |
| No `"targets"` meaning all four (676 as built) | the dependencies' intersection | 770 | 2026-10-21 |
| wasm's `.linear` lowering and its module-wide `.gc` → `.linear` fallback; the build note `wasm: <module> lowered .linear: <feature>` | one lowering, GC; what it cannot lower is a located refusal `the wasm backend has no GC lowering for <what>` at the construct; an unreached gap is an `unreachable` stub carrying the located text | 1105 (1)–(3), 1097, 1056 (3) | 2026-11-03 (built by front 170 s7 P5) |
| comptime's own refusal text "comptime has no linear memory" | the same located refusal the build answers; comptime's `errors/` snapshots re-recorded | 1105 (4), 1033 | 2026-11-03 |
| a Task's or a generator's printed text: wasm's raw value through `.linear`, each other target's native inspect | `print` of a static `Async<T>` / `Iter<T>` / `AsyncIter<T>` refused at build on four targets (`print-task` / `print-generator`); through `unknown`, the named panic `panic: wasm cannot print a … value`, one text on four targets | 1104 | 2026-11-03 |
| a whole-module fallback when one declared type has no GC printer; the interim build refusal of a `T` holding a record or an array (`template_traps` on `shown<T>`) | `gcTaggedPrinter` degrades per declared type, that type's arm alone a located refusal; `gcUnkScalarPrint` falls through to `__print_tagged_raw`; the `gcDeclPrinter` guard comes out | 1101 (overtakes 1099, 1100) | 2026-11-02 |
| `Component<T>` as an eager `T` on wasm, with `resolve` / `allIn` / `run` special-cased | a closure `fn(scope, key) -> T`, one representation `gcReprOfType`, `eagerTypeRef` and `reprOf` agree on, as on every other target | 1102 | 2026-11-02 |
| `'__bp_erl_eval'/2` (a template evaluated from Erlang source at run time) | every template lowered by `comptime/runtime/beam/lower.zig`; a refused template a build error at its call site | 141 | 2026-11-04, found by the record rewrite |
| A2's declaration qualifier `<module>__t__<decl>` (lowercased) and option A's `RESERVED` list with its `bp@` prefix (`bp@math`, `bp@dict`, `bp@queue`) | `<package>@<path>@@<Decl>`, the declaration's case kept; the package name as it is | 109 (1)–(3) | 2026-11-04, found by the record rewrite |
| `bp_std@math@@PI` (a `bp_` prefix on the package) | `std@math@@PI` — the `botopink.json` `name` unprefixed | 109 | 2026-11-04, found by the record rewrite |
| the commonJS departures `string_trim_keeps_nbsp`, `string_lower_final_sigma` | the cells answering std-wasm's text on every target | 521 | 2026-11-04, found by the record rewrite |
| `external-body-not-a-fn`, `external-source-empty`, `external-all-bodies` — `body:` not a private bodied fn of the module; a source with neither `template` nor a cell; an annotation whose every source is a `body:` | a bodied `fn` (every target the botopink body), or the per-target split | 610 | 2026-11-04, found by the record rewrite |
| a second unlabelled argument in an `Implementation` cell (`.Erlang("…", reverseBody)`, `.Erlang("…", true)`) | `body: …`, `inline: …`, `result: …` by label; `external-field-unlabelled` | 621 | 2026-11-04, found by the record rewrite |
| `$self` (a host template marker) | `$0` on a method; refused `template-self-marker` | 795 | 2026-11-04, found by the record rewrite |
| `inline: true` on a type method's `.Erlang(…)` cell (lem-b as built); cell `external_method_local` | refused at the annotation, located; cell `external_method_inline_refused` | 918 (3) | 2026-11-04, found by the record rewrite |
| a `wasi:`/`op:`/`std:` cell naming nothing refused on `--target wasm` only | refused at the annotation on every target | 516 | 2026-11-04, found by the record rewrite |
| the erlang emitter's comment path (`%% field assignment is not directly supported in Erlang.`) | dead code — the checker refuses the assignment | 37 (2) | 2026-11-04, found by the record rewrite |
| `Object.freeze` as the immutability mechanism | the checker's refusal; freeze an opt-in guard at the interop boundary only | 37 | 2026-11-04, found by the record rewrite |
| a raw `crash: badarith` for a float division by zero on erlang and beam | `panic: division by zero: / on f64 at <file>:<line>:<col>` | 675 | 2026-11-04, found by the record rewrite |
| `str_slice`, `mem_eq` in `wat_prelude` | std-wasm's `text.slice` and its search helpers | 455 | 2026-11-04, found by the record rewrite |
| a generated `.wat` leaf | `gen-unicode` writes data and `.bp` only; every `.wat` leaf is hand-written | 559 | 2026-11-04, found by the record rewrite |
| the `--typescript` flag and the manifest's `typings` field | a `.d.ts` always emitted beside each commonJS `.js` | 1013 (1) | 2026-11-04, found by the record rewrite |
| beam-to-wasm, `comptime/runtime/wat/**`, the comptime prelude, `etf.zig`, the term library, `std@__heap`; `erl_parse.zig` / `etf.zig` / `term.zig` under `comptime/runtime/` | deleted at C4 (the evaluators' switch); the three BEAM-target readers moved to `codegen/beam/` | 1035 (6), 1038 (1) | 2026-11-04, found by the record rewrite |
| `run_module` (the page's single-module linking) | `run_units` with one unit | 1069 (4) | 2026-11-04, found by the record rewrite |
| `get_<x>` / `set_<x>` (a val's wasm accessors) | `val:<x>` / `set:<x>` under the `<class>:<name>` convention | 1080 | 2026-11-04, found by the record rewrite |
| `stdWasmSymbol`'s implicit match-by-name table; the `body:` a `std:` cell replaces (`contentHashBody`) | an explicit `std:` cell per std declaration | 440 (3) | 2026-11-04, found by the record rewrite |
| `bp_wat_rt.wasm` and its build step | one wasm runtime (434) | 450 (3) | 2026-11-04, found by the record rewrite |

## std

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `base64` (module) | `encoding` | 106 | Merged; the new name wins |
| `dict`, `sets`, `queue`, `order` | `collections.bp` (`Dict.empty()`, `Set.fromList(xs)`, …) | 106, 111 | |
| `crypto`, `hmac`, `content_hash` | `hash` | 106 | |
| std's `json.bp`; `pub mod json;` in `root.bp` | the `json` repository (`from "json"`) | 396 (1) | std knows nothing of JSON |
| `json.parse`, `json.stringify` | `decode`, `encode` | 336 | |
| `Json.Num(value: f64)` | `Int(value: i64)`, `BigInt(value: bigint)`, `Dec(value: Decimal)` | 332 (4) | |
| `testing/snapshots.bp` (`import {testing.snapshots} from "std"`) | `snap` (`import {assertAs} from "snap";`) | 391, 407 | The old import answers the plain unknown-module error |
| `Pair.of`, `first`, `second`, `swap`, `mapFirst`, `mapSecond`; `Function.*` statics | tuples (`p._0`, `val #(a, _) = p`); std's `functions.bp` | 738 | |
| `fetch(url)` and its `string` error | `fetch(Request(method: .Get, url: u))` answering `Async<Result<Response, HttpError>>` | 623 | |
| `io.random.bool()` | `coin()` | 250 | |
| `fs.openAsset`; `Asset.path`, `.bytes`, `.size`, `.hash`, `.text()`; `File.ofBytes`; `embed-text-not-utf8`, `embed-text-not-at-build`, `embed-open-needs-fs` | `Asset(link).open()` and `File`'s reads, each a `Result<…, FsError>` | 607 (2) | |
| A `string` error from `io.fs` | `FsError`, with `e.message()` | 540 (1), 563 | |
| A library's own copy of a std function (`clock.parseDuration`, `async.RetryPolicy`, `async.nextDelay`) | std's | 170 | |
| `$stringify` (a template marker) | `$N`, `$args` (on a method `$0` is `self`) | 164, 239, 795 | Refused in every template; `$self` too (`template-self-marker`) |
| `clock.formatIso8601` without milliseconds | `.sssZ` always | 849 | 2026-10-21 |
| `json.array(items)` | `json.arrayOf(items)` | 873 | 2026-10-21 |
| `Bytes.toUtf8`'s error text | `bytes.toUtf8: not valid UTF-8` | 873 | 2026-10-21 |
| `log`'s leaf form `import {errorDigest, Logger} from "log"` | per declaring module | 763 | 2026-10-21 |
| 721's "index out of bounds" raise | none: the read answers `null` | 777 | 2026-10-21 |
| `pub fn open(self: Asset) -> File` (no `Result`, the build having proved the file exists) | `open(self: Self) -> Result<File, FsError>` | 538, 607 (2) | 2026-11-04, found by the record rewrite |
| `close()` on a `Scope` that is no root | fails `scope-not-root` at run time; only `Scope.root()`'s and `scope.detach()`'s answer close | 896 | 2026-11-04, found by the record rewrite |
| one place met twice in one render of one parent (`div([h, h])`, a doubled `use h`) | fails `place-duplicate` at run time; write the call twice or key them | 958, 966 (6) | 2026-11-04, found by the record rewrite |
| `rakun-ssr/src/config.bp`'s own `isString(v: Json)` and `types.bp`'s import of it | `Json.isString(self: Self) -> bool` (`v.isString()`) | 941 | 2026-11-04, found by the record rewrite |
| the free `regex.matches(pattern, input)` | `Regex.compile(pattern)` answering `Result`, then `r.matches(input)` | 918 (4) | 2026-11-04, found by the record rewrite |
| `assertAlias` (rakun-ssr's helper) | — (goes with 218) | 390 (4) | 2026-11-04, found by the record rewrite |
| `libs/std/src/unicode_tables.bp` (the flat private sibling) and a consumer's `import {unicode_tables} from "std"` | `libs/std/src/internal/unicode_tables.bp` after 144 B-75; any import of std's `internal/` refused (`std_internal_import_refused`) | 913 | 2026-11-04, found by the record rewrite |
| jhonstart's `__jhTryValue` / `__jhTryTask` (414's renderer); `testing.asserts`' `tryCatch` | `attempt` from `failure.bp` | 431 (3) | 2026-11-04, found by the record rewrite |
| `time`, `clock` (root modules) | `io/clock.bp` | 106 | 2026-11-04, found by the record rewrite |
| `random`, `crypto.randomBytes` at the root | `io/random.bp` | 106 | 2026-11-04, found by the record rewrite |
| `path.absolutePath` | `io/fs.bp`'s `absolutePath` | 106 | 2026-11-04, found by the record rewrite |
| `io.process.start` answering `Error(Unsupported)` at run time off commonJS (B-161 as built) | a located `std-unsupported-on-target` refusal at the call on erlang, beam and wasm | 906 | 2026-11-04, found by the record rewrite |
| erlang's `string:length/1` / `string:slice/3` (grapheme clusters) in std's templates | codepoint counting on every target | 320, 169, 240 | 2026-11-04, found by the record rewrite |
| a host cell for `json.decode`'s numeral conversion | `numeralValue` in botopink, correctly rounded | 142 | 2026-11-04, found by the record rewrite |
| `codePointsOf`, `textsOf`, `codepointText` in compiler.bp; 1038 (3)'s comptime "index out of range" | `chars()`, `charCodeAt`, `string.fromCodepoint`; `xs[i]` out of range answers null in comptime as in a program | 1060 (1), (3) | 2026-11-04, found by the record rewrite |
| rakun's JSON writers `jsonString` / `jsonStrings` / `jsonPairs` / `jsonTriples`, the two `jsonEscape`s, `config.bp`'s hand scanner | std's `json.quote`, `json.unquote`, `json.arrayOf`, `json.object`, `json.decode` | 116 (1) | 2026-11-04, found by the record rewrite |
| rakun's `request_context` codec; jhonstart's `decodePairs` / `encodePairs` | std `encoding` (`percentEncode`, `percentDecode`, `formParse`, `formStringify`) | 116 (2) | 2026-11-04, found by the record rewrite |
| emilia's `hashHex` | std's `hash.contentHash` | 116 (5) | 2026-11-04, found by the record rewrite |
| jhonstart's private `payloadEscape` | std `escape.scriptJson` | 116 (6) | 2026-11-04, found by the record rewrite |

## Libraries and repositories

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| jhonstart, jhonstart-html, -link, -forms, -test | `rakun-bpp` | 724 | Repositories archived, history kept by `git subtree add` |
| `jhonstart-styled` | merged into `rakun-bpp` (jhonstart's core) | 361 (3) | |
| styled | `rakun-style` | 724 | |
| emilia, jhonstart-emilia | `rakun-stylesheet` | 724 | |
| onze and its eight members; the `onze` CLI (`onze create-key`); `onze.json` | `rakun-ssr`; `rakun-ssr build`, `rakun-ssr create-key`; `rakun-ssr.json` | 724, 271, 224 | The mocking library lives as the archived repository's tag `mocking-lib-final` (507). `ONZE_KEY` is `RAKUN_SSR_KEY` (862, 883 (6)) |
| dbcontext (a repository) | `rakun-data` (dbcontext + rakun-data) | 724, 398 | |
| erika; `erika "…"` | `query` (`botopink/query`); `` query @`…` `` | 724, 312, 577 (6) | |
| rakun-web, rakun-actuator | `rakun-service` | 724 | |
| `rakun-actuator-api`, `rakun-logging` | absorbed by the `rakun` core | 187 | |
| `rakun-starter-*` | — (removed): a program declares the packages it uses | 724 | |
| Each `*-test` package (`query-test` included) | its package's `testing/` module (`modules/query/src/testing/`) | 724, 882 | |
| The `botopink/conformance` repository | `repository/botopink-lang/conformance/` | 467 | |
| `actions`, `http`, `log`, `routing`, `validation` inside the compiler | repositories of their own, ordinary dependencies | 326 | |
| onze's `@/` alias (`from "@/…"`) | `import {lib.db.findPost};` | 218 | |
| A library's `"entry"` | — (removed): a library has no entry | 733 | 2026-10-18. Refused, `manifest-entry-in-library` |
| `botopink.json`'s `files` | the tree; `src/internal/` is private | 703 | 2026-10-18. Refused once B-69 / B-75 land |
| A `dependencies` string array | the object form | 76 | |
| `"bppKinds"`; a decorator applied by file name | the decorator written in the header; the route table rakun-app generates | 285 | |
| A `.bpp` header opened by a first-line `---` | the header starts on the first line | 212 | |
| `JhonstartNode`, `Children` | `Node` (`import {Node} from "rakun-bpp";`) | 191, 223 | |
| A `children` field | the default slot, `<Slot />` | 193, 360 | |
| Astro's `prefix:name` directives (`client:load`, …) | annotations inside the tag (`#[clientLoad]`, …); `set:html={s}` → `{raw(s)}`, `set:text={s}` → `{s}`, `class:list={[…]}` → `class={classList([…])}` | 278 | |
| `markDynamic`, `rakun_ssr.erl`'s implicit mark | the hooks list read by `#[page]` | 186, 277 | |
| `pub val prerender`, the `output` key; Next's `dynamic`, `fetchCache` | `#[page]` reads the stage from the hooks list; `revalidate:`, `dynamicParams:`, `headers:` | 202, 290, 291 | |
| A `pages/` tree | `app/…/page.bp` or `page.bpp` | 203 | |
| `route: PageContext`, `paramsOf`, `StaticPath.data: Json`, `isPrerendered()` | `use params<P>()`, `use pageData<T>()`, `use request()`, `use response()` | 293, 291 | |
| A route handler exported by the build (`<outDir>/rss.xml`) | a page-kind file, prerendered | 222, 273 | |
| The `"signed"` island mode | `"sealed"` (default) or `"server"` | 224, 271, 272 | |
| `LocalKey<T>(name)` | `atom(…)` (cardume's `Atom<T>`) | 295 | |
| `ActionOutcome`, `ActionErrorCode`, `orError()` | `Result<T, ActionError>` | 303 | |
| rakun-app's action-id wrapper | `actions.id.deriveActionId` | 324 | |
| `#[service]`, `#[managed]`, the core's `#[repository]` on a type; `#[configuration]`, `#[bean]`; `#[httpExchange]`, `#[getExchange]`; `#[amqpListener]`, `#[kafkaListener]`, `#[redisListener]`, `#[streamListener]`, `#[listener]`; `#[restController]` | `#[component(…)]`, `rakun-data`'s `#[repository]` on a behavior, `#[provides]`, `#[httpClient(…)]`, `#[listen(…)]`, `#[controller]` | 318 | |
| `#[value("…")]`, `rkProp*`, string profiles | `#[config("<prefix>")]` typed records | 299 | |
| `rkRoutes`, `rkBeans`, `rkHooks`; `__rkMake_<T>` | registration through each marker's `compiler.init`; `T.make()` | 625 (1), 234 | |
| The `try*` store twins | one API answering `Result<T, StoreError>` | 304 | |
| rakun's four `Cookie:` readers, the three q-value parsers | `http`'s `cookie` and `accept` | 196 | |
| `Schema<T>`, `Codec<A, B>`, `schemas.*`, `checks.*` (public); the module-level functions named after a type | `#[validated]` and its members (`T.parse`, `T.decode`, …) | 306, 327 | |
| `StyledView`, `StyledPropertyView` | `Styleable.toStyled(self) -> Component<Styled>` | 661 | |
| `rakun-stylesheet`'s run-time entry points (`emilia(tokens)`, `className`, `cls`) | `#[stylesheet(…)]` on a tag (862, 889); `comptime className(…)` | 369, 862, 889 | |
| snap's local `fsText` | `e.message()` | 563 | |
| rakun's SAML 2.0 ACS | — (retired for the milestone): `saml2/` answers 501 under a `deferred.md` row | 713 | |
| `onze-server` (a package of its own after 724) | `rakun-ssr-server`, erlang only, a row of 724's table | 762 | 2026-10-19; renamed by 165 s5 |
| `jhonstart-dom-test` (a package of its own after 724) | `rakun-bpp-dom-test`, commonJS only, a row of 724's table | 762 | 2026-10-19; renamed by 165 s5 |
| `jhonstart-cardume` (296's page-store bridge) | folded into `rakun-cardume`, which holds both stores | 893 | 2026-10-21 |
| The HTML attribute prefix `data-jh-*` (`data-jh-pending`, `data-jh-prefetch`, `data-jh-root`, …) | `data-rakun-*`, the name after the prefix unchanged | 898 | 2026-10-21 |
| `snap.matchesRefused`, `matchesRefusedAt` (a loaded file's refusals as a snapshot) | — (removed): a conformance module prints each case's answer, `cell check` records it | 784, 786, 796 | 2026-10-20 |
| `emilia()` / `emiliaWith` / `emiliaPlugin` / `emilia.bp` / `emilia-*` bundler kinds and examples; `Onze`, `OnzeConfig`, `ONZE_PUBLIC_`, `/_onze/`, `onze_main.bp`, `ONZE_KEY`; `jhonstart_*.erl`, `examples/rakun-bpp/jhonstart-*`; `onzeAvailable()` / `rakun.cli.onze` / `RAKUN_CLI_ONZE` | `stylesheet()` and its kin; `RakunSsr`, `SsrConfig`, `#[publicEnv]` (928; 889's `RAKUN_SSR_PUBLIC_` overtaken), `/_rakun-ssr/`, `ssr_main.bp`, `RAKUN_SSR_KEY`; `rakun_bpp_*.erl`, `counter` / `markup` / `todo`; `ssrAvailable()` / `rakun.cli.rakun-ssr` / `RAKUN_CLI_RAKUN_SSR` | 862, 889, 883 (6), 893, 928 | 2026-10-21; `styled`, `Styled`, `StyledSheet` stay |
| The gate grep `jhonstart\|erika\|emilia\|onze` for compiler-core | `rakun`; `query` as a package (`"query"`, `import query`) | 860 | 2026-10-21 |
| `#[postConstruct]` / `#[preDestroy]`; `rkRegisterLifecycle` over `compiler.methods(decl)` | `rakun`'s `pub behavior Startable` and std's `Closeable`, tested with `is` | 925 | 2026-10-21 |
| `notFound()` / `redirect()` as a raise with a `nav:` string; `signalReason`, `isSignalReason`, `signalPrefixes`, `raiseReason`, `isSignal`, `notFoundReason`, `redirectReason`, `signal_runtime.mjs`, `rkNavSignal` | a `Component<Element>` whose node is `NavSignal(outcome: NavOutcome)`, read by the renderer | 924 | 2026-10-21 |
| a hook named `use` + a capital (`useActionState`) | `use actionState(…)`; refused `hook-name-use-prefix` | 926 | 2026-10-21 |
| the `RAKUN_SSR_PUBLIC_` prefix, `isPublicEnvName`, `publicEnvPrefix` | `#[publicEnv] pub val apiUrl = env.read("API_URL");` | 928 | 2026-10-21 |
| `Query<T>`'s LINQ-named public methods (`where`, `select`, `selectMany`, `orderByDescending`, `toList`), `query.of(xs)` | private lowering targets; ``query @`select …` `` or std's `filter` / `map` / `flatMap` / `unique` | 914 | 2026-10-21 |
| the seven unbuilt example projects of the 1.0.10 list | `modules/README.md` § Examples lists the directories on disk | 935 | 2026-10-21 |
| `jhonstart:redirect:<url>` (the redirect reason) | `nav:redirect:<url>` of `contracts.md § 5b` | 115 (2) as amended by 116 | 2026-11-04, found by the record rewrite |
| the `rakun-validation` boundary member | the bundled library `validation` | 115 (1) as amended by 116 | 2026-11-04, found by the record rewrite |
| the orchestrator (onze) translating `notFound` / `redirect` before the first chunk; `rakun.navigation.allowedHosts` for a late redirect | the render library's own translation and target check — relative through `matchPath`, absolute only when listed in `allowedRedirects` | 115 (1), (2) as amended by 117 | 2026-11-04, found by the record rewrite |
| `rakun-session`'s `session_cookie` last-wins on a duplicated cookie name | first wins, everywhere (RFC 6265 § 5.4) | 181 | 2026-11-04, found by the record rewrite |
| rakun-logging's `errorDigest`, rakun-web's `problem_digest` cell, the render library's `digestOf` | `log`'s `errorDigest(module, errorClass, message, topFrames)` | 194 | 2026-11-04, found by the record rewrite |
| `types.bp`'s `appFileKinds()` and `classifyAppFile()` (rakun-ssr) | `routing`'s `conventions.fileKinds` / `conventions.classify` | 323 | 2026-11-04, found by the record rewrite |
| rakun's five cookie readers (`decodeComponent`, `cookieValue`, `cookieFromHeader`, `cookieFrom`, `sessionIdOf`); `03r-e` | `http`'s one reader (`cookie.parse` / `get`), a malformed chunk absent; `03r-e` lapses | 915 | 2026-11-04, found by the record rewrite |
| `fileSink` raising on a failed host call (106-c) | `Error` of `log`'s own error enum | 921 | 2026-11-04, found by the record rewrite |
| `#[bpp.html]` / `#[bpp.htmlPrelude]` bound to `jhonstart` (`"bpp": "jhonstart"`, `from "jhonstart"`) | `"bpp": "rakun-bpp"`, `from "rakun-bpp"` (724's rename; already listed as the jhonstart → rakun-bpp rename) | 198, 200, 270, 275 | 2026-11-04, found by the record rewrite |
| `<style>` in markup (except `<style #[isInline]>`) | the `--- style ---` section | 338 (8) via the lead | 2026-11-04, found by the record rewrite |
| a prelude module declaring one `#[bpp.htmlPrelude]` marker `val` (270's shape) | marked items where they are declared (589) | 270 (amended by 589) | 2026-11-04, found by the record rewrite |
| rakun-ssr's `build.bp` compiling every `erl/*.erl` on each build | `botopink build` materialises the dependencies' cached `.beam`; `compileBeam` runs `erlc` only over `.erl` with no `.beam` beside them | 767 | 2026-11-04, found by the record rewrite |
| `#[check]` on a field | `#[refine(rule)]`, a field marker; `#[check]` on a field refused naming `#[refine]` | 406 (2) | 2026-11-04, found by the record rewrite |
| the `Name.Http` type and the inferred return of rakun-restclient's generated client | a static `http` added to the behavior, `fn() -> decl`; `Api.http()` answers an `Api` | 627 | 2026-11-04, found by the record rewrite |
| `rakun-routing` (a rakun workspace member), `rakun-validation` | the libraries `routing` and `validation` (115, 116) | 114 (1) | 2026-11-04, found by the record rewrite |
| `LayoutProps`, `rkAppRegisterPage` over `Element` (in rakun) | rakun-bpp's UI conventions; rakun holds an opaque `PageRenderer` per route | 114 (4) | 2026-11-04, found by the record rewrite |
| `setPageRender`, `RenderedPage` | `ChunkWriter`, `PageRenderer`, `page(pattern, render)` | 114 (5) | 2026-11-04, found by the record rewrite |
| `__onze_action`, `X-Onze-Action` | `__bp_action`, `X-Bp-Action` (rakun-ssr's defaults; neither library spells a name) | 114 (7) | 2026-11-04, found by the record rewrite |
| the `rakun_request_context` host binding, the `fillRequest` seam | `RequestData` handed to `renderStream` | 114 (8) | 2026-11-04, found by the record rewrite |
| rakun's page-level `redirect` / `notFound`, `boundaryFor` and every page-signal path of front 63 | signals handled inside rakun-bpp; rakun's `notFound` / `redirect` / `permanentRedirect` / `redirectWithStatus` stay for server actions and route handlers | 117 (1) | 2026-11-04, found by the record rewrite |
| `@utility`, `@theme` in a `styled` literal; `#[isGlobal]`, `#[defineVars]`; `<style>` in markup (but `<style #[isInline]>`) | a `val` or function names a component; `:global(…)`; run-time holes as CSS variables; the `.bpp` style section | 338 (2), (4), (7), (8) | 2026-11-04, found by the record rewrite |
| a `path` dependency to a sibling workspace member | `{ "workspace": true }`, the only sibling form; the `path` is a located error | 75 | 2026-11-04, found by the record rewrite |
| `#[isGlobal]`, `#[defineVars]` (style-section directives) | `:global(…)` and run-time holes in the style section (338) | 278 (dir-5) | 2026-11-04, found by the record rewrite |
| a `slot="fallback"` child of an island | the annotation's argument, `#[serverDefer(fallback: …)]` / `#[clientOnly(fallback: …)]` | 287 | 2026-11-04, found by the record rewrite |
| the string link / script instructions left after 278 (a hand-written reload / history attribute; `<Script>`'s strategy as `Hydrate`) | `<a #[reload]>`, `<a #[history(.Replace)]>` lowered to `data-rakun-reload` / `data-rakun-history`; `strategy={.LazyOnload}` of `ScriptStrategy` | 292 | 2026-11-04, found by the record rewrite |
| `#(string, string)[]` attribute pairs in the native builders; a custom element or an unlisted SVG tag in markup; an event attribute (`onClick`) | typed props records (`GlobalAttrs`, `AriaAttrs`, each element's own, `Type.merge`); `el(…)` keeps the pairs; the tag refused at the tag; `onClick` refused at its name until typed events | 351 (4), (5) | 2026-11-04, found by the record rewrite |
| the `(children, attrs:)` native builder form | `pub fn a(props: AnchorProps) -> Element`, one builder per tag | 362 | 2026-11-04, found by the record rewrite |
| a server twin of a browser-only cell (`sidecars/jhonstart_link.erl`'s `linkStatus`, `sidecars/jhonstart_island.erl`) | — (removed): reached only through a `#[clientOnly]` hook; a `Link`'s pending state is `data-rakun-pending` | 363 (1), (3), (4) | 2026-11-04, found by the record rewrite |
| the per-name `registerStarter`; the page as a thunk `{ -> Page() }`; `__jhPushBoundary` (a `Suspense` registered with the render); `payload()` answering `array<#(string, Json)>` | `registerRouteStarters(pattern, load)` over `globals.starters`; `compose(chain, Page())`; the `Suspense(Boundary(id, fallback, child))` node; `Async<?#(string, Json)>`, `[]` → `null` | 964 (1), (2) | 2026-11-04, found by the record rewrite |
| rakun-bpp's `globals()` function (three flat browser globals) | one `pub val globals` with the fields `globals.payload`, `globals.fill`, `globals.signal` | 140 (3) | 2026-11-04, found by the record rewrite |
| `src/prelude.bp` with `pub val prelude = bpp.Prelude()` (361 (2)'s marker `val`) | `#[bpp.htmlPrelude]` on each `pub` item where it is declared, outside `src/internal/` | 589, 592 (9) | 2026-11-04, found by the record rewrite |
| a member's `targets` list equal to its workspace's (95-b as built) | omitted; a member writes `targets` only to narrow (512 (3)); no `targets` is the intersection (770) | 919 (3) | 2026-11-04, found by the record rewrite |
| `islandKeyEnv` (a key renaming the island key) | the environment variable `RAKUN_SSR_KEY` alone | 271 | 2026-11-04, found by the record rewrite |
| `responseStatus` / `responseHeader` as plain calls | `use response()`'s `res.status(…)` / `res.header(…)` | 291 | 2026-11-04, found by the record rewrite |
| `pageData(route, schema)` | `use pageData<T>()` | 293 | 2026-11-04, found by the record rewrite |
| `navigation.bp`'s `-> i32` (rakun-app's status from the signal) | rakun-app answers the status rakun-bpp's render wrote (130) | 924 (3) | 2026-11-04, found by the record rewrite |
| rakun-data's old `#[query]`, its `<m>Sql()` members, `rkRegisterQuery` | `#[repository]` on a `behavior` with `#[query @`…`]` / `#[nativeQuery("…")]` methods; `Users.Sql(ctx)`, `Users.of(ctx)` | 313 | 2026-11-04, found by the record rewrite |
| `run(sql, params: Array<string>)` on `QueryContext` | `runMany<T>` / `runOne<T>` taking `QueryParam[]` | 427 (1) | 2026-11-04, found by the record rewrite |
| `count(f)` on a non-optional field; `select *` with `group by`; `order by` / `limit` on an ungrouped aggregate | refused (`count(*)` named; `limit has nothing to cut`) | 428 | 2026-11-04, found by the record rewrite |
| hot-loading / a module swap as a form of `rakun-ssr dev` (50-b's (b), (c); 50-d, 50-e, 50-f) | `build` then `start` looped over a file watcher; a restart on every change | 766 | 2026-11-04, found by the record rewrite |
| `env-non-public` keyed on an unprefixed name | `env-non-public` for an `env.read` in a `#[client]` component that is not a `#[publicEnv]` `val` | 928 (1) | 2026-11-04, found by the record rewrite |
| `parseMetrics` / `gradientOf` reading a malformed integer as `0` | `Result<FontMetrics, string>` with `Error("<family> <weight>: line <n>: \"9x0\" is not an integer")`; `gradientOf`'s not-a-gradient value | 942 | 2026-11-04, found by the record rewrite |
| a second start path beside the release's `bin/rakun-ssr` | `start` runs `bin/rakun-ssr` when the release exists, else spawns the node — one path | 965 (4) | 2026-11-04, found by the record rewrite |
| `#[configurationProperties]` | `#[config("<prefix>")]` | 299, 952 (3) | 2026-11-04, found by the record rewrite |
| `rkPropInt("12abc") == 12` (03r-b, a lenient number read) | a malformed number stops the boot naming the file, the line and the expected type | 299 | 2026-11-04, found by the record rewrite |
| 117 (8)'s "every rakun manifest is `["erlang"]`" (03r-a) | every framework package restricts its own `"targets"`; a member repeating the workspace's whole set drops the key | 952 (1), 762, 512 (3) | 2026-11-04, found by the record rewrite |
| `rakun.rsocket.server.transport` compared as a string (`transport == "websocket"`) | `enum Transport { Tcp, Tls, WebSocket }` read through 299's typed config; `rkRegisterTransport(t, mount)` | 939 (1) | 2026-11-04, found by the record rewrite |
| `Astro.slots.render(name, args)`; `slot="…"` as text | `<Slot name=… />`, `#[slot("…")]`, `use hasSlot` | 360 (6) | 2026-11-04, found by the record rewrite |
| the hand-written proxies `<Type>Tx`, `<Type>Sec` | `#[transactional]`, `#[secured(…)]`, `#[retryable(…)]`, `#[useCache]` as wrappers | 318 (7) | 2026-11-04, found by the record rewrite |
| `#("--…", "…")` pairs and `""`-as-clear in a theme | `entry(ns, name, value)`, `clear(ns, name)`, `clearNs(ns)`, `clearAll()` | 300 | 2026-11-04, found by the record rewrite |
| `class={emilia(tokens)}` and the `fn xTokens() -> Token[]` helpers in templates | the tag annotation `#[stylesheet(…)]`; a run-time choice picks among annotated branches | 301 | 2026-11-04, found by the record rewrite |
| `fullTheme()` / `fullOptions()` as a second theme | `defaultTheme()` (the whole Tailwind theme) or `baseTheme()` | 358 | 2026-11-04, found by the record rewrite |
| rakun-stylesheet's own `Rule` / `Sheet` model and codec (`encodeSheet`) | `css`'s sheet model and `Sheet.render()` (338 (3)) | 367, 368 | 2026-11-04, found by the record rewrite |
| `#[schema]` | `#[validated]` | 306 | 2026-11-04, found by the record rewrite |
| the `union2…5` / `tuple2…5` families; a loose value checked ad hoc | a declared type; the `constraints.v*` predicates | 306 | 2026-11-04, found by the record rewrite |
| the `jhonstart:` navigation-reason prefixes | the neutral `nav:` prefix (itself retired by 924) | 116 (1) | 2026-11-04, found by the record rewrite |
| rakun-web's middleware matcher and the CORS preflight's `routeMatches` (two more path grammars) | `routing`'s module `pattern` (`parsePattern`, `matchPattern`, `patternProblem`) | 116 (7) | 2026-11-04, found by the record rewrite |

## Process and files

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| `specs/<version>/decisions-taken.md`, `decisions-taken-steps.md`, `decisions-pending.md`, `decisoes-pendentes.md` (one copy per milestone) | the four files at `specs/`, one each | — (the maintainer) | 2026-10-18; the closed milestones' copies were folded into the record |
| `decisions-taken.md` as the record | `decisions-taken-steps.md` (the record, append-only from 730) and `decisions-taken.md` (the rules in force, by subject) | 730 | 2026-10-18 |
| The tier directories (`1-botopink-lang/`, `2-libraries/`, `3-medium/`) | `machine-1/`, `machine-2/` | 433, meta `AGENTS.md` § Layout | 2026-10-17 |
| The track directories (`00-gate` … `10-specs`, `20-snap`) | the fronts' subdirectories, old ids resolved through the alias tables | 433 | |
| The one-gate-at-a-time lock | the machine-wide job pool (`scripts/gate.sh run`, `exec`) | 468, 469, 674 | 2026-10-11 |
| `scripts/restricted-targets.txt`, `scripts/known-red-libs.txt`, `--include-unsupported`, `expected-failures.txt`, `scripts/known-broken-examples.txt` | the manifests' `"targets"`; a red cell is red | 153, 154, 161 | |
| A `// targets:` line in a single-file suite | a project suite with a `botopink.json` naming `"targets"` | 536 | |
| `docs-check: skip` | `reject <error-id>` and `project` fences | 157 | |
| The `format-check` stage; `blockStatementSemicolon` | `botopink format` applied by the commit hook | 524 | 2026-10-14 |
| `cache/erlcheck`, `cache/beam` | the code cache's level A | 509 (2) | 2026-10-12 |
| `cache/results/lib-test` (a cached test result) | — (removed): no test result is cached | 510 | 2026-10-12 |
| `~/.cache/botopink-lsp`; any cache in `$HOME` or `$XDG_CACHE_HOME` | `.botopinkbuild/cache/` (`lsp/` for the server) | 225, 233 | |
| The windows CI row | — (removed) until the snapshot capture normalises CRLF and path separators | 158 | |
| `gate.sh --cold` inside a `--repo` / `--lang` worktree | the commit hook's warm gate; a cold gate runs in the main checkout's `repository/botopink-lang` | meta `AGENTS.md` § Worktrees (4b) | |
| One full cell per case, `<module>/cases/<case>/` (765); `<module>/run/` and `<module>/refused/` (779) | one package per module, `src/cases/<case>/mod.bp` loaded or called by `main.bp`, one `main.snap`; `cells/<case>/` for a case that cannot share one; `scripts/pack-cells.py` | 765, 779, 789 (4), 796 | 2026-10-19; `cell new` still writes a 765 case, which `pack-cells.py apply` packs |
| A scratch location named in a spec (`.tasks/<name>` paths, `` `/tmp/` ``, a task branch, a worktree by name) | what remains and what blocks it | 484, `scripts/scratch-refs.py` | |
| `botopink cell check` (the CLI command); the spawning `conformance/check/` program and `proof.sh` | the in-process check: each module's `main` loads its cases with `compiler.load`, compares with `main.snap` and writes `.new`; one `runCase("<c>")` per case | 989, 990, 1002 (2) | 2026-10-27 |
| `botopink run <file>.bpr` (the named-file form) | `botopink run [--target <t>]` in the package; the `.bpr` internal under `.botopinkbuild/runtime/<pkg>/` | 1009 | 2026-10-27 |
| commonJS's mirrored subfolders; `out/erl/`; commonJS and wasm output at `out/`'s root; the separate tsc-check stage | flat `<pkg>@<path>` files in `out/commonJS/`, `out/erlang/`, `out/beam/`, `out/wasm/`; one `tsc` folded into the commonJS row | 1013, 1015, 1023 | 2026-10-27 |
| `--jobs` on `build` / `run --target`; the 900 s per-member timeout default; a per-case time bound | the spawner (run.sh, gate.sh, CI) decides parallelism; `--timeout <s>` bounds the whole command, only when passed | 1066, 1067, 1068, 1070 | 2026-10-27 |
| import aliases (`@/…`, the manifest's `alias`, rakun-ssr's `loadAliases`, `rakun-cli create --import-alias`); an unknown manifest key silently accepted | real module paths only; every unknown manifest key refused, located (`manifest-unknown-field`) | 1048, 1050 | 2026-10-27 |
| `scripts/decisions-split.ts` (the per-repository `decisions-taken.md` generator), `scripts/decision-cells.ts` (`scaffold` / `compile` / `promote` / `check`), CI checks 6 and 7 | nothing yet; the generated files and the decision cells stay as content | 1107 (overtakes 482) | 2026-11-02 |
| compiler-core's content-keyed runtime-output cache (`RUN LOG` hits); `scripts/check-docs.sh`'s result store | every `erl` / `node` run runs on every check | 922 (3)–(4), 510 | 2026-10-21 |
| escript's exit status `127` for a crashed `botopink run --target erlang` | `erl`'s status, a crash `1` | 56 | 2026-11-04, found by the record rewrite |
| `escript out/main.erl` (what `botopink run --target erlang` ran) | `erl -noshell -pa <one directory> -s main _botopink_main` | 6 | 2026-11-04, found by the record rewrite |
| `tests/language/` (the old language suite), botopink-lang's `docs.md` / `docs/`; the `run/`, `reject/` and `modules/` shapes | `repository/botopink-lang/conformance/` (`docs.md`, `modules/<cell>/{botopink.json, docs.md, src/, snapshot/output/, snapshot/targets/}`), one shape | 466 (1), 457 (2), 462 (3) | 2026-11-04, found by the record rewrite |
| `<!-- example: <cell> -->` markers (461 (2), 463 (2)) and rakun's `{src/main.bp}` brace link (548 (3)) | an ordinary Markdown relative link, `[src/main.bp](src/main.bp)`, `test-docs` reading the link form | 650 | 2026-11-04, found by the record rewrite |
| `botopink-lib-test` (the binary and its release / install / bpmp entries), `modules/lib-test-runner/`, `scripts/test-libs.sh`; a spawned `botopink test` per library | the in-process program at botopink-lang `scripts/test-libs/` over `compiler.load(package: …)` and `Module.test()` | 993 (7) | 2026-11-04, found by the record rewrite |
| `doc_quotes` | `botopink packages --check-docs` | 993 (7) | 2026-11-04, found by the record rewrite |
| the per-case `.snap` (`snapshot/output/<module>.snap` per case) and `botopink-cell 1` for a module | one `snapshot/main.snap` per module, `== <case>` sections, a departure as `== <case> on <t>` (`botopink-cell 2`) | 989 (5) | 2026-11-04, found by the record rewrite |
| a `pending` verdict for a decision cell's draft | the tree's shape: `draft/main.bp` or `src/main.bp`, never both, never neither | 649 | 2026-11-04, found by the record rewrite |
| cell snapshots written `error: <code>: …` | `error[<code>]: <message>`, one printer for parse and checker refusals | 557 | 2026-11-04, found by the record rewrite |
| the one-gate-per-machine lock (`scripts/AGENTS.md` § Gate lock); botopink-lang's gate lock | the machine-wide job pool in the meta `scripts/gate.sh` (already in retired-forms as the one-gate-at-a-time lock) | 468 (5), 469 (2) | 2026-11-04, found by the record rewrite |
| `HOST_BINDING_MARK`'s text match in `lib-test-runner/src/runner.zig` | the refusal id `host-binding-missing`, matched by id | 920 (3) | 2026-11-04, found by the record rewrite |
| 468 / 469's pool sizing `min(cpus, MemAvailable / 768 MiB) / 2` and their strict first-come admission | `max(1, min(cpus / 2, (MemAvailable − 2 GiB) / 768 MiB))` (674); one small-gate pass ahead of full-pool waiters (717) | 674, 717 | 2026-11-04, found by the record rewrite |
| `SymbolKind.Function` for a type's methods | `SymbolKind.Method` | 7 | 2026-11-04, found by the record rewrite |
| the extension recognising a `test "…"` block by its symbol kind (every `Method` a test) | by its parent in the symbol tree: a child of the file, where a method is a child of a type | 7 | 2026-11-04, found by the record rewrite |
| `01-std/07-std-json-writers` (the front directory) | steps of `01-std/01-std-lib-enablement` | 117 (5) | 2026-11-04, found by the record rewrite |
| `build.zig`'s `bundled_packages`, `libs/AGENTS.md`'s table, `format-check.sh`'s `TREES`; 115–117's "compiled into the binary" | repositories, ordinary dependencies | 326 | 2026-11-04, found by the record rewrite |
| a hand-written JSON Schema walker in `release_test.bp` | 399's vendored validator (`test/tools/check-schema.js`) over the checked-in CycloneDX 1.5 schema | 936 | 2026-11-04, found by the record rewrite |
| the comptime renderer's `id` field (`"id": 0` in every snapshot) | — (removed) | 19 | 2026-11-04, found by the record rewrite |
| the codemod `botopink migrate effects`, `// TODO(migrate-effects)`, `parser.effect_migration`, `infer.effect_migration_files`, `comptime.setEffectMigration`, the `ExprTypeLog` hook | — (removed): migration by hand, from the three located errors | 131 | 2026-11-04, found by the record rewrite |
| the `candidate <path>` print of a conformance run (the `.new` candidate printed on wasm) | `.new` written through `io.fs` on all four targets | 992 (4) | 2026-11-04, found by the record rewrite |
| `modules/lib-test-runner/`, `scripts/test-libs.sh` and the lib-test binary; then `scripts/test-libs/` and the `test-libs` gate stage | the in-process library check inside `conformance/`, one `test-conformance` stage (`conformance/disabled.txt` shrink-only for the migration) | 994 (L5), 995, 996 | 2026-11-04, found by the record rewrite |
| the cells `case_on_disk_not_run_refused`, `case_call_without_directory_refused` (1011 (4)); a decisions-taken directory as the only Cell value | `conformance/run.sh --self-test` fixtures; a Cell column may name a cell slug, `tests/<name>.sh` or `conformance/run.sh --self-test`, set after the row lands | 1012, 1022 | 2026-11-04, found by the record rewrite |
| `backend_exec.sh`'s `wasmtime --invoke main` check; the wasmtime CLI installed by CI | a zig test of the runner (`codegen/wat/runner.zig`); the pinned CLI only in the job running `wasm_pack_runs_standalone` | 1034 (1), 1079 (2) | 2026-11-04, found by the record rewrite |
| the `COMPTIME WAT` snapshot sections (46) | dropped; `COMPTIME REPLY` stays, comptime units snapshotted by the program's generator | 1038 (5) | 2026-11-04, found by the record rewrite |
| `BOTOPINK_TARGET_REPORT`; the `botopink-target:` stderr line | run.sh's file-system stamp; `target runs: <t> built N, reused M` | 1043 (1), (3) | 2026-11-04, found by the record rewrite |
| `flat_output_one_name_scheme-1015/`; the `wasm_units_precompiled_once` directory; 1050's program cell while `compiler.load` differs | `tests/flat_output_names.sh`; `tests/wasm_runner.sh`; `tests/import_alias_refused.sh` until the loader fix | 1054 (1), (2), 1064 (3) | 2026-11-04, found by the record rewrite |
| `main.wat` as a written file name | `<pkg>@main.wasm`; `<module>.wat` only as the harness's module label | 1065 (2), 1079 (1) | 2026-11-04, found by the record rewrite |
| `BOTOPINK_GATE_TIMEOUT`; the 1800 s per compiler run in `runner-standalone.sh` | one `--timeout 1800` (or `setsid timeout -k 5 1800`) over the gate's whole run | 1070 | 2026-11-04, found by the record rewrite |
| a program without `fn main` running (wasi's `no exported instance named wasi:cli/run`, an exit 0, a raw `error:undef`) | the CLI's located refusal before running, one message on every target and host | 517 | 2026-11-04, found by the record rewrite |

## Decision rows replaced, reversed or overtaken

The record keeps these rows as one line (or as the reason they lost force); read the successor instead.

| Retired | Replaced by | Decisions | Since / note |
|---|---|---|---|
| 145 | 384 and 306 | 145 | |
| 149 | 348 | 149 | |
| 179 | 432 | 179 | |
| 184 | 187 | 184 | |
| 209 | 247 | 209 | |
| 252, 514, 515 | 575 (1) | 575 | 514 as amended by 515; 586 overtaken by 575 (1) as well |
| 268, 371, 591 | 666 | 666 | |
| 269 | 354 and 379 | 269 | |
| 279 | 286 | 279 | |
| 288 | 213 and 289 | 288 | |
| 316, 678 | 714 | 714 | |
| 333 (B) | withdrawn | 731 (4) | |
| 353, 698 | 665 | 665 | |
| 366 | 369 | 366 | |
| 374, 387 | 388 | 388 | |
| 411 | 735 with 575 (4) | 735 | |
| 413 | 642 | 642 | |
| 419 | 592 (5), (6) | 728 | |
| 435 | 438 and 452 | 435 | |
| 439 | 452 | 439 | |
| 476 | 477 | 476 | |
| 551 | 581 (1) | 664 | |
| 564 | 576 (1) and 665 | 564 | |
| 612 | 643 (reversed the same day) | 612 | 2026-10-18 |
| 633 | 594 (1), (3) | 633 | |
| 634 | 575 (3), 606 (3) and 632 | 634 | |
| 635 | 603 with 310 | 635 | |
| 636 | 576 (2) and 616 | 636 | |
| 652 | 575 (6) | 652 | |
| 653 | 504 and 593 (1) | 653 | |
| 654 | 392 (1) | 654 | |
| 655 | 316 and 576 (8) | 655 | |
| 656 | 595 (3), (5) and 431 | 656 | |
| 657 | 326 | 657 | |
| 658 | 433 (1) | 658 | |
| 693 | 575 (1) | 693 | |
| 694 | 664 and 665 | 694 | |
| 727 | 576 (3), (11), 631, 697, 698 | 727 | |
| 728 | 592 (5), (6) and 680 | 728 | |
| 729 | 592 and 665 | 729 | |
| 784 (2)–(3), 786 (3) (`snap`'s `matchesRefused`, the suite's refused cases through `snap`) | 789 (4)–(5), 796 | 784, 786 | 2026-10-20 |
| 771 | 816, 818 | 771, 892 | 2026-10-21 |
| 779 (1)–(3), 781 | 789 (4) | 779, 781, 892 | 2026-10-21 |
| 780 (1)–(2), 782 (1) | 786, 833 | 780, 782, 892 | 2026-10-21 |
| 787 (1), 792 (1)–(3), (5)–(6) | 806, 811 (4), 830 | 787, 792, 892 | 2026-10-21 |
| 798 (2), (4) | 805, 834 | 798, 892 | 2026-10-21 |
| 804 (1), (4) | 809 (2), (7), 828 | 804, 892 | 2026-10-21 |
| 809 (1), (6), (8), (9) | 826, 819, 817, 816 / 818 | 809, 892 | 2026-10-21 |
| 810 (5), 815 (1), (3), (5) | 819 | 810, 815, 892 | 2026-10-21 |
| 812 (2), 813 (1) | 816 (6), 817 (3) | 812, 813, 892 | 2026-10-21 |
| 816 (1), (2), (4), (5), (7), 817 (1), (2), (4), 818 (1)–(2) | 818, 819, 825 | 816, 817, 818, 892 | 2026-10-21 |
| 822 (1)–(2), 824 (2) | 825 | 822, 824, 892 | 2026-10-21 |
| 820 (2), 827 (1) | 884, 891 | 820, 827, 892 | 2026-10-21 |
| 835 (2)–(4), 838 (1) | 885, 860 | 835, 838, 892 | 2026-10-21 |
| 853 (2) | 890 | 853, 892 | 2026-10-21 |
| 862 (1)'s `bpp-*` | 889 (2) | 862, 892 | 2026-10-21 |
| 537 (2) | 865 | 537, 892 | 2026-10-21 |
| 539 (5) | 866 | 539, 892 | 2026-10-21 |
| 207's `BpInline__` | 832 | 207, 892 | 2026-10-21 |
| 626 (2) | 842 | 626, 892 | 2026-10-21 |
| 118 rule 1 | 852 | 118, 892 | 2026-10-21 |
| 911 (a hole's raise example written as `raising "x"` / `quote @`…``) | 977 (the example respelt `html @`<p>${10 / zero}</p>``) | 977 | 2026-11-04, found by the record rewrite |

## How to use this page

A thread or a machine that meets a form of the "Retired" column in a README, a cell, a comment or a library's source
rewrites it to the "Replaced by" column; where the replacement is "— (removed)", it writes what the row says one writes
instead. A box or a step whose whole mechanism is retired (a catalogue query, a `@emit` registration, a linear-memory
helper) is closed, not respelled. History sentences, a decision's own text, a codemod's rule and a cell that tests the
refusal keep the old form. A retirement this page misses is added here in the commit that records its decision.
