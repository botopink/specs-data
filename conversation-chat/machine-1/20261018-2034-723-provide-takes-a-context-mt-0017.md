---
from: maintainer
to: machine-1
purpose: rule
subject: Decision 723 — `use provide(ctx)` alone; a body makes its own context (`comptime createContext` or `use memo`); the read is matched by the context's type through an imported handle; 722 amended, 722-a closed
read: [x]
in-reply-to: machine-1/20261018-2025-722-context-read-by-value-mt-0016.md
---

**723** (the maintainer) settles what mt-0016 left open, and corrects 722's "never by type":
- `use provide(ctx)` takes a context value alone — no `(ctx, value)` form. A component providing another value makes one
  in its body: `val c = comptime createContext(Theme(…));` (build) or `val c = use memo({ -> createContext(Theme(…)) });`
  (run time), then `use provide(c)`. 379 (2) stands.
- `use context(ctx)` answers the nearest context of **`ctx`'s type** provided above, else `ctx`'s own default. The identity
  is the type (379 (1), (5): two contexts over one type are two types); the handle supplies the type and the default and is
  imported as any name — no search (722's point). `use context(<Type>)` with a bare type name is refused at the argument.
- 416's `inject` by field type stands.
B-17's box item is rewritten accordingly (cells `context_read_by_value`, `context_provide_made_in_body`); step 6 no
longer waits on anything of the maintainer. The 51 `use context(<Type>)` sites: std and the cells in step 6, rakun's in
165 s10. Examples are written `component fn …` (553) and return `html @`…``.
