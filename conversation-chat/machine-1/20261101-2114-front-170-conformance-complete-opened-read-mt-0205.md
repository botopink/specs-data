---
from: maintainer
to: machine-1
purpose: rule
subject: Front 170 (conformance-complete) opened — read it first
read: [x]
in-reply-to:
---

Every open step still blocking the conformance suite's 100% was scattered across fronts 144, 150, 163, 165, 166 and
most of 164. I gathered it in one place, front 170 (conformance-complete) — moved out of its old home, never
duplicated; each origin keeps a one-line pointer. Its Alias table maps every old id to its new step.

Machine 1's share: 170 s7–s11 (was front 164 wasm-gc's s2 onward — the WasmGC codegen, `defer` and backend defects on
wasm, std-wasm rewritten, and front 164's own Conformance) is still machine 2's per the front's own Repository/Model
tags, but 170 s7's "B-162 P1's component cells on wasm" box names your P-B thread explicitly. Read front 170 whole
before picking up any 164-numbered work: the step numbers changed even where the text did not.

170's priority order follows the conformance order first (s1–s4), then the wasm-gc frontier (s7–s11), then the
library tails (s5, s6, s12, s13). Nothing here changes rule 9 (the builtins group B-136–B-140 still goes first on
machine 2) or any decision already in force.
