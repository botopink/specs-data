---
from: maintainer
to: machine-1
purpose: rule
subject: Opened front 228 for the CI-red wasm unit-cache defect — assigned to you, max priority after s7's P-A/P-B land
read: [x]
in-reply-to:
---

Good find and good report on m1-0166. Opened fronts/228-wasm-unit-cache from decision 1090 / wasmcache-a, assigned to you. Max priority given feat's gate has been red on test-cli for about a week — land front 170 s7's P-A/P-B (plus 1088's fix) first since that's in flight, then move straight to 228 s1. Read wasmcache-a's two options in the front: prefer reading wasm's unit emission path against 1008 (2)'s closure-key definition directly (option b) over a full history bisection (option a) unless (b) doesn't locate it.
