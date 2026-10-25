---
from: machine-2
to: maintainer
purpose: report
subject: Under 768 / 769: the parked compiler branches pushed for machine 1 (five front/<name>); B-157 P3 held again; one wasm red named
read: [x]
in-reply-to: all/20261019-0754-decision-769-the-split-mt-0046.md
---

Done:      Read mt-0043 … mt-0046 and "Under 768". **Branches pushed to botopink/botopink-lang for machine 1.** Each holds its
           last uncommitted work as a final "WIP: parked by machine 2" commit (`--no-verify`, unverified). Machine 1 continues
           from them; nothing of them is built here.
           | branch | tip | what it holds | where it stopped |
           |---|---|---|---|
           | `front/b149p1b` | 3b41cb197 | B-149: 751's `ast_node_closed_union`, 752's error at the `ast` call, 753's `Fn` and type nodes, P1b `code.bp` begun | 3 commits + WIP: std template import registration for `code` |
           | `front/rkgap2` | 0a6e952cd | rakun's gap 2: commonJS `./std/io/terminal.js` for a consumer | WIP: the repro cell begun, no fix yet |
           | `front/d595` | f434b62b2 | 595, the `try { … } catch …` region | WIP: cells and parser / checker begun, the parent build not run |
           | `front/d584` | 6391a3b6d | 584, the marker inside the lambda's brace | WIP: parser, checker and formatter begun, the parser / format tests next |
           | `front/b137r` | adae63de1 | B-137: 759's `decorator-member-local-not-literal` and its cell | WIP: the located refusal at the member and executor sites |
           Each branch sits on an older `feat`; rebase before building.
           B-157 P3's `apply` landed as code only (botopink-lang da9a1f7ca, meta eaad66a9d), and no cell moved: the user's earlier
           "now" is replaced by your order, P3 after machine 1's B-116 (ii), B-139's rest and B-148. Machine 1: m2-0020's
           heads-up stands for when it runs.
           **A red named to machine 1** (filed as a B-155 box, meta eaad66a9d): on wasm, importing `io.process` is refused again,
           "`rawOnSignal` has no implementation for the wasm backend" (`conformance/test/std_process_import.bp`), against 518 (4) /
           652 (3). It was green at 916a688c5. The bisect was stopped unfinished when 769 moved compiler fixes to machine 1.
Running:   (conformance only, as the new section orders) `plan` clean on the completed `Cell` column, the counting aligned with
           `decision-cells.py`, the opus pass over the ambiguity list; 166 drafts for botopink-lang's rows no cell proves; the
           eight library gates of the docs commits.
Next:      P4 stubs, 166 s4 per repository, s5, docs.md examples, 163 s9.
Blocking:  nothing on the maintainer; json's `unquote` / `array` / `object` question stands (m2-0021).
