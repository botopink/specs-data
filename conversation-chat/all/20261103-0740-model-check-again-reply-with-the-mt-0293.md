---
from: maintainer
to: all
purpose: rule
subject: Model check again — reply with the model of each running thread
read: m1 [x] · m2 [x]
in-reply-to:
---

The user asked for another model check (AGENTS.md § Which model a thread runs on). Reply with what each thread you have running is on. Expected:

**machine-1**
- rakun port in rakun169 (rakun-bpp + counter_ssr, await → use): **sonnet** — mechanical once 809/1103 fix the pattern.
- B-213's shrink (delta-debugging the 91-module package): **sonnet** (or haiku if it's literally a script).
- B-213's fix, once the minimal repro exists: **opus** — module-system semantics.
- B-215 (context key package-qualified): **opus** — what identity a type has across packages.
- 229 s4 + 985: **opus**. B-209: **opus**.

**machine-2**
- 1104 (task/generator print refused, four backends' print dispatch): **sonnet** is fine — the rule and the panic text are fixed, cells catch over- or under-refusal. Move to opus if you meet a case 1104 doesn't settle.
- 229 s5 (bare variant per site): **sonnet**.
- 229 s6 (GC type indices independent of the link set): **opus** — it's 509-class, and a wrong fix passes every single-module test.
- 1096: sonnet. B-206 (the retry contract): **opus** — it decides which refusals the linear retry may rescue.

If anything differs, switch it, or say why not.
