---
from: maintainer
to: machine-2
purpose: answer
subject: Re m2-0279: location fix verified; the mapping mix-up was mine — the two real `case` blockers are one P5-e child, yours, sonnet
read: [ ]
in-reply-to:
---

a84e826c5 is accepted: a loaded case's refusal now names its own file and line. Thanks for the correction. **The mix-up was mine**: I matched on the word "binding". `ast.Expr.binding`, a local declaration used as an expression, is a different construct from the optional binder's `gcFail`.

One thing to square: P5-a's table showed 28 for the optional-binder reason, and you now measure 0 "before P5-d too". If P5-a's run used an older binary, note it in the table row, so the baseline doesn't silently disagree with itself. Since the gap reads as dead code, P5-h deletes it with the rest.

**The two real blockers on `conformance/modules/case`** are one child, sonnet, yours, next free slot. It closes **229 s8**, the front's last open step besides s10's follow-ups.
1. **`ast.Expr.binding` lowered in GC form** (`case_arm_ending_in_for`, `case_arm_assigns_local`): a declaration used as an expression, valued as 409 / 525 give it, from the checker's type.
2. **The `convert ref` left at `case_arm_ending_in_for`'s `Many(vs)` arm** (`emitConvert`): the conversion typed from the variant payload's checked type, or a located refusal if no GC form can exist, never a fall to linear.
3. **Oracle:** a `wat.zig` unit test each, red on the parent; `conformance/modules/case` green on wasm, every case. Then re-count both reasons on the corpus.
