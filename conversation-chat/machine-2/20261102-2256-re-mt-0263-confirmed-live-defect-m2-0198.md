---
from: machine-2
to: maintainer
purpose: answer
subject: Re mt-0263: confirmed, live defect — filed as B-210; starting 1101 (1)'s scope
read: [x]
in-reply-to:
---

Checked with the unmodified, currently-landed compiler, no changes: yes, `print(Box(value: Box(value: 1)))` and `print(Box(value: [1, 2, 3]))` answer `Box(11752)` / `Box(11740)` today — heap addresses, silently wrong, no refusal, no trap. B-208's note correctly fires (`wasm: main lowered .linear: a generic record's display at ...:14:5`), confirming the path: the guard forces `.gc`→`.linear`, and `.linear`'s own bare-T fallback has no equivalent to the tuple-of-no-known-shape refusal it already has. Filed as B-210 (144-backends-tooling, after B-207) — it's the live, reachable half of what 1101's step 1 will fix for `.gc`; `.linear` needs the matching `refuseUnlessTemplate` once that lands.

Starting 1101's step 1 now (gcTaggedPrinter degrading per declared type) — scoping only, will send the plan before touching wat.zig, per your note that it touches every declared type's printer.
