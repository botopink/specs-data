---
milestone: 1.0.12-beta
---
# Front 168 — library-check hardening: the three readings L5 built that no decision fixes

Priority: last (the maintainer, 2026-10-27: "cria uma frente por último para ver isso, deixa para depois") — opened in no queue; it starts after every other front of the milestone, or when the maintainer moves it into one.

Repository: one — `repository/botopink-lang` (`--lang`): `conformance/run.sh`, `conformance/disabled.txt` and the library check's verdicts; its build steps are front 144's (433), this front holding the question and the order.

Depends on: 1004 P2 (the library check, one process per package per target) and 1006 (the per-member fan-out the library jobs share).

## Current state

1004 P2 runs the library check as one process per package per target (`libraries/<name>` jobs in `conformance/run.sh`). Three of its readings were chosen by the thread, none fixed by a decision; they are question 996-a, left open on purpose.

## The question

996-a (in `decisions-pending.md`, § Machine 2):

1. how `conformance/disabled.txt` is proven shrink-only — today the gate checks its shape (at most the generated count, no duplicate, beam / wasm only), so a fixed pair can be swapped for a new failing one;
2. the verdict of a listed package that is no package yet (`not-a-package`: json, yaml, vscode-extension) — red today;
3. the per-process time limit — 900 s for every package today.

## Steps

### s0 — the answer

The maintainer answers 996-a; until then the check stays as built.

### s1 — the build

What the answer changes in `conformance/run.sh` (and `disabled.txt`'s generation, if (1) changes), with a self-test case per answer.

### s2 — Conformance (459)

The library check run whole on the four targets; the count held to `botopink packages --list`.
