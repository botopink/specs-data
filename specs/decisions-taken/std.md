---
scope: >-
  Decides std's surface: the three categories (a pure root, `io/`, `testing/`), the merges and the
  type-scoped constructors of `collections`, and the fixed behaviour of `io.fs`, `io.clock`,
  `io.process`, `io.terminal`, `hash`, `async` and `random`. A module's own error enum is
  result-and-failure; `fetch` is actions-http-log-routing-i18n; `Async` / `Iter` are
  body-markers-async-and-iter; assets are assets-and-embed.
terms:
  - '`collections`'
  - '`Dict.empty()`'
  - '`Dict.ofEntries`'
  - '`unique()`'
  - '`coin()`'
  - '`io.fs`'
  - '`FsError`'
  - '`fs.glob`'
  - '`fs.walk`'
  - '`fs.stat`'
  - '`io.clock`'
  - '`formatIso8601`'
  - '`parseDuration`'
  - '`io.process.start`'
  - '`onSignal`'
  - '`terminal.setRaw`'
  - '`hash.pbkdf2Sha256`'
  - '`async.retry`'
  - '`std-unsupported-on-target`'
  - '`testing`'
related:
  - 'result-and-failure'
  - 'assets-and-embed'
  - 'body-markers-async-and-iter'
  - 'actions-http-log-routing-i18n'
  - 'module-system'
  - 'prelude-and-primitives'
binds:
  - '`1-botopink-lang/144` B-10, B-24'
  - '`1-botopink-lang/144` B-24'
  - '`machine-1/144` B-10 G1'
  - '`machine-1/144` B-27'
  - '`machine-1/150`'
  - '`machine-2/144`'
  - '`machine-2/144` B-161'
  - '01-checker (the primitive-named-declaration refusal unparks when 97 lands)'
  - '02-erlang step 4'
  - '02/97'
  - '02/97 step 10'
  - '05-wasm (the trap)'
retired:
  - '`base64` (module)'
  - '`dict`, `sets`, `queue`, `order`'
  - '`crypto`, `hmac`, `content_hash`'
  - '`io.random.bool()`'
  - '`clock.formatIso8601` without milliseconds'
  - '`time`, `clock` (root modules)'
  - '`random`, `crypto.randomBytes` at the root'
  - '`path.absolutePath`'
  - '`io.process.start` answering `Error(Unsupported)` at run time off commonJS (B-161 as built)'
first-step: 43
last-step: 906
in-force: 19
superseded: 1
---
# std — the standard library's surface

**std takes the natural name; one value on every target; a module that can fail answers its own error enum; what is generic goes to std and nothing library-specific.**

(1) Shape: a pure root, `io/`, `testing/`; the merges; type-scoped constructors — 106, 111.

(2) Collections and text: `Dict.ofEntries`, `unique()`, `coin()` — 174, 217, 250.

(3) `hash.pbkdf2Sha256`, `async.retry`, panics on unusable arguments — 175, 197.

(4) `io.fs`: `glob`, `walk`, `stat`, the write answers, `File`'s reads — 177, 178, 197 (4), 499, 711.

(5) `io.clock`: the RFC 3339 domain, `.sssZ` always, `parseDuration`'s bound — 497, 498, 849.

(6) `io.process` and `io.terminal` on erlang and beam; `start` on commonJS alone — 688, 855, 856, 906.

(7) Testing: no lifecycle hook — 706.

(8) `@BeamMemory`'s two layers — 43, overtaken by 547.

