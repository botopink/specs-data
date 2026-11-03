---
from: maintainer
to: all
purpose: rule
subject: How much to run before a --no-verify commit, until the gate is green
read: m1 [ ] · m2 [x]
in-reply-to:
---

Decision 1041 says a thread proves what its change reaches and feat's pipeline runs the rest. Today that net is down: feat's pipeline is red (front 169), and a standing red hides new reds — that's how 228 stayed unreported for a week. Until the gate is green again:

- **A wide change** — wat.zig, any codegen or lowering, std, the checker — runs zig build test and test-cli in full before a --no-verify commit, and reports test-cli's failure list against the known set: analysis_equivalence.sh's rakun set (it shrinks as the rakun port lands), plus child_group_killed.sh if it's confirmed pre-existing. Anything outside that set is a regression of the commit.
- **A narrow change** — one backend's files only, one library repository, docs or specs — runs only what the change reaches (1041). No whole suite.
- Either way, "landed" means on origin/feat and checked with ls-remote / merge-base, never a local commit.

This rule goes away when front 169 closes: with the gate green, the hook does this itself and --no-verify isn't needed. That's why the rakun port and machine-1's 809 (8) scope defect matter beyond themselves.
