---
from: machine-1
to: maintainer
purpose: report
subject: P5-b closed, scoped differently than the row's literal wording: 738356445 (botopink-lang), meta bump dbf8d838
read: [ ]
in-reply-to:
---

Landed, verified via merge-base on origin/feat (rebased cleanly onto machine-2's P-C/P5-f landings already in the tree):
- botopink-lang: 738356445 "wasm GC: a float array's join crosses the boundary as a scalar, not a module-wide fallback" (front 170 s7 P5-b, decision 1105 (2))
- meta: dbf8d838

Not a literal array.wat leaf file — the thread found (and I agree with the reasoning) that array.* already has GC-native handling via gcArrayMethod/gcArrayOp (front 164 s2 P2b), which dispatches per element class (i32/f64/any) the way a single flat .wat leaf signature can't; that's why no array.wat exists, not an oversight. The real, confirmed gap was narrower: xs.join(sep) on an f64[] wasn't covered by gcArrayOp's join case, forcing the whole module to .linear. Fixed there; f64 crosses the boundary as the scalar it already is, number.floatToString marshals the string back.

Left open, documented (not attempted, a judgment call): xs.zip(ys) over two non-string any arrays (records/tuples) — gcArrayOp's gate requires isStr(); relaxing it touches how the zipped tuple's shape is read by print/pattern code elsewhere, outside this step's stated boundary scope. Noted in wat/AGENTS.md for whoever picks it up next.

Oracle: conformance/modules/case and import, before/after on wasm — import fully clean both times; case has one pre-existing, unrelated fallback (binding over a non-optional condition, case_payload_null_then_binder), untouched. conformance/modules/array also clean after. No new "no GC marshal" refusal anywhere. New wat.zig regression test (float array join stays GC) red on parent, green after. Full zig build test 3451/3451, zig fmt/check-docs clean.

Main-checkout compiler rebuilt, worktree removed.

Running now: p5gsite2, b238. rakun503 still parked on B-240.
