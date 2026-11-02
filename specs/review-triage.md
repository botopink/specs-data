---
milestone: 1.0.12-beta
---
# Review triage — the open delegated decisions

The 139 rows that `specs-bot review --open` lists (814–955) — the decisions taken at the maintainer's delegation —
read one by one with `specs-bot step <n>` (2026-10-26) and none marked reviewed. Each row
was checked for: a contradiction with an in-force row or a retired form; a cell named and plausible (a one-liner or a process
row needs none); a rule that answers the question its id names; and whether it is a process rule or a language rule (process rows
are marked *(process)*). Rows 957–963, answered today, were read as part of the record.

- **C — looks wrong**: 2 — a contradiction or a mismatch, naming the row.
- **B — needs a look**: 39 — a broad language surface, an overlap with another row (most often a row a later one amends
  while it stays in force), or loose or stale wording.
- **A — holds up**: 98 — consistent, narrow, matching its question.

Once the maintainer answers, the rows approved are marked with `specs-bot reviewed <n>`, and each row rejected opens a pending
question (`specs-bot pending-add`).

## C — looks wrong

| Step | Rule (one line) | Reason |
|---|---|---|
| 953 | Track 05's nine rakun-bpp choices stand; 31-a's raise-through-host-cell mechanism confirmed, signature left to nat-d6/lg2-l. | Contradicts 924 (signals are data, no raise) and 929: its (3) confirms that `notFound()` / `redirect(url)` raise through a host cell and cites `-> noreturn` and catch-by-type, which 924 rejected. |
| 955 | Track 07's nine rakun-ssr choices stand under current names; 49-a and 68-d amended, 50-a under 506 (3) and 71. | Contradicts 928: its (7) says the public-env manifest entries carry `RAKUN_SSR_PUBLIC_`, a prefix 928 deletes for `#[publicEnv]`. Also no cell for a code-bearing bundle. |

## B — needs a look

