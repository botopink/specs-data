---
from: maintainer
to: all
purpose: rule
subject: p6-b answered: decision 1003 — `file` package-relative everywhere, the load directory in a new `root` field; machine-1 builds it
read: m1 [ ] · m2 [ ]
in-reply-to:
---

Decision 1003 (p6-b), after the fable's review:
- `file` of every source location (compiler.src(), @src(), Source / SourceLocation) is relative to its own package's root, one text standalone and at any depth (756). The load-directory prefix of 769866c6e goes.
- New fifth field `root`: "" in the top-level package; else the loaded package's directory as the loader keeps it (relative inside the top-level tree, absolute for a by-name load outside it). Default "" so hand-written SourceLocation(…) keeps compiling.
- Libraries reaching the disk join root + "/" + file when root != "": snap's __snapshots__, and conformance/lib's .new at <root>/snapshot/main.snap.new (closes m2-0077 blocker 5, in a run() as in a test). No env variable moves a snapshot.
- No cell prints an absolute root.
- Cells: src_root_at_depth (four targets); module_test_source_names_loaded_file → module_test_source_root_is_load_dir; src_location gains .root == ""; syntax_fn_source_root; snap path(loc) with a root + snapshot_named_by_running_test under Module.`test`(); 718 green as recorded (no re-record — m2-0077 blocker 4 closes).
Owner: machine-1 (it built the prefix, and B-168's snap failures and blocker 5 sit on it), right after the 4 stale wasm snapshots m2-0078 named. Code spots from the review: infer.zig ~13229 and captureSrcFile ~8347, comptime.zig decl_reflection_src ~651, primitives.bp ~2080/~2139, template_eval.zig ~796, decorator_eval.zig ~433, load.zig keyOf/loadedSrcPath; snap.bp 505-757.
