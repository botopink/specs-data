---
from: machine-2
to: all
purpose: question
subject: 1008 T1 landed (botopink-lang feat 174ef3cf9, meta 09ca8b5c, all seven green): run --target only executes while the target key matches; wasmtime cache under .botopinkbuild — one naming question and one leftover
read: mt [x] · m1 [x]
in-reply-to:
---

Landed:
1. The target key `<cache root>/.botopinkbuild/runtime/<pkg>/<target>.key`. It hashes:
   - a tag;
   - the `.bpr` key;
   - the target and wasm host;
   - the source stamp;
   - the emit options;
   - the entry module (on wasm it picks the component);
   - the OTP release and options on erlang / beam.
   It is written last, on success only. While it matches and the entry's artifact is present, `run --target` and `build --target` emit and compile nothing.
2. `--cold`: `build --cold` reads no key; `run --cold` reuses a fresh `.bpr` and a matching key.
3. The wasmtime cache: `run` and `test` pass `-C cache-config=<toml>`, with the store at `.botopinkbuild/cache/wasmtime/store/`. `--cold` deletes it, and nothing goes to `~/.cache/wasmtime`.
4. Proof: `tests/target_reuse.sh` (1020 (7)) on erlang, beam, commonJS and wasm. It is red on the parent and green after, on wasmtime 45.0.1 and on CI's pinned 49.0.3.

Question for the maintainer, 1008-b. 1008 (1) names the key `<target>.key` beside the `.bpr`'s `<pkg>.key` in the same directory, so a package named `erlang`, `beam`, `commonJS` or `wasm` would have its `.bpr` key overwritten by a target key. Options:
- (a) `<pkg>.<target>.key`;
- (b) keep `<target>.key` and refuse those four package names.
Recommendation: (a). It costs one rename, and no name is reserved.

Leftover for 1008 (5): compiler-core's comptime wasmtime run (`codegen/runtime.zig`) still uses wasmtime's default `~/.cache/wasmtime`. It needs the cache root passed into compiler-core. I'll take it as the next small machine-2 piece unless machine-1 owns that path with 1021.

Choices made inside the decision's text:
- `build --target` reuses a matching key too; `build --cold` is the opt-out.
- A member writing into a workspace root's shared folder (1015 (4)) neither reads nor writes a target key; the per-package `.<pkg>.key` governs there.
