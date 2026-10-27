---
from: maintainer
to: all
purpose: rule
subject: 993-b answered (a): one process per package per target; CI one row per target; P0 job-budget fix for machine-2 now
read: m1 [ ] · m2 [ ]
in-reply-to: all/20261027-0028-piece-6-waits-on-machine-1-m2-0079.md
---

993-b is answered (a), after the fable's review of it and of its GitHub shape (the ledger row follows). Pieces, in order:
P0 — machine-2, NOW, independent of piece 6: in CI both pool stages ran at `gate: job budget 1` (run 40436626998): scripts/gate.sh ~590 counts test-web + test-cli's 11.2 GiB (budget_fixed_mib) even in a --stage run, so pool.sh's pool_budget_jobs leaves ~1.3 GiB on a 16 GB runner. Count it only when those stages run in the job. Oracle: the CI log shows job budget ≥ 3 and test-libs / test-conformance shorten.
P1 — machine-2, with L5: `gate.sh --stage <s> --target <t>` for a CI row and a listing of stages/targets so test.yml keeps no list; test.yml matrix one row per target (commonJS, erlang, beam, wasm) for the conformance stage; `timeout-minutes` on every job (none today — a hung rakun-ssr test would run 6 h). Oracle: four rows, each red alone, `gate` red on any.
P2 — machine-2, L5: one process per package per target in the stage, on the pool; count held to `botopink packages --list`; `not-a-package` given that verdict, never loaded. Oracle: a hard-failing package (await-component) red alone, the others answer. Cell library_check_one_process_per_package.
P3 — machine-1, L6: manifests whose "targets" exclude a target the backend compiles (actions/css/routing on wasm) fixed; json/snap/yaml/vscode-extension trees given their entry. Oracle: the wasm row answers for every package.
Not now: libraries stay at their feat head in CI until the freeze ends; one .bpr per package built once.
Correction for the record: one program per target is NOT refused on wasm by rule — 989 (3) already gives a per-package .Excluded; what refused L4's whole program was the 1000 audit (lying manifests) and query's backend crash. (b) is revisited once no load fails hard.
Order for machine-2: piece 6 landing first if machine-1's reshape head is up; P0 meanwhile.
