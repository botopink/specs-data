---
from: machine-2
to: maintainer
purpose: question
subject: B-138 left five libraries red on the main compiler (`.Node(` refused): who runs the libraries' 618 codemod, and how subtree-only commits pass meanwhile
read: [x]
---

B-138 landed (botopink-lang 8fdbaa3ab), and the main checkout's compiler was rebuilt on it. It refuses `.Node(`
(618 renamed it `.JavaScript(`). These libraries still write it in their own src:

| library | `.Node(` sites |
|---|---|
| rakun | 167 |
| validation | 29 |
| log | 19 |
| markdown | 4 |
| http | 1 |

So every gate and hook of those five is red on the new compiler. B-138's box left their sites to "their fronts".
166 s3 meets it now: markdown's drafts are written but the commit is refused by the hook (`src/md_text.bp:22`).
log and http (running) will meet the same, and are told to stop with their drafts staged.

Options:
(a) Machine 2 runs `scripts/codemod/implementation_javascript.py` (B-138's own codemod, mechanical) over
    validation, log, markdown and http now. Each library is one commit through its own hook, and the hook is the
    oracle. rakun stays machine 1's, because 165 s10 is in flight there.
(b) Until the fronts' codemods land, a commit holding only `conformance/modules/decisions-taken/**` and the
    workspace manifest skips the hook (`--no-verify`), as a `decisions-taken.md`-only commit does.
(c) Wait for each library's front (machine 1).
Recommendation: (a), so the gates are green again for everyone; (b) is not needed then.
Machine 1 should know before it rebuilds on 8fdbaa3ab: rakun's 167 sites will be red there.

Also from 166 s3, to route:
- 166 s3 actions landed: f53852e63 (meta 066c641ab). snap landed: f722fd4a0 (meta 99cd67f19).
- markdown 594: a comptime call through a module namespace, `markdown.toHtml(markdown.parse(source))` inside
  `comptime render(…)`, gives `the comptime block calls .toHtml(…) with 1 argument(s) …, which no primitive type and
  no type the block reaches provides`. A compiler defect (comptime); I file it as a B-155 box unless you route it.
- markdown 594 (2), a library departure: `md_text.bp`'s pure host cells (`charsOf`, `Chars.at`, `Chars.text`,
  `isWidePunctHost`) have no `.Wasm` form, so they are `comptime-host-cell-unavailable` at build. A
  `language-gaps.md` / 158 row (machine 1's front).
- markdown 330 meets B-154 (`fn` → `?fn`), as css's does.
- snap: no ledger row says how a run-time test passes its caller's location to snap. The drafts read 606 (3) as
  `comptime compiler.src`. It needs a row before s4 promotes the cells (front 160's).
