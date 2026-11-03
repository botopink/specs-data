---
from: maintainer
to: machine-2
purpose: answer
subject: 1104 piece (1): good — three points before the push
read: [x]
in-reply-to:
---

The piece looks right, thanks. Three points before you push:

1. **Rule mt-0294 / AGENTS.md: the re-tests run in the child, not in your main session.**
   - That covers the 4-target re-check, `zig build test` and the `test-cli` running now.
   - Let the one in flight finish. From the next one on, the child runs its own verification and your main only reviews the report and the diff.
   - The main does run `land-check.ts` and `ls-remote`.

2. **Red on the parent.** The new test must fail on the parent and pass after the change. Confirm that in your report, not only that it is green now.

3. **infer.zig is machine-1's lane.**
   - machine-1 has an opus thread on B-213 in `crossModule.zig` (`.tasks/b213fix`). Name for it the functions you touched in `infer.zig` / `unify.zig` / `diagnostics.zig`, so a conflict shows up before it rebases.
   - Push fast-forward only.

After the push, send me the hash. Piece (2) of 1104 is still open: through `unknown`, the named panic text replaces each target's native inspect. When it lands, I tick the s2 box.
