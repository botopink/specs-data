---
scope: >-
  The `.bpp` file format — header, separator, style section, markup — and how the toolchain unfolds it
  onto the `#[bpp.html]` default function of the package `"bpp"` names, the four `bpp` roles std
  declares, and the `#[bpp.htmlPrelude]` prelude. What the markup means and the render library's types
  are markup-and-rakun-bpp; file roles and routes are pages-routing-and-stages.
terms:
  - '`.bpp`'
  - '`#[bpp.html]`'
  - '`#[bpp.htmlPrelude]`'
  - '`#[bpp.style]`'
  - '`#[bpp.stylePrelude]`'
  - '`"bpp"`'
  - '`--- style ---`'
  - '`type Props`'
  - '`pub default fn`'
  - '`botopink prelude`'
  - '`rakun-bpp`'
  - '`libs/std/src/bpp.bp`'
  - 'header'
  - 'prelude'
  - 'unfold'
related:
  - 'markup-and-rakun-bpp'
  - 'pages-routing-and-stages'
  - 'templates'
  - 'module-system'
  - 'decorators'
binds:
  - '`04-rakun/22` step 7'
  - '`05-jhonstart/26` step 10'
  - '`1-botopink-lang/144` B-27'
  - '`machine-1/144` B-27'
  - '01-compiler'
  - '05-jhonstart'
  - '08-bpp/116'
retired:
  - '`"bppKinds"`; a decorator applied by file name'
  - 'A `.bpp` header opened by a first-line `---`'
  - '`#[bpp.html]` / `#[bpp.htmlPrelude]` bound to `jhonstart` (`"bpp": "jhonstart"`, `from "jhonstart"`)'
  - 'a prelude module declaring one `#[bpp.htmlPrelude]` marker `val` (270''s shape)'
first-step: 198
last-step: 709
in-force: 10
superseded: 0
---
# bpp-files — the `.bpp` format, its unfold and its prelude

**A `.bpp` file is another spelling of a `.bp` module, unfolded by the toolchain onto the `#[bpp.html]` default function of the package `"bpp"` names; the toolchain knows the four `bpp` roles and nothing else.**

(1) The format — header on the first line, separator, style section, decorator: 212, 552, 221; the unfold to a function and its return: 198, 199, 275.

(2) The roles — std's `bpp` annotations, the one package, checked on every command: 200, 285, 709.

(3) The prelude — last scope, nothing unused imported, the header wins: 270 (amended by 589).

