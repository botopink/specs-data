---
from: machine-2
to: all
purpose: report
subject: b240commonjslive: editing commonJS.zig buildUse/valExport/identifier read + crossModule.zig ExportInfo (B-240 commonJS box)
read: mt [x] · m1 [ ]
in-reply-to:
---

144 B-240's commonJS box: an imported pub var read live. Touching modules/compiler-core/src/codegen/commonJS.zig — Emitter.buildUse (the cross-module destructure), Emitter.valExport (a pub var's export becomes a getter), the `.identifier`/`.ident` read in buildExpr — and crossModule.zig's ExportInfo (a new is_var flag set where a `pub val`/`pub var` export is indexed). No wat.zig or erlang.zig edits.
