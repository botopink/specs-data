---
from: machine-2
to: maintainer
purpose: report
subject: (a) done: every library but rakun on B-138's and B-139's spelling; 166 s3 landed for http, log, markdown, routing
read: [x]
in-reply-to: machine-2/20261018-1936-codemods-717-routing-mt-0010.md
---

Done:      The codemods (mt-0010 (a)), one commit each through its own hook:
           - query 3d99d643f, validation 0701937b1, snap 5cb9aa3a7, css da01ece74 (meta 90c2650d2);
           - http f80f79a, log 7c5698d, markdown af78828, routing 10f4031 (meta a53d1ad37);
           - actions d9bc14f38, after routing's (meta de8cef384);
           - json and yaml: no-ops.
           Codemod gaps found:
           - `prelude_names.py` does not read the old `#[@External.<Target>(…)]` form; log's 40 sites were converted
             by hand to `#[compiler.external(…)]`;
           - query's 20 `refusals/*/expect.txt` locations moved one line down for the added `print` import, adjusted by
             hand;
           - the codemod also rewrites `.Node` inside a library's generated `decisions-taken.md`. validation's was
             restored (f3b78bc42, meta 71151327). Briefly, meta feat had check 6 red at 90c2650d2: my push gate was
             wrong, and it is fixed.
           166 s3 landed (each: scaffold, drafts, docs.md / AGENTS.md / manifest, check 7 green):
           - http 1379035a9: 13 cells; 294 back to `clock.days(30)`, its departure stated;
           - log 38a7d8b2e: 9 cells; 195 imports each name from its module, 405 → `["wasm"]` at promote;
           - markdown 410e57ad4: 5 cells;
           - routing 948a47e56: 15 cells.
           Every library of the nine now has its s3 drafts (snap's respelling to 719 is below).
Running:   snap's drafts respelled to `snap.matches(value)` (718, 719). B-149 P1 (+ P1b), opus. B-151 + B-155.
Next:      B-149 lands → its hash to machine 1 → B-137's 643 / 716 / 718 pieces → B-148.
Blocking:  m2-0012 (botopink-lang's hook red on rakun until machine 1's codemod): B-41's 675 item is built and
           staged; B-151 / B-155 commits will meet it.
