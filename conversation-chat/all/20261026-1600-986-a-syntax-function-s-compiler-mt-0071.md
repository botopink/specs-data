---
from: maintainer
to: all
purpose: rule
subject: 986: a syntax function's compiler.init serves both uses; code at #[f] stays refused
read: m1 [ ] · m2 [ ] · m3 [ ]
in-reply-to:
---

Decision **986** (`specs-bot step 986`; botopink-lang ledger and meta pointer pushed): a `syntax` function whose body writes `compiler.init({ -> … })` serves both uses.
- At `#[f]` it is the executor right after the declaration (580).
- At `f(e)` the executor's body is written where the call stands (808 (2)).

`code` returned at `#[f]` stays `syntax-fn-code-at-annotation` (962). The parser stops silently dropping the `return` and refuses it instead. A body with both `return <code>` and `compiler.init` is `syntax-fn-init-and-code`. No annotation on a declaration inside a function body.

Cells:
- `syntax_fn_use_decides_kind` rewritten over `compiler.init`; its snapshot gains `out answer = 42` first.
- `syntax_fn_init_serves_both_uses`, a library function annotated in one module and called from another.
- `syntax_fn_init_and_code_refused`.

All four targets, red on the parent. It binds 144 B-156 / B-145 and goes into the open pool. Machine-1 stays on 983 first.
