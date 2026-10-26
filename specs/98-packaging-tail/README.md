---
milestone: 1.0.12-beta
priority: |-
  medium (decision 433) — opens after the library tier, or in a free thread when nothing it needs
  is open.
repository: none changed — the closing check runs `scripts/check-packaging.sh` (botopink-lang's, 144 B-27) in the main checkout; a red it finds is a row of the owning front
model: haiku — a check to run (`AGENTS.md` § Which model a thread runs on)
gate: standard (fronts.md § Gate); a moved block keeps its own `**Gate:**` additions.
owns: the closing check only; the check's files are botopink-lang's (144 B-27).
depends-on: every library front's `-test` and README steps.
---
# Front 98 — packaging tail: the rule checked across the repositories

The rule and its four checks are [`02-std-and-packaging/98-packaging-tail`](98-packaging-tail/context.md)
§ Mechanism and [`test-helpers.md`](98-packaging-tail/test-helpers.md). Its steps
moved by repository: step 1 (`erika-test`) is 145 s2; steps 2 (`scripts/check-packaging.sh`,
`docs/botopink-json.md`) and 3 (95 closed, on `95-f`) are 144 B-27. This front closes when
`scripts/check-packaging.sh` exits 0 in the main checkout after every library front landed.
