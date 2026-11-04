---
scope: >-
  Decides a function's stage (`Build` / `Run` / `Any`) from the resources it names and its
  propagation, what is folded at build and the build error a fold's raise becomes
  (`comptime-badarith`, located frames), top-level `comptime { … }` blocks and the expansion of
  `comptime`-parameter functions with their `compiler.init`. The comptime runtime's primitives are
  comptime-runtime; `compiler.*` reads are compiler-module; template holes are templates.
terms:
  - '`#[compiler.stage(.Any)]`'
  - '`Any`'
  - '`run-in-build`'
  - '`build-and-run`'
  - '`comptime-badarith`'
  - '`comptime { … }`'
  - '`compiler.init`'
  - '`compiler-output-outside-decorator`'
  - '`called from`'
  - '`HookNode.stage`'
  - '`hole_known_at_build_raises`'
  - 'folding'
  - 'division by zero'
  - 'expanded function'
related:
  - 'comptime-runtime'
  - 'compiler-module'
  - 'templates'
  - 'syntax-and-comptime-parameters'
  - 'numbers-and-arithmetic'
  - 'registry-and-init'
binds:
  - '`01-compiler/01-checker` step 36'
  - '`01-compiler/130`'
  - '`01-compiler/14` step 8'
  - '`1-botopink-lang/144`'
  - '`1-botopink-lang/144` B-32'
  - '`machine-1/144` B-159'
  - '`machine-1/144` B-17'
  - '`machine-1/144` B-18'
  - '`machine-2/144` B-32'
  - '`machine-2/166` s3'
retired:
  - 'a `comptime fn` form'
  - '`#[Stage.Any]`, `#[@Stage.Any]`'
  - '`compiler.init` of an expanded function as a program-start init, anywhere (788 (2))'
  - '721''s "index out of bounds" raise'
  - '911 (a hole''s raise example written as `raising "x"` / `quote @`…``)'
first-step: 376
last-step: 977
in-force: 14
superseded: 1
---
# stages-and-folding — `Build`, `Run`, `Any`, and what is computed at build

**Every function has a stage computed from the resources it names; what depends on nothing of the run time is computed at build wherever it is written, fully or an error at build.**

(1) Stages, propagation, `stage` — 376, 681.

(2) Folding, a fold's raise — 380, 721, 777.

(3) `comptime-badarith`, frames, deep `==` — 472, 533, 869, 532, 471.

(4) Top-level `comptime` blocks — 788, 793, 808.

(5) A hole known at build — 977 (replaces 911).

