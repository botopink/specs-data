---
scope: >-
  String indexing by codepoint on every target, `string.fromCodepoint`, Unicode normalisation and case
  tables, the one printed text wasm and commonJS share with the comptime runtime (enum sections, a
  generic `T` written as text), the generic text methods, template markers, and the `bytes` primitive
  with its wasm leaves. Number formatting is numbers-and-arithmetic; the `encoding` and `hash` APIs
  themselves are std.
terms:
  - '`length`'
  - '`indexOf`'
  - '`lastIndexOf`'
  - '`string.fromCodepoint`'
  - '`unicode.normalize`'
  - '`hash.contentHash`'
  - '`bytes`'
  - '`bytes.fromUtf8`'
  - '`toUtf8`'
  - '`bytes.at`'
  - '`bytes.ofWords`'
  - '`normalizeNewlines`'
  - '`trimTrailingNewlines`'
  - '`firstDifferingLine`'
  - '`mkdirRecursive`'
  - '`$stringify`'
  - '`__bp_ty_<T>`'
  - '`gen-unicode`'
  - 'codepoint'
  - 'grapheme'
related:
  - 'numbers-and-arithmetic'
  - 'wasm-target-and-runtime'
  - 'backends-and-run-time-output'
  - 'std'
  - 'types-enums-and-patterns'
  - 'assets-and-embed'
open:
  - '559: `compiler.embed` inside std reading std''s own files (std is embedded in the compiler) lands in s3 P1 before `toUpper` / `toLower`'
binds:
  - '`01-compiler/01-checker`'
  - '`02-erlang`'
  - '`02-erlang` step 15'
  - '`02/97` step 14'
  - '`02/97` step 16 (A)'
  - '`03-beam`'
  - '`03/104`'
  - '`04-js`'
  - '`04-js` step 10'
  - '`05-wasm`'
  - '`05-wasm` step 9, `04-js` step 11, front 18''s emitter (B)'
  - '`1-botopink-lang/144/machine-2-backends-tooling/164-wasm-gc` s3 P2'
  - '`1-botopink-lang/144` 164 s3'
  - '`1-botopink-lang/144` B-00j'
  - '`1-botopink-lang/144` B-22 (machine 1)'
  - '`20-snap/135` step 0'
  - '`machine-2/144` B-78, B-114, B-115'
  - '`machine-2/164` s3 P2-d'
  - '01-checker'
  - '02-erlang step 6'
  - '04-js step 2'
  - '05-wasm'
retired:
  - 'The prebuilt `.wasm` library form (333 (B))'
  - '`str_slice`, `mem_eq` in `wat_prelude`'
  - 'a generated `.wat` leaf'
  - '`$stringify` (a template marker)'
  - 'erlang''s `string:length/1` / `string:slice/3` (grapheme clusters) in std''s templates'
first-step: 164
last-step: 880
in-force: 16
superseded: 0
---
# strings-bytes-and-text — codepoints, `bytes`, one text on every target

**A string index counts codepoints on every target; `bytes` is an immutable byte sequence with no implicit conversion; every target prints the one text the comptime runtime prints.**

(1) Codepoint indexing on the four targets — 320, 169, 240, 455; `string.fromCodepoint` — 262; `contentHash` over code points — 260.

(2) Unicode tables — `normalize` in botopink: 333; case tables embedded on wasm: 559.

(3) One text — enum sections print their path: 601; a generic `T` as text on commonJS: 673; the generic text methods: 402; `$stringify` refused: 164, 239.

(4) `bytes` — the primitive: 346; its wasm leaves and their domains: 585, 880.

