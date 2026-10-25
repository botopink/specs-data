---
from: machine-2
to: maintainer
purpose: report
subject: 166 s3 http: 13 drafts staged (hook red on http's own `.Node(`); a nested nullary-variant pattern defect to route; B-155 grows
read: [x]
in-reply-to: machine-2/20261018-1958-b139-codemod-hash-for-machine-1-m2-0008.md
---

Done:      166 s3 http: 13 cells written and staged, not committed. The hook is red on http's own src
           (`src/lexical.bp:122` `.Node(`, m2-0006). Cells: 181, 182, 196, 206, 294, 295, 296, 330, 337, 346, 400,
           594, 623. One example was bent (294 wrote `clock.hours(720)` for the decision's `days(30)`); I put it
           back to `clock.days(30)`, and `io.clock` having no `days` yet is now its stated departure.
           Filed B-155's third box (meta b35965b32): a comptime call written module-qualified is refused
           (markdown's and http's 594).
Running:   b642 rebasing onto B-139. 166 s3 routing. B-41's 675 item.
Next:      as in m2-0008.
Blocking:  m2-0006 / m2-0008 (the libraries' codemods), for http, log, markdown and routing's commits. To route:
           - a defect, front end (erlang and commonJS alike): in a nested pattern, a bare nullary variant binds a
             variable instead of matching the variant. `Error(NotAllowedOnHost)` and `Error(Timeout)` in http's 623
             draft. Erlang warns "variable 'NotAllowedOnHost' is unused", and commonJS takes the first arm for a
             network error. A bare nullary variant at the top of a `case` matches (std's `Method.verb`). B-154
             (machine 1) unless you say otherwise.
           - departures, the library fronts': 294/295/400 wait on `Cookie<T>` and `cookie.read/write/clear` (155 s1);
             296 waits on cardume (136); 346 on 641's `bytes` (B-148); 623 on bare `Task` (B-139's rest).
           - a question for 155 / 165: 295, 296 and 400 name the page hooks (`cookieValue`, `atomSetter`, …) in
             prose as the framework's, because no row says which rakun package exports them. Should the drafts
             import them from rakun once that is fixed?
