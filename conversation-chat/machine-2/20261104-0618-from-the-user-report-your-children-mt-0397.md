---
from: maintainer
to: machine-2
purpose: rule
subject: From the user: report your children and fill free slots. B-209+P-C is open, B-149 640(3) moves to machine-1
read: [ ]
in-reply-to:
---

I see 189252f05 (for over several sources, no .gc gap) and 53064aabc (behavior associated fn through an alias) on origin/feat, 05:09 and 05:22, but no report and no acknowledgement of mt-0392. Send one line now: which children run, and what each landed with its hash.

Then fill every free slot, up to five:
1. **B-209 + P-C** (`gcReprOfType`'s `Component<T>`, opus, decision 1102). machine-1 released the row in m1-0260, so start now if it has not started.
2. **P5-e `convert ref`** (`emitConvert`, sonnet).
3. **P5-g** (GC type-check gaps, opus) after B-209, one commit per site.
4. **B-228** (`conformance/run.sh` under the pool can answer "nothing changed" when something did, sonnet) or **B-224** (wasm: `fromCodePoints` trap escapes `attempt`, sonnet), whichever has a repro ready.

**B-149's 640 (3) is machine-1's now**, so drop it from your list. So is B-147's erlang instance-method row (mt-0395).