Steps: 198, 199, 200, 212, 213, 221, 270, 275, 285, 289, 338, 361, 529, 552, 561, 589, 604, 709, 724
Binds: 116 · 116 step 2 · 118 · 120 · 05-jhonstart · 08-bpp/116 · 117 · 01-compiler · 118 step 6 · 117 step 1 · `04-rakun/22` step 7 · `05-jhonstart/26` step 10 · `01-compiler/01-checker` step 25 · `08-bpp/116` step 1 (with `libs/std/src/bpp.bp`, a carve-out of `02-std-and-packaging`) · 119 steps 2–5 (in the core) · `05-jhonstart/26` · `07-onze` (imports `jhonstart` only) · 124 (the scaffold's manifest) · `1-botopink-lang/144` B-27 · `1-botopink-lang/144/machine-1-checker/116-bpp-file-format` step 2 · `1-botopink-lang/144` B-69 · `machine-1/144` B-27

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 198 | 08-a · 08-i | A `.bpp` is another spelling of a `.bp` module, unfolded onto the `#[bpp.html]` template function of the one package `botopink.json` names, `"bpp": "rakun-bpp"` (361); the toolchain names no library. The header (212) is ordinary botopink copied as written (`import {components.card};`, `val`, `type`, `pub`); the markup is the literal handed to the default function; the module's anonymous `pub default fn` is the result (213, 289); no `template.emit` / `template.slice`; a diagnostic inside the markup lands on the `.bpp` line | 116 | bpp_file_unfolds_to_default_fn |
| 199 | 08-a2 | `type Props(…)` in the header is the convention; a `.bpp` unfolds to a function, never a `pub val`: with `type Props(title: string)`, `card.bpp` is `pub default component fn (..props: Props) -> View` (529 (5), 731 (10)); with none, `pub default fn () -> View` (213, 275). Header declarations (`import`, `type`, `pub`) stay at module level; its statements (`val`, `use`) become the function's body ahead of `` return <default> @`…`; ``, so they may read `props` and call a hook. A caller's attributes are `Props`'s fields (192); content arrives through slots (`<Slot />`, 193, 360) | 116 step 2 · 118 · 120 | bpp_unfolds_to_function_with_props |
| 200 | 08-a3 | `html` is `rakun-bpp`'s `pub default fn` (jhonstart's core, renamed by 724), carrying `#[bpp.html]` (361) — `import html, {Element, renderToString} from "rakun-bpp";`; `jhonstart-html` is deleted (187's criterion), its dependants importing from the core; a manifest reads `"bpp": "rakun-bpp"` | 05-jhonstart · 08-bpp/116 | html_default_fn_of_jhonstart |
| 212 | bpp-a | The header starts on the first line, with no opening `---`, and ends at the first separator — `---` (the markup follows, to the end of the file) or `--- style ---` (338's style section, closed by `---`, then the markup); no separator: markup only; a first line `---` is an error at the line, `error: the header starts on the first line; a .bpp has no opening ---` | 116 | bpp_header_on_first_line |
| 221 | bpp-c | A `.bpp`'s decorator is written in the header, on the line just before the separator, annotating the unfolded function — ordinary header code; no decorator comes from a file's name (285) | 116 step 2 · 117 | bpp_decorator_in_header |
| 270 | bpp-e | The package `"bpp"` names (361) may have a prelude (270's prelude module — one `#[bpp.htmlPrelude]` marker `val`, `#[bpp.stylePrelude]` for the style section, its only declaration besides imports, every `.bpp` importing what it imports — is amended by 589: marked items where they are declared); no manifest key names or overrides it; with none a `.bpp` imports the default function only. Nothing unused is imported: the prelude is the module's last scope, consulted only for a name the file does not bind; an item becomes an import only when a name of the file — a header expression or a tag the default function looks up — resolves through it, the emitted code importing the same (`<article></article>` → `import {elements.article} from "rakun-bpp";` and nothing else); the scope is generic, a list of import items handed to `compiler-core` with the module, naming no library. Refused at the prelude module's line: anything but an `import` and its marker `val`; an item of another package (242); an activation (`X*`); an alias is allowed. The header wins by scope order: a name it declares or imports never reaches the prelude; a tag resolving to a header declaration that is not a builder fails at the tag, naming the header line. Adding a prelude name breaks no application; removing one fails at each use. A markup-only `.bpp` compiles | 116 · 118 · 01-compiler | bpp_prelude_module |
| 275 | bpp-f · ctr-e | The unfolded function returns the `R` of the default function's declared return, read from that signature (no library's type spelt, 113, 198): rakun-bpp's `html` declares `-> View` (`View` = `Component<Element>`, 276), so every `.bpp` — and every `.bp` returning `` html @`…` `` — returns `View`, `use` or `await` in the header or not; no `.bp` returns a template as a plain `Element` | 116 step 2 · 118 step 6 | bpp_returns_default_fn_result |
| 285 | nat-f1 | The toolchain knows about `.bpp` only the package `"bpp"` names and the declarations `bpp`'s four annotations mark in it (361): the markup's unfold target (`html`, 198, 200, 275), the style section's (338), their preludes (270). A file's role (page, layout, template, loading, error, not-found) is the framework's: the route table `rakun-app` generates at build from `routing`'s file kinds (102, 171) calls `page` / `layout` / … as comptime functions on each unfolded default function (`page("blog/[slug]", f)`, reading `f`'s hooks, 277); no decorator by file name; `"bppKinds"` is gone | 116 step 2 · 117 step 1 · `04-rakun/22` step 7 · `05-jhonstart/26` step 10 | toolchain_knows_bpp_roles_only |
| 552 | B-27-a | The header reads top to bottom as written: declarations (`import`, `type`, `fn`, `pub`) first, statements (`val`, `use`) after (199, 212); a declaration below a statement is a located refusal at the declaration, naming the statement before it (`val n = props.count; fn label() -> string { … }` is refused at `fn label`, naming `val n`); the unfold never moves a declaration, so a `.bpp` never runs in an order or a scope other than the one it shows | `1-botopink-lang/144` B-27 | bpp_declaration_after_statement_refused |
| 709 | 116-b · (confirmed as built, the maintainer's batch, 2026-10-18) | The `bpp` roles are checked whenever the manifest's key is present, `.bpp` file or not, on every `build` / `check` / `run` / `test`; a key that cannot be honoured is refused where it is written (361 (4), 338, 67; `compiler-cli/src/cli/bpp.zig`) | `machine-1/144` B-27 | bpp_roles_checked_without_bpp_file |
