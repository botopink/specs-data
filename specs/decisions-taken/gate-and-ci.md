---
scope: >-
  Decides the gates: `scripts/gate.sh` in every repository, the commit hook's `--no-conformance` step
  gate, `feat`'s conformance pipeline read after the fact by a front's Conformance step, landing on
  `feat`, the meta repository's machine-wide job pool (capacity, admission, `run` / `exec`),
  botopink-lang's CI rows and the library workflows. What a cell is and how it is checked is
  conformance-suite; fronts and threads beyond the gate are process-and-ownership.
terms:
  - '`scripts/gate.sh`'
  - '`--no-conformance`'
  - '`feat`'
  - 'Conformance step'
  - '`test-libs`'
  - '`test-cli`'
  - '`gate.sh run`'
  - '`exec --jobs`'
  - '`POOL_MEMORY_MARGIN_MIB`'
  - '`scripts/gate-test.sh`'
  - '`scripts/land-check.py`'
  - '`hook-integrity.yml`'
  - '`test.yml`'
  - '`cancel-in-progress`'
  - '`host-binding-missing`'
  - '`budget_cold`'
  - '`erlang@28`'
  - '`-Doptimize=ReleaseSafe`'
  - '`objdump -T`'
related:
  - 'conformance-suite'
  - 'process-and-ownership'
  - 'caches-and-build-outputs'
  - 'backends-and-run-time-output'
  - 'formatter'
open:
  - '469 (4): until 150 s25 moves rakun''s timing tests to a controlled clock, two large gates together can redden them'
  - '158: the windows CI row returns once the snapshot capture normalises CRLF and path separators'
  - '265: the 5-minute cold target is a `deferred.md` row'
binds:
  - '`1-botopink-lang/144` B-29'
  - '`1-botopink-lang/144` B-29 step G'
  - '`1-botopink-lang/144` B-29 step J'
  - '`1-botopink-lang/144` B-29 steps I, J'
  - '`3-medium/163` s12'
  - '`3-medium/163` s7'
  - '`machine-2/144` (lib-test-runner, `scripts/test-libs.sh`)'
  - '`machine-2/163`'
  - '00-gate'
  - '00-gate 101'
  - '00-gate/111 step 4, after 110 step 3'
  - '00-gate/114'
  - '00-gate/133'
  - '01-compiler/26'
  - 'process'
retired:
  - 'The one-gate-at-a-time lock'
  - '`scripts/restricted-targets.txt`, `scripts/known-red-libs.txt`, `--include-unsupported`, `expected-failures.txt`, `scripts/known-broken-examples.txt`'
  - 'The windows CI row'
  - 'A scratch location named in a spec (`.tasks/<name>` paths, `` `/tmp/` ``, a task branch, a worktree by name)'
  - 'the one-gate-per-machine lock (`scripts/AGENTS.md` § Gate lock); botopink-lang''s gate lock'
  - '`HOST_BINDING_MARK`''s text match in `lib-test-runner/src/runner.zig`'
  - '468 / 469''s pool sizing `min(cpus, MemAvailable / 768 MiB) / 2` and their strict first-come admission'
first-step: 154
last-step: 920
in-force: 25
superseded: 1
---
# gate-and-ci — the gates, the pool, the pipeline and landing

**`scripts/gate.sh` is every repository's one gate; the commit hook runs it without conformance, the pipeline with, after, and nobody waits; the meta `scripts/gate.sh` schedules the machine's gates under one pool.**

(1) One gate per repository; the commit hook's step gate — 460, 470, 508, 154, 161, 162, 920.

(2) Landing on `feat`; the Conformance step reads the pipeline after the fact — 477, 474, 478, 479, 484, 528.

(3) The machine-wide pool: commands, capacity, admission — 468, 469, 473, 674, 717.

(4) CI rows of botopink-lang and the libraries — 219, 226, 227, 231, 158.

(5) `test-libs` runs and the cold budget — 258, 265.

