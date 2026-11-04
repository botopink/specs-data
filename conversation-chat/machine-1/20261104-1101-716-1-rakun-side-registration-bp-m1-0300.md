---
from: machine-1
to: maintainer
purpose: report
subject: 716(1) rakun-side: registration.bp fixed and committed (842(2) retyping); decorators.bp:263/config.bp:2067 confirmed blocked by a BROADER undef bug than first reported
read: [ ]
in-reply-to:
---

Rebased onto current origin/feat (rakun at d6c20de6) using the main checkout's compiler (1375c40b9, not rebuilt — already current). Worked the exact 3 sites named: decorators.bp:263, config.bp:2067, actuator_api/registration.bp:270.

**Committed (a0d64a06, --no-verify, not pushed):** registration.bp:270's healthIndicator/infoContributor/endpoint. These read `decl.make()` — a member a DIFFERENT decorator (the stereotype) adds, which 613 always permitted written as text; the actual gap was `syntax decl: unknown` giving `decl` no members at all (716(1)). Retyped each to a behavior naming both `make()` and its own method (`HealthCheckOwner`/`InfoContributorOwner`/`EndpointOwner`), met only where the type writes `implement` — confirmed on erlang with a minimal repro first (annotation order both ways, multiple `implement` clauses, all fine) before touching real files. Updated every consumer type across rakun/rakun-data/rakun-service to add the clause. Measured all three targets before/after: identical error set, zero rows added or removed by this commit.

**decorators.bp:263 and config.bp:2067 confirmed still blocked — same bug as mt-0418's new row, but broader than I first reported.** These are same-decorator add-then-read (797), needing 842(1)'s "held as a value" shape, not retyping. I tried building that value with `compiler.ast` + a `Member` node and it crashes `undef` on erlang whenever the closure is held and invoked later rather than dot-called immediately — and this now reproduces for an INSTANCE method call on a freshly-constructed value too (`SomeType(args).someInstanceMethod()`), not only the static `Member(Name(owner), "make")` shape from my first report. I also tried two ways around `compiler.ast` entirely: (a) `@TypeInfo.all` inside decorators.bp itself is refused outright — "reads @TypeInfo.all, so it answers for the whole program and no module imports it" — since every rakun consumer imports decorators.bp, it can never host that call; (b) importing `context.rkResolve` directly into decorators.bp or config.bp is a real import cycle (both are imported BY context.bp), not a file-order oversight. So there is no path I can find that avoids machine-2's new row for these two sites specifically.

Net effect: the committed fix is real and correct but not yet test-visible — `registration_test.bp` and the rakun-service actuator tests import `component`/`service` from the still-red `decorators.bp`, and one error anywhere in a module fails the whole module, so they can't run yet regardless. I'm treating that as covered by your own mt-0418 exception ("a landing that truly cannot wait may still use it, but only when the one red is that analysis_equivalence.sh red at decorators.bp:263") since after this commit that's exactly the one red left in this path — said so in the commit message. Full detail and the broader undef repro went to machine-2 implicitly via this message; happy to hand over the exact minimal .bp files again if useful.

Stopped here per thread-rules (no further code without a decision) — decorators.bp/config.bp wait on machine-2's erlang-undef row.
