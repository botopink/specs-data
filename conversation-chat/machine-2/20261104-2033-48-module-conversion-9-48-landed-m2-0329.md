---
from: machine-2
to: maintainer
purpose: question
subject: 48-module conversion: 9/48 landed; found structural cells/→cases/ harness gaps affecting the other 39, three decisions needed
read: [x]
in-reply-to:
---

Landed `988d7b7dd` (meta `b1eb1918`): 9 of the 48 old-shape decision modules converted cleanly to decision 989's cases/ shape, each verified byte-for-byte against the old shape's recorded answer on every target before the old cells/ was deleted. Roster check: 48 failing → 39 failing.

Note on mt-0425's citation: it referenced "decision 1110" for Q1's ruling, but 1110 is actually "ck3-int" (integer literal typing, now superseded by 1113) — unrelated. The real authority used was your direct text answering m2-0309's Q1 ("convert the 48 cells/-shaped decision modules to the cases/ shape now... do not add them to leftover-cases.txt"), which carries no decision number of its own. Flagging in case that citation needs correcting elsewhere.

The other 39 were NOT converted — converting them exposed genuine structural gaps between decision 989's `compiler.load()`-based harness and scenarios the old standalone `cells/` shape never had to survive (confirmed independently against the standalone shape, not guessed): a loaded case's own module/package path differs from a standalone build's (breaking any case whose answer reflects its own path, and one erlang-atom-hardcoded case); `.bpp` files lose their specific diagnostics under `compiler.load` (generic "unresolved module declaration" instead); self-signaling tests aren't process-isolated across a module's cases; "every module under src/ joins the program" (decision 677) doesn't hold for a dynamically-loaded sub-package; dependency init-executor side effects and refusal formatting differ under load; target-exclusion narrowing differs; stderr capture during an abort is unreliable through the harness's adapter on some targets; an async main's prints aren't captured on commonJS in one case. Full detail with every affected module name is in front 144's thread report (relayed to me, not yet in a spec doc — want me to write this up as its own row, or is this 170 s6's territory since it's about the harness itself?).

Three things need your call, not mine:
1. **`is_async_answers_a_task-967` and `root_closed_by_run-825`** are already red standalone (unrelated to this conversion) for a reason decision 1104 already landed — convert their layout now, keeping the same (correct, already-known) red answer, or leave them in cells/ shape until that's separately fixed?
2. **The structural harness gaps above** — do they block the remaining 39 modules entirely until someone fixes the harness, or is each module meant to just document/accept its own discrepancy and move forward case by case? This looks like real compiler/harness work, not more conversion labor.
3. **10 modules are genuinely untested** (declared, dependency, erlang, host, manifest, sidecar, std, targets_default_is_dependencies_intersection-770, use_all_resolves_a_list-827, use_child_cell_provide_in_order-812) — the thread's own test harness had a stdin-sharing bug that silently truncated its run; fixed, but it ran out of time before finishing. Resume with a fresh thread, or leave for later?
