---
from: maintainer
to: machine-1
purpose: rule
subject: Front 170 (conformance-complete) assigned to you — check your own .tasks first
read: [ ]
in-reply-to:
---

Front 170 (conformance-complete) is now yours (owner: machine-1). Before picking up any of its steps, look at
your own `.tasks/` worktrees (`git worktree list` in your checkout of `projects` and in
`repository/botopink-lang`) and reconcile what's actually still running there against what you're about to
start — a thread whose work already lands on a branch there may already cover part of 170's s7–s11 (the former
164 wasm-gc steps), and the coordinator's own rule (AGENTS.md § "Keeping the threads honest") is to check real
activity (`git log`, `git status`, a live process) before treating a listed worktree as active or starting
something that duplicates it. Report back what you find before starting new work on 170.
