---
scope: >-
  Decides what a module-level `var` is: one value for the whole program on every target, how the BEAM
  holds it (`#[compiler.beamMemory(.Ets)]` / `(.PersistentTerm)`), the atomic `x = f(x)` write, the
  `Dict` seeds a module `var` accepts, and what is refused (a lambda's write to a captured `var`, a
  `var` holding an `Async`). `Dict.bump` is numbers-and-arithmetic; the annotation's spelling is
  decorators.
terms:
  - 'module `var`'
  - '`#[compiler.beamMemory(.Ets)]`'
  - '`#[compiler.beamMemory(.PersistentTerm)]`'
  - '`x = f(x)`'
  - '`persistent_term:put`'
  - '`ets:select_replace`'
  - '`module-var-holds-async`'
  - '`lambda_captured_var_write_refused`'
  - '`Dict.ofEntries`'
  - 'captured `var`'
related:
  - 'numbers-and-arithmetic'
  - 'decorators'
  - 'functions-lambdas-and-blocks'
  - 'wasm-target-and-runtime'
binds:
  - '`machine-2/144` B-143'
  - '01-checker step 7'
  - '02-erlang step 8'
  - '03-beam step 4'
  - '17-beam-memory step 1'
retired:
  - '`module-var-holds-task`'
first-step: 148
last-step: 905
in-force: 4
superseded: 1
---
# module-vars-and-beam-memory — a module-level `var`

**A module-level `var` is one value for the whole program on every target; `#[compiler.beamMemory(…)]` only picks how the BEAM holds it.**

(1) Writes to a captured `var`, the `Dict` seeds of a module `var` — 148, 168.

(2) The atomic `x = f(x)` on a `.PersistentTerm` var; a `var` holding an `Async` — 903, 905.

Steps: 148, 167, 168, 340, 343, 376, 522, 544, 547, 663, 710, 903, 905
Binds: 01-checker step 7 · 02-erlang step 8 · 03-beam step 4 · 17-beam-memory · 17-beam-memory step 1 · std · `01-compiler/17-beam-memory` step 1 · std's `Dict` · `1-botopink-lang/144` · `machine-1/144`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 148 | lg-b | A lambda's write to a captured `var` is refused at check time on every target, located at the write, unless the lambda is a `forEach` body or a local closure called at statement position; a counter shared across calls is a module-level `var` (`#[compiler.beamMemory(…)]`) | 01-checker step 7 · 02-erlang step 8 · 03-beam step 4 | lambda_captured_var_write_refused |
| 168 | 17-a | `Dict.empty()` and `Dict.ofEntries([…])` of literals (`Dict.ofEntries([#("a", 1)])`, 174) seed a module `#[compiler.beamMemory(.Ets)] var x: Dict<K, V>` (`keyed: true` removed, 547), folded at compile time | 17-beam-memory step 1 · std | beam_memory_dict_literal_seeds |
| 522 | B-30-a | Overtaken by 544 | `1-botopink-lang/144` B-30 · 448 · 449 | wasm_message_cycle_refused |
| 903 | 547-b · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; the recommendation (b) overruled: 547 makes a module `var` one value whose `x = f(x)` answers as commonJS's and wasm's on every target and lets the annotation pick only how the BEAM holds it — a lost write would be a second meaning; 547's "no check" is the annotation's fitness, not the write's; rejected: (b) the reference documenting a lost write; (c) `x = f(x)` refused on a `PersistentTerm` var — the same race in `val y = f(x); x = y;`, in silence) | A `#[compiler.beamMemory(.PersistentTerm)]` var's `x = f(x)` is atomic on the BEAM as an `.Ets` one's is (547 (ii)): read, compute, `persistent_term:put` under a per-`var` lock the runtime holds and releases however the writer ends; no write is lost on any holding; reads stay `persistent_term:get`, lock-free; a plain `x = v` is one `put`; the reference states the write's cost (the scan and the lock). (1) The lock is the runtime's, beside the module-var process of 547 (i); a writer that dies releases it; the mechanism is B-143's. (2) Off the BEAM nothing changes (547). (3) Cell `persistent_term_var_write_atomic`: N processes incrementing one `PersistentTerm` var print the total on the four targets, red on the parent on erlang and beam | `machine-2/144` B-143 | persistent_term_var_write_atomic |
| 905 | 547-c · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; rejected: (a) `module-var-holds-task` as built — 547 (iii)'s `@Task` is `Async` since 553 (2), 732, and a code spells no retired name (retired.md)) | A module `var` whose type holds an `Async` is refused `module-var-holds-async`, at the written type else the name; "holds" reaches through type arguments, tuples and the fields of records and variants, never through a function type (a closure only); a module `val` holding an `Async` is accepted (547 (iii)). (1) `module-var-holds-task` is renamed in `diagnostics.zig`; the three refused cases of `module_var_one_program_value-547/` are re-recorded. (2) Cell `module_var_holds_async_refused`: the three shapes refused with the code, four targets | `machine-2/144` B-143 | module_var_holds_async_refused |
