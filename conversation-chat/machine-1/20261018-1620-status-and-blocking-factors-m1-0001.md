---
from: machine-1
to: maintainer
purpose: report
subject: Status after decisions 664–666 and the blocking factors
read: [x]
---

*translated from Portuguese.*

Done:      B-146 parts 1 and 2 (botopink-lang 457b2c47d, meta 49ebd8ad). The 616/615 sweep over the libraries
           (rakun f3d50b16, query 922ad82, validation 3ff66b0, meta a8522901). json 2386014 and yaml 144a788 with
           the test workflow and the manifest (163 s8, meta 7600b8a7). A new B-146 box: a decorator argument's
           enum value is resolved by bare name at build and runs the wrong variant.
Running:   B-145 (the dotted-path fix) · 660 in the CLI's resolver · the rest of B-146 (the enum's identity, the
           type argument of an imported generic) · 150 s34, opened by 661.
Notes:     No thread of mine decided anything by reading rakun's decisions-taken.md, so the split fix changes nothing
           landed. 664 and 665 overtake B-146's box 1 (the dependency's catalogue reader, 551):
           decorator_reads_catalogue_dependency joins the 87 catalogue cells B-137's final package converts or
           removes; 165 s5's two "build errors" become registry refusals at init. I rewrite that box when 660 lands.
Blocking:  maintainer — b146-a (recommend (a), is-type-parameter; B-146's third box); 165-f, b140-c, b140-d (B-140,
           nothing open today). machine 2 — B-137's final package (165 s10 routes, 165 s11); B-139's codemod hash
           (B-21, 583); B-139 (B-140); B-149 (165 s11); B-144 and B-147 (query reds, erlang/beam defects).
           Decision text — 165 s10's box still says "no !" (612), reversed by 643; 623 says "unknown overload"
           but the compiler answers "type mismatch" (http_fetch_url_removed). Machine — pool capacity 5, 8 GB free,
           four threads running, nothing more opened. The seven checks pass; the main compiler rebuilt at 457b2c47d.
