---
from: machine-2
to: maintainer
purpose: question
subject: 1096: before/after split done, but found 2 real regressions — stopping before landing
read: [ ]
in-reply-to: machine-2/20261102-1348-good-diagnosis-stays-yours-decided-as-mt-0230.md
---

Re-swept all 298 after the fix. Split, by prior status:

- AFFECTED → OK: 49 (the fix alone resolved these)
- AFFECTED → OTHER-FAIL: 17, including 985 and 900 — their real wasm symptom is now visible (haven't individually inspected each, that's the next-up work for whoever picks up 900/985)
- AFFECTED → AFFECTED: 1 — `i64_is_64_bit_everywhere-319`, explained: one of its own cases (`std_io_i64_canonical`) genuinely imports `io.fs` itself, not through the scaffold — expected, not a fix gap
- OTHER-FAIL → OTHER-FAIL: 23 (unchanged, unrelated)
- **OK → OTHER-FAIL: 2 — real regressions, confirmed, not a cache or stale-binary artifact**

The two: `declared_dependency_modules_join_program-660` and `no_declaration_files_compiler_value-575`. Both now fail at the wasmtime level (not botopink's own compile): `` type mismatch for export `set:entries`/`set:table` of module instantiation argument `<module>@registry@root` / `<module>@routes@registry` — expected (func (param structref)), found (func (param arrayref)) ``. Confirmed real: reverted candidate.bp to the original on disk, cleared every `.botopinkbuild` in the worktree, rebuilt botopink fresh with `-Doptimize=ReleaseSafe` — original passes both, my version fails both, every time. Not decision 1090/b162wasm-c's known masking-by-stale-binary pattern; this reproduces freshly both ways.

Both failing cells test multi-module linking specifically (one's named for it: "declared_dependency_modules_join_program"; the other hits a "routes@registry" argument). My only change is adding one new `declare fn` with a `.Wasm(body: …)` implementation to `conformance/lib/candidate.bp`, a dependency every module links. My best guess: adding any new declared/external fn to a commonly-linked dependency shifts something in GC type-index allocation that these two join-scenarios are sensitive to — but I haven't isolated further, and this smells adjacent to (not identical to) the wasm-unit-cache territory front 228 just opened for machine-1.

Not landing anything. Options as I see them: (a) I dig into why a new declared fn in a shared dependency breaks GC type linking for these two join-scenarios specifically, before landing 1096 at all; (b) land 1096 anyway and file the 2 regressions as their own row, since the net is +66 fixed/unmasked for -2 broken; (c) try a different implementation of 1096 that doesn't add a new declared fn to conformance-lib (I don't have another idea yet that avoids the all-body refusal otherwise). Your call — this isn't something a decision already answers.
