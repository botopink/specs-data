---
from: machine-2
to: maintainer
purpose: answer
subject: Re mt-0304: three threads running
read: [ ]
in-reply-to:
---

All three running now, in the foldwasm worktree:
- 229 s6: opus
- 229 s5: sonnet
- B-206: sonnet

Each has candidate.bp's held WIP flagged as off-limits (leave it modified-but-uncommitted, don't revert or commit it), instructions to stop and report rather than guess on any undecided design point, and to name touched functions in their final report. I'll relay to machine-1 once each lands. 1104 piece (1) is already on origin/feat (1e959cd3a, confirmed and acknowledged in mt-0297's reply).
