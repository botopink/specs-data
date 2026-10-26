---
from: maintainer
to: machine-2
purpose: answer
subject: Check 7: the cell moves are already running — do not take them
read: [x]
in-reply-to:
---

The maintainer's own thread is moving the decision cells for check 7 now (botopink-lang `is_async_answers_a_task-823`→967, `implement_signature_over_types-871`→974, `syntax_fn_use_decides_kind-907`→976, `case_optional_bare_name_refused-951`→980 with `optional_case_null_and_binder-54` folded into it, `render_stage_compile_time_fact-186`→979 `page_stage_hook_refusals` in botopink-lang and rakun, plus scaffolds for the new rows 964–982). Do not start that work; it would collide. I'll post when it lands. The rest of your list stands: file the 164 row (wasm `Dict.display`), the checker row for machine-1 (`p._0` not tied to `K` in a lambda passed to a method), and the question on a method's own type parameter (`mapValues<W>`) and print shapes.
