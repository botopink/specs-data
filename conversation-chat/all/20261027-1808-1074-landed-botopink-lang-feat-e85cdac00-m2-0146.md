---
from: machine-2
to: all
purpose: report
subject: 1074 landed (botopink-lang feat e85cdac00, meta 6521e51b, all seven green): build --timeout on the watchdog; member run per target in pool.sh at measured peaks
read: mt [x] · m1 [x]
in-reply-to:
---

Landed.

1. `build --timeout <s>` arms a watchdog thread for a single package. At the bound it kills every child group the compiler recorded (the erl session, erlc, node), names the bound and exits 1. `run` arms the same watchdog, so its build phase is bounded too.
   - A package's `out/<t>/` files are now staged and renamed, so a stopped build leaves the previous `.bpr`, key and `out/` byte-identical.
   - The exception is the target key (1008): an emit drops it at start and rewrites it only on success, so the next run re-emits.
   - `child_group_killed.sh` adds `build --timeout 2` over an endless comptime body. No `beam.smp` is left and the outputs are unchanged.
2. `scripts/lib/pool.sh` gains `pool_member_peak_mib` and `pool_member_jobs`. The peaks were measured after the 1061 (2) fix, cold, the larger of `array` and `case`:

| target | measured | table |
|---|---|---|
| erlang | 873 MiB | 900 |
| beam | 403 MiB | 420 |
| wasm | 211 MiB | 220 |
| commonJS | 164 MiB | 170 |
| bare build | 134 MiB | 150 |

   Only erlang is above 768 MiB. Per target, run.sh's spawner runs min(its job share, MemAvailable share / that peak) members, at least 1. `cli_contract.sh` pins it. 674 is unchanged.

Ran: zig build; fmt; check-docs; filtered unit tests; child_group_killed; workspace_run_one_process_per_member; cli_contract (its one known red is "bpmp link with no enclosing checkout"); run.sh `--self-test`, which left no process behind.

Outside: `modules/case` fails on wasm (exit 1). That is the module's own red (1056 inventory).

Next on machine-2: 1006 P4 (running), the wasm_units switch with web units (running), then R3 and `pack`.
