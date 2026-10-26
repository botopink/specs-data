---
from: maintainer
to: all
purpose: rule
subject: Work distribution: only what is in flight is assigned; everything else is an open pool
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to:
---

# Work distribution (maintainer, 2026-10-26)

**Rule.** A machine holds only the work it already has in flight. Everything else stays unassigned, in the open pool below. An agent with a free slot takes the next pool item that touches nothing in flight: it claims the front (`claim`) or, inside a front already held, says so with `doing` and a chat line, and then works it. Items are taken one at a time, never reserved in advance. Front 166 is released for this reason.

## In flight — assigned
**machine-1** (front 144-checker):
- B-162 on `front/b162-p1-rebased`: 958, 959, 960 and 961 (1)+(3) are done. Next is 961 (2), the `bp…__` aliases, which waits on machine-2's answer (m1-0025).

**machine-2** (front 144-backends-tooling):
- pc162 / B-162 P-C (wasm `is Async<unknown>`, the five wasm unit tests): move it onto `front/b162-p1-rebased` first. Answer m1-0025 on the aliases.
- d900's leftovers, filing only: the 164 row (wasm generic `Dict.display`), the checker row "`p._0` not tied to `K` in a lambda passed to a method", and the pending question on `mapValues<W>`'s print shape.

**maintainer**:
- The decision-cell moves for check 7 (823→967, 871→974, 907→976, 951→980 with 54 folded in, 186→979 in botopink-lang and rakun, scaffolds for 964–982). Nobody touches `conformance/modules/decisions-taken/` until this lands.

## Open pool — unassigned, take in this order
1. **165 rakun-workspace**: rakun feat does not compile on today's compiler (m2-0042: 791 (4) `await-component`, `await-without-async`, methods on an `unknown` decl, the 770 cascades). It keeps `test-libs` and `test-cli` red. Highest priority.
2. **982, `compiler.load` takes a package**: B-158, B-163 and B-157's codemod (`src/cases/<case>/mod.bp` → `cases/<case>/`), cell `compiler_load_takes_a_package`.
3. **966**: cell `composition_place_stamped_by_call` and the per-target Place stamping. Its checker half follows 961 (2).
4. **964–981 where they bind code**: 967, 968, 969, 970, 974, 976, 977, 980, 981 (checker); 964, 965, 975 (rakun, behind 165). Each is its own item.
5. **166 decision-cells**: once the maintainer's move lands, the cells for the new rows beyond their scaffolds.
6. **The other unowned fronts** (98, 105, 107, 135, 136, 145–147, 150–152, 155–161, 163, 167): as their READMEs order them.

## Rules
- No force push. A rebase that would need one goes to a new branch.
- A question to the other machine goes by chat. Work that waits on the answer is set aside and the next item is taken.
- A choice no decision covers is a pending question for the maintainer, never decided in a thread.
