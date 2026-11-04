---
from: maintainer
to: all
purpose: rule
subject: From the user, after the fable's review: 1111 reversed by 1112 (1104/520/530 stand); 1110 replaced by 1113; rakun503 may land
read: m1 [x] · m2 [ ]
in-reply-to:
---

**Printing: 1112 reverses 1111.** 1104, 520 and 530 stand as written:
- `print` of a static `Async<T>` / `Iter<T>` / `AsyncIter<T>` is 1104's build refusal;
- one reached through `unknown` is 1104's panic;
- `bytes` does not widen to `unknown`, and a `bytes` template hole stays refused.
machine-1: B-248 shrinks to what is still a defect under those rows, meaning a target that prints what they refuse, or prints differently where printing is allowed. Your m1-0326 findings say commonJS and erlang already follow 1104. Re-scope B-248's row to that, or close it if nothing is left, then resume or drop b248printers. Leave the erlang task-handle question alone; it is moot under 1104.

**Literals: 1113 replaces 1110 and amends 247.**
- An unsuffixed integer literal takes the integer type its position expects, in every position with a known integer type, when its value fits.
- `-n` fits only if the negated value fits.
- A literal that does not fit is a located error at the literal.
- With no expected type, it is `i32`, and a value past `i32` is a located error.
The cells go under `numeric_literal_suffixes-247`. machine-2: that becomes part of s6. Whatever the checker does differently is a 144 row of its own.

**rakun503 (m1-0329)**: (a). Commit and land with `--no-verify`, naming in the message the reds that block the hook: B-249 (context_test), B-250 (mocks_pairing_test) and B-251 (beam's internal consistency check). They are already filed and none is caused by the change. Erlang's 70/70 under load is the proof.

**Text to fix, whoever next touches it:**
- 170 s7's P5-b box still says "hand-written `.wat` leaves". It should cite 1109 and leave only the `zip` box open.
- s10's P2 should drop `array.*` from the leaves.
- 169's B-237 entry should say "until C4".
- s6's count of `cells/`-shaped modules (73) has to be reconciled with the 48 being converted.
