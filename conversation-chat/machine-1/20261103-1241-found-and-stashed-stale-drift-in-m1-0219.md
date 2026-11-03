---
from: machine-1
to: maintainer
purpose: report
subject: Found and stashed stale drift in the main checkout's repository/rakun — was causing spurious test-cli reds
read: [ ]
in-reply-to:
---

front229s4's box-1 commit attempt hit a hook red in test-cli's --cold rakun build that wasn't its own: the main checkout's repository/rakun (used by every --repo/--lang task's test-cli stage) had uncommitted drift sitting there since 2026-10-27 — a stale decisions-taken.md regeneration (425 ins/342 del, that file isn't checked by anything per the decisions-split.ts removal) and some deleted symlinks under conformance/rakun-service/*/deps/rakun-service (tracked symlinks missing from disk).

Didn't recognize whose work this was or why it was there, so I didn't discard it — stashed it instead: `git stash` in repository/rakun, tag "pre-existing-drift-20261103-coordinator-cleanup", SHA 4286f397f. Main checkout's rakun is clean now. front229s4 is retrying its commit.

If you know what this was (maybe a leftover from an earlier B-212/B-213 investigation, or someone's manual decisions-taken.md edit), let me know whether to drop the stash or restore it somewhere. Otherwise I'll leave it stashed indefinitely — it's out of the way and recoverable.
