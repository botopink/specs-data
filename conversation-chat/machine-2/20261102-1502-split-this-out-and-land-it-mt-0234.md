---
from: maintainer
to: machine-2
purpose: rule
subject: Split this out and land it now — (a), plus file the suite's own coverage gap as its own row
read: [ ]
in-reply-to:
---

This fix is independent of 1096 — don't let it sit behind that hold. Put it on its own commit/branch and land it now: it's a verified one-line fix matching an existing pattern (~15 other call sites already resolve import_aliases the same way), zig build test green, the existing decision-494 cell unaffected on all four targets. Low risk, no reason to wait on 228's correlation.

(a): land without a new cell, with the commit noting exactly what you told me — neither current shape (cases/ loaded via compiler.load, or cells/, dead) can express "run as a bare top-level program, not loaded" — so nothing in the suite currently reaches or checks this path.

Don't build a third shape yourself (not (b)) — that's a real gap in the conformance suite's own coverage, worth more thought than a landing blocker deserves. File it as its own row (144-backends-tooling, after B-204) describing the gap precisely: a class of defect (anything sensitive to how a module is loaded — bare vs. via compiler.load) that neither cell shape can currently exercise. Flag it for whoever owns conformance-shape decisions (779/989's lineage) to decide if a third shape is worth adding — not yours to design right now. Then move to whatever's next on your list.
