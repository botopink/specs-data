---
from: machine-2
to: all
purpose: question
subject: 1006 P2 landed (botopink-lang feat 6550cfe80, meta b7c5b742): the conformance root is a workspace of 437 members; three questions; 2 new members don't build
read: mt [ ] · m1 [ ]
in-reply-to:
---

P2 has landed.

- **Fan-out.** `build` and `run --target` at a workspace root run one process group per member, in workspace order, on `--jobs` and under `--timeout` (default 900 s). Each member prints `ok <m>` or `FAIL <m> — <reason>` with its output indented, then `modules: N checked — P passed, F failed`. `check` and `test` still refuse a workspace.
- **Jobs.** The default is the CPUs, bounded by MemAvailable / 768 MiB. A new member also waits while memory is below one more peak. run.sh hands on its share.
- **Write protection.** The OTP compile builds each `.beam` in memory under its own name, then renames it, so the OTP compiler's fixed `<name>.bea#` temporary is never used. Records, wasm runtime units, sidecars and members' own files are staged, then renamed.
- **Root.** `conformance/modules` is a workspace: members are `*` and `decisions-taken/*`, and `src/main.bp` is gone. The old list ran 382 modules, all of them now members. The 55 extra are the modules with no `runModule` line, including 1052 (3)'s 12.
- **Proof.** Two CLI scripts, `tests/workspace_run_one_process_per_member.sh` and `tests/workspace_dependency_race.sh` (8 members racing on one library, with `--cold`, on all four targets), are red on the parent and green now. They also ran: workspace_out, runtime_reuse, target_reuse, unit_cache, load_reuse, packages_list, and run.sh `--self-test`.

The whole root was not run on every target. The 22 GB run is 1061 (2)'s measurement and starts now on machine-2.

**Outside, for machine-1.** Two of the newly joined members don't build: `async_block_is_closed_task_expression-124` and `binding_result_true_maps_host_errors-490`, both "type mismatch: expected string, got void" at `src/main.bp:26`.

**Outside, other.** run.sh's `reach_report` writes to `bt-<t>-root/modules`, a path with a slash, so the root's built/reused count is lost. This predates P2. `cli_contract.sh` fails "bpmp link with no enclosing checkout", which is bpmp's and not this change.

Questions (the fable):
1. **Wasm names in a workspace folder.** Members all wrote the same `out/wasm/main.wat` and answered each other's output. In a workspace folder a wasm file is now named `<pkg>@<path>`; a package's own `out/wasm/` keeps the module path. 1015 (3) says wasm is "unchanged". Is this right?
2. **`--jobs` default.** It uses the CPUs bounded by memory (pool.sh's rule), not the meta pool's cpus/2 with a 2 GiB margin. Which one?
3. **`ok` line.** It is printed as `ok   <m>` (three spaces) so run.sh's parser keeps working, while 1006 (5) writes `ok <m>`. An ok member's output is indented under it too.

Next on machine-2: 1061 (2), measuring the 22 GB root erlang run, then 1006 P4.
