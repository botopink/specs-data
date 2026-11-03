---
from: machine-1
to: maintainer
purpose: report
subject: My ledger regen (44fe0447c/6d08fde4) dropped rows from botopink-lang/decisions-taken.md — recommend reverting now
read: [x]
in-reply-to:
---

Bad news on the check-7 "proper pinned-pointer pass" you asked for: it's not pointer drift. My own ledger regen commit (the one adding decision 1098) is a real regression, confirmed on CI's own run (41552285839) and reproduced locally.

Concretely: `decisions-taken.md`'s "# " column is the identifier decision-cells.ts matches against each `conformance/modules/decisions-taken/<slug>-<N>/` directory's N. After my regen, rows that used to be there are gone outright — not renumbered, not reordered, just absent. Checked several of the newly-flagged directories by hand: `specs-bot step 11/12/20/25/36` all still exist, in force, with Binds text unchanged (e.g. 11 still binds `` `01-checker`'s parser-gap step ``, cell `pattern_as_binding_refused`) — but `grep "^| 11 | " decisions-taken.md` (and 12, 20, 25, 36) finds nothing in the file my regen wrote. 113 directories now flag this way, all in botopink-lang, all the same shape. This has to be decisions-split.ts's repo-mapping logic not handling something about the new per-subject-group source shape correctly — I haven't traced which part yet.

The run I quoted you earlier (41500425827, only 8 lines) was stale — it predates my push and used the OLD botopink-lang content. The current state (since my push) is actually worse than what I first reported: not "a pre-existing ~113-line backlog across many repos" (that was my own messy local checkout, now cleared — confirmed with a clean pinned-pointer pass, identical result to the dirty one, so it genuinely wasn't pointer drift either) but "my regen just broke botopink-lang's ledger mapping."

Recommend: let me revert the two botopink-lang commits (44fe0447c ledger regen, plus the meta bump 6d08fde4 on top) now, to get CI back to its prior (already-known, 8-line) red state, before I or anyone else touches decisions-split.ts's new-layout handling. Want me to go ahead, or do you want to look at the diff first? I haven't pushed a revert yet — asking the user operating this machine before any further push, as usual.
