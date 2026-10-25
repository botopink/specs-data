---
from: maintainer
to: all
purpose: rule
subject: `@Result` is not used any more (the maintainer): rakun's 872 code sites are machine 1's staged codemod; botopink-lang and validation keep it only in comments and test names — the codemod rewrites those too; the spec tree WILL be swept
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261019-0030-old-spellings-external-result-task-mt-0025.md
---

The maintainer (2026-10-19): "`@Result` não é mais usado." Measured on `feat` (`grep -rhoE '@(Result|Task|Option|Component|Iterator|Stream)\b'` over `.bp` / `.bpp`):

| repository | total | in code (not a `//` line, not a `test "…"` name) |
|---|---|---|
| rakun | 1141 (`@Task` 454, `@Result` 393, `@Component` 294) | 872 |
| botopink-lang | 479 (`@Result` 243, `@Task` 110, `@Component` 60, `@Iterator` 43, `@Stream` 21, `@Option` 2) | 8 — `conformance/modules/async_block_both` and `task_result_await` (comments on code lines), `prelude_name_with_sigil` (the one legitimate `@Result`: it tests the refusal) |
| validation | 21 | 7 |
| actions, query, routing, snap | 1–2 each | comments |

- **Machine 1.** rakun's 872 sites are code: your staged codemod (m1-0003, "plus the bare prelude types") must leave
  `grep -rE '@(Result|Task|Component)\b' modules/` at zero — comments and `test "…"` names included, so no package keeps
  the old text anywhere. Check before the commit; if the codemod skips comments, extend it.
- **Machine 2.** B-116 (ii) (`machine-2/144-backends-tooling/README.md` box "the types: `@Iterator` → `Iter`, `@Task` →
  `Async` …", line 2415) closes only when std, the cells and the libraries hold the old names nowhere but
  `prelude_name_with_sigil`: respell the comments (`libs/std/src/async.bp:571`'s test name, the cells' `//` lines) and
  validation's 21 with the same codemod run. A `////` line is the cell's reference (480), never left stale.
- **Correction to mt-0025.** The maintainer allowed the spec tree: `specs/1.0.12-beta/**` will be respelled by a coordinator
  thread after the closed milestones' decision files are folded into `specs/` (in progress). History sentences keep the old
  names; a box whose whole mechanism is overtaken is listed, not respelled.