Steps: 153, 154, 158, 161, 162, 219, 226, 227, 228, 231, 249, 258, 265, 460, 466, 468, 469, 470, 473, 474, 477, 478, 479, 482, 484, 508, 524, 528, 674, 717, 920
Binds: 00-gate/113 · 00-gate/111 step 4, after 110 step 3 · 00-gate/114 · the five libraries · 01-compiler/26 · 00-gate 101 · 108 · 109 · onze's and rakun's workflows · 00-gate · 00-gate/133 step 3 · 00-gate/133 · `1-botopink-lang/144` B-29 step G · 249 · 458 · 459 · `1-botopink-lang/144` B-29 steps H, I · `3-medium/163` s4–s7 · 457 · 460–465 · `1-botopink-lang/144` B-29 step J · `3-medium/163` s7 · 460 · 466 · `1-botopink-lang/144` B-29 steps I, J · 468 · every front · 465 · 469 · 470 · 430 · 474 · 476 · 477 · 478 · `3-medium/163` s10 · every thread · `3-medium/163` s12 · 144 B-29 step J, 163 s7 · process · `machine-2/163`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 154 | gate-b · (process) | `expected-failures.txt` is removed (once at zero lines); `run.sh` reads no such file and prints two numbers; a red language cell is red | 00-gate/111 step 4, after 110 step 3 | |
| 158 | gate-f · (process) | The windows CI row is deleted, not soft, until the snapshot capture normalises CRLF and path separators — then hard; the gap is listed in `status.md` | 00-gate/114 | |
| 161 | gate-i · (process) | A library pre-commit hook that cannot find the compiler refuses the commit, and refuses a staged `*.snap.new` / `*.snap.md.new`; `scripts/known-broken-examples.txt` and its code path are removed; one hook text across the libraries (CI check 4) | the five libraries | |
| 162 | gate-j · (process) | A library's CI matrix is its manifests' target set, every row hard; no row for a target `botopink test` cannot run; every member and example through the runner's discovery on every row | the five libraries | |
| 219 | ci-a · (process) | `build.zig`'s glibc target is 2.35 (the binary runs on ubuntu-22.04 and newer; that workflow row stays), checked by `objdump -T` listing no `GLIBC_2.36`-or-newer symbol | 01-compiler/26 · 00-gate/114 | |
| 226 | gate-l · (process) | botopink-lang's `test.yml` builds and runs every stage after the unit tests with `-Doptimize=ReleaseSafe` (what `gate.sh` builds and `release.yml` ships); `zig build test` stays Debug in both | 00-gate/114 | |
| 227 | gate-m · (process) | The macOS rows of the library workflows install `erlang@28` (`brew install erlang@28 && brew link --force erlang@28`), one text in all, as the linux rows pin `otp-version: '28'`; a move to OTP 29 changes them at once | 00-gate 101 · 108 · 109 · onze's and rakun's workflows | |
| 231 | gate-p · (process) | `test-web` is a gate stage: `gate.sh` runs `zig build test-web` beside stages 7–11 | 00-gate | |
| 258 | lib-a · (process) | `test-libs` given several `--lib` runs every one, in order, in one report | 00-gate/133 | |
| 265 | process | The cold budget is 7m30s (`budget_cold=450`); the 5-minute target is a `deferred.md` row; over budget is a yellow line, never a red | 00-gate/133 | |
| 460 | (process, gate, the maintainer, 2026-10-11) | A step's commit runs the step gate. (1) The commit hook on a `front/*` branch runs `scripts/gate.sh --no-conformance` (470): formatting, the build, `zig build test` (all of compiler-core), `test-cli`, and the `test-libs` libraries the step reaches by the backend partition (249) — a change only in one backend's files runs that backend's part, a change in a shared file (comptime, the checker, the dispatcher) runs all. (2) Conformance (every cell) is `feat`'s GitHub pipeline, read by the front's Conformance step (477). (3) A front's steps land on `feat` as they pass their hook gate (477 (1)). (4) The branch decides the mode — structural, never a flag or variable a commit sets (67) | `1-botopink-lang/144` B-29 step G · 249 · 458 · 459 | |
| 468 | (process, gate, the maintainer, 2026-10-11) | A machine-wide job pool replaces the one-gate-at-a-time lock (`scripts/AGENTS.md` § Gate lock, removed). (1) Every gate the coordinator runs draws its jobs from one token pool at a fixed per-machine path (a jobserver: a token directory or a FIFO under the user's runtime directory), sized to the CPUs bounded by memory, a job counted as its runnable threads (about two: the `botopink` child and its `erl` / `node`); a stage takes a token per job and returns it when the job ends. (2) The pool lives only in the meta repository's `scripts/gate.sh` (469). (3) A gate's `test-out` in a library (a `--repo` / `--lang` worktree's linked siblings are the main checkout's) is written under a directory of its own run, removed after. (4) The fixed path is structural, never a flag or variable a commit sets (67). (5) Measuring a gate's time waits for the pool to be empty | `1-botopink-lang/144` B-29 step J · `3-medium/163` s7 · 460 · 466 | |
| 469 | 468 · (process) | The pool and the scheduling live only in the meta `scripts/gate.sh`. (1) The meta `scripts/gate.sh` (`botopink/projects`) is the machine's scheduler (473): it owns 468's pool, decides how many gates run together and hands each its share of jobs; the coordinator runs every local full gate through it. (2) Each `repository/*/scripts/gate.sh` knows no pool and no lock: it takes a total of jobs (default the machine, as alone in CI or a standalone clone), splits it among its stages and offers `--no-conformance` (470); botopink-lang's gate lock is removed. (3) A library's per-run `test-out` directory stays in the repository's gate (correctness, not scheduling). (4) The commit hook's gate runs free, outside the pool. Until 150 s25 moves rakun's timing tests to a controlled clock, two large gates together can redden them — the step that meets it reruns, never marks it passed | `1-botopink-lang/144` B-29 steps I, J · `3-medium/163` s7 · 460 · 466 · 468 | |
| 470 | (process, gate, the maintainer, 2026-10-11) | The commit hook runs the gate without conformance; the GitHub pipeline runs it with, after; nobody waits for it. (1) Commit hook, every repository: `scripts/gate.sh --no-conformance` — on a `front/*` branch 460's step gate without the conformance cells (`botopink-lang/conformance/`; a library's `conformance/`). (2) A front's Conformance step reads the pipeline's verdict (477). (3) The pipeline runs `scripts/gate.sh` with conformance on every push to `feat` (botopink-lang's and the libraries'): a check after the fact; a red opens a structural fix at once (430, 478), never a revert; no step waits on it. (4) 468 / 469's pool serves the gates the coordinator runs locally | every front · 459 · 460 · 465 · 466 · 469 | |
| 473 | 469 · (process) | The meta `scripts/gate.sh` orchestrates the gates of `repository/*` and of the open tasks under `.tasks/`. (1) `scripts/gate.sh` — the meta repository's own checks (`hook-integrity.yml`'s, locally); `scripts/gate.sh run <repository\|task> …` — those gates together under the pool, each the repository's own `scripts/gate.sh` with its share of jobs; `scripts/gate.sh tasks` — every open task's gate; `scripts/gate.sh libs` — every library's gate on the main checkout's compiler; `scripts/gate.sh status` — what runs and what waits, each one's stage and time. (2) Tasks are found by `git worktree list` of the meta repository and the submodules, a task's own repository told from its linked siblings. (3) A repository's gate knows nothing of it (469); in CI or a standalone clone each runs alone. (4) The commit hook's gate (470) runs outside it. (5) It runs and reports; landing stays the coordinator's. (6) Each run's log is scratch; specs never name it | `3-medium/163` s7 · 468 · 469 · 470 | |
| 474 | (process, the maintainer, 2026-10-11) | A front's Conformance step (its last, 459, 465) reads with `gh` (read only) the pipeline of each repository the front changes: (1) the runs on `feat` since the front's base — every run green, or each red named with its job and cause; (2) a red the front's change causes is fixed at once (477 (2)), a structural fix (430), never a rerun until green, never a red marked passed; a red predating the front and not its doing is filed as its own row and named in the step's report; (3) the report carries the pipeline's state (each repository, its last run on `feat`, green or the reds named) | every front · 459 · 465 · 470 | |
| 477 | 476 · (process) | A front lands on `feat` without waiting for conformance. (1) It lands — its steps pushed to `feat`, fast-forward, never forced — once its commits passed their hook gate (`--no-conformance`, 470 (1)); conformance is no precondition to join the remote `feat`. (2) The pipeline runs `scripts/gate.sh` with conformance on that push; the Conformance step waits on that run (`gh`, read only) and reads `feat`'s runs since the front's base (474): all green → done; red → reproduced locally (conformance runs locally only then), fixed at once as a structural fix ahead of every other step (430) with 478's cheap test, pushed, read again — never rerun until green, never marked passed. (3) No `front/*` branch goes to GitHub: the workflows run on `feat`. Replaces 476 | every front · 430 · 470 · 474 · 476 | |
| 478 | 477 (2) · (process) | When `feat`'s pipeline is red at a front's Conformance step: (1) the cause is found (reproduced locally); (2) the step asks whether a test the repository's hook already runs — a compiler-core unit or snapshot test, a CLI test, a library member's `test` block — would have caught it; (3) if yes, it is written, red on the breaking commit and green on the fix (the conformance cell stays too); (4) if no cheap test can catch it (a behaviour only a whole program on a real runtime shows), the report says why. Fix and test land together | every front · 430 · 458 · 470 · 477 | |
| 479 | (process, the maintainer, 2026-10-11) | A front's Conformance step holds back no front building on it: once its other steps landed on `feat` (477 (1)), a front needing the change opens at once. A red the Conformance step later finds is fixed ahead of every other step (430, 478); a front already building on the change rebases on the fix | every front · 430 · 459 · 465 · 477 · 478 | |
| 482 | (process, the maintainer, 2026-10-11) | Overtaken by 1107 | `3-medium/163` s10 | |
| 484 | (process, the maintainer, 2026-10-11) | (1) Every thread reads `scripts/thread-rules.md` first; its prompt states only the task's own step, boxes, worktree and model. (2) A thread fetches and rebases onto `origin/feat` right before its final commit, so a landing is a fast-forward and the full gate is not re-run at the landing (conformance stays `feat`'s pipeline's, 477). (3) A thread's report is four lines — Done, Commits, Outside, Questions — one line per item, details on request. (4) `scripts/land-check.py` checks a branch before it lands — scratch references, commit hashes in specs, `.snap.new` files, an English/Portuguese pair's ids and code blocks, fast-forward onto `feat` — printing green or each reason. (5) Spec and decision text is never written on `haiku`; a thread writing a cell's expected answer runs on `opus` unless its prompt fixes every answer. (6) Once the meta `scripts/gate.sh` pool lands (163 s7), the number of threads is bounded by the pool's jobs, not a fixed count | every thread · `3-medium/163` s12 | |
| 508 | B-29J · (process) | A gate run with `--no-conformance` takes no lock: botopink-lang's `scripts/gate.sh --no-conformance` (the commit hook's run, staged or not) neither waits on nor holds the one-gate-per-machine lock, and the meta `scripts/gate.sh run` admits it at once (`min(share, free)` jobs, one when none is free), never waiting on the pool; only a run with conformance — the full gate, a Conformance step, a landing, `--cold` — keeps the lock and waits for a free job. Amends 470's hook and 468's admission | 144 B-29 step J, 163 s7 | |
| 528 | B-29-a · (process) | A push to `feat` runs in a CI concurrency group of its own commit — `group: test-${{ github.ref }}-${{ github.event_name == 'push' && github.sha \|\| 'pr' }}`, `cancel-in-progress` kept for pull requests — so every commit on `feat` runs to the end with its own verdict, read by 474 and 477; runs past the concurrent-job limit queue, none cancelled (public repositories: no minutes billed); the same in every repository whose `test.yml` cancels `feat` runs (botopink-lang's and the libraries') | `1-botopink-lang/144` B-29 · every library front · 474 · 477 | |
| 674 | pool-a · (process, the coordinator †; the maintainer, 2026-10-18: "always keep checking the memory, always leave a free margin") | The pool's capacity is `max(1, min(cpus / 2, (MemAvailable − 2 GiB) / 768 MiB))`, re-read on every pass of every admission (469); the CPU half is never applied to the memory bound; 2 GiB (`POOL_MEMORY_MARGIN_MIB`, a constant of `scripts/gate.sh`, not a flag) always stay free — amends 468 / 469's `min(cpus, MemAvailable / 768 MiB) / 2`. As `MemAvailable` falls the free jobs fall with it; below the margin no new gate is admitted while one runs; one job always exists; `status` prints the memory available and the margin. Nothing else of the pool changes (share, leases, `exec`, 470's hook outside the pool) | process · `machine-2/163` | |
| 717 | 163-s13 · (process, the coordinator †, 2026-10-18) | While the pool is not empty, a gate asking for fewer jobs than the capacity may be admitted ahead of older waiters that all ask for the whole pool, at most one such pass in flight; small gates stay first come, first served among themselves; a full-pool gate starts only on an empty pool. Amends 468 / 469's strict order (and `fronts.md` § Gate's statement of it); 674's capacity and the stagger are unchanged. Tested by `scripts/gate-test.sh` in a private pool, red with the pass disabled; its environment overrides `BOTOPINK_POOL_CAPACITY` and `BOTOPINK_POOL_STAGGER` are the test's alone — `gate.sh` outside the test never sets them — and the pool path stays fixed (67) | process · `machine-2/163` | |
| 920 | Choices made by the 00-gate threads and the consolidation (5) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: 113-b as built — a reworded refusal would pass the audit silently (67)) | The five choices stand except: 110-b and 112-a have no object (466, 524); 113-b reversed — the restriction audit matches a refusal's id, never its text. (1) 111-b confirmed, names amended: erlang `codegen/crossModule.zig` `bindsErlangHost`, beam `beam_asm.zig` `bindsBeamHost` / `buildBindsBeamHost`. (2) 113-a as built: `scripts/test-libs.sh` counts `skipped_unsupported` as NOT RUNNABLE and fails. (3) 113-b: a library test refused because the target has no binding for a host function carries the id `host-binding-missing`, beside 334 (3)'s `std-unsupported-on-target`; `lib-test-runner/src/runner.zig` matches the id (`HOST_BINDING_MARK`'s text match removed); 510 untouched. (4) 110-b: `tests/language/` went with 466; 112-a: the `format-check` stage and `scripts/format-check.sh` went with 524 | `machine-2/144` (lib-test-runner, `scripts/test-libs.sh`) | host_binding_missing_has_id |
