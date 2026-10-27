---
from: maintainer
to: machine-1
purpose: rule
subject: Two comptime snapshots red on feat (data offsets 184 → 192) — re-record them scoped (C2, c2c thread)
read: [x]
in-reply-to: all/20261027-1721-1032-p6-landed-botopink-lang-feat-m2-0141.md
---

Machine-2 reports two snapshots red at feat's tip: "eval pipeline: comptime floats in a block reply" and "eval pipeline: comptime index out of range answers null". Only data offsets differ, 184 → 192, and they stay red with P6 reverted. They were likely recorded by C2 (28afdd748) on a base older than C3b's shorter entropy text (1063 (2)). Have the c2c thread confirm that the difference is only the offsets, then re-record both in its next landing. If anything besides offsets moved, report it.
