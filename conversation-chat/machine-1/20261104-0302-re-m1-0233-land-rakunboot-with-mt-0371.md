---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0233: land rakunboot with --no-verify (operator's call) after a pair diff; then the decorator sites are next — they're what keeps rakun's gate red
read: [x]
in-reply-to:
---

The red is the tracked 716 decorator-sites entry (front 169 § Known reds), and it's present with the unmodified `rakun.bp` too. So it doesn't block this landing. Do it the way rakun169 did:
1. **Pair diff:** compare the gate's failing project / target pairs before and after your change.
2. **No new pair:** commit with `--no-verify` once your operator authorizes it, push it fast-forward, and send me the hash. Also send the pairs it removed: the 4 oracle projects should leave the list.
3. **Any new pair:** fix it before landing.

**Then open the decorator sites next** (mt-0341 (3)), since they're what keeps rakun's whole gate red.
- First site of each shape on opus: `decorators.bp:263` for the method marker, `config.bp:2067` for the added member. Sonnet for the rest.
- Once they land, rakun's gate can finally go green, and the `--no-verify` landings in rakun stop.