Steps: 164, 169, 239, 240, 260, 262, 320, 333, 346, 402, 441, 443, 444, 455, 520, 521, 530, 559, 585, 601, 641, 673, 880
Binds: 04-js step 2 · 02-erlang step 6 · std `primitives.bp` · 01-checker · 02 · 05-wasm · `02/97` step 14 · `04-js` step 10 · `02-erlang` step 15 · `02/97` step 16 (A) · `05-wasm` step 9, `04-js` step 11, front 18's emitter (B) · `01-compiler/01-checker` · `02-erlang` · `03-beam` · `04-js` · `05-wasm` · `03/104` · rakun 01, 13, 15, 24, 25, 70, 71 · `03r-ab` · `20-snap/135` step 0 · std `primitives.bp`, `io/fs.bp` · `1-botopink-lang/144` B-00e · 440 · 434 (5) · `1-botopink-lang/144` B-00g · 441 · 442 · `1-botopink-lang/144` B-00j · 442 (1) · `1-botopink-lang/144` · `1-botopink-lang/144` B-78 · 434 · `1-botopink-lang/144` 164 s3 · `1-botopink-lang/144` B-22 (machine 1) · the four backends · `machine-2/144` B-78, B-114, B-115

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 164 | 0405-c | `$stringify` is refused in every user template, located, naming the marker; the documented markers are `$self`, `$N`, `$args`; std included (239) | 04-js step 2 | stringify_marker_refused_in_templates |
| 169 | 23-d | On erlang `indexOf` / `lastIndexOf` answer the codepoint index, as `at` / `slice` / `length` do, so an index hands back to `at`; every target counts codepoints (320) | 02-erlang step 6 · std `primitives.bp` | erlang_index_of_codepoints |
| 239 | 0405-d | The parser refuses `$stringify` in every template, std included; std's `Array.join` Erlang template is written without it; `primOpTemplate.render`'s `$stringify` arm and the backends' `emitStringify*` are deleted | 04-js step 2 · 01-checker · 02 | parser_refuses_stringify |
| 240 | 02e-a | wasm counts a string's index in codepoints, as erlang and beam: `length`, `at`, `slice`, `indexOf`, `lastIndexOf` walk UTF-8 sequences; `run/string_index_of_codepoints` has one answer on the four targets (320) | 05-wasm · 02-erlang step 6 | wasm_string_index_codepoints |
| 260 | 05w-d | `hash.contentHash` folds code points: `contentHash("🎉")` is `djb2([127881])` on every target; the Node cell folds `Array.from(s)`; wasm's is std-wasm's (440) | 05-wasm · 02 | content_hash_folds_codepoints |
| 262 | 05w-f | A primitive `string.fromCodepoint(cp: i32) -> string` in `primitives.bp` (Node `String.fromCodePoint`, erlang `<<Cp/utf8>>`, wasm std-wasm's `str_from_cp`, 442); `unicode`, `encoding`, `querystring` build text with it on wasm; `unicode.fromCodepoint` is a `body:` over it | 05-wasm · 02 | string_from_codepoint |
| 320 | ctr-i | A string index counts codepoints on every target: `length`, `at`, `slice`, `indexOf`, `lastIndexOf` on erlang, beam, wasm and commonJS — `"e\u{301}".length` is 2, `.at(1)` `"\u{301}"`, `"👍".length` 1; std's Erlang templates stop using `string:length/1` / `string:slice/3` (grapheme clusters); on commonJS only a string holding a surrogate pair is walked by codepoint, a JS host template receiving and answering codepoint indices; no target counts grapheme clusters | `02/97` step 14 · `04-js` step 10 · `02-erlang` step 15 | string_index_counts_codepoints |
| 333 | 05w-i · wasm-ext | `unicode.normalize` is a botopink normalizer on the four targets. (A) The four `normalize*` (NFC, NFD, NFKC, NFKD) run std's own botopink body on the four targets — decompose, order by combining class, recompose; Hangul algorithmic — over tables a Zig build step (`zig build gen-unicode`) generates as `.bp` from the official Unicode data files of one pinned version (version and SHA-256 in the generator's manifest; 17.0); no host is asked (neither ICU nor OTP), so the four targets answer the same for every code point; a Unicode bump is a rerun of the generator in one commit; `ǅ` in NFKD is `68 122 780` on the four. (B) withdrawn (731 (4)): the prebuilt `.wasm` library form — a further `@External.Wasm` form, used by nothing — is removed; `Implementation.Wasm` is the enum's variant and nothing else | `02/97` step 16 (A) · `05-wasm` step 9, `04-js` step 11, front 18's emitter (B) | unicode_normalize_in_botopink |
| 346 | lg2-a | `bytes`: an immutable byte sequence on every target (an Erlang binary, a `Uint8Array`, a buffer in wasm memory); no implicit conversion to or from `string`, no string literal typed `bytes` (`val b: bytes = "a";` is a mismatch); `bytes.fromUtf8(s: string) -> bytes` encodes, `b.toUtf8()` answers `Result`, an `Error` on invalid UTF-8; `string` never carries raw bytes — a binary payload (an upload, a download, an image, a socket read) is `bytes` where it enters, host cells marshalling it so; the rest of the surface (length, slice, concatenation, the `encoding` bridges) is the implementing front's, under 67 | `01-compiler/01-checker` · `02-erlang` · `03-beam` · `04-js` · `05-wasm` · `03/104` · rakun 01, 13, 15, 24, 25, 70, 71 · `03r-ab` | bytes_primitive |
| 402 | (snap, 391 (2) — decided under the maintainer's delegation of library-method names, 2026-10-02) | The three generic text methods are `string` methods (641): `normalizeNewlines()` (`\r\n` → `\n`, a lone `\r` stays), `trimTrailingNewlines()` (trailing `\n` only), `firstDifferingLine(other)` (the 1-based line of the first difference of two texts split on `\n`; a whole-line prefix differs at the line after its last; `0` for equal texts) — host templates on both targets, not `default fn`s. `io/fs` gains `mkdirRecursive(path)`: every missing directory above the path is made, one that is there is `Ok`, a file in the way an `Error` (Node `mkdirSync({ recursive: true })`, erlang `filelib:ensure_path/1`) | `20-snap/135` step 0 · std `primitives.bp`, `io/fs.bp` | generic_text_methods_in_std |
| 455 | 442-d | `str_slice` and `mem_eq` are deleted from `wat_prelude`, nothing calls them: `s[i]` and `s[a..b]` are std-wasm's `text.slice` (by code point, as the other targets); the search helpers that called `$__mem_eq` are std-wasm's; what stays in `wat_prelude` is code that runs | `1-botopink-lang/144` B-00j · 442 (1) | wasm_string_slice_by_code_point |
| 559 | 164-s3-d | 443's case mapping on wasm reads tables `zig build gen-unicode` generates from the pinned Unicode data, embedded with `compiler.embed` (519; `@embed` is the retired spelling) — a passive data segment read by `array.new_data`, lowered in GC form (cell `embed_binary_file`); std's embed reading std's own files (std is embedded in the compiler) lands in s3 P1 before `toUpper` / `toLower`. No generator writes `.wat`: `gen-unicode` writes data and `.bp`, never a leaf; every `.wat` leaf of `modules/std-wasm/wat/` is hand-written | `1-botopink-lang/144` 164 s3 | unicode_case_tables_embedded |
| 585 | 164-s3-h · 164-s3-i · 164-s3-j · 164-s3-k · 164-s3-l · (the maintainer, 2026-10-17) | s3 P2: logic in botopink, a leaf only for the atom botopink cannot write, the prelude's names reused, never duplicated. (h) The array type's members (`slice`, `append`, `unique`, …) on GC lower the `default fn` bodies `primitives.bp` holds — no `.wat` cell. (i) `random`'s state is a mutable global the codegen declares in `wat_prelude`, the leaf naming it (549's rule for globals); the `.wat` reader keeps admitting `func` alone. (j) A leaf may name a `wat_prelude` function (`$__wasi_random_f64`, the host's entropy) without declaring it, as it names a type. (k) `encoding`'s byte codecs are botopink bodies over three leaves — `bytes.length`, `bytes.at`, `bytes.ofWords`. (l) `hash.contentHash` becomes a `body:` cell in P2, every `COMPTIME REPLY` byte-equal as the oracle | `1-botopink-lang/144/machine-2-backends-tooling/164-wasm-gc` s3 P2 | wasm_gc_logic_in_botopink |
| 601 | B-22-b · (the maintainer, 2026-10-17) | An enum section's value prints as the leaf's whole path as written, on every target: `print(Token.Color.White)` writes `Token.Color.White` (434 (5)); a name at two levels (`Token.After`, `Token.Layout.Break.After`) stays two texts; no internal name (the section's wrapper record, `_inner`, `__Token__Color`) reaches the output; each backend's enum printer writes the section path the checker resolves; a template hole and `string + enum` take the same text. Cell `enum_section_value_print`; `conformance/docs.md` § Sections of an enum states the text | `1-botopink-lang/144` B-22 (machine 1) · the four backends | enum_section_prints_full_path |
| 673 | 521-a · (implementation, the coordinator †, 2026-10-18) | On commonJS a generic body writing a `T` as text receives each type parameter's print shape at the call, one JS body per function (B-114, B-115): one hidden trailing `__bp_ty_<T>` per type parameter used as text (a fn value, another module, a generic method); the `T` values, the `.d.ts` and every other target unchanged; `Box<T>(value: 2.0)` printed or `show(3.0)` through `fn show<T>(v: T) -> string` answers `2.0` / `3.0` as on erlang, beam and wasm (521, 434 (5)); the cost lands only where a generic writes a `T` as text | `machine-2/144` B-78, B-114, B-115 | commonjs_generic_body_receives_type_shape |
| 880 | 164-s3-m · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 2" — decided by the fable at the maintainer's delegation; rejected: (a) `-1` and the low bits as built, (c) `bytes.at` as `text.byteAt`) | A `bytes` leaf answers nothing outside its domain: `bytes.at` is the bare `array.get_u` (a trap outside `0..length-1`, a negative index read unsigned included), `bytes.ofWords` `unreachable` at the first word outside `0..255`; the codecs keep their own bounds. (1) A leaf is std-private (445), 585 (k) giving it no answer outside its domain. (2) `modules/std-wasm/wat/bytes.wat` rewritten; the unit test asserts `bytesAt(b, 3)`, `bytesAt(b, -1)`, `bytesOfWords([104, 105, 289])` each a trap. (3) `text.byteAt`'s `-1` is untouched | `machine-2/164` s3 P2-d | |
