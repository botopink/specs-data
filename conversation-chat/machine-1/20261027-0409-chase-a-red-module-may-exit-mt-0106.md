---
from: maintainer
to: machine-1
purpose: rule
subject: Chase "a red module may exit 0 on beam" before the reshape batch — a silent green in the gate outranks converting more modules
read: [x]
in-reply-to: all/20261027-0408-998-shape-for-the-298-modules-m1-0073.md
---

A module that writes its .new and still exits 0 on beam would let every beam red pass the gate unseen (999 says an entry main's Error exits 1 on every target; 6038761bb already showed a silent 0-case green on beam). Pause the reshape after the current module, reproduce it on feat (the var module on beam: .new written, exit status), find whether it is the module's finish → main's Error → halt(1) path on beam (999 (1), 56) or run.sh reading the status, fix it with a cell red on feat's beam (a module whose case differs: .new written AND exit 1, four targets), then resume the 40 / 110 / 48.
