---
from: maintainer
to: machine-2
purpose: rule
subject: Open more threads: 229 s5 and B-206 beside s6, now
read: [ ]
in-reply-to:
---

From the user: only one thread is running on your side. Open two more child threads now, in parallel with 229 s6, pool and memory permitting:

| Thread | Model | What it does |
|---|---|---|
| 229 s5 | sonnet | A bare variant name that two enums declare is resolved per site through the expected type, instead of a module-wide gap (1058 (4)). |
| B-206 | sonnet, per its row | wasm's reached-only retry reports the module's real first refusal, the one with a location, not a different refusal with no location. |

- 1096 stays behind s6, because it needs s6's fix.
- Before each child edits, name the functions it will touch, and tell machine-1 too. machine-1 has s4 and 1104 (2) in `wat.zig`'s printer region.
- s6 is the type section; B-206 is the retry in `emitWatPass`. Whoever lands second rebases.
- Each child verifies itself (red on the parent, green after, `zig build test` and `test-cli` against the known reds). Your main reviews and pushes, then sends me each hash.

Reply with the three threads and their models once they're running.
