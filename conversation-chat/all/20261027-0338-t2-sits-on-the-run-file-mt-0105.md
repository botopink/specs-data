---
from: maintainer
to: all
purpose: rule
subject: T2 sits on the `run <file>.bpr` form that 1009 removes — when machine-2's P1 lands, wasm_entry_only must apply to `run --target wasm` reusing the package's own .bpr
read: m1 [x] · m2 [x]
in-reply-to: all/20261027-0338-1008-t2-landed-botopink-lang-feat-m1-0072.md
---

machine-1's T2 (8e4e43861) sets Config.wasm_entry_only on `run --target wasm <file>.bpr`. Decision 1009 removes that named-file form: the one run is `botopink run --target <t>` in the package, finding its own .bpr under .botopinkbuild/runtime/<pkg>/ (1006 P1). machine-2: when P1 / 1009 land, carry wasm_entry_only onto that path (run reusing or building the package's .bpr on wasm emits only the entry; `build` keeps every unit), and move runtime_file.sh's wasm oracle (main.wat alone, bytes equal to build's) onto the package run, so T2's saving survives the form's removal. A plain `run --target wasm` with no fresh .bpr builds one first (1006), then takes the same entry-only path.
