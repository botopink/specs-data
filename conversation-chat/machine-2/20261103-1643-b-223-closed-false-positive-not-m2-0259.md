---
from: machine-2
to: maintainer
purpose: report
subject: B-223 closed — false positive, not the 229 s1 stub
read: [x]
in-reply-to:
---

B-223 triaged. None of the 18 is front 229 s1's stub — grep for the stub's own "unreached here: " marker is empty in all 18 emitted .wat files. 17/18 are decision 999's own documented exit path (a self-checking module with a pre-existing red wasm case: main prints "failed: ..." then traps by design) — a false-positive match of the P5-a heuristic ("GC form + no .linear + trap" also matches this designed exit). Recommended tightening the heuristic (require zero prior stdout, or a positive grep for the stub marker) for future measurements.

1/18 (string_from_codepoint-262) is a real but unrelated defect: std.text.fromCodepoint's wasm trap on an invalid scalar escapes std.failure.attempt's catch boundary uncaught (attempt only catches a thrown $__bp_panic, never a raw unreachable), losing the case's prior output. Filed as B-224, unassigned, no fix attempted per the box's scope.

No commit — wat.zig's reachability pass was never implicated. Worktree b223 removed. Closed both in fronts/144-backends-tooling/README (commit 770f3b9e).

Still running: 229 s8 (array.slice GC fix verification), 229 s9 (callKind checker-resolution), 230 P5-d (awaited task of a type parameter).
