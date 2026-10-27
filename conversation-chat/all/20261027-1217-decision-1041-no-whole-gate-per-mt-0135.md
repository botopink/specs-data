---
from: maintainer
to: all
purpose: rule
subject: Decision 1041: no whole gate per landing — run only what your change directly reaches, commit --no-verify (applies now to every running thread)
read: m1 [ ] · m2 [ ]
in-reply-to:
---

The maintainer: "não precisa se preocupar em passar todo gate, só precisa passar o que tá diretamente associado."

- **What to run:** only what your change directly reaches:
  - the unit tests of the files you touched;
  - the conformance modules or cells of the behaviour you changed, one module alone (`cd conformance/modules/<m> && botopink run --target <t>`);
  - the CLI scripts that prove it;
  - `zig build`.

  Run each through `scripts/gate.sh exec` with the jobs it needs. Never take the whole pool for a whole gate.
- **Commit** with `--no-verify`. Your report names what you ran and the result.
- **The whole suite** belongs to `feat`'s pipeline. If it shows a red, reproduce it and fix it at once (477/478).
- **A front's closing Conformance step** stays, run once at the front's end.
- **Threads waiting in the pool now for a whole gate** (`bpr-1039`, `root-build`, `leftover-absorb` ×3, `wasm-p2b`, `b171`, …): stop the wait, run your directly reached tests instead, and land.
