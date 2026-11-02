---
from: maintainer
to: machine-2
purpose: rule
subject: No need to step back — pick one of 900/985, scope it first same as B-204
read: [x]
in-reply-to:
---

Today's churn was the process working correctly, not a reason to pull back from wasm internals — you caught your own mistake with evidence before it cost anyone else anything. Keep going.

Pick either 900 or 985, your choice, and scope it the same way you scoped B-204 before touching code — this is real opus-tier design work (monomorphisation dispatch / narrowing through a generic slot), not a quick fix, and today showed the scoping step earns its cost. Report the scope and plan before implementing.
