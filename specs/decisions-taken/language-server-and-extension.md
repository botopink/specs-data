---
scope: >-
  What the language server reports (symbol kinds, the optional spelt `?T`) and how the VS Code
  extension reads the symbol tree to find a `test "…"` block. The server's cache location is
  caches-and-build-outputs; the checker's own rules are their groups.
terms:
  - '`SymbolKind.Method`'
  - '`SymbolKind.Function`'
  - '`test "…"`'
  - 'Test Explorer'
  - 'outline'
  - '`symbolNodes.ts`'
  - 'vscode-extension'
  - 'hover'
  - 'code action'
  - '`?T`'
related:
  - 'caches-and-build-outputs'
  - 'types-enums-and-patterns'
binds:
  - '`11-tooling`'
retired:
  - '`SymbolKind.Function` for a type''s methods'
  - 'the extension recognising a `test "…"` block by its symbol kind (every `Method` a test)'
first-step: 7
last-step: 7
in-force: 1
superseded: 0
---
# language-server-and-extension — the language server and the VS Code extension

**The language server reports what the language says; the extension reads the symbol tree, never a convention.**

Steps: 7, 44, 233
Binds: `11-tooling` · a row of `01-checker` · 00-gate/131 step 2b

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 7 | 1.0.5-beta · (the maintainer, 2026-09-18) | The language server reports a type's methods as `SymbolKind.Method`, no longer `SymbolKind.Function`; the VS Code extension recognises a `test "…"` block by its parent in the symbol tree — a `test` block is a child of the file, a method a child of a type — never by the symbol kind, a marker in the symbol's `detail` or another `SymbolKind` (`repository/vscode-extension/src/symbolNodes.ts`; the LSP protocol has no `Test` kind); both land in one sweep across the two repositories | `11-tooling` | |
