---
scope: >-
  Decides what `botopink.json` holds and how it is read: `"targets"` and their default, the OTP
  release, the `dependencies` object form and where a dependency is found, workspaces and what a
  member inherits, `"typings"`, `"wasm": { "host" }`, `"bpp"`, the reserved name `std`. What a module
  is and how it is imported is module-system; the code cache's internals are caches-and-build-outputs.
terms:
  - '`"targets"`'
  - '`dependency-target-missing`'
  - '`"workspaces"`'
  - '`{ "workspace": true }`'
  - '`"subdir"`'
  - '`bpmp link`'
  - '`BOTOPINK_LIB_ROOTS`'
  - '`manifest.isCheckoutRoot`'
  - '`"otp"`'
  - '`"typings"`'
  - '`--typescript`'
  - '`"wasm": { "host": "wasi" }`'
  - '`"bpp"`'
  - '`manifest-entry-in-library`'
  - '`.botopinkbuild/deps/`'
  - '`#[compiler.beamMemory(…)]`'
  - '`--cold`'
  - 'closure key'
related:
  - 'module-system'
  - 'caches-and-build-outputs'
  - 'module-vars-and-beam-memory'
  - 'wasm-target-and-runtime'
  - 'host-functions'
  - 'gate-and-ci'
open:
  - '509 (2): the cache''s level B (a dependency''s checked interface and generated code per target) waits until the invariant "analysis depends on the closure alone, never on the consumer" is proved by a test'
binds:
  - '`01-compiler/140`'
  - '`01-compiler/26`'
  - '`02-packaging` step 1; routes A/B in its § Mechanism are superseded'
  - '`02-packaging` step 2; every `examples/<project>/botopink.json`'
  - '`02/97` steps 11, 17'
  - '`02/98` (the manifest key)'
  - '`02/98` step 4'
  - '`05-jhonstart/26`'
  - '`05-wasm`'
  - '`07-onze/50`, `53`'
  - '`07-onze` (imports `jhonstart` only)'
  - '`08-bpp/116` step 1 (with `libs/std/src/bpp.bp`, a carve-out of `02-std-and-packaging`)'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` B-00j'
  - '`1-botopink-lang/144` B-37'
  - '`3-medium/163` s11'
  - '`machine-1/144` 592''s step'
  - '`machine-1/144` 676''s thread'
  - '`machine-1/165` s5'
  - '`machine-1/165` s5 (every library manifest)'
  - '`machine-2/144` B-138'
  - '`machine-2/98`'
  - '00-gate/111 step 5'
  - '00-gate/113'
  - '00-gate/132'
  - '07-h'
  - '17-beam-memory'
  - '25-gate-perf` step 4; `test-libs` and the gate run in place in a worktree'
retired:
  - '`#[BeamMemory.…]`, `#[@BeamMemory(…)]`'
  - '`keyed: true` and the per-process placement of a module `var`'
  - 'The `Typescript` implementation; `JavaScript`''s `types:` field'
  - 'No `"targets"` meaning all four (676 as built)'
  - '`jhonstart-styled`'
  - 'A library''s `"entry"`'
  - 'A `dependencies` string array'
  - 'a `path` dependency to a sibling workspace member'
  - '117 (8)''s "every rakun manifest is `["erlang"]`" (03r-a)'
  - '`scripts/restricted-targets.txt`, `scripts/known-red-libs.txt`, `--include-unsupported`, `expected-failures.txt`, `scripts/known-broken-examples.txt`'
  - 'A `// targets:` line in a single-file suite'
  - '`cache/erlcheck`, `cache/beam`'
first-step: 75
last-step: 770
in-force: 22
superseded: 0
---
# manifest-and-dependencies — `botopink.json`, targets, dependencies and workspaces

**The manifest is the single source of truth for what a package runs on and depends on; a restriction is checked, never listed.**

(1) Targets: declared, audited, defaulted, checked across dependencies — 153, 156, 167, 536, 676, 770, 334, 619, 620.

(2) OTP: one exact release — 228.

