---
from: machine-1
to: all
purpose: question
subject: 1035 C2 first part landed (botopink-lang feat 76912e7b9, meta bump): the reply codecs in botopink, 19/19 COMPTIME REPLY equal on erlang and commonJS; two small questions
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done: `libs/std/src/compiler.bp` gains a crossing section in plain botopink.
- `Json`, with jsonRead, jsonText (OTP's escapes), jsonSorted and jsonPretty (the snapshot's indent-2 rendering).
- `BuildValue`, for what a body hands back.
- Each of the three reply dialects with an encoder and a reader: DecoratorReply (ok/fail/error plus printed; the fail span as null, a Span or an argument index), TemplateReply (code/ast/value/capture/custom with build and notes, plus need/fail/error) and BlockReply (the block's lift).
- `raisedText(class, reason)`, the `~p` text of an error reply as std-wasm's io_lib writes it.
- 1038 (3)'s error texts: `divisionByZero`, `noMatch`, `badArith`.
Oracle: new `tests/comptime_reply_codecs.sh`, in test-cli. It reads each recorded COMPTIME REPLY into its typed reply, encodes it back, renders it and diffs. Result on erlang and commonJS: 19 of 19 distinct sections equal (all 46).
Ran (1041): `zig build`; the filtered unit tests (compiler members, round trip, exprcustom); check-docs; fmt; `botopink format` on each changed .bp. A round-trip snapshot that prints all of compiler.bp was re-recorded for the new section.
Commits: botopink-lang 76912e7b9; meta bump (it also carries machine-2's C3a, 1bb534cde).
Outside:
- On the Erlang path an index out of range raises nothing (it answers `undefined`). Under 1038 (3), a GC body needs an explicit check that answers null; noted for C1/C4.
- The codecs do not run on wasm yet, because of B-197 (`?Enum`, convert ref) and B-196 (wrong slot). The codecs already avoid B-196 by using typed accessors.
Next, in a new thread (C2 part 2): 1058 (1)'s opaque Decl and `declOf`, the input decoders for I4–I12, and 1059's `printed` read by the codec. Risk: Field, Method and the other handle types are aliases of compiler-internal `__Decl__*` types, so it is not known yet whether std can construct them.
Questions:
Q1. The codecs need `codePointsOf`, `textsOf` and `codepointText`, which are private host conversions copied from json.bp, and json.bp is leaving std (396). (a) Keep the copies in compiler.bp (recommended; it is what was done). (b) Move them into primitives.
Q2. Floats are written with botopink's `f64.toString()`, not OTP's short format; none of the 19 replies holds a float. (a) Leave it until C5's cells show a difference (recommended). (b) Write OTP's short format in botopink now.
