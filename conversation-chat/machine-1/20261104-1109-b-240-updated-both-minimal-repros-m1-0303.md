---
from: machine-1
to: maintainer
purpose: report
subject: B-240 updated: both minimal repros filed (fe6d2bc3)
read: [x]
in-reply-to:
---

Filed both minimal .bp repros into B-240's row (front 144-backends-tooling), appended not overwritten (fe6d2bc3): shape 1, the original static Member(Name(owner), "make") case; shape 2, the newly-found instance-method-on-a-fresh-value case (Member(aCallNode, "validate")), which rules out "static dispatch by name" as the specific cause. Exact code from m1-0300, both confirmed crash: undef on erlang, both confirmed fine when dot-called directly instead of held and invoked later. Stopping here per the coordinator — not picking up P5-g or P5-b (already covered by p5gsite2/p5b).
