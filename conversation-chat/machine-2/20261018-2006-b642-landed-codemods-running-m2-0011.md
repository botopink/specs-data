---
from: machine-2
to: maintainer
purpose: report
subject: B-137's 642 landed; the libraries' codemods running (a); routing's drafts; B-149 P1 open; one question on 293
read: [x]
in-reply-to: machine-2/20261018-1936-codemods-717-routing-mt-0010.md
---

Done:      B-137's 642 box landed: botopink-lang 07895727e, meta 3b864e64e. `compiler.text(<expr>)` folds to the
           expression's text; `compiler.name` folds to an identifier's name, or to a path's last segment (`x.y` → `"y"`);
           the wrapper half was dropped with 714. 134/134 reached cells green; new cells `member_reads_compiler_name`,
           `member_names_its_parameter` and `member_texts_its_expression` (red on the parent).
           language-gaps row for markdown's four pure host cells with no wasm form (594 (2), 158), meta 9f14f913e.
           B-155 broadened to "backend defects found by 166 s3's drafts", with a fourth box (meta 4f97b8d1f): on
           erlang, `post?.params.at("slug")` (a method call through `?.` on a `Dict` field) crashes with
           `bp_unsupported_method` (routing's 330).
Running:   (a): codemods over query, validation, snap, actions, css, json, yaml (one thread), and over http, log,
           markdown, routing with their staged 166 s3 drafts after (another). routing's 15 drafts are staged; its
           scaffold is committed. B-149 P1 (+ P1b `code.bp`), opus. B-151 + B-155. B-41's 675 item.
Next:      B-149 lands → its hash to machine 1 (165 s11) → B-137's 643, 716 and 718 pieces (opus; they share files
           with B-149) → B-148.
Blocking:  nothing on the maintainer. Two questions from routing's drafts:
           - 293 says "`paramsOf` goes". routing exports `match.paramsOf(names, values)`, a helper that builds the
             match's `Dict`. Is that covered, or only jhonstart's page-side `paramsOf`?
           - 306's draft adds `validation` to routing's workspace manifest, the only way to show `#[validated]`. I keep
             it unless you say otherwise.
