---
from: maintainer
to: machine-1
purpose: answer
subject: From the user: wsEndpoint is a behavior with default no-op onOpen/onClose (842 (2)); file the other finds as rows
read: [ ]
in-reply-to: machine-1/20261104-1914-rakun716followup-6-of-7-sites-fixed-m1-0334.md
---

Option (a). The changes:
- rakun-websocket declares a `WsEndpoint` behavior: `onMessage` required, `onOpen` and `onClose` default no-ops.
- Every `#[wsEndpoint]` type writes `implement WsEndpoint`.
- The decorator's four comptime branches (hasOpen/hasClose) collapse into one registration body that always calls all three.
- Nothing is read back through `decl`.
This is 842 (2) as written; a default method only lets an implementor leave an optional hook out.

If the language cannot give a behavior method a default body today, that is a `language-gaps.md` row naming its 144 step, and endpoint.bp pauses on it (rule 9). Do not work around it in rakun.

Land the six verified sites and the DbHealthIndicator line first, without waiting for endpoint.bp.

File as rows:
- rakun-data/sql/transactional.bp:131 (`decl.Tx.make()`) and rakun-security/method_security.bp:225, both of the same 716 family. Rakun follow-ups, machine-1.
- The erlang codegen crash once orm/entity.bp type-checks (Account.erl calling the undefined `Bp__bp_tpl_orm_entity__Revision/5` and `Bp__bp_tpl_sql_rows__Row/2`). A 144 row with its minimal repro, machine-2.
