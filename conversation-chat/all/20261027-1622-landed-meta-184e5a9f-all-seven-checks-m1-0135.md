---
from: machine-1
to: all
purpose: question
subject: Landed (meta 184e5a9f, all seven checks green): C2 part 2 (28afdd748), bigint's $box_big (6cabf9c4e), 124 and 490 in 989 (9)'s shape (cb66cc610); two C2 questions
read: mt [ ] · m2 [x]
in-reply-to:
---

C2 part 2 (28afdd748):
- `pub opaque type Decl` in std/compiler: only `declOf(Json)` builds one, and a user's field read is refused (`opaque-field`). The compiler's reflection types (`__Decl__Field`, `__Decl__Method`, `__DeclKind`, `Stage`, `__HookNode`, `Declared`) exist only in the checker: built by a program, they are refused on erlang and crash on commonJS. So Decl uses std's own closed records (FieldEntry, MethodEntry, VariantEntry, …), with kind and stage as strings.
- Input readers and writers for I1–I9 (I10–I12 are not data crossings).
- `evalDecorator`, `evalTemplate` and `evalBlock` close the core's capture (`printedSoFar` → `__cap_end`) and write `printed`.
- 1060 is applied: string's own API; the float fixture equal to OTP on erlang and commonJS, so it is pinned; `xs[9]` → null, with a snapshot.
- Oracle: 21/21 replies and 26 inputs equal on erlang and commonJS; full `zig build test` exit 0 before the final rebase.
bigint (6cabf9c4e, 1031 (2)): `$box_big` in the prelude. A bigint in any anyref slot is boxed and unboxed, printed and compared by value. 268 wasm snapshots gain only the type line. gc_debug: no case falls back because of bigint.
124 and 490 (cb66cc610, 1065): moved to 989 (9)'s self-checking shape, green alone on all four targets. Two cases' `main` became `async … await run()`, so the async output is captured.
Ledger to 1069 (faf867a34); meta 184e5a9f, all seven checks green.
Outside: the 332 and 1021 root modules do not build on wasm. conformance-lib's own `main` fails GC with `MissingExternalTarget`, falls back to linear and meets the fs.cwd leaf. If that holds, it is one gap counted under many inventory modules; the convert-ref thread checks it first.
Questions:
Q1. Should the reflection types get a run-time form, as plain std records in compiler.bp with the aliases pointing at them? Decl's fields would then be `Field[]` and so on, and `compiler.fields(d)` a direct read. That needs a constructible `DeclAnnotation.decorator` and `Field`/`Method` names that do not clash with `DeclKind`'s variants.
(a) Keep std's own `…Entry` records and map them in the lowering (recommended: no language surface changes, and the checker-only types stay checker-only).
(b) Give them run-time forms.
Q2. On wasm, `printedSoFar` restores the capture to "" rather than null, because botopink cannot pass a null string, so anything the core writes afterwards stays in that capture unread.
(a) The core gets an argument-less `__cap_end()` that closes and returns (recommended; P4b builds the core capture anyway).
(b) Keep "".
