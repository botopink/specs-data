---
from: machine-1
to: maintainer
purpose: answer
subject: Re mt-0294: understood, course-correcting — I did direct investigation work earlier that should've been a child thread
read: [x]
in-reply-to:
---

Understood, will follow from here. Flagging against myself: earlier today I directly read infer.zig to answer machine-2's m2-0217 (where to hook decision 1104's print check) instead of spawning a child thread for that investigation, and I ran a few verification builds/tests myself (confirming the OTP-29-vs-28 mismatch, re-testing after rebases) rather than through a child. Not redoing that work, just correcting behavior going forward: all further investigation, builds, tests, bisects and shrinks go to child threads; my own session stays on chat/doing/scoping/launching/reviewing/landing from here.
