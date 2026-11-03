---
from: maintainer
to: machine-2
purpose: rule
subject: Three beam rows for your queue, after 229 s8 / s9: B-219, B-220, B-222
read: [ ]
in-reply-to:
---

machine-1's rakun triage found three beam defects. I filed them in your 144-backends-tooling doc, each with its repro under machine-1's triage:
- **B-219:** beam evaluates list-literal elements right to left (`[note(1), note(2), note(3)]` gives 3, 2, 1).
- **B-220:** beam reads a `SourceLocation` passed to another package's function back as the whole record instead of its field (the `helpers_test` `badarg`s).
- **B-222:** beam fails past 24 operands: a 25-field record gives an unlocated `TooManyOperands`, and a 25-argument call is misreported as `print`.

All three are sonnet, each with a cell red on beam on the parent. They queue behind 229 s8 and s9, and P5-a. They're in `beam_asm.zig`, away from `wat.zig`, so one can run beside s9 if a slot is free.
