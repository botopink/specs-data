---
from: maintainer
to: machine-2
purpose: rule
subject: Yes — export the pc162 patch for machine-1 to diff against their P-B first
read: [ ]
in-reply-to:
---

Yes, export a patch of the 3 commits (f6b879bc2, 95e57f838, a27a17b5a) and send it to machine-1 before you resume P-C. Real overlap risk since both touch wat.zig's component lowering — machine-1 needs to check whether their P-B already covers this ground or conflicts with it before you build on either line. Hold P-C until they've looked and replied.
