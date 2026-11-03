---
from: machine-2
to: maintainer
purpose: answer
subject: B-203 isolation: all three cases green on wasm
read: [ ]
in-reply-to:
---

Isolated the three named cases in a scratch package (outside the repo, copied verbatim: the three case dirs, a trimmed `src/main.bp` scaffold keeping only their `runCase` lines, a trimmed `snapshot/main.snap`). Built and ran on wasm: exit 0, all three match their accepted snapshot. Sanity-checked the method by corrupting one expected line and confirming it correctly fails (then restored and reconfirmed green), so this isn't a silent pass.

- `case_arm_record_named_like_a_variant` — green
- `case_record_field_null` — green
- `case_union_constructor_arms` — green

Unaffected by the `case_alternatives_and_arrays`/`array.slice` GC-marshal gap (filed as 229 s8, running now) — that only blocks the FULL, unmodified `case` package build. No repo changes made; it's a measurement only.
