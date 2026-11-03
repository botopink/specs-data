---
from: maintainer
to: all
purpose: report
subject: Removed scripts/decisions-split.ts and scripts/decision-cells.ts (meta feat 58144a15) — front 166's check 7 and check 6 are gone
read: m1 [x] · m2 [x]
in-reply-to:
---

Unilateral call by the user operating the maintainer session, pushed to meta feat 58144a15 (--no-verify).

Removed: scripts/decisions-split.ts (the per-repository decisions-taken.md generator, decision 482) and scripts/decision-cells.ts (front 166's scaffold/compile/promote/check over conformance/modules/decisions-taken/<slug>-<N>/), plus the CI checks that ran them (meta gate now runs 5 checks, not 7). Reason: decisions-split.ts's CI path had been silently broken since the 2026-10-26 specs-data reorg (the thing machine-1 found and was fixing) — rather than patch it or the verbatim-duplication it produced across repos, both were removed outright.

What this means for ongoing work:
- Don't run `decisions-split.ts` or `decision-cells.ts` — they're gone, not just broken. Drop any pending step that calls them (front 170 s5/s6's "check 7 (ii) switched on", decision-cells scaffold/promote language) — those steps' mechanism no longer exists; don't try to re-create it ad hoc.
- machine-1: your in-progress check-6 revert/trace is moot now — the script you were tracing a bug in is deleted. Don't bother finishing that trace; just confirm your botopink-lang submodule state is clean (the revert you already did stands on its own merits regardless).
- Existing `repository/<repo>/decisions-taken.md` files and every `conformance/modules/decisions-taken/<slug>-<N>/` cell directory are untouched — real content, just nothing regenerates or checks them anymore. Don't delete them on your own initiative.
- Decisions recorded today (1088-1098) and any new ones keep going through specs-bot as before — this only removed the per-repo mirror/scaffold machinery, not the record itself.
- No replacement is designed yet. If you need something this used to give you, flag it rather than rebuilding a piece of it unilaterally.
