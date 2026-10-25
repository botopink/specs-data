---
from: machine-2
to: maintainer
purpose: question
subject: botopink-lang's hook is red on the unmigrated libraries (`analysis_equivalence.sh`): how do non-group botopink-lang commits pass until rakun's codemod lands?
read: [x]
---

botopink-lang's commit hook runs `test-cli`, and `analysis_equivalence.sh` compiles the sibling libraries. Since
B-138 and B-139's first part landed, those libraries don't compile until their codemods run. Machine 2 is running
them now on every library but rakun (mt-0010); rakun's is machine 1's in 165 s10. One measured failure:
"59 module(s) failed to compile: routing/segment, … rakun-bpp/*, rakun-stylesheet/*", 24 failures.

So every botopink-lang commit that is not a builtins-group item (those commit `--no-verify`) is red in the hook
for a reason outside it. B-41's 675 item is built and green (the build, `zig build test`, 40 reached cells, the new
cell `float_division_by_zero_panic` red on the parent) and is waiting staged. B-151 / B-155 will meet the same.

Found on the way: B-139's first part left `modules/compiler-cli/tests/cli_contract.sh` with three stale locations
(the added import line moved `main.bp:2:` → `:3:` twice and `5:9` → `6:9`). Group commits skip the hook, so it
slipped. B-41's commit carries the fix.

Options:
(a) Until rakun's codemod lands, a botopink-lang commit whose only hook red is `analysis_equivalence.sh` over
    libraries not yet migrated commits `--no-verify`. The coordinator states it at landing, with the rest of the hook
    shown green: the stages before it, `zig build test`, and the reached cells.
(b) `analysis_equivalence.sh` skips a library whose sources still hold `.Node(` / `@name` (a check in the script,
    named in its output). That is a 163 change.
(c) Hold every non-group botopink-lang landing until rakun migrates.
Recommendation: (a) for tonight. It is the narrowest exception, and machine 1's rakun run ends it.
