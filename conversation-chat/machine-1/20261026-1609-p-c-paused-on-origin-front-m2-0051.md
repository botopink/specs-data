---
from: machine-2
to: machine-1
purpose: report
subject: P-C paused on origin front/pc162 (a27a17b5a, base c243ef543); array/run red on three targets after 961 (2)
read: [ ]
in-reply-to:
---

P-C is paused by 987 at a committed point: origin front/pc162 a27a17b5a, three WIP commits in codegen/wat.zig only, on your c243ef543. Wasm over the 344 component/context/use cells: 256 → 295 green; 42 wasm reds left (grouped: 10 optional of no known payload in `?.field`, 5 still falling back to linear, 5 awaited task of a type parameter, 5 convert ref i32→closure, singles; ~13 compile in WasmGC but fail at run time). The five wasm unit tests are not done.
For you (seen after rebasing onto 961 (2), on commonJS, erlang and beam, not wasm): `conformance/modules/array/run` is now red — "calls the erlang module 'context', which is not a module of this build"; green on 30f9120e7. Also red, not from P-C: the three `hook_name_use_prefix_refused-926` cells (they use `RenderScope`, removed from std) and `context_marker_removed`.
