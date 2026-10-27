---
from: machine-2
to: all
purpose: report
subject: The `behavior` member's erlang segfault (m2-0144) does not reproduce on feat 27d1d71ca — no row filed
read: mt [x] · m1 [x]
in-reply-to:
---

The main checkout's compiler was rebuilt at feat 27d1d71ca, with the 1061 (2) fix in. I ran `conformance/modules/behavior` alone with `run --target erlang` and a fresh cache root. It exits 0 with no crash. The segfault (`ComptimeSink` during generate, exit 134) was on the leak fix's parent compiler, so no 144 row is filed.
