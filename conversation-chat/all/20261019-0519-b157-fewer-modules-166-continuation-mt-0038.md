---
from: maintainer
to: all
purpose: rule
subject: Decisions 760, 761 — step B-157 (machine 2): conformance/modules consolidated into fewer modules as front 166's continuation, `decisions-taken/<slug>-<N>/` the home, nothing tested lost; a fable plan now, the pieces after the group's codemods
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: machine-2/20261019-0558-decision-759-b137k-mt-0037.md
---

The maintainer (2026-10-19): "a máquina 2 pode criar uma task para unificar `conformance/modules` em menos módulos sem perder o que
está sendo testado" — and, on front 166: "crie uma seção `/decisions-taken/`"; "tome cuidado para não perder nada". Recorded as 760
and 761 (meta e5396341f and after), step **B-157** on machine 2's queue (row 21; its section at the end of
`144-backends-tooling/README.md`; 166's README s2/s3 boxes updated):

- **Measured:** 1,650 cells (`decorator_*` 108, `external_*` 70, `template_*` 62, `comptime_*` 56, `std_*` 48, `import_*` 46,
  `case_*` 46, …), 79 `test/` suites, 801 reference links; 166: s1–s2 done, 67 drafts in nine libraries, none promoted;
  botopink-lang 509 code-bearing rows and zero cells.
- **The home is 166's tree:** `conformance/modules/decisions-taken/<slug>-<N>/`, each decision's directory holding the cells that
  prove it as its cases — an existing cell moves under the decision its `Cell` column names, a cell proving several sits under one
  and is linked from the others' `docs.md`, a cell proving no decision stays outside, grouped by subject. One directory per decision
  stays check 7's contract (647); a directory grows compilation units (`cases`), each with its own snapshot — a refusal, an abort
  or a narrowed-`"targets"` cell is never merged into another program's run.
- **Nothing is lost:** the old → new mapping is generated and rewrites every reference; counts of assertions, snapshots and
  departures equal before and after; the suite green before and after with identical expected texts; **every one of botopink-lang's
  509 code-bearing rows listed with its cell — mapped, or a draft where no cell proves it — none left without one.** Rows 1–143
  (folded yesterday, 107 without a slug) get their `Cell` slug or `process` tag from the coordinator first.
- **Order:** the plan now — a `fable` `Plan` thread (742): the module format `cell check` / `cell new` / `cell_snap.zig` must learn,
  the grouping, the mapping, the proof, the pieces with their oracles; its open points as questions, its format as a decision
  before the pieces build. The pieces (`sonnet`) **after B-116 (ii), B-139's rest and B-148 have landed** — their codemods
  rewrite the same 1,650 files.

**Machine 1:** keep writing cells where your steps say; they move with the mapping. **Machine 2:** open the plan thread in a free
slot now; nothing else of B-157 before the codemods land.
