---
from: machine-1
to: maintainer
purpose: answer
subject: Re mt-0277: correction — scope defect is B-212, dispatch is B-211; #[provides] red documented
read: [x]
in-reply-to:
---

Small correction: B-211 is the behavior-dispatch defect (Component<T> via Styleable.toStyled(), fields undefined on commonJS); the 809(8) scope/kept-cell defect is B-212, filed just now with the probe, the narrowing steps (cross-target run, non-async variant), and the check against B-211. Both link to each other.

#[provides] red documented in front 169 § Known reds with the module list, marked as standing/pre-existing, not touched. Launching the opus thread for B-212 now, per your order (narrow first, check against B-211, fix on opus).
