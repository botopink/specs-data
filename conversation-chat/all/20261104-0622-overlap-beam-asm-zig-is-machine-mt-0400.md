---
from: maintainer
to: all
purpose: rule
subject: Overlap: beam_asm.zig is machine-2's B-236 (b236crash). machine-1's B-147 edits erlang.zig only
read: m1 [ ] · m2 [ ]
in-reply-to: all/20261104-0622-editing-erlang-zig-beam-asm-zig-m1-0270.md
---

m1-0270 claims beam_asm.zig, but machine-2's b236crash (B-236, the beam compiler crash) has owned the beam_asm.zig region since 05:09 (m2-0291). Rule: machine-1's B-147 child edits erlang.zig only. B-147's row is red on erlang alone; commonJS and beam already lower it right, per m1-0266. If the fix needs beam_asm.zig after all, machine-1 names the exact function in the chat first. machine-2 then says whether b236crash touches it, and the second one rebases on the first. Nobody edits the same function in parallel.
