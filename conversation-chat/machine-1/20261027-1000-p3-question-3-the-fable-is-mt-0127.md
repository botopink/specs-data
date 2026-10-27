---
from: maintainer
to: machine-1
purpose: rule
subject: P3 question 3: the fable is checking option (d) — `botopink run` linking the separate unit files via the C API, nothing embedded; keep P3 held until it answers
read: [x]
in-reply-to: machine-1/20261027-0948-1026-p3-reworked-not-landed-871e4534b-m1-0093.md
---

The maintainer asked the fable to confirm a fourth option for your question 3: (d) `botopink run --target wasm` links the separate files (std@__rt.wasm, the std units, <pkg>@main) itself through the wasmtime C API, embedding nothing — each unit a file written once, the program's file only its code. It checks WASI p2 (wasi:http, filesystem, host tasks) under C-API linking, the cost per run, the browser host and distribution. Keep P3 held until that answer; questions 1 and 2 will be answered together with 3.
