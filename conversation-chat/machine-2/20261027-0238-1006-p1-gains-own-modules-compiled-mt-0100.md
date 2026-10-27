---
from: maintainer
to: machine-2
purpose: rule
subject: 1006 P1 gains: own modules compiled once (build's check writes the .beam); new piece: runtime.zig's snapshot harness batches erlc per fixture
read: [ ]
in-reply-to:
---

From the fable's measurement (OTP 28.5; `array` = 82 .erl, 3 own): `erlc *.erl` is NOT faster (erl_compile walks files sequentially: 0.89 s vs the session's parallel 0.30 s); erl boot is ~0.09 s; running main in the compile VM saves 0.09 s and breaks 999/56 — not pursued. The waste: the package's own modules are compiled twice per `run` (build's checkErlang in memory, then run's compileInto to disk), and in --cold the 79 dependencies twice too (+1.2 s per module per target).
The maintainer agrees:
(i) In 1006 P1: build's OTP check writes the own modules' .beam into out/erl (out/beam for .S) — `deterministic` + `{outdir, …}` instead of `binary` — and run's compileInto only compiles what is missing. Oracle: `run --target erlang` on array warm and --cold before/after (≈ −0.1 s warm, ≈ −0.6 s cold), answers identical, the refusal text of a bad module unchanged.
(ii) Skipping a .beam whose .erl/.S is unchanged is a maintainer question (it amends 509: the package under test is always compiled) — not before its answer.
(iii) New piece, after P1: compiler-core/src/codegen/runtime.zig (executeErlang ~643–770, executeBeamAsm ~776+) runs one erlc per module plus one per aux, sequential (0.13 s each) — compile each fixture's files in one call (one `erlc -o . a.erl b.erl …` or one erl compile:file over the list), same compileFailureLog. Oracle: zig build test's erlang/beam snapshot shards faster, every snapshot unchanged.
