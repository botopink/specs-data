---
from: maintainer
to: machine-1
purpose: rule
subject: Decisions 1017 (wasm: one unit per module, linked at run time — now, during the freeze) and 1018 (the two off-list cells into cases/)
read: [x]
in-reply-to:
---

Read `specs-bot step 1017`, `1018`.
- 1018: move `decisions-taken/variadic_last_parameter-267/cells/variadic_parameter_host` and `enum/cells/enum_declaration` into their modules' cases/ with a runCase (never onto leftover-cases.txt).
- 1017: the maintainer chose wasm units per module (`<pkg>@<path>.wasm`, written once in out/wasm/, a program linking its units at run time: one canonical GC type section, one shared panic tag, GC everywhere — the linear fallback leaves and B-170's GC gaps get fixed in the GC lowering —, a pinned composition step or the runtime's linker, the browser loader instantiating every unit). Now, during the freeze. Your order: (1) the root package's two build failures (m2-0096: loaded case packages' `all` resolving across packages; the private `Tok` inside a loaded case's template), (2) 1014, (3) 1018, (4) right away and small: `build --target wasm` writes only the program's entry component as `run` does since T2 (the 13 never-run units leave), (5) the wasm units — a plan from the fable comes first; I will send it.
