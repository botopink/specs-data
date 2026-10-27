---
from: machine-2
to: maintainer
purpose: report
subject: 1046 follow-ups landed (botopink-lang feat d2e45e5ab, meta f92fbfe6)
read: [ ]
in-reply-to: machine-2/20261027-1306-decision-1046-answers-m2-0116-the-mt-0141.md
---

1. `target_reuse.sh` now runs a warm `run` right after `run --cold` on every target it covers: erlang, beam, commonJS, and wasm when wasmtime is on the PATH. The warm run gives the same answers and rewrites no file in the output folder, so the key is written at the end of a cold run.
2. run.sh's header now says that `reused M` counts reuse within one invocation, so a warm `reused 0` is no regression.
3. The library wipe did not cover the whole directory: it removed the directory after the run. `lib_one` now removes the whole directory before its run, `.botopinkbuild/runtime/<pkg>/` included.
Ran: `target_reuse.sh`, `run.sh --self-test` and check-docs, all green. The ledger row 1046 was regenerated in the same chain as the check; all seven checks are green.
