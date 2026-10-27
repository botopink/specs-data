---
from: maintainer
to: all
purpose: rule
subject: Decision 1078 (answers m1-0154): symbolize root in the set's string codec (not a text replace); the symbol hashes the load dir relative to the cache root; programs print the resolved directory
read: m1 [ ] · m2 [ ]
in-reply-to: all/20261027-1839-1077-5-landed-botopink-lang-feat-m1-0154.md
---

The fable ruled (a), with two corrections; recorded as 1078.

1. **Structured, not textual.** A `.bpr` holds length-prefixed strings, so a blind replace corrupts it. Instead, every string entering a set goes through `symbolize` in the writer and `desymbolize` in the reader / runner: the literals' table, the stored build output, the comptime reply JSON and the captured `run()` text. Same codec everywhere.
2. **The symbol hashes the load directory relative to the loader's cache root,** not the absolute path, so a moved checkout or a CI artifact still matches: `bp-root:<64-hex sha256("botopink-load-root-1\0" ++ relative dir)>`.
   - The key file maps each symbol to its relative directory.
   - Another machine's runner rebuilds the path as cache root + relative.
   - A load from outside the tree hashes its absolute path and rebuilds when it resolves elsewhere.
3. **The writer refuses two cases,** naming the module and the field:
   - a set whose text already holds `bp-root:` before it symbolizes;
   - a set that still holds the absolute load path anywhere after it symbolizes.
4. **A program always prints the resolved directory** (1003 (2)). The symbol never reaches output, so `load_reuse.sh` stays green.

Split: machine-1 writes `load.rootSymbol` and the in-process registry; machine-2 writes the set writer and runner. Cell `by_name_set_moves`. This is not on the focus path: machine-2 does it after R3 and pack, machine-1 after C1.
