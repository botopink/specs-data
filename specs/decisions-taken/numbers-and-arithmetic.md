---
scope: >-
  Decides numeric literals and their suffixes, integer overflow and the widths' ranges (`i64` on
  commonJS), `abs`, `string.parseInt` past `i64`, `bigint` staying static, where `Decimal` and
  `Json`'s numbers live, and `Dict.bump`. `==` on numbers (`f64`'s total order, `f64` against an
  integer literal, `Decimal`'s `==`) is equality; a module `var`'s atomic write is
  module-vars-and-beam-memory.
terms:
  - 'numeric suffixes'
  - '`42l`'
  - '`1.5f`'
  - 'integer overflow'
  - '`int_chk`'
  - '`i64`'
  - '`u64`'
  - '`abs`'
  - '`string.parseInt`'
  - '`bigint`'
  - '`bigint-widened`'
  - '`bigint-type-test`'
  - '`comptime-bigint`'
  - '`Decimal`'
  - '`Dict.bump`'
  - 'division by zero'
related:
  - 'equality'
  - 'module-vars-and-beam-memory'
  - 'data-formats'
  - 'backends-and-run-time-output'
  - 'std'
binds:
  - '`01-compiler/17-beam-memory` step 1'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` B-24'
  - '`1-botopink-lang/144` B-24, B-27'
  - '`2-libraries/151` s1'
  - '01-checker (lexer, checker)'
  - '01-checker (literal typing); decision 247; front 170 s6 (cell numeric_literal_suffixes)'
  - '02-erlang'
  - '02/97'
  - '03-beam'
  - '04-js'
retired:
  - '`I32`, `I64` (per-width contracts)'
first-step: 176
last-step: 1113
in-force: 9
superseded: 1
---
# numbers-and-arithmetic — literals, widths, overflow, `bigint`, `Decimal`

**Kotlin's lowercase suffixes; a literal never changes type to fit; integer overflow is a program error on every target; `i64` is a real 64-bit integer everywhere; big numbers are exact.**

(1) Literals and suffixes — 247.

(2) Overflow, `abs`, `parseInt` past `i64` — 264, 496, 176.

(3) `bigint` static, `Decimal` and `Json` numbers in std / the json repository — 501, 500.

(4) `Dict.bump` — 340, 534.

Steps: 176, 215, 247, 264, 319, 332, 340, 444, 472, 496, 500, 501, 527, 533, 534, 547, 641, 675, 1110, 1113
Binds: 02/97 · 01-checker · 01-checker (lexer, checker) · backends · 02-erlang · 03-beam · 04-js · `04-js` step 9 · `01-checker` step 18 · `02/97` step 13 · `02-erlang`, `03-beam` (the shared cells) · `01-compiler/139` · `02/97` step 15 · `03-bundled-libs/125` · the 13 files with a `case` over `Json` · `01-compiler/17-beam-memory` step 1 · std's `Dict` · `1-botopink-lang/144` B-00e · 441 · `1-botopink-lang/144` B-24 · 264 · 319 · `1-botopink-lang/144` B-24, B-27 · `2-libraries/151` s1 · 332 · `1-botopink-lang/144` · `machine-2/144` B-41, B-07 · 01-checker (literal typing); decision 247; front 170 s6 (cell numeric_literal_suffixes)

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 176 | 97-c | † `string.parseInt()` of an integer beyond the `i64` range (−2^63 … 2^63 − 1, 319) is `Error` on every target | 02/97 | parse_int_beyond_i64_error |
| 247 | ck3-a | Kotlin's numeric suffixes, lowercase: `1.5` is `f64` and `42` `i32` by default; `1.5f` f32, `1.5d` f64, `42l` i64, `42u` u32, `42ul` u64, `42i8`, `42i16`, `42u8`, `42u16`, `42isize`, `42usize`; an uppercase suffix (`42L`, `1.5F`) is a located error naming the lowercase one. A literal without suffix never changes type to fit: `val f: f32 = 1.5` and `val x: f64 = 1` are errors (write `1.5f`, `1d` or `1.0`). 215 stands. The lexer's exact rule (hex digits `d`/`f` against suffixes, exponent, member access on a literal) and the targets' representation of `i64`/`u64`/`f32` (319) are the implementing front's | 01-checker (lexer, checker) · backends | numeric_literal_suffixes |
| 264 | gw-a | Integer overflow is a program error on every target: `+`, `-`, `*`, unary `-` and the compound assignments of every integer type check the result against the declared type's range and abort (wasm's `int_chk`); commonJS and erlang/beam add a range test per operation; commonJS's `i64` representation is 319's; no target wraps or answers a wider number | 02-erlang · 03-beam · 04-js | integer_overflow_aborts |
| 340 | 17-b | `Dict.bump(key, by) -> Dict<K, V>` in std (integer `V`; an absent key counts from 0): on any `Dict` it is `insert(key, (at(key) ?? 0) + by)`; the `keyed: true` var and its `ets:update_counter(T, k, n, {k, 0})` lowering are removed (547) — `bump` is a plain `Dict` method, atomic on a module `var` as `x = f(x)` (534). The written read-modify-write `counts.insert(k, (counts.at(k) ?? 0) + n)` stays refused (1.0.5's 40, rule 5(b)) — no pattern is recognised —, and `counts[k] += 1` stays out of the grammar | `01-compiler/17-beam-memory` step 1 · std's `Dict` | dict_bump_counts |
| 496 | 97-s13-a | `abs` aborts past its integer type as unary `-` does (`integer overflow: abs on i64`), declared per width — on the types `i32` and `i64` (641; the contracts `I32`, `I64` are retired), not on `Signed`, each with its own bound in its forms; `lo64().abs()` aborts on every target | `1-botopink-lang/144` B-24 · 264 · 319 | abs_aborts_on_overflow |
| 500 | 97-s15-a | (a) 142 s1 first (144 B-27, then 151 s1): `json` leaves std whole; 97 s15's `Json` half (`Int` / `BigInt` / `Dec` replacing the removed `Num`, the consumers' arms) lands in the json repository (151); its `Decimal` half stays in std (144 B-24); each consumer is touched once | `1-botopink-lang/144` B-24, B-27 · `2-libraries/151` s1 | json_numbers_in_json_library |
| 501 | 139-a | (a), as built: a `bigint`'s type stays static — it does not widen to `unknown` (`bigint-widened`), `is` neither tests for one nor tests a value holding one (`bigint-type-test`), a `comptime` computing one is `comptime-bigint`; `print`'s variadic `unknown` takes one and a union holding one stays legal; (b) or (c) may widen it later, when a program needs it | `1-botopink-lang/144` B-24 · 332 | bigint_type_stays_static |
| 534 | B-26-a | (a): `Dict.bump(key, by)` exists for an integer `V` alone (340); on a `Dict` whose `V` is not an integer type the call is refused, located; `bump` is a plain `Dict` method (17-c); on a module `var`, `d = d.bump(k, 1)` is an `x = f(x)` and so atomic on the BEAM (17-c (ii)); wasm's `8976.0` is the separately filed defect | `1-botopink-lang/144` | dict_bump_integer_values_only |
| 1110 | ck3-int · (the maintainer, 2026-11-04, 2026-11-04) | Replaced by 1113 | 01-checker (literal typing); decision 247; front 170 s6 (cell numeric_literal_suffixes) | |
| 1113 | ck3-int-b · (the maintainer, 2026-11-04, after the fable's review of the day's rows, 2026-11-04) | Amends 247 and replaces 1110. 247's "a literal without suffix never changes type to fit" holds for the float types and for an integer literal standing for a float (`val f: f32 = 1.5`, `val x: f64 = 1` stay errors). An unsuffixed integer literal takes the integer type its position expects, in every position with a known integer type: a `val` / `var` annotation, a pattern, an argument, a return, an array element, a field, an operator's other operand. It does so only when its value fits that type. A negated literal `-n` fits only when the negated value fits (`-1` against `u8` is refused). A literal that does not fit is a located error at the literal, the same text as `integer_suffix_out_of_range`'s. With no expected type, a literal is 247's default `i32`, and a value past `i32` is a located error (write a suffix, `3000000000l`). 215 stands. Cell: cases under `numeric_literal_suffixes-247` for an unsuffixed literal that fits (`i64`, `u8`) and one that does not (`u8 = 300`, `-1` against `u8`, an `i32`-overflowing literal with no expected type). | 01-checker (literal typing); decision 247; front 170 s6 (cell numeric_literal_suffixes) | numeric_literal_suffixes |
