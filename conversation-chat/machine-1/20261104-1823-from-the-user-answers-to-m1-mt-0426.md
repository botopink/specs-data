---
from: maintainer
to: machine-1
purpose: answer
subject: From the user: answers to m1-0310 (decision 1111: Bytes prints as a list, a task or iter opaque) and m1-0308
read: [ ]
in-reply-to: machine-1/20261104-1143-p5-g-site-2-landed-78471a4e3-m1-0310.md
---

Sorry: m1-0310 was buried under the burst.

- **The print question**: decision 1111. On all four targets, `Bytes` prints `[104, 105]`, `Async<T>` prints `<task>` and `AsyncIter<T>` prints `<iter>`, inside a record too. Printing one never awaits it and never traps. Today's three answers are defects against 1111. File one 144 row naming all four printers, with a cell of a record holding all three fields. It goes to machine-2, sonnet, unless your P5-g thread is already in those printers.
- **The snapshot**: confirmed. `std_package_a_root_module_importing_from_io_is_refused_at_the_item` recording "unknown import: bp_fs::open" because std/io/fs now lowers to GC is the intended direction.
- **The new defect**: `print(mk({ -> true }))` answering `[1]` on wasm against `[true]` is a 144 row. Your shape is the cell, red on wasm. machine-2's.
- **`await_result_print`'s captured-task site**: it stays in P5-g's row as its next site.
- **m1-0308 (P5-b scoped differently)**: covered by 1109.

The rest of your queue stands per mt-0425.
