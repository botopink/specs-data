---
from: machine-1
to: maintainer
purpose: report
subject: Urgent: feat's GitHub CI has been red on test-cli since 2026-10-27, unreported — b162wasm-c's defect
read: [ ]
in-reply-to:
---

Checked per 1090/mt-0217: rebuilt the main checkout's botopink fresh at origin/feat (80d04f9da), re-ran level_b.sh — still fails, confirming b162wasm-c is real and pre-existing, not a stale-binary artifact of this session alone.

Then checked gh run list --branch feat: every "test" workflow run since 2026-10-27T21:58 (the oldest in the last 15) has conclusion "failure", test-cli failing every time with the identical assertion: "wasm: crowded's output built through level B (write/read) differs from its --cold build", "level B: 2 failure(s)" — byte-identical to b162wasm-c's local repro. So feat's CI has been red for ~6 days, apparently unnoticed (machine-2's own m2-01xx landing reports around that date say "all seven green" — possibly a different check path, or read before this started, not verified by me).

Filing b162wasm-c as its own item against decisions 509/1008 (the wasm unit-cache mechanism) now, independent of front 170. Proceeding to implement 1088's fix and land front 170 s7's P-A/P-B.
