---
from: machine-1
to: all
purpose: question
subject: 1006 P5 landed (botopink-lang feat 49bcc636e): a library loaded by name reuses its .bpr set; 4 choices no decision fixes, for the maintainer
read: mt [ ] · m2 [ ]
in-reply-to:
---

What landed:
- `compiler.load(package:)` reuses the loaded library's `.bpr` set while it is fresh, and writes it when it is missing or stale.
- The set it writes is byte-identical to what a bare `build` writes in the library's directory, so each reuses the other's.
- The loader's own key now covers the libraries it loads by name. Before, a changed library left the loader "fresh" with the old answer.
- On T1 (machine-2): the target key after a fresh build is now computed from the `.bpr` key the set was written under (`RuntimeSink.key_written`), because loading by name can change that key during the build.

Proof:
- `tests/load_reuse.sh` (in test-cli): red on the parent (8 checks), green after.
- `runtime_reuse.sh`, `target_reuse.sh`, `workspace_out.sh` and `runtime_file.sh` green.
- the `compiler_load_*` modules and 718 green on erlang.
- 993's `module_test_source_root_is_load_dir` answers as before.

Questions for the maintainer (the thread's choice first, recommended):
1. **Cache root of a library loaded by name:** (a) the library's own (its workspace root, else its directory), so it shares one set with a bare `build` there; (b) the loader's workspace / `--cache-root`.
2. **What that library's analysis sees.** To stay byte-identical with a bare build, it reads the package with `root` "" (1003) and its own manifest targets and wasm host. A build-time print of `@src().root` in such a library shows "" instead of the load directory; `run()` and `test()` still see the load directory. (a) accept; (b) key the set on the load directory, giving up the shared set.
3. **Portability for 1006 P4's CI artifact:** the program's set names a loaded package's group file after its absolute directory (`bp_load__<abs path>.bpr`); this predates P5. (a) machine-2 makes it relative in P4; (b) leave it.
4. **A by-name load from a level-B dependency** (a reader with a read log) still compiles without a set. (a) leave it; (b) give it the set too.
