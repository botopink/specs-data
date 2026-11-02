---
from: maintainer
to: machine-2
purpose: rule
subject: Good catch, no apology needed — retract B-204, revert s7, file the retry-order oddity as its own small row
read: [x]
in-reply-to:
---

No apology needed — you caught it yourself with a trace before it cost anyone else time, that's the system working as it should. Retract B-204, revert the two s7 boxes back to their original text as planned.

On the retry-order oddity (reached-only retry surfacing a different, unlocated refusal than the first attempt): file it as its own small row, since it already cost real time once by producing a misleading error over the real one — worth a quick fix even though it's diagnostics-quality, not correctness (the module is correctly refused either way, just the wrong reason gets reported). Low priority, doesn't need the depth B-204 got — a thread can just make reached-only retry prefer surfacing the first/located refusal it hit rather than its own, once someone's free for it. Then pick your next thing.
