---
from: machine-1
to: maintainer
purpose: question
subject: rakun716followup: 6 of 7 sites fixed, verifying before commit; rakun-websocket/endpoint.bp needs a design call neither landed mechanism covers
read: [ ]
in-reply-to:
---

rakun716followup found all 6 named sites across rakun-cli/plugins.bp, rakun-data/orm/entity.bp (both sites), rakun-messaging/markers.bp, rakun-scheduling/markers.bp+jobstore/markers.bp, and all 4 rakun-service/convention.bp sites fit 842(1) — including a variant it had to generalize one level: convention.bp's filter/messageConverter/webCustomizer each add their OWN make() then chain `.make().<method>(...)` off it, so the held value is a nested compiler.ast tree (Call(Member(Call(...),"handle"),...)) rather than one flat member call. Verified structurally sound and compiling. Also fixed the DbHealthIndicator one-line gap. Sending it back to re-verify two unisolated botopink test failure counts before committing (one run was hit by a concurrent compiler-rebuild race from another thread).

**rakun-websocket/endpoint.bp:65-96 stopped, needs your call.** It's add-then-read by a DIFFERENT decorator (842(2)'s category, matching actuator_api's shape) but doesn't fit cleanly: wsEndpoint has one required method (onMessage) plus two OPTIONAL ones (onOpen/onClose) that only some implementors define, and the decorator branches at comptime into 4 different registration bodies depending on which are present (hasOpen/hasClose). A single fixed implement-satisfied behavior can't express "maybe present" the way 842(2)'s existing precedent (always exactly one required method) does. No existing default-fn-no-op pattern (decision 628-shaped) found anywhere in rakun to borrow from. Options the thread found: (a) a behavior with default no-op onOpen/onClose, forcing implement on every #[wsEndpoint] type; (b) extend 842(1)'s AST-splice mechanism to this different-decorator case too (mechanically verified it would work — Node types support arbitrary nesting — but it contradicts the "never read a DIFFERENT decorator's member back through decl, retype instead" framing); (c) something else. Not touched, left exactly as-is.

Also found, pre-existing, not part of this task, will file as their own rows once confirmed: rakun-data/sql/transactional.bp:131's decl.Tx.make() (same 716-family, unfixed) and rakun-security/method_security.bp:225 (same family); and a separate erlang codegen crash once orm/entity.bp finally type-checks far enough to reach it (Account.erl references undefined Bp__bp_tpl_orm_entity__Revision/5 and Bp__bp_tpl_sql_rows__Row/2) — not a decision-842 site, confirmed pre-existing via stash comparison.
