---
from: machine-1
to: maintainer
purpose: question
subject: B-232: the coercion is decided (retired, 804 (4)); what NodeChild is meanwhile is not — interim `NodeChildren = Element[]` now, or 809 (7)'s whole tree in this step?
read: [x]
in-reply-to:
---

B-232, machine-1, nothing committed. Stopped for one choice.

**What the decisions say.** No decision keeps the `Children` coercion at the language level. 804 (4) retires "the compiler-known `Children` and its coercions (a single child, a string where the list stands)", spelled `div([text("x")])`. 809 (7) restates the retirement and fixes `NodeChild = Component<Element>`, `NodeChildren = NodeChild[]`, with the builders as `component fn`s and the renderer resolving every child. 813 (1): a ready `Element` enters through a component lambda. 813 (2): the resolved tree is a record of its own. 857 (2): after the retirement, `Children` is an unknown name. The html holes (191, 223) are rakun-bpp's own `Node` alias, which the html macro lowers, so they are not the checker's business. So per the row's first box: the coercion is not something the language decides to keep, and dropping the compiler hack is fully decided.

**Measured in my worktree (experiment only, not committed).**
- I removed `isCompilerKnownTypeName` and `childrenCoercion` from env.zig and infer.zig.
- rakun-bpp now declares `pub type NodeChildren = Element[];` and uses it everywhere `Children` was. The only caller of the coercion was element.bp's G4 test `coerceSingle` / `coerceText`, which asserted the retired rule and is removed. Three tests and render.bp also needed `import {element.NodeChildren}`.
- rakun-bpp suite on commonJS, erlang and beam: identical apart from that one removed test. Beam fails 4 fewer tests, which is my base being newer than the main checkout's compiler (B-219).
- element.bp:29 `children: []` lowers in GC with no `.linear` note. The parent compiler with `Children` gives `.linear: an empty array literal of no known type at element.bp:29:5`.
- `pub type El(tag: string, children: Children)` is now `unknown type 'Children'` (857 (2)).

**The choice no decision fixes.** The decided alias is `NodeChild[]` with `NodeChild = Component<Element>`. That alias is not a representation change. It is B-162's open 809 (7) box: every builder becomes a `component fn`, every call site passing a ready Element wraps it in a lambda, and the renderer resolves each child into a new `Rendered` record (its name is "165's step's"). That rewrites render.bp, streaming, suspense, client, dom-test and so on, so the suite cannot stay byte-unchanged. `Element[]` is behaviour-identical, but it is an interim `NodeChild = Element`, which no decision names (809 even retired `Element | Component<Element>`).
- (a) Recommended: land now the compiler drop plus `pub type NodeChildren = Element[];` in rakun-bpp, plus 857 (1)'s `children_array_walk` move. 809 (7)'s `NodeChild = Component<Element>` stays B-162's box (165's commit in rakun).
- (b) Do the whole 809 (7) / 813 tree migration in B-232 now: a large semantic rakun-bpp rewrite, opus, with the `Rendered` name to fix.

Which one?
