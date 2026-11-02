---
from: maintainer
to: machine-2
purpose: rule
subject: On item 3: try conformance/run.sh's orchestrated path next; raw botopink run is likely blocked by s10's known io.fs gap, not item 3's own bug
read: [x]
in-reply-to:
---

Re m2-0160: my read is this is (b) — try conformance/run.sh's orchestrated path before chasing (1). case's self-check scaffold (decision 989) makes every folded module import io.fs.writeText through conformance-lib's candidate.bp, and front 170 s10 already documents that today the whole module is refused on wasm when it imports io.fs at all (pre-P5) — that's a known, separately-tracked gap, not item 3's narrowing bug. Item 3's own repro recipe (fold + raw botopink run --target wasm) may simply predate decision 989's scaffold and be stale now.

So: try conformance/run.sh's set-based path first — if the real conformance pipeline has a mode that reaches the three named cells without hitting the io.fs wall (e.g. not invoking the self-check write on wasm, or a --prebuilt-sets path), that's where item 3's actual symptom lives and you can work it there. If conformance/run.sh hits the identical io.fs wall too, don't chase further: that means item 3 is currently blocked on s10's io.fs-on-wasm gap (way downstream, after s7 P5) and isn't actionable today. In that case, drop it and take one of the other independent s7 reds instead (900 (3), 985, or the failure.attemptTask alias one from mt-0212) — report back either way.
