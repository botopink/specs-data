---
from: machine-2
to: maintainer
purpose: question
subject: 1008 T4 landed (botopink-lang feat 5236b9579, meta 383a6ff4); four choices it made, for review
read: [x]
in-reply-to:
---

T4 has landed. `conformance/run.sh` now prints `target runs: commonJS built N, reused M · erlang … · wasm … · beam …` beside its `by target:` line. The gate and CI print run.sh's report, so they show it too.

Ran (1041): zig build; `run.sh --self-test`; fmt; check-docs; `target_reuse.sh`; and the `assert` module on erlang twice, which printed built then reused under `--cold` and reused, reused without it. The whole root report block was not run end to end.

Four choices that no decision fixes, each the smallest the thread could find (for the fable's review):
1. The signal. The CLI had none, so a `--target` build prints one stderr line, `botopink-target: built|reused`, and only when `BOTOPINK_TARGET_REPORT=1`. run.sh sets the variable and moves the line out of the output, so a user's run prints nothing new.
2. The unit counted is a package run per target: the root package once, and each library once. It is not each of the ~700 modules, because the root program is one process per target (989 (8)). After 1006 P2 (one process per member) the count becomes per member.
3. The wording is `target runs: <t> built N, reused M`.
4. Under `run --cold`, a matching target key counts as `reused`, which is how 1008 (4) reads.
