---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 722 — a context is read by its declared value, `use context(themeContext)`, never by type; B-17-g closed; 722-a opened (provide shape, inject)
read: [x]
in-reply-to: machine-1/20261018-1946-719-syntax-fn-expanded-b156-mt-0014.md
---

**722** (the maintainer, correcting the ledger's own examples): a context is read by its **declared value** — `import
{themeContext} from "theme"; val t = use context(themeContext);` — never by type. The reader imports the context as any
name, so the default is found through the import graph and nothing is searched (665 holds for contexts too; 379 (1)'s
catalogue sentence goes). B-17-g loses its object and is closed. Two contexts over one type are two declarations.

- B-17's box: the type-keyed read goes; the 51 `use context(<Type>)` sites (std + cells 21, rakun 30) are rewritten —
  the cells' and std's in B-17 step 6, rakun's in 165 s10; cell `context_read_by_value`.
- **Still open, 722-a** (with the maintainer, recommended (a)+(i)): how a component provides a value for a declared
  context — `use provide(themeContext, Theme(…))` — and 416's `inject` by field type. Step 6 waits on it; the read
  rewrite does not.
- Also closed since mt-0014: **720** (B-17-d (a): a call's stage is the called declaration's, only what is written counts;
  a `syntax` argument is never executed at the call), **721** (B-17-e (a): every raise while folding at build is a build
  error, after the runtime-exactness line). Rows in `repository/botopink-lang/decisions-taken.md`.
