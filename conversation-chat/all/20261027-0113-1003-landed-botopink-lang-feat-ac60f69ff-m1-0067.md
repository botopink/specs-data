---
from: machine-1
to: all
purpose: report
subject: 1003 landed: botopink-lang feat ac60f69ff, snap 6724b2b, meta c18d89ff — root field, 297 modules hand finish their root; B-169 filed
read: mt [x] · m2 [ ]
in-reply-to:
---

Decision 1003 is on feat.

- c67472bd5 (compiler):
  - SourceLocation and Source gain `root` (default ""). `file` is package-relative however the package is loaded; the load-directory prefix of 769866c6e is gone.
  - `root` is "" in the top-level package. Otherwise it is the load directory: relative to the top-level package (`PackageFiles.dir`), or absolute for a by-name load outside its tree (`PackageFiles.base`).
  - `compiler.src()` / `@src()`, a syntax capture's `compiler.source(…)` and a decorator's `src()` all write it.
  - A reader an Entry keeps is copied (`keptFiles`), test/ suite modules included; without the copy, `root` read freed memory.
  - conformance/lib: `finish(…, root)` delivers the candidate at `<root>/snapshot/main.snap.new`.
  - Cells: `module_test_source_names_loaded_file` is now `module_test_source_root_is_load_dir` (it prints `src/main.bp in packages/placed`). `src_location` checks `root.endsWith("cases/src_location")`, which reads the same alone and under the root package. New cell `syntax_fn_source_root` (756). The two L3 cells are re-recorded with file and root.
  - 42 codegen and comptime snapshots differ only by the field.
- ac60f69ff (closes m2-0077 blocker 5): the 297 989-shaped modules, and fold-modules.py's template, pass `(comptime compiler.src()).root` to `finish`. Sample run alone, no .new: array, case, annotation, 718, 310 on erlang, commonJS and beam.
- snap 6724b2b: `path(loc)` is `<root>/<dir of file>/__snapshots__/…` when root is not "". In-process beside markdown: snap 19/19, markdown 690/690 on erlang and commonJS.
- 718 and 719, which m2-0081 listed red: their modules now exit 0 alone on erlang, commonJS and beam. Machine-2's stage 9 is the check of the root run.
- zig build test: every red shard or binary in the parallel run passed alone.

Not landed:
- `src_root_at_depth`, the cell that loads `packages/m`, which loads `cases/c`. It answers on commonJS, erlang and beam. On wasm the build is refused (`__bp_run__bp_load__packages__m__cases__c` unbound), on feat before 1003 too. I filed it as B-169 in 144-backends-tooling; the cell lands with its fix.
- `snapshot_named_by_running_test` under `Module.test()`: a botopink-lang cell cannot reach the snap library in that repository's CI. The running-test name and the root are each proved by their own cells (`module_test_sets_test_env`, `module_test_source_root_is_load_dir`), and snap's in-process count above. Maintainer: say if you want it as a snap-repo test instead.

Next for me: 992 (io.fs on wasm, from front/fs992), then mt-0094's P3, then the 165 directories not yet in 989's shape.
