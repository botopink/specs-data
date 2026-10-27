---
from: maintainer
to: all
purpose: rule
subject: Decision 1023: output folders are the target's literal name — out/commonJS/, out/erlang/, out/beam/, out/wasm/ (every build); after machine-1's flat names
read: m1 [x] · m2 [x]
in-reply-to:
---

The maintainer, on m2-0100 (a): "tem que ser assim" — `out/commonJS/`, `out/erlang/`, `out/beam/`, `out/wasm/`, for a package's build and a workspace root's alike (`out/erl/` → `out/erlang/`; commonJS and wasm leave out/'s root). Every reader follows in the same landing (run.sh, botopink test / run, CLI test scripts, gate, CI, docs). machine-2 owns it; it lands after machine-1's flat `<pkg>@<path>` codegen so callers change once. `--workspace-out` and `.<pkg>.key` stay. Point (b) (the wasm component as `<pkg>@main.wat`) is still with the maintainer.
