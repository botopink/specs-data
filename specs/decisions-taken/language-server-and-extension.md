# language-server-and-extension — the language server and the VS Code extension

**The language server reports what the language says; the extension reads the symbol tree, never a convention.**

The language server reports a type's methods as `SymbolKind.Method`; the VS Code extension recognises a `test "…"` block by its place in the symbol tree — a child of the file, where a method is a child of a type — never by the symbol kind (7). The server names the optional `?T` and never the checker's internal `optional<T>`, in a hover or a code action (44). Its cache is § caches-and-build-outputs (233).

Steps: 7, 44, 233
Binds: `11-tooling` · a row of `01-checker` · 00-gate/131 step 2b

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 7 | 1.0.5-beta · (the maintainer, 2026-09-18) | **A type's methods are `Function`, not `Method`** **Decided 2026-09-18 by the maintainer: (a).** The extension recognises a test by its declaration, and the language server emits `Method`. Both land in one sweep across the two repositories. **Measured.** The language server reports a type's methods as `SymbolKind.Function`. Making them `Method` is correct for the outline and **breaks the VS Code Test Explorer**, which classifies every `Method` symbol as a `test "…"` block (`repository/vscode-extension/src/symbolNodes.ts`; the LSP protocol has no `Test` kind). **Options.** (a) Teach the extension to recognise a test by its declaration (`test "…"`), not by the symbol kind, then emit `Method`. (b) Leave both as they are and document it. **Recommendation: (a).** The outline is user-facing and wrong today; the Test Explorer's rule is an internal shortcut that the extension owns. The two land in one sweep across the two repositories. **The sub-question (a) forces:** how does the extension then recognise a `test "…"` block? By a marker in the symbol's `detail`, by another `SymbolKind`, or **by its parent in the tree** — a `test` block is a child of the file, a method is a child of a type. The last is the cheapest and the only one that does not invent a convention; decide it with (a), because until then the language server is kept wrong on purpose so that the extension stays right. **Blocks:** `11-tooling`. | `11-tooling` | |