| Step | Rule (one line) | Reason |
|---|---|---|
| 815 | `Composition<T>` is a function again; a plain lambda is a component; hand calls admitted; union-member returns fit. | Largely overtaken: its retired line gives 815 (1), (3), (5) to 819 (`fn(scope, key: Place)`). Row still in force with supersedes none. |
| 816 | Hooks' state lives in the node's scope cell, kept across renders while the same component stands at the same place. | Most clauses (1), (2), (4), (5), (7) retired by 818, 819, 825 per its own retired line; little of the row stands as written. |
| 817 | std `Scope` keeps the tree of cells by place and identity; `#[key]` on a parameter or field; contexts refreshed on reuse. | 817 (1), (2), (4) overtaken by 818 (identity by call, `#[key(expr)]` at the call) and 819 (Place numbers); only (3), (5) stand. |
| 818 | Every value-answering `use` takes a child cell; identity is the call site numbered in its declaration; `#[key(expr)]` at the call. | 818 (1)–(2) retired by 819 (places as numbers, `App#1` reread); its retired line lists itself; overlaps 819–821. |
| 819 | `Composition<T> = fn(scope: Scope, key: Place) -> T or Async<T>`; a place is the call's number plus item number or key. | Rule field is garbled: the `or` in the question split it, so the rule opens with question text. Amended again by 820 (stamp on the value), 884, 891. |
| 820 | A component's place is stamped into its value by the call; the runner's `key` replaces only the item half. | 820 (2) (renderer and children pass `Place.none()`) overtaken by 884 and 891 (`Place.index(i)` for `all` and the renderer's child list). |
| 822 | A root runs a component with std's `run`; `resolve` stays the renderer's and `use c`'s. | Rule field garbled (it opens with question text). 822 (1)–(2) `run(c, scope)` overtaken by 825 (`scope: ?Scope = null`, `await run(App())`). |
| 823 | `is Async<unknown>` answers whether a value is a task; false for every value on erlang and beam; wasm via `ref.test`. | Content consistent with 822 and 825, but the rule field is garbled: it opens with the question text after a split. |
| 824 | On BEAM a root's cell tree lives in the owning process dictionary keyed by ref; it crosses processes only via `scope.detach()`. | 824 (2) (`close` a no-op on commonJS and wasm) reversed by 825 (2): close marks a root closed on every target. |
| 827 | std `all<T>(cs: Component<T>[]) -> Component<T[]>` resolves a run-time component list under one `use`. | 827 (1) running each entry with `Place.none()` amended by 884 and 891 to `Place.index(i)`. |
| 835 | *(process)* A folded value the language cannot write is printed as the run-time call that builds it. | 835 (2)–(4) overtaken by 885 (`@embed` removed; `Asset(Link(path))`, `bytes.fromHex`) and 860 (`@TypeInfo.all` gone). |
| 844 | Answered by 723: one declared default per context type; a context's identity is its type. | Loose: 723 lets a body make further contexts of one type (`createContext(Theme(…))`), so "one declared default per type" needs scoping to module-level declarations. |
| 852 | A `-> View` template answers `Component<Element>`; aliases in declared returns are erased like everywhere else | Says "amends 118 rule 1", but 118 was overtaken by 553; 883 (7) corrects this to 553 (2) and 276. The row text is still stale. |
| 853 | Two module paths that fold to one erlang atom are refused at the second, both named | 890 amends (2): refused on every target, cell renamed `module_atom_pair_refused`. The row's own erlang/beam-only scope and cell name are stale. |
| 856 | On erlang/beam `terminal.setRaw`/`size` are Linux-only; elsewhere `Error(Unsupported)` and `null` | Changes program behaviour (`TerminalError` gains `Unsupported`) but names no cell; the off-Linux branch is untested by design. |
| 859 | A method without `pub` is module-private for every type (`method-not-pub`); behaviour-implementing methods are reachable everywhere | Broad visibility change amending 814 (2) and 811 (1). 894 later amends its (4) on `.d.ts`; the codemod spans all of std. |
| 862 | Package code uses the package's own name: former library names are renamed by codemod | 889 amends (1): the `bpp-*` examples become `counter`/`markup`/`todo`, plus extra renames. 928 removes the `RAKUN_SSR_PUBLIC_` prefix. The row's list is stale. |
| 864 | `..` is the only spread and takes any expression; record parameters work alike on every callable, with no variadic or default | Wide surface (6 clauses, methods, generics). "closes 37's update path" is loose wording; withdraws part of 529 (3). |
| 866 | A `defer` body cannot throw or propagate: `defer-throw`, `defer-try`; a local `try … catch` is allowed | 883 (3) says the (2) example `defer { try f.close() catch … }` cannot compile, because `close` returns `void` (800). |
| 871 | Implement signatures are compared as types, not spellings; `Self<U>` substitution; a parameter's `comptime` marker is part of the signature | 883 (4) corrects (2) and (3): body markers stay outside the signature, and a member's own type parameter is not counted. |
| 873 | Primitive bodies declare `val length: i32`; locals shadow primitive statics; a module-level name equal to a lowercase type is refused | Bundles four rules. The naming refusal is broad (`array` added; std's `json.array` renamed); touches 641 and 606. |
| 878 | Comptime stays on Cranelift; SIGINT and LSP cancel call `interrupt()` and end with `comptime-interrupted` | New diagnostic, exit code and LSP behaviour, but no cell; it also bundles the engine choice and cache reaping (B-77). |
| 883 | *(process)* Eight wording fixes to rows 814–882, no rule changed | Its retired field copies 862's rename list verbatim, which looks misattached; the corrections it records (852, 866, 871) are not yet applied in those rows' text. |
| 884 | `use all(cs)` runs entry `i` with `Place.index(i)`; an index fills a counted or absent item half, never a key | 891 amends 884 (1): a body's count is now kept, so 884's "fills a count" no longer holds. 884 is still in-force with no supersededBy; read it with 891, 958, 960. |
| 888 | An untyped lambda may omit trailing parameters of its expected function type; the checker pads it to that arity | A broad general language rule settled by delegation, not a narrow fix. 895 extends it with `_`. |
| 889 | *(process)* Confirms and extends 862 (1)'s renames (emilia, onze, jhonstart to stylesheet, ssr, bpp names; the examples become counter, markup, todo) | `RAKUN_SSR_PUBLIC_` is already overtaken by 928 (`#[publicEnv]`), as its own retired line says. Naming row, no cell, which is plausible. |
| 897 | A detached scope is a seed: its tree starts per process at the first read and ends at that process's `close()` or end; stale cells fail `scope-closed` | Reworks 824 (3) and 825 (2) and changes run-time semantics on four targets. It is intricate (a detached root's close differs from `Scope.root()`'s) and deserves the maintainer's eye. |
| 903 | A `PersistentTerm` var's `x = f(x)` is atomic on the BEAM under a per-var runtime lock; reads stay lock-free | The fable overruled the recorded recommendation (b) on 547's "no check". It adds a runtime lock with a real cost. Needs the maintainer's eye. |
| 907 | A function with a `syntax` parameter is one kind; the place of use decides it: `#[f]` decorator, `f(e)` expansion; `isSyntaxExprFn` goes | 962 amends 907 (2): a body returning code is refused at `#[f]`, `syntax-fn-code-at-annotation`. Read 907 with 962. |
| 911 | A template hole known at build whose value raises is refused at the hole, located, never deferred to render | Its cell example uses `raising "x"` and a `quote` template, which are not known spellings. It also sits uneasily with 380 (3): a raise written as such is not folded without `comptime`. |
| 912 | `use` only under `component`; hooks are `component fn`s read with `use`; a `comptime` or hole reaching a `use` is refused | An omnibus confirmation over a broad surface. Its example `use provide(createContext(…))` skips 723's `comptime` / `use memo` wrapping. It overlaps 959. |
| 918 | The 28 choices of the `01-compiler` table stand, except seven overtaken and lem-b, lem-d and cep-c amended to refuse | An omnibus over very broad surface (regex API, `inline:` refusal, comptime record patterns), with one cell named for many rules. Each exception needs the maintainer's eye. |
| 919 | The `02-std-and-packaging` table stands; 95-a and 95-c overtaken, 95-b reversed, and std-c decided: a folder is not importable | An omnibus. std-c amends 110 (2) and 95-b changes manifest targets (512 (3), 770). Broad surface under one cell. |
| 943 | An atom holds any `T`; an island reading a non-encodable atom requires `#[clientOnly]` on the `val`, checked at build. | It widens 278's tag-annotation `#[clientOnly]` and 186's hook marker to a `val`. That is new surface, and its `HookUse` extension depends on B-17. |
| 945 | *(process)* The writer of a decision that retires a spelling rewrites its current-form lines and adds a `retired.md` row; no land-check check. | Stale wording: it names `land-check.py`, `specs/1.0.12-beta/**` and `specs/retired.md` paths. The tool is now TS and the specs live in specs-bot's flat tree. |
| 947 | 186's prerendered-page refusal goes; `#[page]` refuses misplaced `#[serverOnly]`/`#[clientOnly]` hooks, renders per request otherwise. | It amends 186 (still in-force, not superseded) and carries refusal behaviour with no cell named. |
| 951 | A `?T` is matched by `null` and `_`, the value read as `x!`; 54's binder arm refused `case-bare-name-arm`. | It amends 54, but 54 stays in-force and unsuperseded and still states the `v` binder arm as the rule. |
| 952 | Track 04's 21 rakun implementation choices stand under package names; 03r-a/e/r overtaken, seven amended, rest confirmed. | A very broad omnibus across caching, messaging, config, OAuth2, outbox and targets, with no cell. It overlaps 724, 762, 196, 299 and 318. |
| 954 | Track 06's nine rakun-stylesheet choices stand as Tailwind 4.3.2 output (350), held as literal text under 150 s52. | A code-bearing bundle with no cell named. It rests on the 350 test rather than a decision cell. |

## A — holds up

| Step | Rule (one line) | Reason |
|---|---|---|
| 814 | Opaque type: constructor and fields type-private; its non-`pub` methods module-private like any declaration; amends 811 (1). | Narrow; consistent with 811, 829, 830. |
| 821 | Call numbers count within the nearest `component` body, its lambdas included; a body's call stamps over a plain function's. | Kept and refined by 891 (1), which distinguishes body counts from plain-function counts. |
| 825 | std `run(c, scope: ?Scope = null)` makes and closes its own root unless handed one; `close` marks closed everywhere. | Amends 822 and 824 coherently; cell `root_closed_by_run` plausible. |
| 826 | `Composition`, `Composable` and `Component` are prelude names in `primitives.bp`; the checker reads them nominally. | Consistent with 606 (1), 815, 819. |
| 828 | Type-form refusal codes: `implement-component-not-composable`, `component-compose-unmarked`, `component-scope-field`, `component-compose-called`, `component-arg-is-component`. | Consistent with 815 (3) and 824's `Fill` exception. |
| 829 | `opaque` closes a record only: a contextual word before `type`; refused elsewhere with `opaque-not-record`. |  |
| 830 | Compiler lowering calls are known by a mark on the call node; a hand-written `__bp_` call is `reserved-name`. | Consistent with 814 (2); 885 reuses the mark for `Link(path)`. |
| 831 | A behavior's run-time identity is its declaration atom `<package>@<path>@@<B>`; no counter crosses a package. |  |
| 832 | A record field may hold an inline type; each occurrence is a private nominal type named `Bp__<Owner>__<field>`. | Widens the syntax (fields as well as parameters) but by the maintainer's explicit ruling; consistent with 831 (3) and 836. |
| 833 | A `compiler.load` file is checked for every target in the caller's manifest, never the build's `--target`. |  |
| 834 | *(process)* `--emit-resolved` writes one `.bp` per module under `<dir>/<pkg>/`, names as written and imports kept. | Tooling and output rule; consistent with 837. |
| 836 | Compiler-written twin names move into the reserved space (`__bp_<f>__type`, `Bp__<Enum>__<Section>`, `__bp_embed_<p>`). | `__embed_<p>` may be moot once 885 removes `@embed`; minor. |
| 837 | *(process)* One `.bpr` per package and per std module; only the root's file carries the program order and builds. |  |
| 838 | *(process)* A `.bpr` is built and run only from the directory of the project that wrote it; else `runtime-other-project`. | 885 rewords 838 (1)'s assets clause; nothing reversed. |
| 839 | `use context(ctx)` names a module-level context value only, never a parameter, local or expression. | Consistent with 722 and 723. |
| 840 | Call `compiler.meta(d, Entity)` or `compiler.metaAll(d, Index)` as declared; `compiler.meta<M>(d)` is no spelling. |  |
| 841 | A function with a `syntax` parameter may return any written `T`, `void` included, besides `anyvalue` or `anytype`. | Reads 719's "a type" broadly; consistent with 622 and 846. |
| 842 | A member a decorator adds and needs is held as a value, never read back through `decl`; behavior `decl` needs `implement`. | Consistent with 716 (1); retires 626 (2) as stated. |
| 843 | Answered by 606 (1), 639, 826 (3): a module may shadow compiler-ruled prelude names except literal types. | One-liner; no cell needed. |
| 845 | Answered by 583 and 408: `fn() { … }` without typed parameters is the untyped form, typed by position, writes no `->`. | One-liner. |
| 846 | Answered by 622: arrow-less `fn f(x: T) R` is no spelling, refused `fn-return-missing`. | One-liner; consistent with 841. |
| 847 | A `template` text starting `std:` is refused on every variant and target, naming `.Wasm(std: "…")`. | Consistent with 305 and 516. |
| 848 | `compiler.variants(d)` answers `compiler.Variant[]` entries with name, fields, annotations and dotted section. |  |
| 849 | `clock.formatIso8601` always writes `.sssZ` milliseconds on every target; `parseIso8601` reads both widths | Agrees with 497's domain, cell named. |
| 850 | Answered by 826, 629, 828: a `Component<T>` alias declares nothing; `implement Component<…>` refused; behaviour implemented by `R` |  |
| 851 | Overtaken by 804: `Renderable` gone; `#[client]` checks only that the return is a component | Status overtaken, supersededBy 804, consistent. |
| 854 | A backtick type name has no first letter, so a backtick type application before `.m()` parses as two comparisons | Narrows 561 and says so explicitly. |
| 855 | Overtaken by B-128: typed `AsyncIter` yields keys as they arrive; no `readKey`; `keys()` stays the one API | Small oddity: worded "Overtaken by" but status is in-force (a one-liner, no cell needed). |
| 857 | The `Children` walk cell is rewritten over `children: El[]` and moved under 804's module | Follows 804 (4). |
| 858 | Every exhaustiveness refusal carries the code `non-exhaustive` | Narrow, cell named. |
| 860 | *(process)* The lib-agnostic gate refuses `rakun` anywhere and `query` only as a package; `jhonstart` dropped |  |
| 861 | *(process)* Answered by 650: one Markdown relative-link form in every reference, markers rewritten by codemod |  |
| 863 | *(process)* The version set is one row per workspace package in `version_set.bp`; the name grep skips that file |  |
| 865 | `catch` is the lowest-precedence infix, below `or`; `??` stays the tightest binary operator | Corrects 537 (2) explicitly; consistent with 330 (4) and 595. |
| 867 | Answered by 607: `Asset` is std's `asset.bp`; `embed-open-needs-fs` and its cell leave with B-139 |  |
| 868 | *(process)* Refusal cells claim `from <file>:<line>:<column>` frame lines exactly; the header stays `botopink-cell 1` | Conformance-file format; amends 475 the way 485 did. |
| 869 | `comptime-badarith` names the dividing `binaryOp` exactly as written at its caret | Consistent with 532 and 868; 883 (8) restates it. |
| 870 | On commonJS the entry module installs the abort handler itself, before `main`; the runner's `--import` guard is dropped there |  |
| 872 | A required contract member the type already has is met by the type's own method and checked against the contract | Consistent with 799 and 800. |
| 874 | Answered by 553, 147, 819, 584: a `component` lambda's `throw` channel is its expected return's |  |
| 875 | Answered by 575 (6), 621: `Implementation` cells are checked as ordinary enum constructor calls |  |
| 876 | Answered by 823: erlang/beam `Async<T>` calls are settled; racing uses `raceOf`/`runAll` thunks |  |
| 877 | Answered by 547: an unannotated module `var` is one program-wide value (ETS on BEAM); the lag is a defect |  |
| 879 | `String.slice` becomes `fn:` bodies in `primitives.bp` counting codepoints; the index forms use the same bodies | Follows 585 and 320. |
| 880 | A `Bytes` leaf traps outside its domain: `bytes.at` uses bare `array.get_u`, `ofWords` is `unreachable` | No cell, but std-private (445) and covered by a unit test; plausible. |
| 881 | A std decorator imported as a leaf annotates by that name; `std-decorator-leaf-import` removed |  |
| 882 | *(process)* A library's test helpers live in its package's `testing/` module; no `-test` packages | Library layout rule; no cell needed. |
| 885 | A folded `Asset` prints `Asset(Link(path: …))`, folded bytes `bytes.fromHex("…")`; adds `bytes.fromHex` / `toHex`; no `@embed` remains | Fits the maintainer's note that `@embed` was removed and 607 (1). It adds std surface in `primitives.bp`. |
| 886 | A type's own non-`pub` method meets an extension block's contract only in its own module, else `method-not-pub` at the block | Narrows 872 (2) and keeps 859 (2). 894 relies on it. |
| 887 | Members added by `compiler.addMember` are `pub`; a primitive's property is written `pub val length: i32;` | Consistent with 859 and 842. |
| 890 | Two modules whose paths fold to one module atom are refused on every target, before any backend | Amends 853 (2) under 831 and 833. The cell is renamed to `module_atom_pair_refused`. |
| 891 | The renderer's child list runs child `i` with `Place.index(i)`; an index keeps a body's count and a key | Amends 884 (1) and (2). Consistent with 958 (`place-duplicate`) and 960 (`key-outside-body`). |
| 892 | *(process)* Retired forms stated as current in rows 751–879 are read as their replacements; no rule changes | Reading sweep, no cell needed. The replacement chains it names match 884, 885, 889, 890 and 891. |
| 894 | The `.d.ts` also declares non-`pub` methods that implement a behavior the type's own `implement` clause names | Amends 859 (4) to match 859 (2). It excludes members met only by an extension block, as 886 does. No cell, since the `.d.ts` runs nothing, which is plausible. |
| 895 | `_` is a lambda parameter that binds nothing, may repeat, and lowers as 888 (2)'s unnamed parameter | Lets the `{ _ -> v }` spelling written by 815, 817, 819 and 888 parse. The cell is named. |
| 896 | `close()` on a non-root `Scope` fails `scope-not-root` at run time; a second `close()` on a closed root is a no-op | Narrows 824 (2) and 825 (2). Consistent with 897. |
| 899 | On commonJS a call into another module's bodied generic fn passes the print shapes, judged by the callee's signature alone | Settles B-115 box 2 under 673. The cache stays sound per 509 (2). |
| 900 | On commonJS a generic type's value carries its type arguments' print shapes (`__bp_s`), copied by the methods that answer a new value | Settles B-115 box 3 and is consistent with 899 and 673. It touches every std generic constructor. |
| 901 | The first SIGINT during a comptime body interrupts it (exit 130); a second SIGINT, or one with no body running, ends the process | Confirms what was built, under 878. A unit test, not a cell, is plausible for CLI signal handling. |
| 902 | `--emit-resolved`'s origin comments are `// from <template>`, `// from comptime`, `// from comptime { … }` with file:line | Confirms 798 (2)'s shape. The oracle is unit tests, so no cell. |
| 904 | A refused package's `.snap` lists its `build` lines first, then the refusal records; a `build` after `refused` is malformed | Amends 789 (1)'s order list to match its clause. The cell is named. |
| 905 | The refusal code for a module `var` holding an `Async` is `module-var-holds-async`, with its reach as built | A rename away from the retired `@Task` wording (547 (iii), 553). |
| 906 | `io.process.start(…, env: string[])` takes `NAME=value` entries, exists on commonJS only, and a call is refused on other targets | Applies 518 (4) and 67. It changes `target_check` so a `declare fn` with no cell for a target is emitted unreachable, which is wider than this one function. |
| 908 | *(process)* Seven cells that use an outside `render(c, scope)` helper are rewritten to resolve children inside the providing body, keeping their answers | A cell-maintenance rule; its id says process although its process flag is false. Consistent with 817 (5), 891 and 888. |
| 909 | A `compiler.variants` section wrapper has one field `value` and `section` (null at top level); entries in source order | Confirms 848 (3) as built. The cell is named. |
| 910 | Overtaken by 576 and 840: hooks-list declarations are opaque handles whose meta is read typed | One-liner marked overtaken by 576, so no cell is needed. |
| 913 | `unicode_tables` stays a flat private sibling until B-75, then moves to `src/internal/`; importing std's `internal/` is refused | Consistent with 592 (8) and 703. The refusal depends on B-69. |
| 914 | Over an array `query` has one public spelling, the template grammar; `Query<T>`'s LINQ methods become private lowering targets | A library-API decision within the delegated scope (170, 283). The cell is named. |
| 915 | Malformed, non-UTF-8 or control-character query components and cookie chunks are refused; cookies answer the chunk as absent | `03r-e` lapses and `std-a` stands. The cell is in `http`. |
| 916 | `rakun-ssr` content gains `toElementWith(doc, render)`; the page's function maps each `MdNode` to a `NodeChild`, or `null` for the default | Typed by 804 and 809 (7). Keeps `markdown` free of framework names (396 (3)). |
| 917 | *(process)* The OTP release renderers are one `rakun` workspace package, `rakun-release`; no `release` repository is born | Amends 326's example and 187's fold of `rakun-release` into `rakun-cli`, under 724. Process, no cell needed. |
| 920 | Library tests refused for a missing host binding carry id `host-binding-missing`; the audit matches ids, never text. |  |
| 921 | `log`'s `fileSink` answers `Error` of log's enum on a failed host call, never raises; `consoleSink` prints through `terminal.print`. |  |
| 922 | compiler-core snapshot tests lose their runtime-output cache; every `erl`/`node` run reruns; interrupted runs never recorded. | The cell name `bugs_sweep_choices_confirmed` is generic for a bundle of four choices. |
| 923 | *(process)* Locale routing lives in `rakun-app/src/i18n.bp`; no `rakun-i18n` member; BCP 47 subset is `i18n`'s. |  |
| 924 | `notFound()`/`redirect(url)` answer a `Component<Element>` node `NavSignal(outcome: NavOutcome)` the renderer reads; no raise, no `noreturn`. | Wide surface (rakun-bpp, rakun-app, routing), but it is consistent with 527 (5), 554 and 929. 953 (3) contradicts it. |
| 925 | Component lifecycle via `Startable` (rakun) and `Closeable` (std) behaviors tested with `is`; `#[postConstruct]`/`#[preDestroy]` go. |  |
| 926 | A declaration answering `Component<R>` named `use[A-Z]…` is refused `hook-name-use-prefix`; write `use actionState(createPost, initial)`. |  |
| 927 | `rakun-ssr.json`'s six keys read at build into typed `SsrConfig`; unknown or ill-typed keys refused naming the path. |  |
| 928 | Browser-visible env values are `#[publicEnv] pub val x = env.read("…")`; the `RAKUN_SSR_PUBLIC_` prefix goes. | 955 (7) still says public-env entries carry `RAKUN_SSR_PUBLIC_`. |
| 929 | `noreturn` is the bottom type; a `-> noreturn` body that can complete is refused `noreturn-falls-through`. |  |
| 930 | Overtaken by 804: `NodeChild = Component<Element>`, no coercion; boundary `child` fields become `Component<Element>`. |  |
| 931 | No module-graph reflection; handles answer declarations only; rakun-ssr bundler keeps `importsOf` textual scan. | No cell, but the row states an absence (a gap closed by design), so none is needed. |
| 932 | *(process)* A new package needs two or more consuming libraries (115); in-library duplicates go to std or that library's core. |  |
| 933 | `rakun-data` `#[documentRepository]` behavior with `#[documentQuery]` template annotations; `${name}` holes bound to parameters. |  |
| 934 | 150 s17 ships ets, mnesia, redis, https arms; other NoSQL schemes refuse boot naming the driver; HTTP via `rkRegisterHttpClient`. |  |
| 935 | *(process)* The seven unbuilt rakun example projects are retired; every `rakun/examples/` directory carries a README. |  |
| 936 | `release_test.bp` validates the SBOM against the checked-in CycloneDX 1.5 schema using 399's vendored ajv validator, test-only. |  |
| 937 | The outbox relay publishes through `withProducerTransaction` on the in-process broker; the real-broker run is a deferred row. |  |
| 938 | Broker and scheduler doubles live in `rakun`'s `testing/`, reaching registries only via core hooks, importing no member. |  |
| 939 | Core declares `enum Transport { Tcp, Tls, WebSocket }` and `rkRegisterTransport`; rakun-websocket registers `.WebSocket`. |  |
| 940 | `fake_dom.mjs` gains form, input, FormData and submit; DOM-side forms boxes asserted in `forms_dom_test.bp`. |  |
| 941 | `Json` gains `isString()` beside `isObject`, in std `json.bp` until 151 s1 moves it; rakun-ssr drops its own. |  |
| 942 | A malformed integer in og metrics or a gradient angle is refused with an `Error`, never read as `0`. |  |
| 944 | *(process)* No atom effects in cardume's first cut; `persistLocal`/`syncSearchParam` later, keyed by declaration, never a string. |  |
| 946 | *(process)* A bundled package may not export a name std or a framework exports; standing rule, aliases only for programs. |  |
| 948 | *(process)* A comments-only carve-out is the owning step's; org-3 sequences nothing; amends 189's org-3. |  |
| 949 | 337 (2),(3) overtaken by 592 (1): no `mod`/`pub mod`; 337 keeps `shorthand-import` refusal and its migration. |  |
