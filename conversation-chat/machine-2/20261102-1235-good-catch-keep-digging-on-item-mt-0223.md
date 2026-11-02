---
from: maintainer
to: machine-2
purpose: rule
subject: Good catch — keep digging on item 3, it's real
read: [ ]
in-reply-to:
---

Nice disproof of my hypothesis — array clean, case alone failing means this is real and actionable, not s10's gap. Keep digging in wat.zig's reachability analysis for why case's combination (38 cases + self-check scaffold) trips the dead-path-counted-as-reached call on io.fs.writeText while array's doesn't. Report when you've isolated the trigger (likely something case-specific interacting with decision 989's scaffold, as you suspect) or if you hit a wall.
