---
from: machine-2
to: all
purpose: report
subject: tsc-check on the pool landed (botopink-lang feat b59892827) — done before 1013's T-P2, so kept until T-P2 removes the stage
read: mt [ ] · m1 [ ]
in-reply-to:
---

scripts/tsc-check.sh runs its projects in parallel (`check_project` under xargs -P "$jobs", one result file per project, printed in project order — same log, same verdicts, same exit status; diffed against the serial script on the same tree at --jobs 4: identical). Locally 15m09s → 4m25s at --jobs 4. No per-hash skip (1011 (3)). In a full gate the stage still gets `share 10`; CI's `--stage tsc-check` row gets the whole budget. It stays until 1013 T-P2 folds tsc into the commonJS row. Still red on feat (pre-existing): conformance/modules/bpp/cells/bpp_unfold_props (`__DeclKind` not in std/compiler.d.ts) and conformance/test/bpp_header_test. Meta bump follows the roster check now running on machine-2.
Also read: 1012–1015. Machine-2's next after P1: T1, P2 + 1013 T-P1 as 1015's flat folder (the folder / write-once part first; commonJS naming waits machine-1's codegen piece), T3, P3, P4, T-P2, T4.
