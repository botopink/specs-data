---
from: maintainer
to: all
purpose: rule
subject: Decorator sites: the fable's verdict — two checker defects (B-235, machine-1), decision 1106, rows 234/236 split; shape A lands now
read: m1 [ ] · m2 [ ]
in-reply-to:
---

The fable read m1-0243's three blockers against the decisions. **None needs a new design except one, which the user decided as 1106.**

**Q1 — the checker is behind 842, and 842's example is right.** 842 (1), in force and newer than 370 / 575, rules a member handed as a **held `fn` literal** in, and 627 rules `-> decl` inside it. Both refusals are checker defects. They're filed as **B-235**: machine-1, opus, with cells `added_member_handed_as_value` and `decl_in_type_position`.

**Q3 — decision 1106 (the user, 2026-11-04):** a `decl` typed by a type parameter has **no members**, like `unknown`.
- `<T>(syntax decl: T)` + `decl.make()` is refused, located, never left unchecked.
- `T` only hands `decl` on to another `T`-typed parameter.
- It goes in B-235's box, cell `decl_type_param_no_member`.
- **No rakun site may use the `<T>` form.**

**Q2 — rows 234 / 236 split by shape:**
- **Shape A lands now**, with no `compiler.ast` needed. It's machine-1's rakun child: the method-marker sites (`decorators.bp:263/349/427`, scheduling `markers.bp:139`, jobstore `markers.bp:114`, `registration.bp:270`), plus `entity.bp:334` / `transactional.bp:131` if their values hand over as scalar literals.
  - They register as `compiler.init({ -> rkRegisterRoute(compiler.name(compiler.owner(decl)), .Get, path, decl) })`, with `decl` the unbound method as code (613).
  - The string `addMember` and `rkRoutes` / `rkSchedules` / `rkJobs` go (625 (1)).
- **Shape B waits on two things:** B-235, and **B-149's 640 (3)** (`compiler.ast` admitted in a decorator body, **machine-2's**). It covers every `make` / `bindProperties` / `new` / `check`: `config.bp:2067` and the six string `make` members in `decorators.bp`.

**A sibling's `make`:** through the run-time registry grouped by owner. The stereotype that builds `make` registers it in its own executor (`compiler.init({ -> rkRegisterFactory(owner, make) })`), the method marker registers `(owner, verb, path, decl)`, and boot joins the two by owner. It never goes through `decl`, and never through `implement`.

**Order:**
- **machine-1:** B-232 (running), then shape A on rakun (sonnet), then B-235 (opus).
- **machine-2:** B-149's 640 (3) goes after P5-g, unless you have a slot sooner; it unblocks rakun's last red family.
