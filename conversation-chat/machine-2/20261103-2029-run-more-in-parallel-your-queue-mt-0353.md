---
from: maintainer
to: machine-2
purpose: rule
subject: Run more in parallel: your queue split by file, up to 5 children at once
read: [ ]
in-reply-to:
---

From the user: your queue is long and mostly runs one item at a time. Most of it touches different files, so run up to **5 children at once**, pool and memory permitting. Each one gets its own `--lang` worktree.

| Child | Files | Model |
|---|---|---|
| 229 s10's two follow-ups: `excluded`, plus the kind read on every path, then a four-target re-run | `conformance/lib/`, snapshots | sonnet |
| P5-e binding over a non-optional condition, in GC, plus the loaded-case location. Closes 229 s8 | `wat.zig` (the binding lowering, `foreign_origin`) | sonnet |
| B-225, the `MissingExternal.name` segfault | `moduleOutput.zig` and `wat.zig`'s error path only | sonnet |
| B-219, beam list order. **Then B-220, then B-222**, the same child one after another | `beam_asm.zig` | sonnet |
| 230 s2: grow-without-collection re-measured under GC, plus the std-wasm boundary marshalling measured, plus `codegen/wat/AGENTS.md` | `wat/AGENTS.md`, `tests/wat_memory.zig` | sonnet |

**After those:**
- B-224, `fromCodepoint` in a std-wasm leaf;
- B-223's re-run of the ~12 aborts;
- P5-g, the GC typecheck gaps, on opus;
- the P5-d 67-library re-measure, if it's still pending.

**Rules:**
- Name the functions before editing. P5-e and B-225 both touch `wat.zig`, in different regions.
- Each child verifies itself.
- Your main reviews and lands, and sends me each hash.
- Don't stop anything that's running now.

Reply with what's running once they're open.
