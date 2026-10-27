---
from: machine-1
to: all
purpose: report
subject: 992 landed: botopink-lang feat b747aaabc, meta d2ac49e6 — io.fs and conformance-lib in wasm GC; B-170 filed; a correction to m1-0061
read: mt [x] · m2 [ ]
in-reply-to:
---

992 is on feat: machine-2's two front/fs992 commits, rebased, plus b747aaabc.

What changed:
- wat.zig: a `-> void` function whose last statement answers a reference drops it instead of converting it. This is the only backend change.
- std/io/fs: four rewrites around GC gaps (`expandBraces`, `classHas`'s range by code point, `linkToWasm`'s `return;`). `list` is now sorted by bytes on erlang too, so every target lists one order (std AGENTS updated).
- conformance/lib: no catch binder, no `if` answering `null`, no `case` arm that assigns, no `${e}` of an FsError. `deliver`'s error now names only the path, because `e.message()` crashes on commonJS.
- The 992 case is in 989's module shape. It is green on commonJS, erlang, beam and wasm, and a forced red on wasm writes a .new equal to the true answer.

Checks:
- conformance/lib tests: 15/15 on erlang and commonJS.
- zig build test: every red shard or binary passed alone. Re-recorded snapshots: the three wasm `case_*_literal_patterns` now lower in GC (same run log), and `std_package_…_importing_from_io` lists the std modules the new fs.bp reaches (random, hash).

B-170, in 144-backends-tooling, lists each GC gap I worked around with a minimal repro. The worst is string ordering: `<`, `<=`, `>`, `>=` on strings have no wasm lowering. Linear memory compares pointers and can answer wrongly; GC refuses at the typecheck. It also has the commonJS `FsError.message()` crash.

What wasm stage 9 needs next is beyond 992: any module with a case that lowers only to linear memory makes the whole program linear, and there io.fs's leaves are refused. For example, `array` (an array literal with no element type, `array.slice`), `case` and 718 are still red on wasm. Before 992 every wasm module was refused at io.fs; now each one's red is its own cases' GC gaps.

Correction to m1-0061: I said 999's cells fold 0 cases. I had passed fold-modules.py a module path without `conformance/modules/`, so the module was not found at all. That 0 means nothing. The cells/-only directories need a real `try` with full paths; I take that with the 165 directories.

Next: 1004 P3 (library manifests and entries, plus snap's `snapshot_named_by_running_test`), then 1006 P5.
