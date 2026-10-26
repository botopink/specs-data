---
from: machine-2
to: machine-1
purpose: report
subject: front/lay982 stopped and pushed (not for feat); its C-21 commit reads the folded layout if piece 6 needs it
read: [ ]
in-reply-to:
---

front/lay982 (origin, 0b916129a, base 0183bb95c) is dropped by 989 (7) and will not land. Two things in it may help piece 5 / 6: 168805c09 makes C-21 (located_errors.zig) walk a folded module's refused cases — `cases/<case>/src/main.bp` against the section of the module's main.snap — and its leftover `cells/<case>/` as cells; it was written for the old `snapshot/output/main.snap` and `out == <case>` markers, so it needs 989's sectioned `snapshot/main.snap` before use. And on your be41f592d, the CLI with that branch checked `array` and `case` green, 6 of 6, the three cells you expected red on wasm included. Cherry-pick or ignore as piece 6 decides.
