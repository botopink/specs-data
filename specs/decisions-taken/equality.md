---
scope: >-
  Decides `==` / `!=`: structural by value on every target, lowered per target, never user-defined (no
  `===`, no `behavior Eq`, `equals` ordinary), `f64` a total order under `==`, `Decimal` by numeric
  value, `f64` against an integer literal refused, wasm's `$__unk_eq`. The `bigint` / `Decimal` /
  `Json` number rules of 332 sit here as the row carrying 332 (3); literals, widths and overflow are
  numbers-and-arithmetic.
terms:
  - '`==`'
  - '`!=`'
  - '`=:=`'
  - '`$__unk_eq`'
  - '`Double.compare`'
  - '`NaN == NaN`'
  - '`asserts.deepEquals`'
  - '`compiler.same`'
  - '`Decimal`'
  - '`bigint`'
  - '`Json`'
  - '`USE_BIG_DECIMAL_FOR_FLOATS`'
  - '`#[validated]`'
  - 'f64_vs_integer_literal_refused'
related:
  - 'numbers-and-arithmetic'
  - 'wasm-target-and-runtime'
  - 'data-formats'
  - 'validation'
  - 'compiler-module'
binds:
  - '`01-compiler/139`'
  - '`02/97` step 15'
  - '`03-bundled-libs/125`'
  - '`04-js` step 9'
  - '`1-botopink-lang/144` 164 s2'
  - '01-checker'
  - '04-js'
  - '05-wasm'
retired:
  - '`===`, `behavior Eq`, a user `equals`'
  - '`Json.Num(value: f64)`'
first-step: 210
last-step: 569
in-force: 7
superseded: 0
---
# equality — `==` is structural, user code never runs

**`==` is structural on every target, a type cannot define its own equality, `f64` under `==` is a total order.**

(1) Structural `==`, no user equality — 210, 211, 348.

(2) `f64`: total order; against an integer literal refused — 214, 215.

(3) `bigint`, `Decimal` (`==` by numeric value), `Json` numbers — 332.

(4) wasm's `$__unk_eq` — 569.

Steps: 210, 211, 214, 215, 332, 348, 471, 569, 666, 738
Binds: 04-js · 05-wasm · a four-target cell in 12 · a cell in 12 · 01-checker · `1-botopink-lang/144` B-32 · 434 · 450 · `1-botopink-lang/144` 164 s2

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 210 | eq-a | `==` is structural on every target: records, tuples, lists and enum variants compare by value, recursively; two values of different types are never equal. erlang/beam: one term, `=:=`. commonJS and wasm lower by the operands' static type — a primitive keeps its instruction (f64: 214), a composite calls an equality function generated per type that answers `true` at once for the same reference, else compares fields in order, stopping at the first difference; no hash at construction, no interning (a lazily cached hash only if a record-keyed `Dict` / `Set` needs one). `!=` is the negation | 04-js · 05-wasm · a four-target cell in 12 | equality_is_structural |
| 211 | eq-b | A type cannot define its own equality: `==` is always field by field (210) and never calls user code; a method named `equals` has no special role; another sameness is a method with its own name (`sameAddress`); the identity operator `===` and `behavior Eq` are refused (348) | 04-js · 05-wasm | no_user_defined_equality |
| 214 | eq-c | `f64` under `==` is a total order (Java's `Double.compare`): `0.0 == -0.0` is `false` and `NaN == NaN` is `true`, bare or inside a record, tuple, list or variant, on every target (commonJS `Object.is` semantics; wasm a bit-pattern compare after NaN canonicalisation); `<`, `>`, `<=`, `>=` keep IEEE ordering | 04-js · 05-wasm · a cell in 12 | f64_equality_total_order |
| 215 | num-b | `==` / `!=` between an `f64` and an integer literal is a compile error at the literal: `error: comparing f64 with an integer literal — write 2.0` | 01-checker | f64_vs_integer_literal_refused |
| 332 | jsi64-a | Big numbers, and `Json` read like Jackson's strict configuration. (1) `bigint` is a primitive integer of any size with every integer operator and the literal suffix `n` (`123…890n`); erlang/beam the VM's integer, commonJS `BigInt`, wasm std-wasm's `bigint` (442) — one value on the four targets (front `01-compiler/139`). (2) std's `Decimal` is the exact decimal (Java's `BigDecimal`: an unscaled `bigint` and a scale): `add`, `sub`, `mul` exact; `div` takes a scale and a rounding mode (`a.div(b, scale: 2, rounding: .HalfEven)`) and has no form without them. (3) `==` on `Decimal` compares the numeric value (`1.0 == 1.00`, as `compareTo`); the scale is kept and `toString()` writes it (`"1.00"`). (4) `Json` (the `json` library, 396) chooses numbers by the numeral, as Jackson's nodes with `USE_BIG_DECIMAL_FOR_FLOATS` on: an integer within `i64` is `Int(value: i64)`, a larger one `BigInt(value: bigint)`, one with a fraction or an exponent `Dec(value: Decimal)`, exact; `Num(value: f64)` is removed; readers `num() -> ?f64` (any number, approximate), `i64() -> ?i64`, `bigint() -> ?bigint`, `decimal() -> ?Decimal` (exact, `null` when the value does not fit — never a coercion), `isNumber()`, `isIntegral()`; writing keeps the value exact: `Int` and `BigInt` as their digits, `Dec` as its plain text with its scale. (5) `#[validated]`'s bind reads a field by its own type (Jackson's typed binding with `ACCEPT_FLOAT_AS_INT` and `ALLOW_COERCION_OF_SCALARS` off): `i64` exact (a fraction or an out-of-range integer is a violation at the field, never truncated), `bigint` any integer, `Decimal` any number exactly, `f64` any number rounded; a string becomes a number only under `#[coerce]` (325 step 6) | `01-compiler/139` · `02/97` step 15 · `03-bundled-libs/125` · `04-js` step 9 · the 13 files with a `case` over `Json` | bigint_decimal_strict_json |
| 348 | ctr-h | 210 and 211 are the rule for `==`: records, tuples, lists and enum variants by value, recursively, on every target (210; `f64` per 214); no type defines its own equality, a method named `equals` has no role, `behavior Eq` and `===` are refused (211); `asserts.deepEquals` stays a test helper, equal in meaning to `==` | 01-checker · 04-js · 05-wasm | equality_rule_by_value |
| 569 | 164-s2-b | On wasm `$__unk_eq` (the GC runtime's `unknown` equality) compares records, variants, arrays and tuples field by field — strings by content, numbers and booleans by value — never by identity; `==` over a generic record with unwritten type arguments (`#(1, "x") == #(1, "x")`) answers as on the other targets and the module stays in GC form | `1-botopink-lang/144` 164 s2 | wasm_unknown_equality_structural |
