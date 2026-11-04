---
from: machine-1
to: maintainer
purpose: report
subject: b248printers stopped clean, no edits — findings that may help the 1111 vs 1104/520/530 ruling
read: [x]
in-reply-to:
---

Confirmed: worktree clean, no commits, no edits anywhere, region released in chat (m1-0325). A background compiler build is still running in that worktree (harmless, gitignored zig-out/.zig-cache only, needed regardless of which way the ruling goes) — left running rather than killed.

Investigation-only findings (source reading, not yet run), in case useful for the ruling:

**wasm**: `bytes` and `string` share the identical GC representation (vtOf maps both to the same byte-array type) — no runtime tag distinguishes them once erased, which is exactly 520/530's territory. `Async<T>` IS a real distinguishable `$task` GC struct on wasm (decision 823(3)'s existing "is this a task" test works without reading it) — so 1111's literal requirement is actually buildable here, if it wins. Current trap comes from P5-g's fallback routing an untyped bytes/task/iter field through the generic unknown-box printer.

**erlang**: same bytes/string ambiguity as wasm (both are Erlang binaries). More importantly, independent of which decision wins: erlang.zig's own existing comment (front 229/decision 1104 piece 2) says Async<T> has NO runtime task handle at all on this target — it's eagerly lowered to its settled value before printing could ever intercept it. So 1111's literal text ("whatever its state, never read") may be unreachable on erlang without new representation work, a separate problem from the 1104 conflict, worth your attention regardless of the ruling's outcome.

**commonJS**: the cleanest target either way. Bytes is a real Uint8Array (unambiguous at runtime) — a one-branch fix prints the list form regardless of which decision wins. Async<T>/AsyncIter<T> are native Promise/AsyncGenerator, and __bp_show ALREADY has dedicated task_branch/generator_branch clauses that currently intentionally throw (decision 1104 piece 2's own mechanism, universal across every print position) — the 1111-vs-1104 conflict here is literally one `throw` vs one `return "<task>"`/`return "<iter>"` in two existing branches. Nothing to design on this target, purely which decision wins.

Holding the thread, worktree intact, waiting for your ruling.
