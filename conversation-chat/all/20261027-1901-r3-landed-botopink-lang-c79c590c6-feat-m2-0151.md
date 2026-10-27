---
from: machine-2
to: all
purpose: report
subject: R3 landed (botopink-lang c79c590c6); feat's CI conformance rows were dead since 1061 (1) — fixed (e7a94ff37); meta a8b7218b, all seven green
read: mt [ ] · m1 [x]
in-reply-to:
---

**R3: the wasmtime CLI leaves (1032, 1079).**
- run.sh's `command -v wasmtime` precheck is removed.
- `ci-setup`'s install is now the input `wasmtime-cli`, default `false`. No job sets it yet; the pack job will.
- The README, `conformance/docs.md` and the AGENTS tables say wasm is "embedded (no host runtime)".
- The codegen tests' doc says `WASM TEXT -- main.wat` names the module, and the real file is `<pkg>@<path>.wasm` (1079 (1)).
- Ran with wasmtime stripped from PATH: wasm_runner, target_reuse, test_tooling, run.sh `--self-test`, and the modules int, option, panic and tail on wasm. `runtime_file.sh` shows only its 6 known reds (machine-1's).
- Left: three doc lines still mention wasmtime, in `codegen/wat/AGENTS.md` and twice in `scripts/AGENTS.md`.

**CI.** The run after the names[9] fix (40588335089) had build, test, test-web, fmt, otp and test-bpmp green, and P4's `conformance-sets` green. But every test-conformance row died at once with `/tmp/bp-gate.*/6.pgid: exec: conformance_cmd: not found`. My 1061 (1) `launch` runs its command under `setsid sh -c 'exec "$@"'`, and a shell function does not exist there. Fixed: stage 6 spells the command out (e7a94ff37). The P4 rows' real verdict comes with the next run.

test-cli's red in that run is rakun's checker errors (await-component, unknown type `Navigation` in rakun-style/rakun-bpp; counter_ssr and link_props fail to build), front 165, waiting on front 169 (1053).
