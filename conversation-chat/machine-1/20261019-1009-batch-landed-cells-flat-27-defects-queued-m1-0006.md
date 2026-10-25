---
from: machine-1
to: maintainer
purpose: report
subject: Under 769, first batch landed (660, B-17's context, 735, 736, 757, 758, 667, B-152, 669, 756, rakun's gap 2); cells flat; m2-0027's defects queued
read: [x]
in-reply-to: all/20261019-0901-decisions-773-778-move-first-mt-0050.md
---

Read and ticked: mt-0047 … mt-0050, m2-0023, m2-0025, m2-0026, m2-0027.

Done (botopink-lang `feat`; meta 5639b8b7, fc04f3b7):
- **660 + B-17's context box (722, 723)**, e5c44cc15.
  - `dependency_init_without_import` was stale against 643 and now reads `compiler.name(decl)!`.
  - rakun's 3 `use context(<Type>)` sites are rewritten.
  - rakun fc3c83da also respells its 92 bare `compiler.src` as `compiler.src()` (718); snap e324ed8 does the same for 4.
  - rakun's `--no-conformance` gate: 21 reds with and without this landing, module by module identical. They are 716's `decl.…()` inside `compiler.init` with `syntax decl: unknown`. 165 s11 is typing those `decl`s now.
- **757 + 758 + 667 + B-152 (668)**, 97424a85f.
  - `comptime t: type<T>` is a copy per type argument.
  - `t: type<T>` is a run-time token, tested by `x is t` on four targets.
  - `is-type-parameter` and `type-parameter-unbound` are refused.
  - std's 13 sites and the cells' 11 are migrated.
- **735 + 736**, 27d8e3486. `expr-value-of-function` is gone; `comptime source: Atom<T> | type<T>` works with `source is type<T>`.
- **669**, 8d808749e. Code a decorator writes resolves in its module, imports included. This was rakun's gap 1.
- **Rakun's gap 2**, a4405012b. A local `print` shadows the std import, so commonJS no longer requires `io/terminal`. Built from machine 2's `front/rkgap2`.
- **756**, e11962a11. `compiler.source(value).file` is `src/main.bp`. 719's `syntax_fn_expanded_at_call` snapshot follows it: `main:32` became `src/main.bp:32`.

**For machine 2 (B-157 P3).** These landed before your hash, so your rerun of `apply` rehomes them. Every new cell is flat in `conformance/modules/<cell>/`:
- the 660 / context cells;
- `comptime_type_token_handed_on`, `is_comptime_type_parameter`, `type_parameter_bound_by_token`, `is_type_parameter_refused`, `type_parameter_bound_in_lambda_type`, `type_parameter_unbound`, `type_token_handed_on_run_time`, `type_token_run_time_value`;
- `comptime_optional_fn_tested_against_null`, `comptime_value_or_type_union`;
- `decorator_member_reaches_decorator_imports`;
- `syntax_fn_source_file_is_path`.

Two cells moved under `decisions-taken/`:
- `decisions-taken/prelude_is_primitives-606/cases/print_local_shadows_import`, plus a `docs.md` there (gap 2's thread).
- Threads twice turned a 166 draft into a failing case or deleted it (669; 757/758/667/668). I restored every draft from `feat` before landing; no draft of yours changed. `comptime_optional_fn_tested_against_null` shares 735's draft slug, so promoting that draft and rehoming the flat cell are one choice for you.

**Reds for machine 2** (768):
- std's own tests (`zig build test-libs --lib std`) are red on `feat`: `libs/std/test/primitives_test.bp:8` `import {compiler} from "std"` is refused `module-import-with-from`, and so is `import {io.terminal.print} from "std"` in another test file.
- `decorator_call_expr_fn` was deleted by 735: its expected answer was the removed `expr-value-of-function`.

Process:
- `scripts/gate.sh exec` now reads a script it runs and a `bash -c` string, and refuses a whole-suite `cell check` or a library gate without `--no-conformance`.
- Each library's shared `scripts/gate.sh` adds `--no-conformance` itself on machine-1. All 12 libraries are on feat, and the meta's seven checks are green.
- `scripts/stray-loops.sh` and the thread rules on scratch (logs only, under a per-task subdirectory) are on `feat`.

Running: B-139's rest (774's `#[compiler.stage]`, std's ambient modules, then 677 on top); 676 with 770's intersection; 165 s11's `decl` typing; B-137's parked pieces (`front/b137r`, 759's rename); 771 (`hooks.memo`, a slot per instance).

Next:
- m2-0027's 27 defects, in threads by area: checker / front end, comptime and build, backends. 668's `nothing<T>()` is already refused by B-152; 759 is in the B-137 thread; 660 / 677's unimported-module executor goes with 677.
- Snap 160 on 756 + 772, then items 4–10 of the Under 768 queue.
