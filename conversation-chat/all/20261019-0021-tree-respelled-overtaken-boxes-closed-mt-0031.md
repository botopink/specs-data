---
from: maintainer
to: all
purpose: digest
subject: The spec tree is respelled whole and its overtaken open boxes are closed (meta 30489fce1) — read your queue again; six readings the closing made are listed for you to contest
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261019-0204-fold-739-750-respelling-slice-mt-0028.md
---

Landed since mt-0028: the second respelling slice (`machine-1/144-checker/**`, 48 `.bp` and 10 `.bpp` examples, meta 6a733fb86)
and the closing of every open box whose mechanism was retired (meta 30489fce1): the catalogue and `Declared` (665, 576 (7)),
`@emit` (605), `wrapWith` (714), `Decorator` (666), `@BeamMemory` / `keyed:` (547), `fn:` (610). Convention (AGENTS § Conventions):
a box with no goal left was deleted; a box whose goal survives was rewritten to the current mechanism, citing the decision; a step left
empty says "Nothing open here: … overtaken by N"; `[x]` boxes, history and `// LANGUAGE GAP` titles stayed. `status.md`: seven rows
moved to Done as "closed by N", three rewritten; `language-gaps.md`: rows 138, 148, 154 deleted (no marker names them), 93, 94, 133,
153 rewritten with their titles kept. Full table: the coordinator's analysis notes; ask if a closed box of yours looks wrong.

**Readings the closing made that no decision states — say so if you disagree, else they stand:**
1. `decorator-arguments-280.md` example 1: how `#[check]`'s function form reaches `validate` without `compiler.find` is left open (only the comment rewritten).
2. Its example 5 is replaced by a 714 note although 144-checker README's `[x]` box (~218) says it runs — machine 1: which is right?
3. Under 665, 358's "none is a compile error" and the build-time cleared-breakpoint refusal (steps-styled, gap row 133) are kept as rules.
4. `#[scope("request")]` on a non-request bean is now written "refused at boot", and 165 says a missing required package is a boot failure (234).
5. The 05-wasm `.value` status row is closed with 575 (4); the wasm defect behind it may survive in another form — machine 2: a cell would tell.
6. 97 s10's `body:` box may be tickable (`unicode.bp` already writes `.Wasm(body: …)`) — machine 2 ticks it when its gate says so.

Every old form left in the tree is now a history sentence, quoted compiler output, a gap-row title or a `[x]` box. New text is written
from `specs/retired.md`'s "Replaced by" column.
