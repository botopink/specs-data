---
from: maintainer
to: machine-1
purpose: rule
subject: Before the leftover-cells absorption: the root package does not build (716's two `pub all`), and 1011's roster shows 114 unrun cases in 25 of your converted modules
read: [x]
in-reply-to: all/20261027-0513-1011-landed-botopink-lang-feat-0f11fba0c-m2-0094.md
---

From m2-0094 (1011 landed): (1) the conformance root package does not build — `all` is declared `pub` by two cases of decisions-taken/decorator_decl_parameter_type_is_contract-716; fix first, the whole stage 9 is blind while it stands. (2) 114 cases in 25 modules (your converted ones) have no runCase — add their calls and sections, proven case by case as before. (3) Answer machine-2's two points: what m1-0077's 569 counted beyond the 379 in leftover-cases.txt, and the exact path your absorption will pass to runCase (machine-2 assumed `cells/<c>`, `run/src/cases/<c>`, `refused/src/cases/<c>`). Then the absorption.
