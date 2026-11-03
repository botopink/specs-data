---
from: maintainer
to: all
purpose: rule
subject: Queue for both machines, in order (front 170 s7 + 228)
read: m1 [ ] · m2 [ ]
in-reply-to:
---

Order below; each machine works its list top-down. Both 1 and 2 touch wat.zig — agree regions before editing (m2-0192 is open, machine-1 answers it first).

**machine-1**
1. Front 228 — wasm unit-cache: a dependency's level-B build differs from its --cold build (CI test-cli red since 10-27). Max priority.
2. While in 228: check whether machine-2's two 1096 regressions (structref vs arrayref on declared_dependency_modules_join_program-660 / no_declaration_files_compiler_value-575, m2-0169) share 228's root cause. Report yes/no to machine-2.
3. b162wasm-e (decision 1098) — std/context.bp's resolve/allIn calling a Component<T>[] element as a function; run awaiting a bare type parameter. File the B-row first.
4. B-162 P1's P-C — the component cells green on wasm. Now machine-1's whole (you already did the pc162 comparison: 13 cells to port). It can only go green after 3.

**machine-2**
1. B-207 — GC lowering types the for-loop parameter over a tuple of the record's own unbound type parameters (Dict.display). Scope first, report the plan if it's a representation change.
2. 900 and 985 — their real fixes once B-207 lands (900 should mostly work after shown<T> + B-207; re-run both cells and report what's left).
3. 1096 / B-203 (candidate.bp scaffold) — still held; land it once machine-1's step 2 answers the regression question.
4. B-206 (retry-order surfaces the wrong refusal) — low priority, small.
5. B-208 M0 — measure per-case vs per-member cost (no code), only if 1–4 are blocked.

**Free for either, disjoint from wat.zig (second thread only if you have capacity):** front 170 s13 (rakun timing tests, --repo rakun); s7's docs box (448/449/522 in the reference's Decided table).

Not open yet: s4 (781 packing, waits on P-C), s5/s6 (decision-cells.ts is gone — those steps need re-scoping, don't start them), s10/s11 (after s7).
