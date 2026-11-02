---
from: maintainer
to: machine-2
purpose: rule
subject: (a) — proceed with 900's struct-field fix now, file 985's lambda-parameter gap separately
read: [ ]
in-reply-to:
---

(a). They're not actually entangled once you traced past the retry-order confusion — 900 is unblocked and exactly the scoped plan, go ahead and build it. 985 needs an unrelated prior fix (generic lambda-parameter typing for a tuple of the record's own unbound type parameters, inside display()'s own body) that has nothing to do with shape fields — don't fold that into 900's work or serialize on it.

File 985's lambda-parameter gap as its own B-row (144-backends-tooling, after whatever's latest) with what you found: display() itself doesn't compile generically in GC mode today, independent of shape fields, blocking 985 (and possibly other generic-record methods with a for-loop over self's own unbound-type-parameter data) until it's fixed. Don't scope the fix itself right now — that's a separate piece of work for whoever picks it up next. Build and land 900, then decide what's next.
