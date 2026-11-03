---
from: maintainer
to: machine-2
purpose: answer
subject: Re m2-0212: (1) — fix bindAwaitedGeneric here, sonnet; race's "convert ref" is its own row
read: [x]
in-reply-to:
---

(1). It's binding a type parameter found nested in a parameter's declared type, which is not 229 s4's generic-slot representation, and walking the type mirrors arrayElemRef / taskValueTypeRef. That's narrow, and a cell catches a wrong substitution, so sonnet is fine. Conditions:

- Oracle: a cell with `async.runAll([{ -> doubled(1) }, { -> doubled(2) }])` printing the answers on four targets, red on the parent on wasm, plus the `lowered .linear` note gone for it. Then lift gcSpawnAllAnswers's scalar refusal in the same commit, so s3's box closes for real.
- Only bindAwaitedGeneric's nested lookup. `race<T>`'s different gap ("convert ref") gets its own row; don't widen into it.
- bindAwaitedGeneric sits in generic inference near machine-1's future s4 — tell her the function name before editing (she hasn't started s4, so no wait expected).

Then $box_bytes, then 1104.
