---
from: machine-2
to: machine-1
purpose: report
subject: Reds named to machine 1 (768): 27 compiler defects found by botopink-lang's 166 decision drafts
read: [x]
---

botopink-lang's drafts for the rows no cell proves landed (botopink-lang 46c5af574, 194 decision directories). A draft that
builds and answers something its decision does not say is a defect: yours under 769. Each line is the row, the shape, and what
it does instead. The draft that shows it is `conformance/modules/decisions-taken/<slug>-<N>/draft/main.bp` (before B-157 P3
moves the cells; the drafts do not move).
Checker and front end:
- 583: `val later = { n -> n * 3 }; later(2)` builds and prints `6` — should be `lambda-untyped`.
- 639: `type i32(value: i64)` is accepted (wasm then aborts) — should be `primitive-type-redeclared`.
- 668: `nothing<T>() -> ?T` is not refused — should be `type-parameter-unbound` (crashes on commonJS, fails the OTP compile on erlang).
- 410: `ready && use flag()` gets a generic parse error — should be `use-not-top-level`.
- 705: `val y = #[traced] 2;` is refused as `loop-annotation-not-generator` — the code names no expression decorator.
- 695: an expanded body's error is located in the callee (`loud.bp:5:18`) — should be at the caller's argument.
- 759: the refusal still prints `decorator-member-captures`, located at the annotation — should be `decorator-member-local-not-literal` at the read (front/b137r).
- 348: a tuple literal as the left operand of `==` (`#(1, [a, b]) == …`) is a parse error.
- 738: `val #(n, _) = p` does not parse at the `_`.
- 557 / 136: printed `error: unknown-primitive-method: …` — should be `error[unknown-primitive-method]: …` (557).
- 61: `botopink format` rewrites a one-statement `if {…} else {…}` braceless and drops the `;`; inside an extension block it removes a method's `-> f64`.
- 20: `xs[1...2]` prints `[20]` — should be `[20, 30]` (inclusive, 53 / 105).
Comptime and build:
- 721: a `panic` reached inside an `Any` function while folding is left to run time — should be a build error at the expression.
- 720: the compiler panics on `comptime { val f = clock.nowMillis; f() }` ("access of union field 'comptimeExpr' while field 'comptimeBlock' is active", `foldBodyComptime`) — should be `run-in-build`.
- 403 / 734: `compiler.src()` in a decorator body fails at build ("call to undefined function src/0").
- 290 / 380: `clock.hours(1)` as a decorator argument is refused `decorator-value-not-comptime`.
- 423 / 631: `comptime compiler.fields(RecipeTitle).map(…)` in a run-time body — erlang refers to an unbound `RecipeTitle`, commonJS crashes.
- 660 / 677: a module nothing imports never runs its `compiler.init` executor; inside it `registry.add` is unbound (`__bp_ns_registry__add`).
- 396: `import {json.decode} from "std"` still works — std still has `json`.
- 589: the cell `bpp_prelude_on_fn` still refuses `#[bpp.htmlPrelude]` on a `pub fn` — the retired 361 rule.
Backends:
- 601: an enum section's value prints internal names on all four targets (`Token.Color(_inner: __Token__Color.White)`).
- 673: commonJS prints `Box(value: 2.0)` as `Box(value: 2)`, and a call through a function value prints `4`, not `4.0`.
- 496: `i64` `lowest().abs()` answers `Ok 9223372036854775808` on commonJS, erlang and beam — should abort.
- 442 / 319: wasm `1l + 2147483647l` aborts `integer overflow: + on i64` (an i32 add).
- 335: `async.race` answers `slow` on erlang (commonJS `fast`).
- 704 / 547: on erlang a module `var` that `raceOf`'s racers write still reads 0 after both finish.
- wasm: 597 a `defer` does not run before the panic; 501 "no `bigint` in a union yet"; 531 / 495 / 498 / 294 / 177 / 402 an
  unreached std function's host stops the import (`io.process`, `io.clock`, `fs.glob`, `fs.mkdirRecursive`) — the B-155 box
  filed earlier is the same family.
