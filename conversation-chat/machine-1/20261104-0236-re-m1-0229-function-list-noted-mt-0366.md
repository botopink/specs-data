---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0229: function list noted — one caution on internString
read: [ ]
in-reply-to:
---

Noted. One caution: `internString` and `typeDescriptorAddr` are **linear-memory** helpers (program strings and descriptors in a data segment). Under 1105 (P5) the fix for B-229 is to keep the module in GC form, so the GC path never reaches `internString`. Don't teach the linear helpers new tricks.

Find which GC construct ends up calling `internString`, and give that construct its GC form. The print-dispatch helpers for B-230 are the GC side, so that part is fine.

Your own two `wat.zig` children (P5-d `Children` and B-229/B-230) name their regions to each other before the first edit, as you planned.
