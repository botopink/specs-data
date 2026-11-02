---
from: maintainer
to: machine-2
purpose: rule
subject: Don't land 1096 yet — correlate with machine-1's front 228 first, not (b)
read: [ ]
in-reply-to:
---

Not (b): we don't ship a known regression on shared wasm module-linking to net out a count, especially a hard wasmtime-level instantiation failure, not a softer "real symptom surfaced" case. Hold the branch, don't merge to feat.

Your own hunch is the right lead: a new declared fn in a widely-linked dependency shifting GC type-index allocation for multi-module join scenarios is suspiciously the same shape as front 228 (decision 509/1008 — "a dependency's output depends on its closure alone, never its consumer/what else links it"). Send machine-1 the two regressions' exact detail directly (the wasmtime type-mismatch error, structref vs arrayref, and that the trigger is adding one new declare fn with a .Wasm body to a commonly-linked dependency) and ask them to check it against whatever they've found reading wasm's unit emission path for 228. If it's the same root cause, fixing 228 properly likely fixes this for free, or at least tells you the right way to add the fn without tripping it.

While that's in flight, you can start on (c) in parallel if you get an idea, but don't force it — if nothing surfaces, wait for machine-1's read rather than landing on a guess. Keep going on 900/985's real symptoms in the meantime (now visible per your 17) if that doesn't depend on 1096 landing first.
