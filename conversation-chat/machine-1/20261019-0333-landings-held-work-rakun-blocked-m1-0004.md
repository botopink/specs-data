---
from: machine-1
to: maintainer
purpose: report
subject: B-146 (1–2), B-154 (nested variant) and B-156 landed; 660/676 and B-17's context ready, held for rakun; rakun's codemod commit blocked by two B-139 gaps
read: [x]
in-reply-to: all/20261019-0021-tree-respelled-overtaken-boxes-closed-mt-0031.md
---

Read and ticked: mt-0020 … mt-0028, mt-0030, mt-0031.

Done:
- 144 B-146, boxes 1–2: botopink-lang 8984bf52a; meta 44966c24. An enum argument keeps its type's identity at build
  and in an executor (`annotation_argument_enum_identity`). An imported generic takes explicit type arguments
  (`imported_generic_fn_type_arguments`). Box 3 (667) is built and held on 667-a.
- 144 B-154, the nested nullary variant: botopink-lang de9e2a043; meta 7e224f58. A bare nullary variant inside a
  pattern matches the variant; commonJS now tests and binds an `Ok` / `Error` pattern's nested payload
  (`nested_pattern_nullary_variant`).
- 144 B-156 (719): botopink-lang ef2a4e33e; meta 9cad1691. A function with a `syntax` expression parameter
  answering `anyvalue` / `anytype` is expanded at its call. Five cells on four targets; full suite 1644/1646, only
  the two `fs_*` red.
- Filed:
  - questions 667-a (it now also blocks B-152), 668-a, 719-a, 719-b, 723-a, 723-b, 723-c;
  - B-154 boxes (exhaustiveness over nested variants, the refusal's generic labels);
  - B-147 boxes (wasm: a generic `?T` method answer; a generic `R` of `string` / `bool`).
- The main checkout's compiler was rebuilt at ef2a4e33e. It was found moved to 611acc96d with a stale binary at
  00:28; whoever moves `repository/botopink-lang` in the main checkout, please rebuild it or tell me.

Held, verified green:
- 660 + 676 (dependency executors by level; `dependency-target-missing`), 1635/1639. They refuse rakun's cells as
  built: rakun and rakun-stylesheet declare no `beam` target while their cells run on beam (676 is right). They land
  together with a rakun commit adding the missing targets.
- B-17's context box (722, 723), 1638/1642:
  - `use context(ctx)` reads through the handle;
  - `use context(<Type>)` is refused, `context-read-by-type`;
  - the cells' 35 sites are rewritten;
  - `context_undeclared_type` and `context_behavior_undeclared` are removed (731: no provider answers the default).
  It refuses rakun's 30 `use context(<Type>)` sites, so it lands with that rakun commit too (165 s10).
- B-152 (668): built (`type-parameter-unbound`, std's sites, the 11 cells). The token `comptime t: type<T>`
  reaches no target at run time, so `async.failed` and `type_parameter_bound_by_token` are red. It waits on 667-a.
- 677: it compiles std's ambient `src/` files (`builtins.d.bp`, `primitives.bp`) as modules, so std's own build
  fails. It waits on B-139's rest. 733's `manifest-entry-in-library` goes in with it.

Blocking — rakun's codemod commit (165 s10):
- The commit stages 594 files. `@(Result|Task|Component|Iterator|Stream|Option)` and `#[@External` are at 0 in
  `modules/` and `conformance/`, comments and test names included. Rakun's hook is red on two compiler gaps that
  B-139's first part opened:
  1. Code a decorator writes cannot reach an imported std function. rakun-data's `entity.bp` generates a member
     calling `panic(…)` through `compiler.addMember`, and every use fails `unbound variable 'panic'`, whatever imports
     `failure.panic`. Before, `@panic` was global. My thread is building 669's rule: the code's names resolve in the
     module that wrote it, with its imports. The cell is `decorator_member_reaches_decorator_imports`.
  2. **Machine 2** — commonJS: a program whose `print` comes from `io.terminal` fails at run time with `Cannot find
     module './std/io/terminal.js'`. Rakun's example `examples/rakun-stylesheet/emilia-modifiers` shows it. This is a
     B-139 / backend row for machine 2.
- `Async`: std declares no `Async` yet, so rakun keeps `Task` until B-137's codemod (732).

Running:
- B-154's other five boxes;
- 669's resolution of decorator-written code (rakun's gap 1);
- 160's `matches` in 719's shape (snap).

Next:
- When gap 1 lands and machine 2 answers gap 2: rakun's codemod commit through the hook. Then one rakun commit with
  the 676 targets and the 30 context sites, and 660 + 676 + the context box landed together after rakun's whole gate.
- Then 165 s11 on B-149 P1.
