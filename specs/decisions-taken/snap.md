---
scope: >-
  The snapshot engine `snap` (`botopink/snap`): the `.snap` path rule and slugifier, the
  `botopink-snap 1` format, the check and the `.new` flow, how a test's location and name reach a
  snapshot, and which std primitives it is written over. The conformance suite's `.snap` cells are
  conformance-suite; `io/fs` errors are std.
terms:
  - '`botopink-snap 1`'
  - '`__snapshots__`'
  - '`.snap.new`'
  - '`assertAs`'
  - '`assertText`'
  - '`assertNamed`'
  - '`snap.matches`'
  - '`snap.matchesAt`'
  - '`FsError`'
  - '`e.message()`'
  - '`fsText`'
  - 'slugifier'
  - '`test-snap.md`'
  - '`compiler.src()`'
related:
  - 'conformance-suite'
  - 'std'
  - 'syntax-and-comptime-parameters'
  - 'library-split'
binds:
  - '`01-std` step 3 (`snapshots.md`)'
  - '`1-botopink-lang/144` B-126'
  - '`2-libraries/150` (rakun-ssr)'
  - '`2-libraries/160`'
  - '`machine-1/135`'
  - '`machine-1/160`'
retired:
  - 'A `string` error from `io.fs`'
  - 'snap''s local `fsText`'
first-step: 72
last-step: 772
in-force: 3
superseded: 0
---
# snap — the snapshot engine

**`snap` holds the path rule, the `.snap` format, the check and the `.new` flow; std provides only the general primitives it is written over; a new `.snap` exists only where its bytes are a contract another package reads.**

Steps: 72, 390, 391, 402, 407, 563, 718, 719, 772, 784, 786, 789, 796
Binds: `20-snap/135` steps 1–5 · 97 s7 · 19 s6 · 26 s7 · 33 s1, s3, s4 · 50 s8 · 51 s7 · 53 · 71 s6 · `107-release` · `20-snap/135` step 0 · std (`testing/` and the text methods) · jhonstart · onze · `contracts.md` § 7 · std `primitives.bp`, `io/fs.bp` · `20-snap` step 0 (its last box) · `libs/std/AGENTS.md` · `repository/snap/AGENTS.md` · `1-botopink-lang/144` B-126 · `2-libraries/160` · `2-libraries/150` (rakun-ssr) · `machine-2/144` B-137 · `machine-1/160` · `machine-1/135` · `machine-2/166` s4 (snap) · `machine-1/144` B-156

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 72 | 1.0.10-beta · (the maintainer, 2026-09-20) | The `.snap` file is `botopink-snap 1` / `test: <name>` / `subject: <helper>` / blank line / body; one slugifier, the compiler's (`codegen/tests/helpers.zig:38`), for the compiler's snapshots and the libraries' alike; the library `test-snap.md` maps that assumed a bare body (rakun-bpp) are re-read against this | `01-std` step 3 (`snapshots.md`) | |
| 563 | 540-c | `pub fn message(self: FsError) -> string` in `io/fs`, one text per variant, `<what>: <path>`: `not found: <path>`, `permission denied: <path>`, `is a directory: <path>`, `not a directory: <path>`, `already exists: <path>`, `not UTF-8: <path> at byte <offset>`, and `<path>: <message>` for `Other` (489's host text); the same text on every target; a library carrying an `io.fs` failure into a `string` error writes `e.message()` and no `case` of its own; snap's and rakun-ssr's local `fsText` helpers are removed; a generic `mapErr` on `Result` (540-c (c)) is not decided by this row | `1-botopink-lang/144` B-126 · `2-libraries/160` · `2-libraries/150` (rakun-ssr) | fs_error_message_text |
| 772 | 160-b · (the coordinator †, 2026-10-19) | The test runner sets the running test's name where the run-time `snap.matchesAt` reads it (a run-time value of the test harness, as the suite already is); the caller's location (719, 756) only places the snapshot inside the file; a snapshot keeps its name when a line above it moves. Cell `snapshot_named_by_running_test`: two tests, one `matches` each, the names in the `.snap.md` | `machine-1/160` · `machine-1/135` | snapshot_named_by_running_test |
