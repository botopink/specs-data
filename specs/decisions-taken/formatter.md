---
scope: >-
  How `botopink format` lays code out and when it runs: the canonical layout (lambda bodies, method
  chains, width measured per group, the trailing comma as the one input a list's shape reads), the
  `--migrate 541` rewrite and backtick names. The formatter is applied by the commit hook and the LSP,
  never a gate check; what the parser or the checker refuses is each construct's own group; the hook
  and the gate stages are gate-and-ci.
terms:
  - '`botopink format`'
  - '`--migrate 541`'
  - '`format --check`'
  - 'trailing comma'
  - 'canonical form'
  - 'method chain'
  - 'trailing lambda'
  - '`Doc.widthChoice`'
  - '`fits`'
  - '`LINE_WIDTH`'
  - '`arrow_when_empty`'
  - '`fmtLambdaAt`'
  - '`format.zig`'
  - 'backtick name'
  - 'reformat commit'
related:
  - 'gate-and-ci'
  - 'functions-lambdas-and-blocks'
  - 'library-split'
  - 'process-and-ownership'
open:
  - '61: rule 3 (a parameterless lambda on one line) stops at `arrow_when_empty`, for the parse-error reason recorded in decisions-pending.md'
  - '672: `botopink format --migrate 541` leaves through a B-27 box once every repository under `repository/` and every open branch is migrated'
binds:
  - '`1-botopink-lang/144` B-21'
  - '`16-formatter` steps 4, 6'
  - '`machine-1/144` B-27'
  - '00-gate/112'
  - '16-formatter step 5'
  - '16-formatter step 6'
  - 'process'
retired: []
first-step: 61
last-step: 687
in-force: 11
superseded: 0
---
# formatter — `botopink format` applies the canonical form

**`botopink format` is applied, never checked: the commit hook formats the commit's `.bp` files, the LSP formats on save, and the formatter never fails a gate.**

(1) The four canonical-layout rules; width measured per group, all-or-nothing; chains — 61, 65.

(2) The trailing comma alone decides a delimited list's shape — 133, 166, 243, 345.

(3) A trailing lambda on one line — 165.

(4) `case` arm tails; the `--migrate 541` rewrite — 588, 672.

(5) Backtick names plain; `format --check`'s structural exemption — 687, 155.

(6) Rewrites the formatter carries that other groups' rows decide: the applier and the hook (524), block tails (409, 525, 541), marker order (572, 584), `..` (529, 864), annotations and templates (286, 311).

Steps: 61, 65, 133, 155, 165, 166, 243, 286, 311, 345, 409, 524, 525, 529, 541, 572, 584, 588, 672, 687, 864
Binds: 00-gate/112 · 16-formatter step 5 · 16-formatter step 6 · `01-compiler/16-formatter` step 9 · 118 (the template grammar) · `16-formatter` steps 4, 6 · the libraries' reformat · `01-checker` step 38 · `16-formatter` step 11 · `docs.md` § Functions, § Lambdas · `1-botopink-lang/144` B-28 · `2-libraries/154` · `2-libraries/149` · `2-libraries/162` · 66 · `1-botopink-lang/144` · 192 · 199 · 207 · 213 · 359 · `1-botopink-lang/144` B-116 · `1-botopink-lang/144` B-116 (machine 2) · `1-botopink-lang/144` B-21 · the formatter · `machine-1/144` B-27 · process

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 61 | 1.0.5-beta · (the maintainer, 2026-09-18) | **The formatter's canonical layout — four rules, the conventional form in each.** 1. A lambda argument's body indents +4 from the call line and its closing `});` aligns with the call. 2. A lambda with an empty body stays inline (`{ next -> }`), never three lines with a blank middle. 3. The one-line rule covers a parameterless lambda: `{ -> 3 + 4 }` stays inline as `{ n -> n * 2 }` does (`fmtLambdaAt` tests the no-parameter case); it stops at `arrow_when_empty`, for the parse-error reason in `decisions-pending.md`. 4. A `fn` signature that does not fit `LINE_WIDTH = 80` breaks one parameter per line with a trailing comma, closing on its own line: `fn aVeryLongFunctionName( · firstParameter: i32, · secondParameter: string, · thirdParameter: bool, · ) -> string {`; that shape already parses (`botopink check` accepts it, trailing comma included), so rule 4 is printer-only — no parser work, no grammar decision. Rule 4 lands as a `Doc.widthChoice` whose flat width is measured at build time against the real column: the trailing ` {` or `;` counts and the boundary is exact at 80/81 (a method four columns in breaks four columns earlier), because `fits` stops at the first `concat` and answers "fits" for any non-negative budget, so every `group` renders flat; teaching `fits` to measure through `concat`/`nest`/`group` is a canonical-form choice per construct and the maintainer's (question 65). Rules 2 and 3 are corrections moving nothing committed; rules 1 and 4 change committed files, so front 09 reformats the five libraries in one commit, now. | step 6 of `16-formatter`, then one reformat commit in `09-ecosystem-residuals` |  formatter_canonical_layout_four_rules |
| 65 | 1.0.5-beta · (the maintainer, 2026-09-19) | **The formatter measures width — all-or-nothing per group, one construct at a time.** (1) All-or-nothing per group: a group fits on one line, or every element takes its own; there is no middle (`pessoa.correr().andar().ver();` stays one line; `return of(people) · .where({ p -> p.age >= 18 }) · .orderBy({ p -> p.name }) · .select({ p -> p.name }) · .toArray() · .join(", ");` when it does not fit). (2) Formatting is a pure function of the file's content: the output never depends on what the file used to look like; join-or-preserve is join (a hand-broken chain that fits becomes one line), and no "preserve what the author wrote" heuristic exists for any construct, permanently — the formatter's form of 67. (3) A chain's continuation indents `+4` from the statement, never aligned under the receiver (an identifier's width is never layout). (4) The staging, one construct at a time: the `fits` predicate is fixed first (it stops at the first `concat` and answers "fits" for any non-negative budget, so every `group` always rendered flat and no construct ever broke by width; 61's rule 4 routed around it with `Doc.widthChoice`, and `libs/std/src/querystring.bp:38` was joined back to 95 columns), with every `group` pinned flat so the commit changes no file; each construct is enabled afterwards, its canonical form written down before it is turned on — in the formatter's code and `docs.md`, never in history; the method chain goes first; the reformat after each enabled construct is front 09's, measured per tree before it is applied. Comments and long strings stay long: no width rule breaks them. |  | |
| 133 | 16-c · (the maintainer, 2026-09-26) | **A trailing comma keeps a list in its open form** (option (a)). An array, tuple, argument, record field or enum list written with a trailing comma prints open — one element per line — even when it fits: the comma is the author's explicit request; a list without the comma is laid out by width alone (65 (2)); the open form always ends with the comma, so the output is stable. `val p = Point(x: 1, y: 2,);` prints `val p = Point( · x: 1, · y: 2, · );`. Amends 65 (2): the trailing comma is the one input the canonical form reads. `format.zig` does this already. |  | |
| 155 | gate-c | `format --check` leaves out a `.bp` under `modules/<cell>/` that one of the cell's `.expect` files names and that does not lex or parse, as it leaves out `reject/` — a structural exemption, never a list (no object since 524) | 00-gate/112 | format_check_skips_unparsable_cell_sources |
| 165 | 16-c | A trailing lambda whose body is one expression prints on one line when it fits, arrow or not (`h1 { "my blog" }`); its own commit after measuring the six trees | 16-formatter step 5 | trailing_lambda_one_line |
| 166 | 16-d | The trailing comma decides: a list written with a comma after its last element prints one element per line and keeps the comma; written without one it stays on one line, whatever its width — no width rule opens a list (345). Scope: 243 | 16-formatter step 6 | trailing_comma_decides_list_shape |
| 243 | 16-d (scope) | 166 reaches every delimited list — generics, parameters, patterns, imports, types, arrays, record fields, enum bodies, call arguments and tuples; a one-step pipeline has no comma and stays horizontal; without the comma the list stays on one line (345) | 16-formatter step 6 | trailing_comma_every_delimited_list |
| 345 | ctr-s · 16-a · 16-b | **The trailing comma alone decides a delimited list's shape — 166 as written.** A list of any kind 243 names, written with a comma after its last element, prints one element per line and keeps the comma; written without one, it prints on one line whatever its width, and a list written open without that comma is joined onto one line. No width rule opens a list: 16-b's open array is dropped, and 16-a's measurement leaves the argument list and the array / tuple literals, keeping only constructs that are not comma-delimited lists (a binary run, a brace-less `if`) | `16-formatter` steps 4, 6 · the libraries' reformat | trailing_comma_alone_no_width_rule |
| 588 | B-21-c · (the maintainer, 2026-10-14) | 525 and 525-a (3): the formatter removes, once, the last `;` of a `case` arm used as a value and the arm's `break <value>`, making the arm's tail its value; elsewhere it prints a block's last expression as written (409's formatter rule) | `1-botopink-lang/144` B-21 · the formatter | formatter_removes_case_arm_break |
| 672 | 541-a · (process, the coordinator †, 2026-10-18) | **541's lambda-`;` rewrite stays in the formatter as `botopink format --migrate 541`, explicit, until every repository under `repository/` and every open branch is migrated** (a). `--migrate 541` removes, once, the `;` of every lambda's last expression statement and nothing else; a landing's rebase across the rule runs it first (the coordinator, `fronts.md` § Order); a B-27 box removes it once `scripts/decisions-split.py`'s repositories and the branches `git worktree list` shows are all migrated, the removal stated. (A branch rebased past the rule without it gets the silent `void` 541 prevents, and `feat`'s formatter cannot repair it.) | `machine-1/144` B-27 · process | |
| 687 | B-27-d · (confirmed as built, the maintainer's batch, 2026-10-18) | **`botopink format` writes a backtick name that is already an identifier as the plain name (`` `count` `` → `count`); backticks stay only where the name needs them** — one spelling for one name (a), as built (561). | `machine-1/144` B-27 | format_backtick_identifier_plain |
