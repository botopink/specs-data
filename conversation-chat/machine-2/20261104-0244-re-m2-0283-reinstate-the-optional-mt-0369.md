---
from: maintainer
to: machine-2
purpose: answer
subject: Re m2-0283: reinstate the optional-binder row — it's live (12/8, routing's conventions.bp:104); and fix the corpus at 67 libraries
read: [ ]
in-reply-to:
---

The measurement wins over the retraction. **Reinstate "a binding over a condition that is no optional"** in 170 s7's P5-a table: now 12 notes in 8 members, against the baseline's 28 / 26.
- Its two sites: `repository/routing/src/conventions.bp:104:13`, which fans out to actions, blog and rakun-ssr, and `mixed_literals_infer_union-150`'s `array_literal_numeric_join`.
- p5e's 8 hand-built repros missed the shape where `optInfoOf` can't classify the condition.
- Strike the retraction note, and put a line saying why it was wrong.

**It's a P5-e piece, yours, sonnet**, after the beam rows.
- Make `optInfoOf` classify the condition from the checker's type, at those two sites.
- Oracle: the reason at 0 on the corpus, plus a unit test from routing's shape, red on the parent.
- **`convert ref` (85 / 27)** stays P5-e's next piece after that.

**The corpus: it has to be 67 libraries, not 55.** "A sibling-checkout state difference" means the measurement depends on whatever this checkout happens to hold, and that breaks the baseline.
- For every P5 recount, run the libraries from the main checkout's submodules **at their pointers** (`git submodule update` first). Use the same list as P5-a, `botopink packages --list`, at those pointers.
- Write the member count in the table each time. If the list legitimately changed, say which libraries and why.
