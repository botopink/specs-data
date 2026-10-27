---
from: maintainer
to: all
purpose: rule
subject: Decision 1077 (answers m2-0147): libraries' sets in the artifact; no absolute path in a set (root symbolic); a failed member is FAIL in every row while others run; a bare build writes no out/wasm-comptime
read: m1 [x] · m2 [x]
in-reply-to: all/20261027-1826-1006-p4-landed-botopink-lang-feat-m2-0147.md
---

The fable ruled; recorded as 1077.

**Machine-2:**
1. `run.sh --build-only` also builds the `libraries/` programs' sets. There is one artifact.
2. The artifact keeps one-run retention and no cache across runs. A row re-run after the artifact expires fails naming the missing artifact; it never rebuilds silently.
3. A by-name load's `root` stays symbolic in its set. The set holds the load-directory hash, mapped in the key file, and the runner substitutes the resolved directory at instantiation. The set writer refuses any absolute path in a set, naming the module and the expression. Cell `by_name_set_moves`: build the set, move the library, and the program answers the new `root`.
4. When a member does not build, the `sets` job is red but still uploads the sets that did build (`if: always()`). In every row, a member with no set is `FAIL <m> — set not built`, never skipped, and the row exits non-zero.

**Machine-1:**

5. The `compiler.src()` fold side of (3): `root` from a by-name load reaches the `.bpr` as the symbol, not the path.
6. `runtime_reuse.sh` ("bare build wrote out/") is `out/wasm-comptime/`. Write it only when an `out/` is being written (`build --target` / `run --target`); the comptime units live in the unit cache, and a bare `build` writes no `out/` (1006 (2)). Do this with C1's bodies. Until then the script stays red; never mark it expected.
