---
from: maintainer
to: machine-1
purpose: answer
subject: The fable's three verdicts: all three are rakun work, no compiler change, no new decision — filed in front 169 Known reds
read: [ ]
in-reply-to:
---

**1. B-217 is not a compiler defect, so I refiled it to rakun.**
- A call is counted where it's written (966 (3) / (4)). A fill opens its own cell under the detached seed (966 (5), 970 (3)). A boundary holds the component *value*, not a thunk (964 (2) 30-c / 30-d, 809 (7)).
- `suspense.bp`'s `Boundary(child: fn() -> Component<Element>)` thunk stamps `Slow()` over the page's cell and then runs in the fill's process. That gives `scope-foreign`, which is 970 (3)'s own answer.
- `streaming.bp` also runs the fill over `Scope.root()` instead of `Fill.scope`. That is `bridge_test:116`.
- Fix in rakun-bpp:
  - `Boundary.child: Component<Element>`, evaluated in the page body;
  - `Fill(boundary, scope: myScope.detach())`;
  - `run(b.child, fill.scope)`;
  - the same for error and not-found boundaries;
  - `keptAt` / `boundTo` / `__jhPushBoundary` go.
- `std` stays as it is.

**2. `modules/rakun`'s boot: async.**
- A boot is a root (825 (1)), and on commonJS a module body may await (809 (4)). So it's `pub async fn boot() -> Async<void>`, with `main` writing `await rakun.boot();`.
- `mount` resolves `resolve(c, root, Place.key(m.name))` and awaits a task answer. **Not `Place.none()`**: that would put every module in one cell, and their hooks would collide (966 (5), `openChild`).
- `inject(name)` resolves by hand over its own cell with `Place.key(name)`.

**3. The 716 decorator sites take two decided shapes, not a behavior contract per site.**
- **Method-marker sites** (`decorators.bp:263`, `markers.bp:139`, jobstore `markers.bp:114`, `registration.bp:270`) register through `compiler.init` with the declaration as code (625 (1), 613). `rkRoutes`, `rkSchedules`, `rkJobs` and the string `addMember` go.
- **Sites reading a member they add** (`config.bp:2067`, `entity.bp:334`, `transactional.bp:131`) use it from the value they built, never through `decl` (842 (1)). They type `syntax decl: <Behavior>` only where the type writes `implement` (842 (2)).
- This is 165 s10 rows 234 / 236.

All three are now in front 169 § Known reds with their oracles. Model and order, after B-218 / B-221 and the P5-d empty-array piece:
- (1) opus, the most reds it clears;
- (2) sonnet;
- (3) opus for the first site of each shape, then sonnet for the rest.
