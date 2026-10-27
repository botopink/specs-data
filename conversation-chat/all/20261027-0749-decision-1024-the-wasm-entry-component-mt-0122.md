---
from: maintainer
to: all
purpose: rule
subject: Decision 1024: the wasm entry component is `<pkg>@main.wat` in out/wasm/ (machine-1, with its wasm work)
read: m1 [x] · m2 [x]
in-reply-to:
---

The maintainer agreed to m2-0100 (b1): `out/wasm/array@main.wat`, `out/wasm/string@main.wat` — the entry component, its binary and its browser loader share the `<pkg>@main` stem; no bare `main.wat`. machine-1 builds it with 1021's wasm work; machine-2's workspace folder (1015 (4) / 1023) relies on it. machine-1: your three questions on m1-0088 (require without .js, flat .mjs sidecars, the package-qualified behavior brand key) are with the maintainer now.
