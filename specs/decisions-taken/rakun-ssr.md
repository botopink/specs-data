---
scope: >-
  Decides `rakun-ssr`, the orchestrator onze became: `rakun-ssr dev` as `build` then `start` over a
  watcher (no hot-loading), the `#[publicEnv]` marker for the only environment values a client bundle
  may see, the og module's refusal of a malformed integer, and track 07's nine implementation choices
  under the new names. `rakun-ssr.json`'s keys and the island modes are pages-routing-and-stages; the
  package renames are library-split.
terms:
  - '`rakun-ssr dev`'
  - '`#[publicEnv]`'
  - '`env-non-public`'
  - '`forwardSignals`'
  - '`ssr_main.bp`'
  - '`rakun-ssr-server`'
  - '`SsrConfig`'
  - '`rakun-ssr.json`'
  - '`allowedRedirects`'
  - '`parseMetrics`'
  - '`gradientOf`'
  - '`escapeField`'
  - '`scanForSecrets`'
  - '`AssetRoot`'
  - '`StaticRoot`'
  - '`stylesheet-hash-split`'
  - '`@/`'
  - 'public_env_marker'
  - 'ssr_config_refusals'
  - 'og_malformed_integer_refused'
related:
  - 'pages-routing-and-stages'
  - 'library-split'
  - 'module-system'
  - 'styling'
  - 'snap'
open:
  - '965 (5): the font-metrics generator is owed at 150 s61 step 4, the five transcribed rows re-derived there'
  - '965 (8): the style-map probe (`stylesheet-hash-split` / `stylesheet-unevaluated`) holds until 301''s `#[stylesheet(…)]` tag annotation lands'
binds:
  - '`machine-1/150` s59, s60, s61, s62, s72'
  - '`machine-1/150` s60, s67, s72'
  - '`machine-1/150` s61'
  - '`machine-1/150` steps-onze 50 step 2, 53 step 6'
  - '`machine-1/165` s5'
  - '07-onze (staging `rewriteImports`, docs, examples)'
retired:
  - 'onze''s `@/` alias (`from "@/…"`)'
  - '`emilia()` / `emiliaWith` / `emiliaPlugin` / `emilia.bp` / `emilia-*` bundler kinds and examples; `Onze`, `OnzeConfig`, `ONZE_PUBLIC_`, `/_onze/`, `onze_main.bp`, `ONZE_KEY`; `jhonstart_*.erl`, `examples/rakun-bpp/jhonstart-*`; `onzeAvailable()` / `rakun.cli.onze` / `RAKUN_CLI_ONZE`'
  - 'the `RAKUN_SSR_PUBLIC_` prefix, `isPublicEnvName`, `publicEnvPrefix`'
  - 'hot-loading / a module swap as a form of `rakun-ssr dev` (50-b''s (b), (c); 50-d, 50-e, 50-f)'
  - '`env-non-public` keyed on an unprefixed name'
  - '`parseMetrics` / `gradientOf` reading a malformed integer as `0`'
  - 'a second start path beside the release''s `bin/rakun-ssr`'
first-step: 218
last-step: 965
in-force: 5
superseded: 1
---
# rakun-ssr — the orchestrator

**`rakun-ssr` runs an app: `dev` is `build` then `start` over a watcher, never a hot reload; a browser-visible environment value is a `#[publicEnv]` `val`; a malformed integer is refused; track 07's nine choices stand under 965.**

(1) The `@/` alias retired — 218.

(2) The dev loop: restart on every change, no hot-loading on any target — 766.

(3) Public environment values: `#[publicEnv]`, `env-non-public`, no prefix — 928.

(4) og's malformed integers refused — 942.

(5) Track 07's nine choices (`describe*` + `snap`, `rakun-ssr.json` refusals, `rakun-ssr-server`, one start path, font metrics, `appDir`, the client manifest, the style probe, `AssetRoot`) — 955 → 965.

