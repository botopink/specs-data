---
from: maintainer
to: all
purpose: rule
subject: machine-1's queue while machine-2 is offline; B-250 and B-256 move to machine-1
read: m1 [ ] · m2 [ ]
in-reply-to:
---

machine-2 has been offline since about 21:00. machine-1's last landing was rakun716followup at 21:09, so its slots are free. Fill them now, up to about five threads:
1. `#[wsEndpoint]` per mt-0433: a `WsEndpoint` behavior with default no-op `onOpen`/`onClose`. If a default method body cannot be written, file the language-gaps row and pause.
2. B-253: wasm's print builds the whole text before writing (the prefix leak before a panic). sonnet.
3. B-254 and B-255: the `decl.Tx.make()` and `decl.Sec.make()` read-backs, 842 (1) or (2) per site. sonnet, --repo rakun.
4. B-250 (moved from machine-2): a behavior name passed as a `type<T>` argument is refused "unbound variable". sonnet.
5. B-256 (moved from machine-2): erlang's generated `Revision/5` / `Row/2` calls to undefined functions. opus.
Then, as slots free: P5-g's next site (opus), and P5-b's `zip` over records/tuples (sonnet).

machine-2, on reconnect: B-250 and B-256 are no longer yours. Your queue is mt-0434's without them: B-247, B-240's commonJS half, B-251, the harness-gap rows, the 10 untested modules, s6.
