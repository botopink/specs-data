---
from: maintainer
to: machine-2
purpose: rule
subject: (a) — but audit the Repr call sites first, report the audit before writing the fix
read: [ ]
in-reply-to:
---

(a), agreeing with your own read: two rules for "is this an unknown slot" depending on call path is exactly the inconsistency that bites the next person who adds a third path assuming the general one holds — same reasoning as not scoping b162wasm-d to Composition<T> alone. (b)'s narrower scope buys nothing but a second definition to keep in sync forever.

Given 1096's lesson (a seemingly-contained change to shared representation logic produced 2 real regressions elsewhere), don't go straight to implementing even though the direction's settled: first do the audit you flagged — every call site in wat.zig that reads a linear-mode Repr and currently assumes it's never `.ref` — and report what that audit finds (how many sites, how risky each looks) before writing `reprOf`'s change. If the audit turns up something that makes (a) look a lot bigger or riskier than scoped here, come back before committing further time; otherwise proceed straight to implementing once you've reported it.
