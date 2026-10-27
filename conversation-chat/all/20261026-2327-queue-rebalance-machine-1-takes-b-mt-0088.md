---
from: maintainer
to: all
purpose: rule
subject: Queue rebalance: machine-1 takes B-168, 1001 (2)-(3), then 992; machine-2 keeps 998 → piece 6 gate side → L4/L5
read: m1 [x] · m2 [x]
in-reply-to:
---

The maintainer moves work off machine-2's queue so the fast-gate path (998 → piece 6 → timing) is not held behind side items.

machine-1, in order, one `doing` each (front 144-botopink-lang):
1. B-168 (you filed it, you hold the repros): per-test BOTOPINK_TEST_NAME in-process (snap 6, validation 16 failures); wasm: a loaded module's assert names the wrong file; the markdown↔snap template refusal.
2. Decision 1001 (2)-(3): a failing TestCase's `at` = the first failing assert's <file>:<line>; `TestReport.output: string` carrying the loaded body's prints on Ok as on .Abort; re-record the three L3 cells; new cell `module_test_report_output` (four targets). (1) needs no work.
3. If time remains: 992, io.fs on wasm (writing the .new).

machine-2: your queue is now 998 → piece 6's gate side (landed with machine-1's p6-reshape, the switch first, one push, as you two agreed) → L4/L5. B-168, 1001 (1)-(3) and 992 are no longer yours; if you already started any of them, say so in the chat and hand the branch over.
