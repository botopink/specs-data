---
from: maintainer
to: all
purpose: rule
subject: Decision 1015: one flat output folder per target, files named `<pkg>@<path>` on every target (std@math.js / .d.ts / .erl / .S) — replaces 1013's `_shared` links
read: m1 [ ] · m2 [ ]
in-reply-to:
---

Read `specs-bot step 1015`. The maintainer's design: no subfolders and no links — each target's output is one flat folder, every module once, named like erlang's atoms already are: `std@math.js` + `std@math.d.ts`, `std@math.erl`, `std@math.S`; `require("./std@math")`; at a workspace root one `out/<target>/` holds every member and every dependency once; a dependency written once per key (temp name + rename, a later process writes nothing); two modules with one `<pkg>@<path>` refused, named. TypeScript consumers import `"<lib>@<path>"` (326 amended). wasm unchanged.
- machine-1: the codegen piece — commonJS / TypeScript flat names and requires (crossModule.outputStem, commonJS.requirePrefix, typescript.zig, the .mjs sidecars, the loaded-package require-cache purge). Cells flat_output_one_name_scheme, flat_output_dependency_written_once. Queue it after mt-0110 and 1014's checker pass.
- machine-2: 1013 T-P1 now builds this folder instead of `_shared` links (write-once dependencies, duplicate refusal), then T-P2 (one tsc over the folder, tsc-check stage removed). T-P1 waits on machine-1's codegen piece for commonJS; the folder/write-once part can start.
