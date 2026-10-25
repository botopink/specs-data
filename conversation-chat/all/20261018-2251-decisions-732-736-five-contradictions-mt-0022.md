---
from: maintainer
to: all
purpose: rule
subject: Decisions 732–736 — five of the seven contradictions settled (Async<T>; no library "entry"; compiler.src() in a decorator; rule == null; cardume's Atom<T> | type<T>); ctr-aa and ctr-ae still open
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to:
---

The maintainer answered five of the seven contradictions of mt-0021, each (a). Read the rows in your generated
`decisions-taken.md` (meta 81815a422); the subject file carries the same sentences.

- **732 (ctr-ab).** `Async<T>` is the one name of an `async` body's return type; `Task` is no name of the prelude.
  606 (1)'s `Task<User>` and 623's `fetch(req) -> Task<Result<Response, HttpError>>` read `Async<…>`. Machine 2:
  B-137's codemod and `io/http`'s `fetch` (623) carry the spelling.
- **733 (ctr-ad).** A library has no `"entry"`: the key is an executable's alone, and in a manifest with no `main` it is
  refused, `manifest-entry-in-library`, located at the key. 677 keeps its root-package rule and loses its `root.bp`
  clause. Machine 1: the 660 + 676 + 677 thread (mt-0019 told it to build nothing on the `"entry"` sentence) now
  builds this — cell `library_manifest_entry_refused` (reject); 165 s5 checks every library manifest.
- **734 (ctr-z).** `compiler.src()` in a decorator body is legal and answers the annotated declaration's location (718,
  575 (3)) — a value an output may carry (a diagnostic, a snapshot, a meta); never a route: 403 survives as "no route
  from a file's location". `decl.loc` stays absent. Machine 1, B-17: cell `decorator_compiler_src_is_declaration_location`.
- **735 (ctr-y).** An optional function-typed `comptime` argument is tested against `null` as any `?T` is —
  `if (rule == null) { … }`. 411 is overtaken (`expr-value-of-function` gone); its cell
  `no_null_test_of_optional_fn_expr` is replaced by `comptime_optional_fn_tested_against_null`. Machine 1: B-17, and
  146 s7's `check` reads `rule == null` to tell its two forms apart.
- **736 (ctr-ac).** 297 in 575 (5)'s spelling: `comptime source: Atom<T> | type<T>`, the body testing
  `source is type<T>`. One function, one name, two forms. Machine 1: 136 (every hook), B-17 (`type<T>` inside a
  `comptime` parameter's union); cell `comptime_value_or_type_union`.

**Still open with the maintainer** (build on neither side): ctr-aa (a component's props — plain parameters or one
record, 529 vs 593 (2)) and ctr-ae (`Pair<A, B>` / `Function`: the maintainer asks whether a pair type is needed at
all, a pair being the tuple `#(A, B)`). Also open: 667-a (machine 1's B-146 box 3 stays held) and 660-a.

**Read: m2-0013, m1-0003, m2-0014.** Machine 2's two snap points are front 160's (machine 1), and neither is a new row:
`import {snap} from "snap"` binds a module named `snap` — 592 (1), a module's name is its path — so 160's step that
gives snap its `matches` writes it in `src/snap.bp`; 563's `throw` in a catch lambda is 595's handler form, a
departure until machine 2's queue row 11 lands, as m2-0014 says. Machine 1: rakun's codemods wait only on machine 2's
routing / snap / css codemods, which m2-0013 reports landed on `feat` — rebase and commit through rakun's hook.
