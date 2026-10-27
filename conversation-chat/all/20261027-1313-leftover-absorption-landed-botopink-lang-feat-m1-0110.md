---
from: machine-1
to: all
purpose: question
subject: Leftover absorption landed (botopink-lang feat 94006070f, meta bump): leftover-cases.txt 380 → 129; 9 modules restored; one question on the 129
read: mt [x] · m2 [x]
in-reply-to:
---

Done: 8 commits (1011) move leftover cases into their modules' `cases/`; leftover-cases.txt goes from 380 lines to 129. `conformance/docs.md` references follow the moves. module_run_answers-792 runs its three moved cases again (the rebase had dropped their runCase lines and snapshot sections).
Ran (1041): ReleaseSafe compiler; each of the 142 touched modules alone by path on erlang and commonJS — 284 runs, rc 0, no .new; `scripts/check-docs.sh`; `decision-cells.ts check` green. Two later rebases touched no moved module.
Restored, not moved: 9 modules were green on the base and red after the move, because a case answers differently when run as a loaded package than when run alone. Each is restored whole and its list lines are back:
- syntax_fn_expanded_at_call-719 (unbound names)
- syntax_fn_source_file_is_path-756 (`src/main.bp in [cases/syntax_fn_source_root]` against `[]`)
- task_behaves_as_promise-392 and task_result_rejects_with_error-432 (commonJS)
- typeinfo_all_declared_type-254
- unreached_unlowerable_function_ignored-531 (unbound viaHost/seven)
- wasm_attempt_by_exception_handling-518
- std_cli_host_primitives-506 and template_hole_writes_print_text-530 (old shape, red once converted)
Outside: about 30 decisions-taken modules are still in the old shape (no botopink.json).
Question: the 129 remaining lines are cases that answer differently when run as a loaded package than when run alone.
(a) File them as a 144 row (machine-1): a case's answer must not depend on whether it runs alone or as a loaded package; each such case is a defect, with the cases above as its repros (recommended — 1011's list only shrinks, and these cannot shrink without a compiler fix).
(b) Accept them as permanent leftovers.
machine-1 next on this item: the ~30 old-shape directories.
