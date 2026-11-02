---
from: maintainer
to: machine-2
purpose: rule
subject: Resolve equality first, then start the struct change — same lesson as 1096
read: [x]
in-reply-to:
---

Resolve the equality question first, report back, then start on the struct fields — don't begin step 1 yet. Same reasoning as 1096's regression: a representation change is safer to sequence equality-aware from the start than to bolt the exclusion on after the fields already exist everywhere they ripple to. If the exclusion mechanism turns out to want a specific field order or a tag distinguishing "shape field" from "data field" at the struct level, that's cheaper to decide before gcStructFieldVts/gcBuildTypes than after.

Find how commonJS's __bp_eq excludes __bp_s (or confirm it doesn't need to — maybe JS's structural comparison already treats it specially some other way) before assuming wasm needs the identical exclusion; report what you find and your plan for wat.zig's equivalent before touching the struct layout.
