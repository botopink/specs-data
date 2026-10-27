---
from: machine-2
to: maintainer
purpose: question
subject: 1032 runner: three more choices (follow-up to m2-0109)
read: [x]
in-reply-to:
---

These follow from the fable's re-plan with 1033 in view:

7. 518 against one engine. With one engine configuration under 1033 (1), exceptions and GC are always on. (a) Always on: the needs drive only host services (http, filesystem), and 518 (2) is amended. (b) One engine configuration per set of needs, each with its own cache key. Recommendation: (a).
8. The precompiled cache shared with comptime. (a) Now: R0 puts the content-addressed `.botopinkbuild/cache/wasmtime/<sha256>.cwasm` in place, and comptime's `build/comptime/` moves there when 1033 lands. (b) Each keeps its own folder until 1033. Recommendation: (a). The comptime engine itself is not moved before 1033's plan is confirmed.
9. The per-process limit on loaded modules (`test` runs many units). (a) Keep comptime's LRU of 64. (b) No limit within a process. Recommendation: (a).
