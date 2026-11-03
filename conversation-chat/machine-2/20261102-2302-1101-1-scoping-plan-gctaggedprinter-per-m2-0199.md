---
from: machine-2
to: maintainer
purpose: question
subject: 1101 (1) scoping plan — gcTaggedPrinter per-type degradation; two open questions before I build it
read: [x]
in-reply-to:
---

Read-only scoping, nothing touched yet. Here's the plan.

**Current mechanism.** `gcTaggedPrinter` (called once, lazily, whenever `gc_tagged_used` is set — by a real `unknown` print, a generic-param print, a tagged field shape, more) walks every type in `self.gc_types.items` and calls `try self.gcDeclPrinter(n, null)` / `try self.gcDeclPrinter(v.en, v.name)` per type, building one `ref.test`-guarded arm per type in `__print_tagged_raw`. The `try` means ANY single type's failure propagates immediately out of the whole function, out of `finishGc`'s caller, aborting the entire `.gc` attempt — this is the exact mechanism that forced 4 modules to `.linear` for my shown<T> landing, and what makes B-203's class of bug possible generally.

**The fix.** Wrap each `gcDeclPrinter` call in the loop; on any error but `OutOfMemory`, don't propagate — skip that type's arm and continue the loop. Two things need explicit handling, both found by reading the actual code, not assumed:

1. `self.cur` (the capture-stack pointer `open`/`seal` manage) and `self.gc_gap` both get mutated by a PARTIAL `gcDeclPrinter` call before it fails — `gcDeclPrinter` opens its own capture (`self.open(&c)`) and only seals it on success, and `gcGap` sets `self.gc_gap` unconditionally on the first gap it sees. Today this never matters because the whole `Emitter` is discarded the instant any `.gc` attempt fails. My fix keeps using the SAME emitter for the rest of the module, so both need to be saved before the call and restored on failure, or `self.cur` is left pointing at a capture whose backing memory is about to go out of scope (the next emit after that would write through a dangling pointer), and `self.gc_gap` staying set would spuriously trip `finishGc`'s own later check (line ~7124) and abort the module anyway for no reason.
2. `gcDeclPrinter` inserts its `gc_printers` map entry (key → a fresh `__prN` symbol name) BEFORE any of its failure-prone logic, and memoizes on that key — a failed call leaves that entry in the map, pointing at a symbol nothing ever defines. I think this is narrower than it looks: anything that would call `gcDeclPrinter` for the SAME type a second time (e.g. a direct, static `print` of that type elsewhere) already fails the whole module TODAY, before `gcTaggedPrinter` even runs (it runs late, during module assembly) — so in practice nothing else should ever re-request the same stale key. Still, I'd rather clear the entry defensively on failure than rely on that holding forever.

**Two questions before I build this:**

- "A located refusal" (your wording) — for a per-type arm inside a SHARED runtime-dispatch helper, there's no single call site to locate. I read it as: the type's arm is simply left out, falling through to the EXISTING `__print_decl`/bare `unreachable` tail — the same, already-accepted outcome `gcUnkPrint`'s own docstring describes for a form it doesn't support (an array or a tuple traps there today, by design). Is that what you mean, or do you want something more — a named runtime panic naming the type and why, before it traps, instead of a bare `unreachable`? I don't have a strong read on which "located" means here.
- Scope boundary: this step only touches `gcTaggedPrinter`'s own loop. `gcPrintArg`'s direct, static call to `gcDeclPrinter` (a plain `print(aConcretelyTypedRecord)`) stays exactly as it is — a gap there still fails the whole module, same as today. I'm assuming that's right (B-203's shape is specifically "something UNRELATED gets walked," not "the thing actually printed fails") — flag if you want that call site covered too.

Once these are answered I'll build it, verify with `GCTRACE`-style tracing that a gapped type's arm is skipped while an ungapped type in the same module still gets a working one, then the full `zig build test`.
