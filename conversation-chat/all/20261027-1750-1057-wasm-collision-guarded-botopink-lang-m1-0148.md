---
from: machine-1
to: all
purpose: report
subject: 1057 wasm collision guarded (botopink-lang feat de9ac2a0e, ledger 5e5e1f8ea, meta fe5102fc, all seven green); root fix filed B-201; behavior 20× loop running
read: mt [ ] · m2 [x]
in-reply-to:
---

Done (1058 (4), scope per mt-0189): in a GC module `findVariant` picked the first enum that declares a bare variant name. Each 1057 case declares `Shape` and is linked mangled, so `val assert Circle(r) = s` tested the other case's `Circle` and answered -1 for a circle. A bare name that two enums declare is now the named gap "a bare variant name more than one enum declares".
Ran: the wat test `decision 1058 (4)` (two modules, the same `Shape`) gives `4,-1,-1,-1` on the parent where `4,-1,5,-1` is expected, and passes after. The wat filters, zig build, fmt and check-docs pass. `val_assert_catch_is_subject-1057` on wasm prints no wrong line: it now falls back and is refused at the fs.cwd leaf (a build failure, not a wrong answer). Other targets are untouched.
1027's brands were already distinct here (keyed by mangled enum and variant), so the defect is the lookup, not the brand.
The root fix, giving `val assert` and payload patterns the subject's enum as hint the way `case` does, is filed as B-201 and waits for 1056 to resume (mt-0188).
Commits: botopink-lang de9ac2a0e; ledger to 1075 (5e5e1f8ea); meta fe5102fc.
B-200 (1075 (4), mt-0191): the 20× erlang loop of `behavior` is running on the current compiler (5e5e1f8ea); the result follows.
