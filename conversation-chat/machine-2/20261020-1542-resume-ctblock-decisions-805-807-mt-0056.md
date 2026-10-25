---
from: maintainer
to: machine-2
purpose: rule
subject: Resume the `ctblock` worktree (B-159); the decisions of 2026-10-20 that reach your queue (804–807)
read: [x]
in-reply-to:
---

**1. Resume the `ctblock` worktree (B-159, decisions 788 and 793).** It stopped when the process hung, not by intent — continue from where it stopped:
- check its state: 20 files uncommitted, +491 / −296, base `20e577913`;
- run `zig build test` and `comptime/tests/comptime_blocks.zig` to see what is already green;
- close B-159's open boxes: a refusal naming the block as `comptime` (not `__bp_comptime_<k>`), `return` / `throw` refused in a block, a library's block in 660's level order, a `pub` all-`comptime` function expanded from another module's block, a cached build replaying the build output, a `comptime { print }` inside a function written as build output, the cell `module_comptime_block_rules`, the language server over the expanded function;
- rebase onto `origin/feat` before the final commit.

**2. Decisions of today that reach your queue** (all on the meta's `feat`):
- **805 (answers 798-a) — B-163 may open:** `--emit-runtime` writes a **pure binary `.bpr` per package**, reused by every dependant; another compiler's `.bpr` refused; `--target` required to build from one; `target` leaves `Module` (`Module(name, path)`); mode 3 prints specialised names between backticks (`` `pad_$1` ``); `$`, `__bp_` and `Bp__` in a hand-written name are `reserved-name`.
- **806 (answers 792-a) — B-158's row:** `run()` answers `Result<void, RunFailure>`, `RunFailure(kind: type { Failed, Abort }, message: string)`, `Failure` unchanged; nothing of the loaded package propagates; **each `run()` re-initialises the package** (`val`s, `var`s, body, executors) alike on the four targets — commonJS drops its `require` cache entry, erlang and beam re-run `'_botopink_init'/0` whole; cells `module_run_contains_body_failure` and `module_run_twice_body`.
- **804 (answers 791-a/b/c) — B-162, machine 1's:** `Renderable` goes, a type-bound component starts at `compose()`, `NodeChild = Element | Component<Element>`. For reference only.
- **807 — `comptime var`**, a variable of the build: step B-164, machine 1's, **after B-163**.
- **803 / front 167** (completions inside templates): later, in no queue.

**3. Unchanged:** `test-cli` failing on `dependency-target-missing` (770) stays yours — measure it and file it as a defect row if it is one.
