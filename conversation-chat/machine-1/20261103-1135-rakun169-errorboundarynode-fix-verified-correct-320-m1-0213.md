---
from: machine-1
to: maintainer
purpose: question
subject: rakun169: errorBoundaryNode fix verified correct (320/4 exact fable match) — but found new pre-existing reds on erlang/beam + a cross-target compile failure, holding the commit
read: [ ]
in-reply-to:
---

The thread applied your verbatim errorBoundaryNode fix (selfScope + keptAt) and the test rename exactly as given. Verified load-bearing by revert-and-retest: reverted → 319/5 (render_test's own boundary case fails), restored → 320/4 on commonJS, matching the fable's number exactly. Only the 4 known B-216 client_app_test reds remain on commonJS.

It then ran erlang and beam (both are real targets in this workspace's botopink.json, not optional) and found NEW pre-existing reds, unrelated to the fix, confirmed via the same revert-and-retest method:
- erlang: 310/14. The 14 are all streaming_test.bp (12 — Suspense/boundary/fill-order/plugin) and testing/helpers_test.bp (2). client_app_test is 4/4 green here (B-216 is commonJS-only, consistent). errorBoundaryNode's own test: 23/23 green.
- beam: 302/22. Same two families (12 + 9) plus one unrelated render_test failure ("the shell carries every placeholder and no child, and no document" — Suspense/shellHtml, not error-boundary territory) and one `{error,badarg}` crash in a placeholder-children test.
- All three targets: `html/template_test.bp` fails to COMPILE (not just assert-fail) — "type mismatch: expected string | i32 | ... | Element[], got function" at line 154, a function value in an html-DSL hole. Unrelated to Scope/render, confirmed pre-existing.

Two questions before it commits:
1. Are the erlang/beam streaming_test/helpers_test reds and the html/template_test.bp compile failure already tracked rows, or is this new information that needs filing (separate from B-216)?
2. commonJS is clean except the 4 known B-216 reds, which is what you asked for — should it commit now? A real (non-dry-run) commit through the hook will likely also run erlang/beam/html-template_test and refuse on these untracked reds unless the gate only checks commonJS by default or these are already in the known-reds baseline somewhere I haven't found.

Separate operational note, not rakun-specific: this machine's default `erl` on PATH is OTP 29.1.1; OTP 28.5.0.8 is installed via mise but not first on PATH. Botopink's commit hook demands OTP 28. The rakun169 thread worked around it locally (prepended the mise 28.5.0.8 bin dir for its own test runs, no hook skip), but if this is machine-wide it'll hit every thread's commit hook here — the d1104p2 thread hit the exact same thing independently. Worth fixing the machine's PATH ordering once rather than per-thread.

Fix itself not committed yet — holding per your own thread-rules guidance (stop and report on anything new/unexpected rather than deciding scope unilaterally).
