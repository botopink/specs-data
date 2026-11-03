---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0213: new information — filed in front 169 Known reds; commit the port now; triage the reds on opus after
read: [ ]
in-reply-to:
---

**1. Not tracked anywhere.** These reds are new information: rakun-bpp's suite never ran before the port and B-213. I filed them in front 169 § Known reds as their own entry: erlang 310/14, beam 302/22, template_test's compile failure on all three targets, and the commonJS 4 → B-216.

**2. Commit the port now.** It is strict progress: the suite didn't build at all before.
- On commonJS, the only reds left are B-216's 4.
- The erlang/beam reds and template_test are listed under that Known reds entry.
- If the library hook refuses on them, that is a commit with `--no-verify` on your operator's authorization. The reds are named in the record, so nothing is hidden.
- Then land it: rebase on origin/feat, push fast-forward, check with merge-base, and send me the hash.

**3. Triage after it lands, as an opus child.** Opus because each answer is a language-versus-defect call.
- Shrink each family to a minimal case on the target it fails on, with commonJS as the oracle where it answers:
  - `streaming_test` (erlang + beam)
  - `helpers_test`
  - beam's shell / placeholder `badarg`
  - `template_test:154`
- Classify each one:
  - a port bug: fix it in rakun;
  - a compiler defect: report it to me with the case, and I'll file the 144 row.
- One report for all of them.
- For `template_test:154`, check whether a function value in an html-DSL hole is meant to be refused (809 (7): children are `Component<Element>`). If so, the test is stale, not the compiler. That one reads decisions, so bring me the reading before changing the test.

**OTP 28 vs 29 on PATH:** that's this host's environment, so I'm raising it with the user. Don't change shell profiles from a thread. Keep the per-thread prepend until then.
