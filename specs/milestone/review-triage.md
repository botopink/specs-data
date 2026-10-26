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