Steps: 43, 106, 111, 116, 170, 174, 175, 176, 177, 178, 197, 217, 250, 262, 335, 340, 402, 493, 494, 497, 498, 499, 503, 506, 534, 540, 563, 623, 641, 688, 689, 690, 704, 706, 711, 732, 849, 855, 856, 893, 906, 918
Binds: 02/97 steps 3 and 5, after 01-checker's import fix · 02 · 02/97 · rakun · 05-wasm (the trap) · 02-erlang step 4 · 02/97 step 10 · 01-checker (the primitive-named-declaration refusal unparks when 97 lands) · 05-wasm · `20-snap/135` step 0 · std `primitives.bp`, `io/fs.bp` · `1-botopink-lang/144` B-10, B-24 · 319 · `1-botopink-lang/144` B-24 · `1-botopink-lang/144` B-27 · `2-libraries/162` · 431 · 486 · `1-botopink-lang/144` · `1-botopink-lang/144` B-126 · `2-libraries/160` · `2-libraries/150` (rakun-ssr) · `machine-1/144` B-27 · `machine-1/150` s60 · `machine-2/144` · `machine-1/150` · 540 · `02/97` steps 11, 17 · `01-compiler/140` · `lib-test-runner` (the wasm column) · `01-compiler/17-beam-memory` step 1 · std's `Dict` · `1-botopink-lang/144` B-07, B-25 · 146 · 74 · `machine-1/144` B-25 · `machine-1/155` · `machine-2/144` B-148 · `machine-1/165` s10 · `machine-1/146` s3 · `machine-1/145`

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 43 | 1.0.5-beta · (the maintainer, 2026-09-18) | Overtaken by 547 | the size of `17-beam-memory`, and its step 3b, which front 09 lands | |
| 106 | 1.0.10-beta · (the maintainer, 2026-09-24) | std in three categories: a pure root, `io/` and `testing/`. One criterion: `io/` is everything that talks to the world outside the process; a root module is pure — same input, same output; no clock, disk, network or entropy — and imports nothing from `io/`, refused by the compiler (67, no flag), the check applying inside std too; outside std `io.` on an import line is a reading signal (`grep 'io\.'` lists what a module touches outside the process), not a guarantee — an external `declare fn` does what it wants. Categories: pure · the root of `src/` · imports nothing from `io/`; io · `io/` · talks to the world, may import from the root; testing · `testing/` · the harness (`mocks` records calls), impure by nature, entered only under `botopink test`, may import from `io/` and the root. `erlang.bp` and `beam.bp` are outside the criterion: the target's surface, not domain modules, existing only on erlang/beam. The directory is `testing`, not `test` — `test` is a keyword (`test "…" { }`) and `import {test}` does not parse. (1) Merge only where the new name wins: `dict` + `sets` + `queue` + `order` → `collections` (the type is the namespace — `collections: {Dict, Set}`, never `dict.Dict, sets.Set` —, and one file lets `Dict.keys()` answer `Set<K>`); `crypto` (hashes) + `hmac` + `content_hash` → `hash` (hashing is pure; `crypto` without `randomBytes` is no crypto); `base64` + `encoding` → `encoding`; the merged-away module names are removed. `regex`, `unicode`, `string_builder`, `url`, `querystring` have no merge that earns a name and stay (`url` and `querystring` both have `parse`); `json` is since 396 (1) the `json` repository. (2) A directory groups function modules, a file groups types: `io/` and `testing/` are directories because `fs`, `http`, `asserts` are function namespaces, each its own file (inline tests at the foot); `collections.bp` is a file because `Dict`, `Set`, `Queue`, `Order` are types. Purity beats domain at the edges: `random` and `crypto.randomBytes` go to `io/random.bp` (entropy is a side effect); `path` stays at the root minus `absolutePath`, which reads the cwd and goes to `io/fs.bp`; `time` and `clock` become `io/clock.bp` (the wall/monotonic split kept); `os`, `env`, `process` stay three files under `io/` (in one `system` module `env.get` would be `system.get`); `async` (combinators, no I/O of its own) and `escape` (pure string) stay at the root; `snapshots` goes to `testing/` because it writes files. The tree `libs/std/src/`: `primitives.bp` (the `.d.bp` files are retired, 606); `collections.bp` (`Dict`, `Set`, `Queue`, `Order`); `math.bp` (without random); `path.bp` (without `absolutePath`); `url.bp`, `querystring.bp`, `unicode.bp`, `regex.bp`, `string_builder.bp`; `encoding.bp`; `hash.bp` (`sha256`, `sha512`, `md5`, `hmac`, `contentHash`); `escape.bp`; `async.bp`; `erlang.bp`, `beam.bp` (the target surface); `testing/`: `asserts.bp`, `mocks.bp` (`snapshots.bp` retired for `snap`, 391, 407); `io/`: `fs.bp` (`readText`, `writeText`, `exists`, `list`, `mkdir`, `rm`, `absolutePath`), `http.bp`, `net.bp` (TCP/TLS sockets, server-only), `clock.bp` (`nowMillis`, `monotonicMillis`, `measureMillis`), `random.bp` (`coin`, `intInRange`, `pick`, `randomBytes`; `bool` retired, 250), `os.bp`, `env.bp`, `process.bp`. The `root.bp` / `pub mod` lines of the time are retired (592 (1): every `.bp` under `src/` is a module, its path its name). The seven modules fronts 01/02/03 planned at the root — `net`, `clock`, `encoding`, `hmac`, `escape` (01), `async` (02), `content_hash` (03) — are absorbed by the tree. 71 is amended in path only: only the leaf enters scope (107), so `mocks` is imported as a leaf and `mocks.when`, `mocks.verify` stay letter for letter (`#[mocks.mock]` since retired for `mock(T)`, 644); the module's name and its uniqueness stay. No module's surface changes beyond the moves named: every side effect carries `io.` on its import line and a pure std module importing `io.` is refused at compile time. | `libs/std/src/*`, `root.bp`, `io/mod.bp`, `testing/mod.bp`, the root-imports-no-`io` check — the `std-purity` task, after front 01 (`01-std-lib-enablement`) and the std-async task merge, because the tree moves their modules | std_root_module_imports_no_io |
| 111 | 1.0.10-beta · (the maintainer, 2026-09-26) | `collections`' constructors are type-scoped, each called on the type it builds: `Dict.empty()`, `Set.empty()`, `Set.fromList(xs)`, `Queue.empty()`, `Queue.fromList(xs)` (106's merge of `dict`, `sets`, `queue`, `order` into `collections.bp` collides `empty` — dict, sets, queue — and `fromList` — sets, queue — as module-level names). The one exception to 106's "moves paths, not function names": the function's name stays (`empty`, `fromList`), its owner moves from the module to the type; every other function of the merged modules keeps its name. A `Type.fn()` static that does not yet compile on every backend is made to compile (front 23), never a reason to keep module-level names. | front 23 (`00-compiler-carry-over/23-std-purity`) — `libs/std/src/collections.bp`, and type-scoped static functions on the four backends where they are missing | collections_constructors_type_scoped |
| 174 | 17-a (name) | † `Dict.ofEntries(entries: #(K, V)[]) -> Dict<K, V>` in `libs/std/src/collections.bp`; a repeated key keeps its last value, as `insert` does; `Set.fromList` / `Queue.fromList` keep their names | 02 | dict_of_entries_last_wins |
| 175 | 97-b | † `hash.pbkdf2Sha256(password, salt, iterations, length)` derives over the salt's UTF-8 bytes, the same on node and erlang (`("password", "salt", 1, 32)` → `Eg-2z_z4syxD5yJSVsT4N6hlSMkszDVICAWYfLcL4Xs`); rakun's base64url-salt cell changes in rakun's "consume std" step | 02/97 · rakun | pbkdf2_sha256_utf8_salt |
| 177 | 97-d | † `fs.glob`, one rule on both targets: `*` and `**` do not match a name starting with `.` unless the pattern writes the dot; the walk does not descend through a link to a directory | 02/97 | glob_skips_dot_names |
| 178 | 97-e | † A dangling link under `fs.walk` is an `Error` naming the link, on both targets — not skipped | 02/97 | walk_dangling_link_error |
| 197 | — | † (1) erlang's `indexOf` / `lastIndexOf` count codepoints (320). (2) `async.retry` with an unusable policy panics (`maxAttempts` < 1, a negative delay, `maxMillis` > 2147483647, `multiplier` < 1.0), as `race([])` does; `nextDelay` answers `null` for it. (3) `hash.pbkdf2Sha256` with `iterations` or `length` < 1 panics with one text on every target, never the host's raise. (4) `fs.glob`, identical on every target: a final `**` is every entry at every depth, the root excluded; a trailing `/` keeps real directories only; a `..` segment is a literal name; a `{a,b}` alternative holding `/` matches nothing | 02/97 | std_panics_on_unusable_arguments |
| 217 | — | † `unique()` on an `array<T>` removes every duplicate, keeping each value's first occurrence in order — `[1, 2, 1, 3, 2].unique()` is `[1, 2, 3]` on every target, compared with `==` (210); no consecutive-only method | 02 · 05-wasm (the trap) · 02-erlang step 4 | array_unique_keeps_first |
| 250 | — | † std's `io.random.bool()` is dropped, not renamed; `coin()` is the boolean draw | 02/97 step 10 · 01-checker (the primitive-named-declaration refusal unparks when 97 lands) | random_coin_is_bool_draw |
| 497 | 97-s13-b | `io/clock`'s domain is the epochs RFC 3339 writes, one on every target — 0000-01-01T00:00:00Z … 9999-12-31T23:59:59.999Z (−62167219200000 … 253402300799999); `formatIso8601`, `toCivil` and `offsetMinutes` abort past it, naming the value, on every target | `1-botopink-lang/144` B-10, B-24 · 319 | clock_rfc3339_domain |
| 498 | 97-s13-c | `io.clock.parseDuration` keeps its 2^53 − 1 ms bound: a duration is handed on as a timer delay or a JSON number, both `f64`, inexact past 2^53; `largestExactMillis`'s comment names that reason | `1-botopink-lang/144` B-24 · 319 | parse_duration_exact_bound |
| 499 | 97-s13-d | `fs.stat`'s `mtime` is whole seconds on every target: the Node form floors it too, as erlang and beam answer it | `1-botopink-lang/144` B-24 | stat_mtime_whole_seconds |
| 688 | B-27-g1 · (confirmed as built, the maintainer's batch, 2026-10-18) | `onSignal(.Int, f)` answers `Error(Unsupported)` on erlang and beam, where the VM keeps `SIGINT` for its break handler; `forwardSignals` skips `Int` there; `Int` stays in the shared enum (506 (c)); the terminal's Ctrl-C still reaches a spawned child through the process group | `machine-1/144` B-27 | process_signal_int_unsupported_beam |
| 706 | std-e · (confirmed as built, the maintainer's batch, 2026-10-18) | No test lifecycle hook: nothing implicit runs around a `test` block; a test body calls its reset helper (67, 513); `language-gaps.md`'s row "No test lifecycle hooks" closes as the language's answer | `machine-2/144` · `machine-1/150` | test_block_no_lifecycle_hook |
| 711 | 540-a · (the maintainer's batch, 2026-10-18: (2), (3) as built; (1), (4) a change) | `io.fs` details 540 left open: (1) a dangling link under `walk` answers `NotFound(<root>/<link>)` — what a read through it answers —, `path` naming the link; (2) `hash()` hashes the whole file whatever the read position (as `Asset.hash`); (3) `lines()` ends at an `InvalidUtf8` line; (4) the write and directory functions (`writeBytes`, `writeText`, `appendText`, `mkdir`, `mkdirRecursive`, `rm`, `removeTree`, `copy`) answer `Result<void, FsError>` (no `i32` 0), `File.write` alone a count; the pinned cells `fs_error_variants`, `std_fs_walk_root_spellings` re-recorded for (1) and (4) | `machine-2/144` · 540 | fs_walk_dangling_link_not_found |
| 849 | B-10-c · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 1" — decided by the fable at the maintainer's delegation; rejected: milliseconds only when nonzero — two widths sort and parse by two rules) | `io.clock.formatIso8601` answers `YYYY-MM-DDTHH:MM:SS.sssZ` on every target, milliseconds always; 497 kept. (1) The erlang cell calls `calendar:system_time_to_rfc3339(M, [{unit, millisecond}, {offset, "Z"}])` on the millis, no flooring; commonJS unchanged. (2) `parseIso8601` reads both widths | `machine-1/144` B-10 G1 | clock_iso8601_millis_always |
| 855 | B-27-g2 · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 1" — decided by the fable at the maintainer's delegation; no rule added) | Overtaken by B-128 (105, 125 as built): a typed `AsyncIter` on erlang and beam runs in a process that waits for each request, so `keys()` yields each key as it arrives; no `readKey` is added, `keys()` stays the one API | `machine-1/144` B-27 | |
| 856 | B-27-g4 · (the maintainer, 2026-10-21: "crie um thread para o fable reponder todas da maquina 1" — decided by the fable at the maintainer's delegation; rejected: a path per operating system, untested) | On erlang and beam `terminal.setRaw` and `size` are Linux's: elsewhere `setRaw` answers `Error(Unsupported)` and `size()` `null`; `TerminalError` gains `Unsupported`. (1) The cells test `os:type() =:= {unix, linux}` before `/proc` and `stty`; commonJS unchanged. (2) No cell runs off Linux; the branch is read in the template and `libs/std/AGENTS.md` states it | `machine-1/144` B-27 | |
| 906 | 790-b · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; the recommendation (a) overruled for the answer off commonJS: 67 and 518 (4) — what is known at build is refused at build, at the call, never at the import; `Error(Unsupported)` is for what only the run time knows (`onSignal(.Int)`, 688; `setRaw`, 856); rejected: (a)'s run-time `Error(Unsupported)` on erlang and beam; (b) `env: Dict<string, string>` — the OS's form is `NAME=value`, a conversion on every call for nothing) | `io.process.start(cmd, args, cwd: ?string, env: string[])`: `env` is `NAME=value` entries added to the parent's environment, no shell, the first `=` ending the name; an entry with no `=` or an empty name is answered `Error(Other(message))` naming it; the function exists on commonJS alone — a call reaching it on erlang, beam or wasm is refused at the call, `std-unsupported-on-target` (518 (4), 503), the module importable and `run` / `spawn` unchanged; amends B-161's built answer. (1) The mechanism is `target_check.zig`'s per-call refusal (B-163), read for erlang and beam as for wasm: a `declare fn` with no cell for the target is emitted unreachable, every call refused by the check, so a method body over such a cell no longer refuses its module. (2) 790's program runs on commonJS alone (B-161) and is unaffected. (3) The `cell_check_program-790/` cells' erlang and beam answer becomes the refusal; cell `process_start_commonjs_only`: a call to `start` refused on erlang, beam and wasm, run on commonJS | `machine-2/144` B-161 · std (`io/process`) | process_start_commonjs_only |