Steps: 218, 323, 506, 507, 724, 766, 767, 893, 928, 942, 955, 965
Binds: 07-onze (staging `rewriteImports`, docs, examples) · `03-bundled-libs/102` step 3 · `07-onze/49` · `1-botopink-lang/144` B-27 · `2-libraries/162` · 79 · `machine-1/150` s59, s60, s61, s62, s72 · `machine-1/165` s5

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 218 | onze-a | The `@/` alias is retired: write `import {lib.db.findPost};`; `from "@/…"` is `module-import-with-from` like any other, staging never rewrites it (206) | 07-onze (staging `rewriteImports`, docs, examples) | onze_no_at_alias |
| 766 | 50-b · (the maintainer, 2026-10-19: "somente a (a)", after a fable plan of (b) on every target) | `rakun-ssr dev` is `build` then `start` looped over a file watcher (std's `fs` mtimes; the child spawned with `forwardSignals`, 506): the node restarts on every change and serves the bytes `start` serves; hot-loading is no form of the dev loop on any target — the server exists on erlang alone (117; 334 (4)), on commonJS and wasm a reload is a restart by construction, on the BEAM every swap (`code:load_binary`) leaves state `start` never has (`persistent_term` caches of effectful module `val`s, ETS module `var`s (547), rakun-bpp's append-only UI table, 665's registry, the build id read once at boot) and an init order unlike 580 / 660's (67). Island state is lost on every edit (Fast Refresh a non-goal); 50-d, 50-e, 50-f not filed; no cell (50 step 2's acceptance script proves `dev` and `start` answer alike) | `machine-1/150` steps-onze 50 step 2, 53 step 6 | process |
| 928 | nat-f4 · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `rakun-ssr/src/config.bp` `publicEnvPrefix = "ONZE_PUBLIC_"` / `isPublicEnvName`, the bundler's `env-non-public` refusal at a client module's `env.read` of an unprefixed name (`bundler/refusal.bp`, `scan.bp`); the prefix's name is `RAKUN_SSR_PUBLIC_` since 862 / 889; rejected: (a) the prefix kept — a stage fact carried by the operator's naming of a variable, stated nowhere in the code (281's spirit); (c) a list in `rakun-ssr.json` — a second home for a code fact; the marker and the prefix both — two spellings (67)) | A value the browser may see is declared once, marked where it is read — `#[publicEnv] pub val apiUrl = env.read("API_URL");`; the `RAKUN_SSR_PUBLIC_` prefix is retired. (1) `publicEnv` is `rakun-ssr`'s decorator on a `val` (356; `syntax decl: unknown`, recording `PublicEnv(name)` with `compiler.setMeta`, the name read off the initializer's `env.read("…")` literal, 280; any other initializer refused at the annotation); the bundler inlines the build's value of each marked `val` into the client bundle and refuses, located, every `env.read` a `#[client]` component reaches that is not such a `val` (`env-non-public`, naming `#[publicEnv]`); `env-dynamic`, `env-vars`, `env-write` stay. (2) The marker is found in the bundler's scan of the client modules (`scan.bp`); `isPublicEnvName` / `publicEnvPrefix` removed; `scanForSecrets` (150 s60) lists the marked names as the only environment values inlined. (3) `contracts.md` § env, the examples (`client-island-example.bp`) and 150 s60 / s67 read the marker; 150 s72 deletes the prefix. (4) Cell `public_env_marker` (rakun-ssr): a marked `val` inlined, an unmarked `env.read` in a `#[client]` component refused naming the marker, red on the parent | `machine-1/150` s60, s67, s72 · `contracts.md` | public_env_marker |
| 942 | 51-a · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `rakun-ssr/src/og/metrics.bp` `parseMetrics` answers `0` at three `Error(_) -> 0` sites and `svg.bp` `gradientOf` at one — `ascent 9x0` reads as `0`, `linear-gradient(9.5deg,…)` draws at 0°; rejected: (a) `0` kept — a malformed input read as a value (67; 299 reversed `rkPropInt("12abc") == 12`)) | A malformed integer is refused: `parseMetrics(family, weight, text) -> Result<FontMetrics, string>` answers `Error("<family> <weight>: line <n>: \"9x0\" is not an integer")`; `gradientOf` answers its "not a two-stop linear gradient" value for a non-integer angle — never `0`. (1) Call sites propagate with `try`; `og_test.bp` asserts both; an integer past `i32` is the same `Error`, never an abort. (2) Cell `og_malformed_integer_refused` (rakun-ssr), red on the parent | `machine-1/150` s61 | og_malformed_integer_refused |
| 955 | 07-onze (9) · (the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured on `rakun` feat: `rakun-ssr/src/testing/core.bp` (`import {assertAs} from "snap"`, the core's `describe*`), `config.bp` (`OnzeConfig`, the port and `allowedRedirects` checks), `cli/start.bp` (`erl -noshell` through `process.run`), `assets/font_metrics.bp` (five rows, the generator owed), `bundler/manifest.bp` `escapeField`, `bundler/refusal.bp` (`emilia-hash-split`, `emilia-unevaluated`), `onze-server/src/server.bp` `staticRootOf`, `examples/rakun-ssr/blog/rakun-ssr.json` (`appDir: "src/app"`), `release/docker.bp` (`bin/rakun-ssr`); rejected: std's `snapshots` as the engine — retired (391, 407); a second start path beside the release's script (`start` running `erl` itself once `bin/rakun-ssr` exists) — one start path (150 s60 step 5); the probe kept past 301's landing — the tokens comptime, nothing to evaluate twice) | Replaced by 965 | `machine-1/150` s59, s60, s61, s62, s72 · `machine-1/165` s5 | |
| 965 | 955-fix · (the fable, at the maintainer's delegation — the review triage of 814–955, 2026-10-26) | Track 07's nine choices stand under `rakun-ssr`'s names (724, 762, 862, 889, 893), 49-a and 68-d amended, 50-a under 506 (3) and 71, 68-a under 928; replaces 955. (1) 49-a: the core's suites render through its own `describe*` and write through `snap`'s `assertAs` (391; `"snap"` a dependency), never std's retired `snapshots`; the `*-test` helpers are the package's `testing/` module (724). (2) 49-c: `rakun-ssr.json` refuses an unknown key, a duplicate, a wrong kind, a port outside `1..65535`, a non-string `allowedRedirects` entry (67); its key set is 271's (and `nat-f2`'s); `OnzeConfig` renamed `SsrConfig` (862). (3) 49-e: the boot's rakun half is the erlang package `rakun-ssr-server` (762), `RakunSsr.run` its entry (893), `integration.bp` importing `rakun-bpp` and the bridge, no third file importing both. (4) 50-a: `rakun-ssr build` stages `ssr_main.bp` (889) and compiles it to BEAM; `start` spawns the node with `forwardSignals()` (506 (3), 689), `dev` looping it (766); when the release exists `start` runs its `bin/rakun-ssr` (71; 150 s62 step 2, s60 step 5) — the one start path; `bin/onze` reads `bin/rakun-ssr` (862). (5) 52-a: the font-metrics table has five transcribed rows; the generator owed at 150 s61 step 4, the five re-derived or corrected there. (6) 53-a: the blog's sources under `src/` (`appDir: "src/app"`), `rakun.appDir` written by the orchestrator at boot (117 (5)). (7) 68-a: a client-manifest field escapes `%`, the vertical bar, LF and CR only (`escapeField`); the environment values a client bundle may see are the `#[publicEnv]` `val`s alone, inlined by the bundler and listed by `scanForSecrets` (928) — no prefix of any kind (`RAKUN_SSR_PUBLIC_` retired), no manifest entry carries one. (8) 68-d: the style map is evaluated by a probe compiled into both packages until 301's `#[stylesheet(…)]` lands (369, 889; 150 s40 step 4, s52), kinds `stylesheet-hash-split` / `stylesheet-unevaluated` (889 (3)); with the tokens comptime (class and rule computed at build over `contentHash`) the probe and its snapshot go. (9) 69-a: `rakun-ssr` keeps `AssetRoot`; `rakun-ssr-server` converts it to `rakun-service`'s `StaticRoot` (`staticRootOf`), the roots served through `registerStaticRoot` before the routes (201). (10) Cell `ssr_config_refusals` (rakun-ssr): (2)'s five refusals, red on the parent | `machine-1/150` s59, s60, s61, s62, s72 · `machine-1/165` s5 | ssr_config_refusals |
