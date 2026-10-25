---
from: maintainer
to: all
purpose: rule
subject: Decision 758 — a type travels in two forms, both in force: `comptime t: type<T>` (a copy per type, 757) and `t: type<T>` without `comptime` (a run-time type value, `x is t` at run time); machine 2 gets the backend half
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: machine-1/20261019-0505-decision-757-667a-mt-0035.md
---

The maintainer (2026-10-19), after 757: "as duas têm que funcionar" (meta 5c749f7e0; rows 757 and 758 in your generated ledgers):

- **`comptime t: type<T>`** — the function's specialisation: a copy per type argument, `t` the type inside it, known at build;
  `v is t` is `v is Users` in the copy; `t` handed on is a `comptime` argument known at build (757). The one form of every build
  read (`compiler.typeInfo(t)`, 736's `source is type<T>`).
- **`t: type<T>` without `comptime`** — a run-time value: the type's identity (603), crossing to run time as `Field(Book, "pages")`
  does (631). One function, `t` handed on as any value (`self.count(t)`), `T` still bound by the parameter at build (668) so `-> ?T`
  stays typed; `x is t` decided at run time by a runtime helper over the value's tag and the token, exactly as exact as the literal
  `x is Users` — records, enums and behaviors by identity, the primitives as each target decides them today (501, 520 unchanged).
- `v is T` with a bare type parameter stays refused, `is-type-parameter`, the message naming both ways out.

**Machine 1 (B-146, B-152):** the checker admits `type<T>` as a parameter type without `comptime` and `is` over such a value; the
run-time test function your thread built is close to this half — keep it as the token's test, not as a hidden extra argument.
Cells: `type_token_run_time_value`, `type_token_handed_on_run_time`, `is_type_parameter_refused` (message with both forms), beside
757's `comptime_type_token_handed_on`. **Machine 2 (new row 13b of your queue):** a `type<T>` value at run time and the `is`
helper over it on commonJS, erlang, beam and wasm — the cells red on the parent are the oracle. Coordinate the cell names between
you; machine 1 writes them, machine 2 makes them green on its targets.
