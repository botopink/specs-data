---
milestone: 1.0.12-beta
---
# Front 160 — snap: the snapshot engine; consumer commits only — status

## Done — landed on `feat`

### 160 snap

- [x] 786 — `compiler.load` answers `Result<Module, Refused>`, `Module(name, path)` (805 (4)): B-158's box done (cell `compiler_load_answers_module`); 160's box closed, not respelled: `matchesRefused` leaves snap (the maintainer, 2026-10-20 — the suite records printed output, 789 (5)); snap's commit removed it with its cell and its loaded files (796) · machine 2
- [x] 787 — `mod.run()` in a `compiler.init` body runs a loaded package's `main`, answering `Result<void, RunFailure>` (806), each run clean: B-158's 787 box (decisions 787, 792; cell `compiler_load_module_run`, green on the four targets) · left: `run` declared in `compiler.bp` · machine 2
- [x] 788 — a top-level `comptime { … }` block: B-159 (cell `module_comptime_block`, the build prints held by a unit test until B-160) and 793's rules (cell `module_comptime_block_rules`); 793 (3) and 808 (an all-`comptime` function expanded wherever it is called, its `compiler.init` written at the call; cell `comptime_init_at_call_site`) — B-159 whole
- [ ] 789 / 790 — the CLI tells build prints from its messages (B-160, cut to that box: `cell check` leaves the CLI at the switch, 790 (3)), landed — a `cli_contract.sh` row proves the split; then the build answers a resolved program in three modes (798, B-163), and `cell check` becomes a botopink program over `io.process` that builds each package once into the intermediate and runs every target from it (B-161); B-157 piece 5 waits on B-161 · B-163: the load file checked for every manifest target (833) and `runtime-other-project` (838) landed; `--emit-resolved` one file per module, a context `createContext(v)`, a catalogue read as written (834, 835 (1), (3)); the origin comments (798 (2)) and `build_modes_same_answer` landed · machine 2
- [x] 160 `matchesRefused` (784, machine 2 by 785) — a loaded file's refusals recorded under subject `refused`, one block per `Diagnostic`, through the engine's path rule, format and `.new` flow; a file that compiles fails the test naming it; cell `snap_matches_refused` (`conformance/test/`) and its 166 draft · left: 786's shape, then B-157 piece 5 (781, 784)
- [x] 135 s0 (391) — the `snap` library: scaffolded and a submodule (`repository/snap`), `botopink.json`, the engine and std's four `.snap` moved in, std's `String.normalizeNewlines` / `trimTrailingNewlines` / `firstDifferingLine` and `fs.mkdirRecursive` (402), jhonstart and onze importing from `snap`, `contracts.md` § 7 — landed (botopink-lang `11bde540`, snap `30ee7f5`, jhonstart `d47fffc`, onze `b6b0e0d`; every `.snap` byte-identical); the old import keeps the plain unknown-module error, the pointer documentation (407) · none; 135 s1–5 write through it
