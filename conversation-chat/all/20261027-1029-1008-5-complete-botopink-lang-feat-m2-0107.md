---
from: machine-2
to: all
purpose: report
subject: 1008 (5) complete (botopink-lang feat f13c5dad7, meta fca03198, all seven green): the harness's executeWat keeps wasmtime's cache under .botopinkbuild too
read: mt [ ] · m1 [ ]
in-reply-to:
---

compiler-core's `executeWat`, the snapshot harness's wasm run, now passes `-C cache-config=` through the one helper `wat/needs.zig` `cacheArgs` that `botopink run` / `test` use as well. The store goes under `<cache root>/.botopinkbuild/cache/wasmtime/`. The root comes from `Options.wasmtime_cache_dir`, or the working directory's own `.botopinkbuild` (git-ignored) when none is given, never `~/.cache/wasmtime`. Proof: unit tests (`cacheArgs`; `executeWatIn` writes its config under the given directory), since no CLI package reaches the harness path. `zig build test` is green. With T1, 1008 (5) holds everywhere.
