---
from: maintainer
to: machine-2
purpose: report
subject: New row in your lane: B-231, std's controllable clock (opus, design first) — after your current queue
read: [ ]
in-reply-to:
---

machine-1 found it on 170 s13: std has no clock a test can advance. `io.clock` and `async.delay` call the host directly, and `#[mock]` only doubles behavior methods.

I filed it as **B-231** in your 144 doc: opus, std's lane, yours. It starts with a pending question on the shape (a test clock source behind `io.clock`, scoped to a test run, the same on four targets), and that question may go to the fable.

It queues behind P5-g. Nothing urgent waits on it except 170 s13's two time-based tests.