Steps: 376, 380, 471, 472, 532, 533, 547, 562, 632, 634, 681, 682, 720, 721, 764, 777, 788, 793, 808, 869, 911, 977
Binds: `01-compiler/01-checker` step 36 · `01-compiler/14` step 8 · `01-compiler/130` · std · 277 · 375 · `1-botopink-lang/144` B-32 · 434 · 450 · 444 · `1-botopink-lang/144` · `1-botopink-lang/144` B-99 · `2-libraries/165` s5, s7 · `machine-2/144` B-137 · `machine-1/144` B-17 · `machine-1/144` B-18

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 376 | 14s8-b · (stages) | **Every function has a stage — `Build`, `Run` or `Any` — computed from the resources it uses and propagated through its calls; `use` takes its hook's stage.** (1) Resources. Build-only: `compiler.*` (575 (3)), a template body's reads. Run-only: a host function with an effect (io, `fs`, clock, random, network, `process`, `env`), an `await` on a host `Async`, a module `var` (547). Neither — `Any`: arithmetic, strings, records, arrays, `case`, loops, std's pure primitives. Amended: reading a `comptime` parameter makes a function expanded, not `Build` (562); a call's stage is the called declaration's (720). (2) `Any + Any = Any`, `Any + Build = Build`, `Any + Run = Run`; `Build + Run` is `build-and-run` at the second resource, naming the first; a `comptime { … }` block inside a `Run` function is resolved at build into a constant. (3) `use` is a means, not a stage: `use h(…)` has `h`'s stage — `provide`, `context` (388) and a style's activation `Any`; `request()` / `response()` / `cookieValue(…)` / an atom `Run`; a hook of the program what its body gives. (4) Host functions are `Run` by default (67); std declares `Any` on its pure primitives (`string`, `math`, 263), a library may declare its own; the spelling is 681's. (5) What is computed at build is 380's; a body that runs at build (a decorator's, a template's, a `comptime` block) calls `Build` and `Any` functions, a helper of the program included, never a `Run` one — `run-in-build` at the call; `async` (375) exists only inside `Run`. (6) Published with the hooks list (`HookNode.stage`, beside 375's `async`) and across modules | `01-compiler/01-checker` step 36 · `01-compiler/14` step 8 · `01-compiler/130` · std · 277 · 375 | function_stage_propagated |
| 380 | (build) | **What depends on nothing of the run time is computed at build, wherever it is written — fully, or an error at build.** (1) An expression whose every input is known at build (a literal, a constant `val` of any module, a `comptime` value, a context read known at build, 379 (6)) and whose every function is `Any` (376) is computed by the comptime runtime wherever it is written — a body, an argument, a hole, a `val` — with no `comptime`: `val raio = ESPACO * 2 + 4;` in a component is `12`; `padAll(n)` with `n` a parameter is not. (2) No limit: no step or time budget, no fallback to the run time; a raise (a division by zero, 472; an overflow, 264) is an error at build at the expression; a computation that never ends never ends the build. (3) A raise written as such — `panic(…)`, `throw` — is never computed at build without `comptime`: a dead branch's `panic("never happens")` stays a run-time raise. (4) `comptime` written demands the build: an input of the run time under it is an error at the input | `01-compiler/14` step 8 · `01-compiler/01-checker` step 36 | build_known_computed_at_build |
| 471 | (comptime, the maintainer, 2026-10-11) | **Structural equality at build answers whatever the depth: iterative, never bounded by the runtime's stack.** `==` over terms (and every comparison of the runtime's term library: term order, map keys, `lists:member` …) walks with an explicit work list on the heap, not recursion — `comptime same(2000000)`, two 2,000,000-deep chains, answers `true` on every target, never a stack-overflow trap; a depth limit is never part of the language's answer; the wat runtime's limits (434 (6)) cover memory, not depth | `1-botopink-lang/144` B-32 · 434 · 450 | comptime_equality_iterative |
| 472 | (comptime, the maintainer, 2026-10-11) | **An arithmetic error at build reads as Erlang's, located as JavaScript's.** Every `badarith` at build is refused with Erlang's wording plus the operation and place — `` error: comptime-badarith: an error occurred when evaluating an arithmetic expression — `1.0 / 0.0` (division by zero) `` and ` --> src/main.bp:<line>:<column>` at the expression —, never the raw `{error,badarith}` term; one message on every target (434 (5)); at run time each target keeps its own answer (commonJS / wasm `Infinity`, erlang / beam `badarith`, 444) | `1-botopink-lang/144` B-32 · 434 · 444 | comptime_badarith_message |
| 532 | B-48-a | **A raise at build is located at the call that raised, with frames (451 (3); 144 B-48).** In its own file — a helper's line in the library, a decorator body's line in its module —, every call of the chain a `called from <file>:<line>:<column>` line, innermost first, down to the program's call, annotation or `comptime`; a call inside a template expansion takes the frame of the template's use, the one line it has — no call of an expansion left unlocated | `1-botopink-lang/144` | build_raise_located_with_frames |
| 533 | B-32-a | `comptime-badarith`: every division and remainder by zero at build — `/` and `%`, integer and float, alone or inside a larger expression — reads `… (division by zero)` (472's wording), located at the dividing operator, never at the whole expression | `1-botopink-lang/144` | division_by_zero_at_operator |
| 681 | B-17-b · (confirmed as built, the maintainer's batch, 2026-10-18) | **A function's stage is written only as `#[compiler.stage(.Any)]` (774's spelling of 663's `stage`), `compiler` imported from std; `Build` and `Run` follow from resources and are never written — `#[compiler.stage(.Build)]` / `#[compiler.stage(.Run)]` are refused by `stage` itself at the argument.** std's `math` host functions carry it | `machine-1/144` B-17 | stage_any_annotation |
| 721 | B-17-e · (the maintainer, 2026-10-18) | **Every raise met while folding at build is a build error at the expression — a failed conversion, a missing key, a `panic` reached inside an `Any` function (380 (2)); nothing that raised at build is left to the run time** (amended by 777: an index out of bounds is no raise, `xs[3]` answers `null`). The message is the target's (472's one text); a fold is never dropped to leave the expression running; unchanged: 380 (3) — a `panic` / `throw` written as such is never computed at build without `comptime` — and a fold that never ends never ends the build; order: after the B-17 line making the comptime runtime's primitives answer exactly as the targets do — a wrong primitive answer is never a false build error | `machine-1/144` B-17 | fold_raise_is_build_error |
| 777 | 721-a · (the coordinator †, 2026-10-19) | **721's raises lose "an index out of bounds": `xs[3]` answers `?T` (`null`, 63 as overtaken by 139) and raises nothing, so no fold can raise there; the raises that remain are a failed conversion, a missing key and a `panic` reached inside an `Any` function.** The 721 draft shows a failed conversion | `machine-1/144` B-17 · `machine-2/166` s3 | index_out_of_bounds_reads_null |
| 788 | load-i · (the maintainer, 2026-10-19: the conformance module's `src/main.bp` written as `fn runCase(comptime name: string) { … }` and a top-level `comptime { runCase("…"); … }`) | **A module may hold top-level `comptime { … }` blocks: build bodies run once per build in the order written, after the module's declarations are known; a function whose every parameter is `comptime` is called there and expanded at the call (139's rule) — no `comptime fn` form** (amended by 793, 808). (1) It holds what a build body holds — `compiler.*` (`load`, `init`, …), `val`s known at build, calls of expanded functions, `print`; a run-time effect reached there is `run-in-build` (594 (1)); it answers and declares nothing outside itself. (2) Order: a module's blocks top to bottom; a package's modules in their build order (660's levels between packages); each `compiler.init` registered there runs at program start in that order (632). (3) A `print` reached in it or in a function it expands is the build phase's output, recorded by 789. (4) The return type stays written on the expanded function (`fn runCase(comptime name: string) -> void`, 284 (1)) | `machine-1/144` B-159 | module_comptime_block |
| 793 | 788-a · (the maintainer, 2026-10-20: ticked (a) on each of the five points) | **One rule for every top-level `comptime` block; amends 788 (1)–(3).** (1) A `return` or a `throw` inside a block is refused, located. (2) A library package's block runs in the build of the package using it, in 660's level order. (3) A function whose every parameter is `comptime` is expanded at the call also when `pub` and called from another module's block. (4) A cached build replays the build output: every build prints it. (5) A `comptime { … }` inside a function body writes its `print` as build output too | `machine-1/144` B-159 | module_comptime_block_rules |
| 808 | 793-a · (the maintainer, 2026-10-20: of a run-time call, "toda função com parâmetros comptime é resolvida parte ou totalmente no build independente se são ou não chamadas no comptime"; then "concordo com as duas": (2-ii) over an init moved before `main` (2-i) and a refusal (2-iii), and (4-a′) over a refusal (4-a) and an init at program start (4-b); (1) and (3) as recommended, (1)(a) over a hidden handle parameter (b) and private-only (c), (3)(b) over the decorator's executor (a)) | **A function whose every parameter is `comptime` is expanded at build wherever it is called; its `compiler.init` is a program-start init only in a top-level `comptime` block, anywhere else the executor's body is written where the call is; amends 788 (2), 793 (3).** (1) In its own module a `pub` such function writing `compiler.init` type-checks with `compiler.init` typed `void` and leaves the program (562's drop) — no hidden handle, no refusal. (2) A run-time call (`main`, any run-time body, any module) is expanded at build as every call is (562): the build-only lines run at build, the `compiler.init({ -> … })` it reaches emits the executor's body at the call, run when that line runs — `print("antes"); runCase("soma"); print("depois");` prints `antes`, the case, `depois`; under an `if`, only when the branch runs. (3) A call from a decorator body stays refused `compiler-output-outside-decorator`; 793 (3) names blocks. (4) A `comptime { … }` inside a function body (793 (5)) calling such a function writes the executor's body where the block is, run each time the function runs. Only a top-level block, inside nothing that runs, makes `compiler.init` a program-start init in 788 (2)'s order | `machine-1/144` B-159 | comptime_init_at_call_site |
| 869 | 533-a · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 2" — decided by the fable at the maintainer's delegation; rejected: (a) the `comptime`'s whole text at a caret on one operator, (c) no backticked operation (472's wording keeps it)) | **`comptime-badarith` names the operation at its caret: the dividing `binaryOp` as written (`6 / (3 - 3)`; `a / b` in the helper's own file), text and caret agreeing; the chain is the `from` lines (532); amends 533.** (1) The backticked text is the source of the node whose operator the reply located, never the enclosing expression. (2) A non-division `badarith` names its own operation the same way | `machine-2/144` B-32 | badarith_names_dividing_operation |
| 911 | 14s8-c · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; the maintainer's answer of 2026-10-11, (a), numbered; rejected: (b) the hole computed at render — a raise deferred to run time against 380 (2)) | Replaced by 977 | `machine-1/144` B-18 | hole_known_at_build_raises |
| 977 | 911-fix · (the fable, at the maintainer's delegation — the review triage of 814–955, 2026-10-26) | **A template's hole known at build whose fold raises is refused at the hole, located, never deferred to render (380 (2) applied to the hole); a raise written as such in a hole stays 380 (3)'s run-time raise; replaces 911.** (1) A hole's expression is spliced into the template's code (577 (1), 802); with every input known at build it is folded by the comptime runtime as a `comptime` is (331, 380 (1)), a raise in that fold (a division by zero, 472; an overflow, 264) an error at the user's hole, with its frames (532). (2) `panic(…)` / `throw` in a hole is 380 (3)'s: not folded unless `comptime` is written, a run-time raise where the template's code runs; `${comptime panic("x")}` is refused at the hole (380 (4)). (3) Cell `hole_known_at_build_raises`: `pub val zero = 0;` and `` html @`<p>${10 / zero}</p>` `` in a component body refused at `${10 / zero}`, `${comptime panic("x")}` refused the same, `${panic("x")}` alone compiling; four targets | `machine-1/144` B-18 | hole_known_at_build_raises |
