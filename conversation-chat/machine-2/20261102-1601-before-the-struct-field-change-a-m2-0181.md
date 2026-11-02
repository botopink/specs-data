---
from: machine-2
to: maintainer
purpose: question
subject: Before the struct-field change: a quick experiment found gcDeclPrinter's guard is hiding two more gaps, not just the shape-field one
read: [ ]
in-reply-to:
---

Before starting the struct field I ran one more check to make sure I understood why the guard exists (didn't want to build the shape mechanism against a guard that turns out to be guarding something else too) — tried commenting out `gcDeclPrinter`'s refusal alone, no other change, to see what actually happens underneath it. Reverted immediately after, no diff left; this was read-only diagnosis, same as today's other traces.

Result: it's not a clean "lift the guard, add shapes, done." Two more real gaps sit directly behind it:

1. **900's case (Dict<string,f64>, non-empty):** with the guard lifted, it compiles and calls `Dict_display` for real — then traps at runtime with "cast failure." This is plausibly exactly decision 900's own shape-field problem (a wrong unboxing assumption without knowing the value's shape) — consistent with the plan.

2. **985's case:** with the guard lifted, it does NOT reach decision 900's territory at all — it hits a different, earlier GC gap first: "a lambda parameter nothing types," inside `Dict.display()`'s own body (`for self.pairs { p -> … }` — the for-loop's parameter `p: #(K, V)`, a tuple of the record's own unbound type parameters, which GC mode's lambda-parameter inference can't type yet). This is a distinct, separate compile-time gap, unrelated to shape fields — display() itself doesn't compile generically today, for a reason that has nothing to do with knowing K/V's runtime shape.

So the guard was doing double duty: it was blocking decision 900's actual ask, but it was also papering over a real gap in generic lambda-parameter typing that's needed before display() can run in GC mode at all. The shape-field mechanism, once built, won't help 985's case — 985 needs the lambda-parameter gap fixed first (a GC-lowering fix, not a representation addition), and only then would it even reach the point where a shape field matters.

I haven't touched anything — this just changes what "done" looks like for 985 specifically. 900 still looks like exactly what we scoped (struct field, construction, forwarding, lands on the cast-failure case). 985 needs that plus an unrelated fix first. Want me to: (a) still start the struct-field change for 900 now, and treat 985's lambda-parameter gap as its own follow-up (likely its own B-row); (b) scope the lambda-parameter gap too before starting anything, since it's upstream of 985; (c) something else?
