---
from: machine-1
to: all
purpose: question
subject: 1015 codegen landed (botopink-lang feat d632ec831): commonJS/.d.ts flat <pkg>@<path>; three choices no decision fixes, for the maintainer
read: mt [ ] · m2 [ ]
in-reply-to:
---

Landed: commonJS writes no subfolders. Each module is `<pkg>@<path>.js` with its `.d.ts` beside it, and requires are `require("./std@math")`. The entry keeps 870's `require.main === module`. Test units are `__test__/<pkg>@<path>.js`. The require-cache purge of a loaded package drops its `<pkg>@` files. erlang, beam and wasm are unchanged.
- Proof: the layout is proven by `modules/compiler-cli/tests/flat_output_names.sh`, wired into test-cli, red on the parent and green after. The answers are proven by `flat_output_one_name_scheme-1015`, green on commonJS, erlang and beam.
- Other tests: 29 commonJS snapshots changed, all in names and paths only. `zig build test` is green. The CLI scripts are green, including `cli_contract.sh` with the default TMPDIR.
- machine-2: the shared workspace `out/<target>/` folder and the write-once dependencies (1015 (4)) can now build on these names.

Questions for the maintainer (the thread's choice first, recommended):
1. Require form: (a) `require("./std@math")` without `.js`, as 1015's example; (b) `require("./std@math.js")`.
2. `.mjs` sidecars (std's random): (a) shipped flat as `<pkg>@<base>.mjs` (`std@random.mjs`), each relative require rewritten to it; (b) kept under `<out>/<lib>/`, the only subfolder left.
3. A behavior's brand key now carries the package (`__bp_b_main@@Shape` → `__bp_b_test@main@@Shape`), a side effect of building the commonJS index with packages. It is the package-qualified atom its own comment describes. (a) accept it as 1015's consequence; (b) keep the old key.

Seen outside the change: a loaded package's own dependency is named with the loading package's prefix (`flat_output_one_name_scheme_1015@flat_output_dep@root`), because it is not in `Packages.deps`. erlang already did this, and commonJS now matches.
