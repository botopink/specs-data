---
from: machine-1
to: maintainer
purpose: question
subject: Shape A blocked: the owner-grouped registry needs decl-as-value, which hits open erlang defects (B-147), not just B-235
read: [x]
in-reply-to:
---

Investigated 165 s10 shape A (decorators.bp:263/349/427, scheduling markers.bp:139, jobstore markers.bp:114) before touching code — built small repros against the main checkout's compiler (OTP 28 via mise) to confirm the mechanism compiles before committing a design. Result: it does not, on two independent fronts, neither of which is B-235 or B-149's 640(3).

**1. `decl` as a bare value, where the annotated declaration is an INSTANCE method (self + any other param), breaks the erlang backend — already filed, open:** front 144-backends-tooling B-147's unchecked row: "erlang: an instance method handed as a value (the `decl` of an init executor) builds, but the emitted module is refused by erlc (`variable 'Users' is unbound`)". I reproduced it directly: `syntax decl: fn(self: unknown, req: string) -> string` (or any instance-method shape, even same-module, even calling `decl(self, req)` inline instead of storing it) emits `'__bp_field'(Owner, method)` on erlang — a bare unbound variable, since `Owner` is a type name, not a runtime value. commonJS and beam lower the identical source correctly; only erlang breaks. Every rakun method marker this step would touch (`getMapping`/`postMapping`/…, `scheduled`/`fixedRate`/`fixedDelay`, `persistentJob`) annotates an INSTANCE method, so the "method marker registers `(owner, verb, path, decl)`" mechanism in your message needs exactly this, on every site. rakun is erlang-only (decision 113) — there is no other target to fall back to.

**2. `decl.make()` on `syntax decl: unknown` is refused today, full stop, regardless of who added `make`.** I compiled rakun as it stands: `registration.bp:270`'s `decl.make().check()` (not touched by shape A, but same shape) and `config.bp:2067`'s `decl.check()` both fail "cannot call a method on an `unknown` value" — matching decision 716's own `decl_unknown_no_member` cell exactly, not a 797 same-decorator-added-member nuance. That means the "sibling's `make`" half of your mechanism — the stereotype registering `compiler.init({ -> rkRegisterFactory(owner, make) })` — can't reference `decl.make` either (bound or unbound) while the stereotype decorators (`component`/`service`/`controller`/…) keep `syntax decl: unknown`. Retyping them to a behavior contract is 797-a, which your message left open ("whether a behavior-typed `decl` is met by `implement` or by the type's own members").

So landing shape A as specified needs either B-147's erlang fix (machine-2) or 797-a answered and the stereotypes retyped — not just clearing B-235/640(3). I haven't touched any file in rakun (worktree `rakunshapea` stays clean) and made no commit, since every variant I could build either isn't what 625(1)/797(2) ask for or reproduces a known-but-open compiler defect. Want me to (a) wait on B-147, (b) take 797-a to the registry mechanism and report back once you've ruled, or (c) something else?
