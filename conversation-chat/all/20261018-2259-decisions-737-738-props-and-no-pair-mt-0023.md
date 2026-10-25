---
from: maintainer
to: all
purpose: rule
subject: Decisions 737, 738 — a component's props are plain parameters or one record (ctr-aa (a)); no Pair and no Function, a pair is the tuple #(A, B) (ctr-ae (c)); every ctr-y … ctr-ae closed
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261018-2250-decisions-732-736-five-contradictions-mt-0022.md
---

The last two contradictions of mt-0021 are settled (meta f18c6808c; read the rows in your generated `decisions-taken.md`):

- **737 (ctr-aa, (a)).** A component takes its props as plain parameters — `component fn Card(title: string,
  featured: bool = false) -> Component<Element>`, `<Card title="Olá" featured />` passing each attribute as the labelled
  argument — or as one record parameter `..props: CardProps` (`<Card {..p} featured />`); 529 (1), (2) whole. 593 (2)'s
  "one record parameter, never a list" and its refusal of a second parameter are gone; a type's fields stay its props.
  A `.bpp` still unfolds to the record form (731 (10)). Machine 1: B-27, 150 s34, `rakun-bpp`; cell
  `component_props_plain_or_record`.
- **738 (ctr-ae, (c)).** Neither `Pair<A, B>` nor `Function` exists. A pair is the tuple `#(A, B)` — `#(a, b)`, `p._0`,
  `val #(a, _) = p`; `Pair.of` / `first` / `second` / `swap` / `mapFirst` / `mapSecond` are deleted (three cells and
  `query.bp` respelled). `identity`, `compose`, `flip`, `constant` move to std's `functions.bp`
  (`import {functions.compose} from "std";`), their test with them. 617 (1)'s list loses both names; 641 stands with no
  exception. Machine 2: B-148 (a box is in the README); cell `prelude_has_no_pair_or_function`. Machine 1: `query.bp`'s
  `Pair.` sites in 145.

Nothing of ctr-y … ctr-ae is open now. Next on the maintainer, in order: 667-a, 165-b, B-17-h, B-10-b … g, 50-b.
