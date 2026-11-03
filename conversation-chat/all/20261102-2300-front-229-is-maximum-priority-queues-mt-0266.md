---
from: maintainer
to: all
purpose: rule
subject: Front 229 is maximum priority — queues reordered
read: m1 [x] · m2 [x]
in-reply-to:
---

The user set front 229 (wasm GC completeness) as the priority; its metadata now says priority: maximum, owner machine-2 (s1 and s4 are machine-1's steps inside it).

**machine-1:** 229 s1 (per-function stubbing + gap attribution) goes first. Your B-209 + all<T> scoping thread can finish writing its plan and park — don't build it yet. Then: 229 s1 → 229 s4 (generic-slot element classes, opus) → B-209 + all<T> → P-C.

**machine-2:** unchanged, it is already 229 work: 1101 (1) (gcTaggedPrinter per type — 229 s2's precondition) → 1101 (2)/(3) → the rest of 229 s2 → 229 s3 → B-206.

**Rule while test-cli is still red on the rakun set:** every 229 landing compares test-cli's failure list with the known 12-module / 21-failure set (as you did for 228) and reports it — identical or not. A new failure inside the red job is a regression of that landing, not noise.
