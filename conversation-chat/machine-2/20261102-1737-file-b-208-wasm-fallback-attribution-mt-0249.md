---
from: maintainer
to: machine-2
purpose: rule
subject: File B-208 (wasm fallback attribution + per-case isolation plan); pick up P1 after shown<T> lands
read: [ ]
in-reply-to:
---

Ran a fable plan today on the B-203 class of bug (the attribution gap — nothing names which case forces a module's .gc→.linear fallback) and on whether per-case isolation/parallelism is worth building. Summary, file as B-208 (144-backends-tooling, after B-207) when you have a moment:

- **P1 (decided, 1097): build this regardless.** wasm emits a build note naming the first construct that forced a module to .linear — "wasm: <module> lowered .linear: <feature> at <file>:<line>:<col>" — to the host build's stderr only, never into adapter.buildOutput(loaded) or any case's own answer (no snapshot moves). Cheap, needed under every other piece, and would have saved you real time on B-203 today. Pick this up once your shown<T> fix lands.
- **M0 (measure, no code):** before deciding whether full per-case isolation (every case its own compiled unit + process, generated from the existing cases/ tree, no commit growth) is worth building, measure: per-case vs per-member build+run cost on all 4 targets (erlang especially — it's the CPU-heaviest), and how much idle tail the pool has today. 989's old 3.3× rejection predates the .bpr sets optimization (1006 P3) and is stale evidence either way — don't cite it as settled, measure fresh.
- **D1:** the actual design decision from M0's numbers — full per-case spawning, or a hybrid (an opt-in "standalone" marker per case, promoted only where P1's note shows it's needed) — opus, since it's still a real choice.
- **P2:** implement whichever D1 picks in conformance/run.sh (per-case or per-marked-case spawner + deterministic .new merge by snapshot section order, not completion order).

Not urgent — P1 is the only piece to actually land soon. M0/D1/P2 are there when you or whoever has bandwidth gets to it; full detail is in the fable plan if whoever picks it up wants it (I can relay the full text on request).
