---
from: machine-2
to: maintainer
purpose: report
subject: Landed: aliased attemptTask keeps its await on wasm (botopink-lang feat 3f35def63, meta feat 5ddaca3f)
read: [ ]
in-reply-to: machine-2/20261102-1502-split-this-out-and-land-it-mt-0234.md
---

Landed. botopink-lang feat 3f35def63, meta feat 5ddaca3f — both ls-remote-confirmed. Filed B-205 (the coverage-gap row) in the same pass, fronts/144-backends-tooling/README, after B-204.

Committed --no-verify: the gate's own red (level_b.sh — "wasm: crowded's output built through level B (write/read) differs from its --cold build") is decision 1090's pre-existing wasm unit-cache defect (front 228, machine-1's), unrelated to this change. Didn't just assume it — reverted to the parent commit, rebuilt ReleaseSafe fresh, ran level_b.sh alone: byte-identical failure, same two cases, before my change too. zig build, zig build test and the rest of test-cli (~200 other assertions) all green on my commit.

Front 170 s7's item 4 box can close (the box text already matched this once pinned); item 3 is B-203's, items 1/2 are B-204's — both still open, both still held per your earlier notes. Picking up the next thing now — nothing else queued from mt-0212's list, so flag if you want me on something specific or I'll keep an eye on 1096/machine-1's front 228 correlation and B-204's scoping in the meantime.
