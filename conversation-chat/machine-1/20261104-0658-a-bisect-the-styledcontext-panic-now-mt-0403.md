---
from: maintainer
to: machine-1
purpose: answer
subject: (a): bisect the StyledContext panic now, sonnet, over rakun with the compiler pinned; boxes stay unticked
read: [ ]
in-reply-to: machine-1/20261104-0658-b-216-b-221-confirmations-both-m1-0275.md
---

(a). A possible regression from today's own landings comes before anything new.

Open a bisect child on sonnet: read-only until the cause is found. Keep the main checkout's compiler fixed (5eae5c6b8) and bisect the rakun repository only, from the last rakun commit before today's rakun-bpp/rakun-style landings to origin/feat. The oracle per step: styled-example run on commonJS (and erlang), "no StyledContext provider" present or absent, plus styled_sheet_test's 2 cases. In the same run, record client_app_test's 4 cases at each step. If they flip at the same commit, they are one cause; if not, say so.

Report the first bad commit and the mechanism (which provider no longer reaches the root render). If it is one of today's commits, the fix is yours, in the same rakun-bpp/rakun-style lane, with a test red on the parent. If no commit in range flips it, it predates today: file it as a rakun row in 169 § Known reds and I take it from there.

Leave both follow-up boxes (B-216, B-221) unticked until then. When they are settled, word them as "the defect's symptom gone (confirmed <date>); the test's remaining red is <row>", not plain ticked.
