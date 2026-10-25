---
from: maintainer
to: machine-2
purpose: answer
subject: B-157 P3 — 774 and 777 now carry Cell slugs (no --allow-unslugged needed), 776 is process; removing the nine rows' drafts is right (761, 765); 606's case went flat again (machine 1); the reds machine 1 named for you
read: [x]
in-reply-to: machine-2/20261019-0805-library-gates-json-question-m2-0024.md
---

Read your P3 stop report (through the maintainer). The stop was right, and your reading of 761 + 765 is the one in force. Landed at meta 36031600b (gate green; your generated ledger follows):

- **Slugs.** The three rows 166 s3 met unslugged were my slip. Now: **774** `stage_beam_memory_compiler_members`, **777** `index_out_of_bounds_reads_null`; **776** is `· (process)` (no directory). Rerun `plan` without `--allow-unslugged` — every code-bearing row has a slug again. If the apply already scaffolded 774 / 777 under another name, rename to these.
- **The nine rows with real cells (660, 668, 669, 676, 722, 723, 735, 757, 758).** Confirmed: the draft of each goes out in the same commit, its `docs.md` stays and links the cases, and a draft paragraph no case states is kept. 765 never lets `draft/` and `cases/` share a directory. Machine 1 said (m1-0006) `comptime_optional_fn_tested_against_null` shares 735's draft slug: rehome the flat cell as 735's case and drop that draft, one choice.
- **606.** Machine 1 had put `print_local_shadows_import` under `decisions-taken/prelude_is_primitives-606/cases/` with a `docs.md` that had no `.bp` include; check 7 went red on feat. Machine 1 moved it flat again (botopink-lang 9d2e3659f, "until front 166 homes decision 606"). Your `apply` homes it; the module `docs.md` needs the `[…/src/main.bp](…/src/main.bp)` include like every other.
- **The feat your rebase meets.** botopink-lang 9d2e3659f and after: 660 / context (722, 723), 735, 736, 756, 757 / 758 / 667 / 668, 669, rakun's gap 2, B-137's 759 rename. Every new cell is flat in `conformance/modules/<cell>/`; m1-0006 lists the slugs.
- **Reds named to you by machine 1 (768):** (1) `zig build test-libs --lib std` is red on feat — `libs/std/test/primitives_test.bp:8` `import {compiler} from "std"` and `import {io.terminal.print} from "std"` in another test are refused `module-import-with-from`; (2) `decorator_call_expr_fn` was deleted by 735 (its expected answer was the removed `expr-value-of-function`) — confirm nothing else proved what it proved, or write the successor; (3) your own `tsc-check.sh` red on `std/compiler.d.ts`: confirm on the base as you said, and if it predates P3, file it to machine 1 as a 144 row, not in the P3 commit.
- **Rakun drafts.** Parts 2 and 3 are on rakun's feat (7c2f75f6, 48ebb00e); part 1 is the one still running per your report.

Your answer to m2-0024 is **778** (`json_quote_unquote_array_object`), already in mt-0050. Nothing of yours waits on the maintainer.
