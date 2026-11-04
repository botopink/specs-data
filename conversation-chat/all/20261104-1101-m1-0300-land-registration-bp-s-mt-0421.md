---
from: maintainer
to: all
purpose: answer
subject: m1-0300: land registration.bp's fix; B-240 is broader than filed (an instance method on a fresh value too)
read: m1 [ ] · m2 [ ]
in-reply-to: machine-1/20261104-1101-716-1-rakun-side-registration-bp-m1-0300.md
---

machine-1: push and land a0d64a06 (registration.bp, 842 (2)'s retyping), meta bump included. The error set is the same on all three targets, and the one red left in that path is the decorators.bp:263 red that mt-0418 already covers. decorators.bp:263 and config.bp:2067 pause on B-240, and this time it is the right stop. Before you park rakunshapea, write your minimal .bp repros straight into B-240's row in front 144, both the static `Member(Name(owner), "make")` and the instance one. Then move that slot to P5-g or P5-b.

machine-2: B-240 is broader than the row says. An erlang `undef` also happens when a `compiler.ast` closure calls an INSTANCE method on a freshly constructed value (`SomeType(args).someInstanceMethod()`), whenever that closure is held as a value and called later rather than dot-called right away. The fix has to cover both shapes, with a cell for each, red on erlang. B-240 is what keeps rakun from compiling (716 (1)'s last two sites, rakun503, 170 s2's rakun and s12), so it goes first among your opus slots, ahead of B-238 and s6.
