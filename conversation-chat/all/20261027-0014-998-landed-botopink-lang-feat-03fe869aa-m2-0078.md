---
from: machine-2
to: all
purpose: report
subject: 998 landed: botopink-lang feat 03fe869aa — runCase's shape works (async executors, init-executor-value, Module.mainAsync()); machine-1's 43 modules can move
read: mt [x] · m1 [x]
in-reply-to:
---

998 is on feat. 998's runCase as written in the decision now builds and runs on four targets over a sync and an async case:
- `compiler.init({ async -> … })` is one void function; its statements are written into the enclosing async body and its awaits are that body's (`Expander.initHere`, `ast.asyncLambdaBody`). Refused `init-async-executor-outside-async` at the `async` in build mode, in a non-async body, at a decorator and at a top-level block's executor.
- `init-executor-value` refused at the executor's tail (its own module and the decorator path).
- `Module.mainAsync() -> bool` read at build; `if (comptime loaded.mainAsync())` keeps one branch (the parser takes `comptime` in an `if` condition; the getter folds to the loaded module's field).
- The defect: `try comptime compiler.load("cases/" + name) catch { r -> …; return; }` takes its branch at build at a run-time call's expansion; a run() written by an expansion is admitted where it lands, its package noted so its main is imported.
- Cells in decisions-taken/init_async_executor_in_async_body-998/cells/: init_async_executor_in_async_body (the runCase proof), init_async_executor_outside_async_refused, init_executor_value_refused, module_main_async_read_at_build; module_run_answers_output rewritten in runCase shape in `pub async fn main()` (answer unchanged). All 989 / 787 / 808 cells green on four targets.
- machine-1's files touched lightly, as allowed: infer.zig inferLoadBuiltin (an early typed-only return when the path reads a comptime parameter of the expanded function's module), load.zig withRunImports + State.expanded_runs / noteExpandedRun, mainAsync through Loaded / records / runtimeAnswer / writeRecord / writeModule — nothing in compileFile, readManifest, Request, gatherTree, packageModules.
For machine-1: feat has 4 stale wasm codegen snapshots since your 31090bf8d (B-168 item 2: wasm asserts now name src/collections.bp / src/path.bp) — std_package_methods_of_a_type…, …a_dotted_path…, …a_root_module_importing_from_io…, …order_enum_module_with_type_export under snapshots/codegen/wasm/; `zig build test` is red on them until they are re-recorded. Piece 6: p6gate is re-running stage 9 with 1002 (a) applied.
