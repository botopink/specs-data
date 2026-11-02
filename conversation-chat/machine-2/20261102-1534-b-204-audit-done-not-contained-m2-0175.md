---
from: machine-2
to: maintainer
purpose: answer
subject: B-204 audit done: not contained — and there's a pre-existing linear-mode boxing path that may be the better fix entirely
read: [ ]
in-reply-to: machine-2/20261102-1529-a-but-audit-the-repr-call-mt-0236.md
---

Audit done (no edits). ~111 Repr/.ref-related call sites checked across wat.zig; ~85 already gated by self.mode == .gc or a gc-prefixed function, safely unreachable either way. Twenty needed individual reading. Result: not contained — bigger than scoped, and there's a real alternative worth evaluating before committing to (a) as originally framed.

HIGH risk, beyond the boxing pair at lowerCoerced/emitConvert I'd already scoped:
- case-subject vs. a numeric-literal arm (~17343, 17677): isWord() returns true for a boxed .ref the same as a plain i32, so a generic case subject's comparison would use i32.eq on the boxed pointer instead of the decoded value — wrong answer, not a crash.
- generator/iterator yield typing (genItemOfTypeRef ~29053, feeding genLoopItem/genResultItem and the step/yield emission ~29387-29429): calls reprOf directly, not gc-gated (for/iter loops run on every target) — every downstream reader of a yielded generic value's repr would need an unbox step that doesn't exist today.

The more important finding: a separate, pre-existing boxing mechanism for "unknown" in .linear mode already exists, independent of Repr entirely — elemBoxOfExpr/elemBoxOfTypeRef (~6091, 6105) and allocTagged/primDescriptorAddr's tagged-box code (~5995-6160), keyed off AST-level signals (isUnknownExpr, type hints), used for array/tuple literals and case arms today. If I widen reprOf to produce Repr{.ref=.unknown} in linear mode, that new path would run *alongside* this existing one rather than through it — two boxing mechanisms, not one. I haven't evaluated whether routing the generic-slot case through the EXISTING tagged-box mechanism (rather than widening Repr at all) gets the same result with a much smaller diff — that's unexplored, not ruled out.

MEDIUM, needs a direct test either way: caseResultRepr (~16877) and emitArith's i32-vs-i64 helper selection (~32335) over a generic arithmetic body — plausible but I found no concrete call site proving it fires.

My read: this clears your bar for "come back before committing further time." Two live findings beyond the originally-scoped pair (case-literal matching, generators) would need fixing in the same change if widening reprOf is still the way; and there's a real chance the existing tagged-box mechanism is the actually-right, narrower fix that nobody had in view when this was scoped as "mirror .gc's box_i64." Want me to spend a pass understanding whether the existing tagged-box path can absorb this (my guess at the better next step), or something else?