(3) Dependencies: the object form, `subdir`, where they are found, transitivity, the reserved name `std` — 76, 344, 143, 483, 453.

(4) Workspaces and members: what is shared and what is own, cells as members — 75, 512, 511, 703, 919.

(5) The code cache's manifest side and module `var` placement — 509, 547.

(6) Configuration in JSON, `"bpp"`, a library's `"entry"` — 284, 361, 733.

Steps: 75, 76, 143, 153, 156, 167, 228, 284, 334, 344, 361, 453, 483, 509, 511, 512, 536, 547, 619, 620, 676, 703, 733, 770, 919
Binds: 00-gate/113 · 00-gate/111 step 5 · 113 step 2 · 17-beam-memory · `08-bpp/116` step 1 · 119 steps 2–5 · `05-jhonstart/26` · `07-onze` · 144 B-57, B-60 · 00-gate/132 · 116 · 124 · 98 · `07-onze/50`, `53` · `01-compiler/140` · `02/97` steps 11, 17 · `05-wasm` · front 18 · `02/98` (the manifest key) · `02/98` step 4 · `01-compiler/26` · rakun 73 · 07-h · `1-botopink-lang/144` B-00j · 445 · `1-botopink-lang/144` B-37 · `3-medium/163` s11 · 144 B-61 · 144 B-58, B-61 · `1-botopink-lang/144` · `machine-2/144` B-138 · `machine-2/98` · `machine-1/144` 660's step · `machine-1/165` s5 · `machine-1/144` B-69, B-75

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 75 | 1.0.10-beta · (the maintainer, 2026-09-20) | **A `workspaces` manifest, npm-style, declares a library's members.** (C). `repository/<lib>/botopink.json` is a workspace, never a package: `"workspaces": ["modules/*", "examples/*"]`, no `src` / `entry` (`files` gone since 703); importing it is a located error. Each expansion holds a `botopink.json` whose `name` is its import name. `{ "workspace": true }` resolves a dependency to the sibling member by name — the only way a member depends on a sibling; a `path` to a sibling is a located error. `test-libs` and `botopink test` run every member, examples included, reporting per member; two members with one `name` across roots is a located error. Discovery is one shared function in the runner and the loader (read the umbrella, expand `workspaces`, each expansion a lib-root entry), no recursion, no environment variable. A workspace may carry `targets` as a default its members inherit and may only restrict; each `repository/<lib>` is a workspace, the meta-repo (no manifest) is not; the gate iterates the workspaces. Routes A/B of `02-packaging` § Mechanism are superseded | `02-packaging` step 1; routes A/B in its § Mechanism are superseded | |
| 76 | 1.0.10-beta · (the maintainer, 2026-09-20) | **`dependencies` is the object form only.** (a). `"dependencies": { "<name>": { "path" \| "git", "ref" } }` is the one shape, parsed by every reader (`config.zig`, `bpmp/manifest.zig`, `project_graph.zig`), `path` honoured; the string array is a located error. The pin is `branch \| tag \| rev` (exactly one), not a literal `ref`. `{ "workspace": true }` is the sibling form (75) | `02-packaging` step 2; every `examples/<project>/botopink.json` | |
| 143 | 24-f · (the maintainer, 2026-09-26) | **Library resolution stops at the enclosing checkout.** (a). The walk-up — `BOTOPINK_LIB_ROOTS`, then per ancestor `D`: `D` when it is a workspace, `D/repository/botopink-lang/libs`, `D/repository`, `D/libs` — stops after the first `D` holding `repository/` (the meta workspace, a worktree of it, or CI's `botopink-lang` checkout with the libraries in `repository/`); an ancestor of it is another checkout's. One predicate, `manifest.isCheckoutRoot`, serves the compiler's loader (`compiler-cli` `libs.zig`), `botopink-lib-test` (`discovery.zig`) and the language server (`project_graph.zig`). No flag widens it: a library outside the checkout comes through `BOTOPINK_LIB_ROOTS`, `--lib-root` or a `path` dependency. Dependencies are transitive: each dependency's own entries resolve from its manifest and directory (`{ "workspace": true }` from its workspace, `path` from its directory, `git` across the roots); every package loads once by import name, after every package it depends on. Refused, located at the entry that brought it in: one import name two packages resolve to two directories; a cycle between packages | `00 · 25-gate-perf` step 4; `test-libs` and the gate run in place in a worktree | |
| 153 | gate-a | The manifest is the single source of truth: `test-libs` runs a member on the targets its manifest declares and no other; `scripts/restricted-targets.txt`, `scripts/known-red-libs.txt` and `--include-unsupported` are removed; a restriction is audited structurally (156); a rakun member on a commonJS row is a manifest error (`03r-ah`) | 00-gate/113 | member_runs_manifest_targets_only |
| 156 | gate-d | A `.targets` narrowing or a manifest `targets` list is honoured everywhere and audited: a cell or member may exclude a target only when `botopink build --target <t>` refuses it with a host-binding error; any other outcome refuses the narrowing | 00-gate/111 step 5 · 113 step 2 | target_narrowing_needs_host_refusal |
| 167 | 111-a | A module-level `var` with `#[compiler.beamMemory(…)]` off the BEAM (commonJS, wasm) is a located refusal (amends 1.0.10's 43; amended by 547: accepted there, no effect), so a cell excluding those targets passes 156's audit by the ordinary rule; front 111's structural exemption goes; `test/beam_memory_noop` becomes a refusal cell | 17-beam-memory | beam_memory_refused_off_beam |
| 228 | gate-n | The compiler emits for one exact OTP release (28 — one constant, printed by `botopink --version`), never a range; `build` / `run` / `test` on erlang or beam refuse another `erl` on `PATH`; a manifest's `"otp"` must be a release the compiler supports, every package of a closure that declares one agreeing; `gate.sh` and the workflows take the release from the compiler | 00-gate/132 | one_exact_otp_release |
| 284 | nat-0 (rule 4) | `botopink.json` stays as clean as possible; a configuration lives in it or in another JSON file, case by case (`nat-f1`…`nat-f4`); `"bpp"` is required — one package name, `"bpp": "rakun-bpp"` — and the roles are found by `bpp`'s annotations (361) | 116 · 124 · 98 · `07-onze/50`, `53` | bpp_config_names_one_package |
| 334 | 97-a · 97-b · wasm-host | **A wasm build binds to the runtime it runs on; wasmtime with WASI preview 2 first.** (1) Two profiles, built together: `wasi` (wasmtime and the runtimes following WASI preview 2 — `wasi:http`, `wasi:clocks`, `wasi:io/poll`; the default) and `browser` (JS imports `fetch`, `setTimeout`, `Promise`; node runs it too); std binds a cell on both hosts or on neither (one only is refused by std's own check); every cell's wasm column runs under wasmtime and under node. (2) `botopink.json`: `"wasm": { "host": "wasi" }`, absent meaning `wasi`. (3) `#[compiler.external(.Wasm(…))]` takes `host: .Wasi \| .Browser` only where the hosts differ (394); a binding without `host:` serves every profile; a cell with no binding for the build's host is the located `std-unsupported-on-target` naming the host. (4) `Async<T>` on wasm behaves as a Promise (392): one scheduler over `wasi:io/poll` / the JS event loop; an adapter may answer `Async<T>` (393); `io/http`'s `fetch` binds to `wasi:http`, `async`'s cells to the clock and pollables. `unicode.normalize` stays 333 (A)'s botopink body | `01-compiler/140` · `02/97` steps 11, 17 · `05-wasm` · front 18 · `02/98` (the manifest key) | wasm_host_profiles_wasi_browser |
| 344 | lg2-v | **A git dependency may name a package inside its repository: `"subdir"`.** `{"git": "https://github.com/botopink/rakun", "ref": "v1.0", "subdir": "modules/rakun-web"}`: `bpmp` clones the repository at `ref` once, reads the package at `subdir`, resolves its `path` dependencies inside the same checkout; two dependencies on one repository at one `ref` share the checkout. Refused, located in the manifest: `subdir` without `git`; absolute or leaving the checkout (`..`); with no `botopink.json` or a workspace manifest; one repository at two `ref`s, naming both dependencies. `DepSpec` (`modules/manifest/src/root.zig`) gains the field | `02/98` step 4 · `01-compiler/26` · rakun 73 · 07-h | git_dependency_subdir |
| 361 | (bpp) | **std's module `bpp` holds the four role annotations; `rakun-bpp` is one package; the manifest names it alone.** (1) `libs/std/src/bpp.bp` (`import {bpp} from "std";`, written `#[bpp.html]`) is the contract between toolchain and framework: four annotations in 302's shape — `html` (the markup's unfold target), `htmlPrelude` (its prelude), `style` (the style section's unfold target), `stylePrelude` (its prelude). (2) `#[bpp.html]` / `#[bpp.style]` go on the two template functions (`pub default fn html(…)`, `pub fn style(…)`); a prelude is a module (270) and a module takes no annotation (315), so `#[bpp.htmlPrelude]` / `#[bpp.stylePrelude]` go on a marker `val` the prelude module declares (`#[bpp.htmlPrelude] pub val prelude = bpp.Prelude();`, 356), that module's imports being the prelude (amended by 589: the marker goes on each prelude item where it is declared; `src/prelude.bp` and its marker `val` are removed). (3) One package: the former styled member is merged into the core (its style function, scoped `use`, run-time holes, the `StyledContext` provider, `#[styled(…)]`, the sink); the core depends on `rakun-style` (`rakun-style` and `css` know no `rakun-bpp`, 338 (4)). (4) `"bpp": "rakun-bpp"`, one package name; the toolchain finds the roles there by `bpp`'s annotations: `html` exactly once (missing or twice an error at the key naming the declarations), the others at most once; a `.bpp` style section in a project whose package has no `#[style]` is an error at its `--- style ---` line (338 (7)). (5) The toolchain knows (285) only the package `"bpp"` names and the declarations std's `bpp` annotations mark in it | `08-bpp/116` step 1 (with `libs/std/src/bpp.bp`, a carve-out of `02-std-and-packaging`) · 119 steps 2–5 (in the core) · `05-jhonstart/26` · `07-onze` (imports `jhonstart` only) · 124 (the scaffold's manifest) | std_bpp_role_annotations |
| 453 | 445-a | **The package name `std` is the bundled standard library's alone.** A `botopink.json` named `std` that is not the bundled `libs/std` is refused at the manifest, located: `` error: the package name `std` is the bundled standard library's — choose another name ``; the bundled std is recognised as today (the embedded modules, the prelude, the root package `libs/std`) | `1-botopink-lang/144` B-00j · 445 | std_package_name_reserved |
| 483 | 143 | **A project's dependencies are found in its own `.botopinkbuild/deps/`, as `node_modules`; a library task holds its repository alone.** (1) A `git` dependency resolves first from `<project>/.botopinkbuild/deps/<name>/`; the walk-up to an enclosing `repository/` is a fallback (`BOTOPINK_LIB_ROOTS` first when set); `path` and `workspace` unchanged. (2) `bpmp link` links each dependency of the manifest to a local checkout (`.botopinkbuild/deps/<name>` → `<checkout>/repository/<name>`), cloning nothing; CI keeps `bpmp install`, which fetches. (3) A library's gate finds the compiler at `<project>/.botopinkbuild/bin/botopink` first (`locateBotopink`), before the enclosing checkout's. (4) `scripts/worktree-add.sh --repo <lib>` makes `.tasks/<name>/<lib>` alone (no sibling links), runs `bpmp link` against the main checkout and links `.botopinkbuild/bin/botopink` to its compiler; a compiler task (`--lang`) still sees every library (its `test-libs` runs them all). Amends 143 | `1-botopink-lang/144` B-37 · `3-medium/163` s11 | dependencies_resolve_from_project_deps |
| 509 | B-58 | **One code cache, the CLI's, for every target; what a test exercises never comes from it.** (1) Only dependencies are cached: the package under test (a cell's own, the member whose tests run, the project built or run) is always analysed, generated, compiled and run; its dependencies (std, a `path` or `git` dependency, a library) may come from the cache. (2) Level A, first: every target's toolchain step after the codegen, for a dependency's modules, keyed by its input bytes and the tool's version — erlang's `.erl` → `.beam` (the options, the OTP release, the erts / `compiler` / `stdlib` versions; a source with `-include` or `parse_transform` is never looked up), wasm's module assembly and its runtime's precompile, any later step a target adds; one mechanism for every target; it replaces `cache/erlcheck` and `cache/beam`; `build`, `run`, `test` and `cell check` read it. Level B, later, only after a test proves "a package's analysis and generated code depend on its dependency closure alone, never on its consumer": a dependency's checked interface and generated code per target under its closure key. (3) The closure key (a hash): the package's files by content, its dependencies' closure keys (Merkle), the target, the compiler's sources by backend partition (249's `backend-partition.txt`); never the binary's hash alone. (4) Where: 225's cache root — the workspace root, else the project's own; every `conformance/modules/` is a workspace of its cells (`"workspaces": ["*"]`), sharing `conformance/modules/.botopinkbuild/cache/`. An entry is stored by its hash, never by a package or module name; a program never runs from the cache — an entry is materialised (hard link, else copy) into the project's own output directory. (5) `--cold` on `build`, `run`, `test` and `cell check` reads nothing and writes what it ran; a gate's `--cold` hands it on; CI and a landing run cold. Only a success is stored, nothing when a key cannot be computed with certainty; concurrent writers stage and rename, no lock. (6) Order: B-57, then level A (B-58), level B (B-60) | 144 B-57, B-58, B-60 | only_dependencies_code_cached |
| 511 | B-61 · (process) | **A cell's package name is its directory's name.** The `name` of `conformance/modules/<cell>/botopink.json` is `<cell>`, in botopink-lang and in every library; a missing or wrong name is filled by a one-off script, never checked by `cell check` (512 (1) refuses a member without a name or with a duplicate); no two cells share a package name, so none share a module name (`<name>@main`) | 144 B-61 | cell_package_named_by_directory |
| 512 | B-58 | **A workspace declares what its members share; a member declares only its own** (75's rules kept). (1) A member's `name` is required and unique in its workspace — missing or repeated is refused, located (75) — so no two members emit a module of one name (`<name>@<path>`); a cell's name is its directory's (511). (2) The workspace's `dependencies` are inherited by every member, a `path` resolved from the workspace's manifest; a member may add its own; redeclaring an inherited one is refused, located (one source per dependency). (3) `targets` and `otp` are inherited, a member only restricting `targets`. (4) `src`, `entry` and `version` default to `src/`, `main.bp` and the workspace's version, written only when they differ. (5) Every `conformance/modules/` is such a workspace (`"workspaces": ["*"]`) declaring its cells' shared dependencies and targets: one dependency closure, one cache (509 (4)) | 144 B-58, B-61 | workspace_members_declare_own |
| 536 | B-64-a · (process) | **A single-file `test/` suite never narrows its targets.** (a): a `test/` suite that narrows its targets is a project suite — its own directory with a `botopink.json` naming `"targets"`, as a cell (475 (1)); a single file declares no narrowing; the `// targets:` line is removed (one place for a restriction, the manifest; the compiler reads no configuration from a comment); the seven suites become seven directories | `1-botopink-lang/144` | test_suite_narrows_by_manifest |
| 547 | 17-c | **A module `var` is one value for the whole program on every target; an annotation only picks how the BEAM holds it.** A module-level `var` stays, its data immutable (`counts = counts.insert(k, v)` is Erlang's `Counts2 = maps:put(…)`); unannotated it is one value for the whole program on every target (amends 430's per-process BEAM default): BEAM a one-row ETS table, commonJS a variable, wasm a permanent root outside every heap (522 (6)). The annotation keeps two members only, a closed enum as 518's `WasmNeed`, in 302's shape: `#[compiler.beamMemory(.Ets)]` (the default, a one-row ETS table) and `#[compiler.beamMemory(.PersistentTerm)]` for a `var` written rarely and read much (a write scans every process; documented and weighed by the writer, not checked); any other value is refused at the annotation. Off the BEAM it is accepted with no effect (amends 167). `keyed: true` and the per-process placement are removed (amends 38, 63); the checker's keyed rules (`noteKeyedRowRead`, `checkKeyedWrite`, `refuseKeyedWholeRead`) and the row lowerings go; `Dict.bump` (340, B-26) is a plain `Dict` method. Amended: (i) on the BEAM the runtime creates every module `var`'s ETS table at boot (`botopink run`'s `main`, the application's start) in a process living as long as the program and runs the initializers once — a table never belongs to the first process touching the `var`; on commonJS and wasm the initializer runs at module load. (ii) A reassignment reading the `var` it writes (`x = f(x)`) is atomic on the BEAM — read, compute, `ets:select_replace` against the value read, retried when another process wrote between — so no write is lost and the answer is commonJS's and wasm's; a plain `x = v` is one insert. (iii) A module `var` whose type holds an `Async<T>` is refused, located, on every target (a task never crosses heaps, B-30-b). (iv) 376's resource "a module's mutable state (a `keyed: true` var)" reads "a module `var`" | `1-botopink-lang/144` | module_var_one_program_value |
| 619 | impl-b · (the maintainer, 2026-10-18) | **TypeScript is no part of `Implementation` — no variant, no `types:` field; the `.d.ts` emission is a package configuration, `"typings": true` in `botopink.json`.** Amends 618 (its `types:` field goes) and 575 (6). A source of `Implementation` is host code a target runs; a `.d.ts` types the commonJS output and runs nothing; `codegen/typescript.zig` derives every typing from the botopink declaration, no template. The enum: `Erlang(template = null, body = null, inline = false, result = false) \| JavaScript(template = null, body = null, result = false) \| Wasm(template \| op \| std \| wasi \| body — one —, host, needs, result)`; `parser/implementations.zig`'s `.typescript` row and every reader go. `"typings": true` makes the commonJS build write a `.d.ts` beside each `.js`; `botopink build --typescript` stays beside it (620: either turns the emission on) | `machine-2/144` B-138 · `machine-2/98` | typings_in_manifest_not_implementation |
| 620 | impl-c · (the maintainer, 2026-10-18) | **The `.d.ts` emission is switched by either the package's `botopink.json` (`"typings": true`) or the CLI (`botopink build --typescript`): the manifest is the package's default, the flag turns it on for one build.** Amends 619's removal of the flag; the rest of 619 stands. Each only turns the emission on — no `--no-typescript`, no `"typings": false` — so a build emits the `.d.ts` when either says so; `compiler-cli/AGENTS.md` and `conformance/docs.md` state both; the library gates and `scripts/tsc-check.sh` keep the flag | `machine-2/144` B-138 · `machine-2/98` | typings_from_manifest_or_flag |
| 733 | ctr-ad · (the maintainer, 2026-10-18) | **(a): a library has no `"entry"` — an executable's key alone, refused in a library's manifest.** 592 (2) stands whole (every file under `src/` is a module; a library has no entry); 677 keeps its root-package rule (every module in the program; `"entry"` says only where `main` starts, `main.bp` when absent) and its `root.bp` clause is dropped: an `"entry"` in a manifest with no `main` is `manifest-entry-in-library`, located at the key, naming the package. Cell `library_manifest_entry_refused` (reject) | `machine-1/144` 592's step · `machine-1/165` s5 (every library manifest) | library_manifest_entry_refused |
| 770 | 676-a · (the coordinator †, 2026-10-19; built as (b) by machine 1, held) | **(a): a package with no `"targets"` holds the intersection of its dependencies' targets (and its workspace's, when a member); 676 refuses only a declared target a dependency lacks.** A target set is stated once, where a host binding decides it, and flows to what uses it. Cell `targets_default_is_dependencies_intersection`: no `"targets"` over an erlang-only dependency builds for erlang alone; the same cell declaring `"commonJS"` is `dependency-target-missing` | `machine-1/165` s5 · `machine-1/144` 676's thread | targets_default_is_dependencies_intersection |
