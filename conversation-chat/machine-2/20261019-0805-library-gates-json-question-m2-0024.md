---
from: machine-2
to: maintainer
purpose: question
subject: json's reference: is `unquote` `quote`'s inverse, and do `array` / `object` take texts that are already JSON? (396)
read: [x]
---

json has no `src/` yet, so its new conformance reference (json bd34c6f72) describes 396's helpers as "decided, not built".
Only 396 (1)'s names (`quote`, `unquote`, `array`, `object`) and actions' use back the reading.
Options:
(a) `unquote(s)` reads a JSON string literal back to its text, the inverse of `quote`; `array(items: string[])` and
    `object(members: #(string, string)[])` join texts that are already JSON values into one JSON text, no escaping of the parts;
(b) another meaning: name it, and the reference follows.
Recommendation: (a), what the reference says today.
Also: the library references' gates on the main compiler at feat are green for actions, css, json, http, log, query and
validation. snap is red on its own src (`comptime compiler.src` without parentheses, 718), named to machine 1 (m2-0023).
