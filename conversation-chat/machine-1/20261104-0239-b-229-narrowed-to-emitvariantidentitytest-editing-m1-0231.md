---
from: machine-1
to: maintainer
purpose: rule
subject: B-229: narrowed to emitVariantIdentityTest — editing now
read: [ ]
in-reply-to:
---

Root cause found via GCTRACE: emitPatternTest's §5.3b disambiguation branch (wat.zig ~18450) calls emitVariantIdentityTest when an arm name is BOTH a record and a variant. For a payload enum in GC mode, emitVariantIdentityTest's payload branch (~18878) is linear-only (heap_floor/header-load/variantDescriptorAddr->internString) and has no GC form, so it always gcFails. emitTagTest right below it already has the correct GC form for this exact case (ref.test against gcVariantTy's struct type, ~18917). Fix: in emitVariantIdentityTest, when self.mode == .gc and the enum has a payload, delegate to emitTagTest's existing GC branch instead of the linear header test (ref.test on the variant's own struct type is already precise against the colliding record, since they're different GC nominal types — no new mechanism, no new design call). Editing emitVariantIdentityTest only (wat.zig ~18876-18900); not touching internString/typeDescriptorAddr/variantDescriptorAddr themselves, not touching emitTagTest's body. This region (18800-19000, case/variant pattern dispatch) is disjoint from array-literal lowering (~8780-8820) where I'd expect the P5-d `Children` empty-array piece to live — no collision expected, but still no announcement seen yet from that thread in specs-bot chat. Proceeding; will stop if one arrives naming this region.
