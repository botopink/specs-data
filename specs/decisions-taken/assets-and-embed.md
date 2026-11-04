---
scope: >-
  How a file of the package becomes part of a program: `compiler.embed` resolves a path and answers a
  `Link`, `Asset` opens a `File` over it, the `comptime` written at the read decides a build-time
  constant versus a run-time read, and how a folded asset prints. Reading a file is `io.fs`'s API
  (std); the lowering mark and the resolved print are compiler-module's and
  backends-and-run-time-output's.
terms:
  - '`compiler.embed`'
  - '`Link`'
  - '`Asset`'
  - '`Asset(link).open()`'
  - '`asset.bp`'
  - '`embed-path-absolute`'
  - '`embed-path-outside-package`'
  - '`embed-file-missing`'
  - '`embed-no-reader`'
  - '`comptime-arg-not-known`'
  - '`bytes.fromHex`'
  - '`bytes.toHex`'
  - '`__bp_embed_<p>`'
  - '`FsError`'
  - '`compiler-web`'
related:
  - 'compiler-module'
  - 'std'
  - 'stages-and-folding'
  - 'backends-and-run-time-output'
  - 'caches-and-build-outputs'
binds:
  - '`01-checker` (the builtins)'
  - '`01-compiler/14` step 6'
  - '`08-bpp/121`'
  - '`1-botopink-lang/144`'
  - '`machine-2/144` B-163'
retired:
  - '`@embedFile(comptime path: @Expr<string>) -> string`, `@embedBytes(comptime path: @Expr<string>) -> Bytes` (346)'
  - '`pub fn open(self: Asset) -> File` (no `Result`, the build having proved the file exists)'
first-step: 342
last-step: 885
in-force: 3
superseded: 0
---
# assets-and-embed — `compiler.embed`, `Link`, `Asset`

**`compiler.embed(path)` makes the link and nothing else; `Asset` opens a `File` over it; when the file is read is the `comptime` written at the read.**

Steps: 342, 519, 520, 538, 540, 606, 607, 885
Binds: `01-compiler/14` step 6 · `01-checker` (the builtins) · rakun 88, 93 · `08-bpp/121` · `1-botopink-lang/144` · `machine-2/144` B-139

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 342 | lg2-o | `compiler.embed(comptime path: string) -> Link` (607; this row's `@embedFile(comptime path: @Expr<string>) -> string` / `@embedBytes(comptime path: @Expr<string>) -> Bytes` (346) are retired) resolves a file at build, in any context: a path not known at build is an error at the argument; in a run-time body a build read is a constant of the compiled program (607 (3)). The path is relative to the `botopink.json` of the package that wrote it — the application's for its own code and for a decorator annotating its declarations (`#[wsdl("schemas/billing.wsdl")]` reads the application's file), a library's for its own calls, the caller's for a function taking `comptime path` and passing it on, the member's in a workspace. Refused at the argument: an absolute path, one leaving the package (`..`); a missing file is a build error at the call (a non-UTF-8 text is `File.text`'s `FsError`, 607 (2)). A read file is a build input: its content hash enters the cache key; watch and the LSP rebuild on change. `fs` stays refused in a comptime body | `01-compiler/14` step 6 · `01-checker` (the builtins) · rakun 88, 93 · `08-bpp/121` | embed_file_at_compile_time |
| 538 | B-12-c | (a): `size` an `i64`; `hash` the SHA-256 of the bytes in lowercase hex; a path through a `comptime` parameter reaches the function as a hidden last parameter `__bp_embed_<p>: Asset` (836's spelling of `__embed_<p>: Asset`), one body per function; an `Asset` is a module-level constant and opens as a `File` — `open(self: Self) -> Result<File, FsError>` (607 (2); this row's `pub fn open(self: Asset) -> File` with no `@Result` is replaced), every read of `File`'s API (`read`, `bytes`, `text`, `chunks`, `lines`, `hash`), a fallible one answering `Result<…, FsError>` as on disk, `close` a no-op; code taking a `File` reads a disk file (`fs.open`) and an embedded one alike (Go's `embed.FS` model); `text()` of an `Asset` not known at build refused (`embed-text-not-at-build`, naming `asset.open().text()`) is removed by 607 (2) | `1-botopink-lang/144` | asset_size_hash_open |
| 885 | ctr-embed-resolved (the fable audit of 814–882; the maintainer, 2026-10-21: "pede o fable decidir as seis" — decided by the fable at the maintainer's delegation; the maintainer: "`@embed("caminho")` foi removido hoje, ele tá no compiler"; rejected: (b) `compiler.embed` a run-time call — reverses 607 (1); (c) `--emit-resolved` refusing the module — the oracle loses every asset cell; `Asset(compiler.embed("…"))` printed — a build member in a program with no comptime left (798 (1)); a byte literal `<<…>>`) | A folded `Asset` prints as `Asset(Link(path: "<path>"))`, folded `bytes` as `bytes.fromHex("…")`; amends 835 (2), (4), 838 (1). (1) `Link(path: …)` is a spelling only the printer writes and only the oracle reads (834 (2)), admitted there as a lowering-marked call (830); the path is package-relative, read at run time from the project's directory (838 (2)). (2) `bytes` gains `pub declare fn fromHex(s: string) -> bytes` and `toHex(self) -> string` in `primitives.bp`, four targets; bytes folded by a build read (607 (3)) print so, once at the module's init. (3) 838 (1)'s "519's assets" reads "the bytes a build read folded (607 (3))" — binary, never printed. (4) `@embed` is removed entirely; 835 (2) reads with this spelling. | `machine-2/144` B-163 · std `primitives.bp` | resolved_prints_asset_and_bytes |
