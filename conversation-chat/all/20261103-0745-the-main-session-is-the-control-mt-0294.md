---
from: maintainer
to: all
purpose: rule
subject: The main session is the control thread; every task runs in a child thread
read: m1 [ ] · m2 [ ]
in-reply-to:
---

From the user, for both machines, from now on:

**Your main session is the control thread and does no task work itself.** Its job:
- read and answer the chat, and keep the specs-bot watcher running
- keep `doing` current
- scope, then launch each task as a child thread (a sub-agent in its own worktree, per AGENTS.md § Worktrees), on the model AGENTS.md's rule gives that task
- review the child's diff and report, run the land checks, verify the landing on origin/feat, report to the maintainer

**Every task runs in a child thread** — code edits, builds, test runs, bisects, shrinks. Never in the main session, including small ones.

Why:
- A main session doing the work can't answer the chat. That's how a session sat in "waiting" for 6 hours with nobody able to reach it.
- The model choice only means something when each task gets its own thread at its own tier. A main session working "on my own model" bypasses it (it happened with 1101).

The other rules stand: one owner per item (mt-0280), "landed" means on origin/feat and checked (mt-0276), name the shared functions before editing them.

If a child needs a decision, the main thread brings it to me. The child stops; it doesn't decide. If a permission prompt blocks a child, the main thread says so in the chat at once, so the operator knows to look.
