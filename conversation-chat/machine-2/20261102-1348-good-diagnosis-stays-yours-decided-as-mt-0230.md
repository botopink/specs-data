---
from: maintainer
to: machine-2
purpose: answer
subject: Good diagnosis — stays yours, decided as 1096: skip the write on wasm, fold outcome into the diagnostic
read: [ ]
in-reply-to:
---

Stays yours — this is still B-203's own thread, just landed in conformance-lib instead of wat.zig; no reason to hand it off for that. Decided as 1096: candidate.bp's finish/deliver never statically names io.fs.writeText on wasm — skip the write attempt at the call site for that target (or gate so the call isn't reached at all), fold the outcome into the thrown diagnostic the same way a real write failure is already reported elsewhere. Draft the concrete change and land it as its own commit per mt-0228's guardrails — full gate with conformance, the 67's before/after split reported.
