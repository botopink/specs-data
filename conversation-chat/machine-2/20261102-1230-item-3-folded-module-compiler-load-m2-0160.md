---
from: machine-2
to: maintainer
purpose: question
subject: Item 3 (folded-module compiler.load wasm cases) — repro doesn't match the 3 named cells, need a call
read: [ ]
in-reply-to:
---

Repro'd in a fresh --lang worktree (foldwasm): `botopink run --target wasm` in conformance/modules/case fails outright — "`.Wasm(std: \"fs.cwd\")` on `wasiCwd`: `fs.cwd` is a `.wat` leaf of std-wasm, which a module in linear memory cannot call — in another module's code this line reaches", at the `import {adapter, candidate, observe, records} from "conformance-lib"` line in src/main.bp. commonJS/erlang/beam all pass clean (exit 0, matches snapshot).

The "in another module's code" suffix is generic (wat.zig:4539, `self.foreign_origin`) — not specific to fs.cwd, so this is the same class of cross-module-reachability bug 170 s7's item 3 describes. But it's not the same symptom: this is a **whole-module compile refusal** (every one of case's 39 folded cases blocked, none run), not three specific cases answering wrong while the rest succeed. And I checked: none of the three named cells (case_arm_record_named_like_a_variant, case_record_field_null, case_union_constructor_arms) touch io.fs — they're pure case/variant matching, no std.io.fs anywhere in their source.

My read: case's main.bp (the piece-4 self-checking scaffold, decision 989) always imports conformance-lib's candidate.bp, which imports `io.fs.writeText` for writing snapshot/main.snap.new on mismatch (decision 989 (6)) — that's in every folded module, not case-specific. Front 170 s10 says today the whole module is refused when it imports io.fs at all (pre-P5). So this could be: (a) a distinct, broader bug than the three-cell one — self-checking scaffolding + io.fs makes every folded module's wasm run unbuildable, independent of case's own content; or (b) I'm invoking this wrong and the three-cell symptom lives behind a different path (conformance/run.sh's set-based orchestration, maybe a `--prebuilt-sets` mode that handles io.fs differently) that I haven't tried yet.

Haven't gone further — this is exactly a "no decision or README fixes it" fork. Want me to: (1) chase whether every other folded module hits the same fs.cwd wall on wasm (if so this is much bigger than item 3, maybe it's actually 170 s10's problem surfacing early), or (2) try conformance/run.sh's orchestrated path first to see if the three-cell symptom shows up there instead, or (3) something else?
