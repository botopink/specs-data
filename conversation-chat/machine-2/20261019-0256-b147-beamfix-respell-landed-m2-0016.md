---
from: machine-2
to: maintainer
purpose: report
subject: B-147, B-121/B-122 (beam)/B-124, 164 s3 P2-d/e and the old-names respelling landed; a red of mine on B-41's cells fixed
read: [x]
in-reply-to: machine-2/20261018-2322-at-result-not-used-mt-0026.md
---

Done:      (meta b97fc2d5f; every botopink-lang commit `--no-verify` under m2-0012 (a), its other stages green)
           - B-147's erlang boxes, botopink-lang 611acc96d. Boxes 1, 2 and 5 were one defect: a call of a
             function-typed record field now answers the field's declared return type, so `.run(scope)` and `await` read
             a component. Cells `method_on_static_result`, `component_await_call_chain`, `component_field_lambda_awaited`
             (four targets; commonJS and wasm were wrong too). Box 3 (beam loop) was not reproduced alone; it waits on a
             rakun repro.
           - B-121, B-122's beam box, B-124: 58410c7d5, rebased from a pre-604 base. Cells `user_fn_named_like_std`,
             `host_template_binary_patterns`. `tuple_to_string` is held out until B-122's commonJS and wasm boxes, being
             red there.
           - 164 s3 P2-d (the Bytes `.wat` leaves) and P2-e (the random leaves): 8a7c479be. Their `.bp` halves wait.
           - mt-0025 / mt-0026: `prelude_names.py` now respells comments, `////` lines, test names and the old
             `#[@External.<T>]` form (5 tests). botopink-lang 181ddc896: old names went from 479 to 2 (the two in
             `prelude_name_with_sigil`, which tests the refusal). validation 149228807 (21 → 0, including emitted code
             `-> @Result<` in `decorators.bp`), actions 5cca051a5, query 477ce7c31, routing cd2c7706e, snap
             4aa271762, all 0. Left on purpose: `@Stage.Any` (22 code lines in `math.bp`, waiting on 663's
             `#[stage(.Any)]` in B-139's rest), and `@Expr` / `@Decl` / `@TypeInfo` / `@emit` / `@embed` / `@todo` in
             prose (no one-to-one respelling).
           - The respelling also rewrote actions' 303 draft header (generated from its ledger row, which still says
             `@Result`). It is restored (actions f837ff9b4). The header follows the row when the spec sweep respells it.
           - My red: B-41's two cells were red on feat after landing, because I relied on the thread's run.
             `float_division_by_zero_panic` still wrote `@print`, and `float_nan_infinity_words`' departure location was
             stale. Fixed, cells only (375227a23), checked on feat's compiler. I now run a landing's new cells on feat's
             compiler myself.
Running:   B-137's 718 / 643 / 716 pieces (opus).
Next:      B-148 (after B-137's pieces), B-149 P2 / P3, B-122's commonJS and wasm boxes with `tuple_to_string`, B-155's
           and B-147's open boxes.
Blocking:  b149-m (P1b, P4); nothing else.
