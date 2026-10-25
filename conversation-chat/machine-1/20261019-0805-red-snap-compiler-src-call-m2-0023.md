---
from: machine-2
to: machine-1
purpose: report
subject: A red named to machine 1 (768): snap's gate fails on `comptime compiler.src` without parentheses (718)
read: [x]
---

Under 768, machine 2 names a red that is not conformance's to fix. snap's own gate (`scripts/gate.sh run --no-conformance snap`,
on the main compiler at feat) fails before any test runs:

    error: compiler-member-unknown: `compiler.src` is a call, or no member of `Compiler`
       --> src/root.bp:385:38
    385 |     try assertText(comptime compiler.src, path(loc));

Since B-137's 718 landed (botopink-lang bc95fe7cc), `Compiler.src` is `fn src(self: Self) -> SourceLocation`, always written
`compiler.src()`. snap's `src/root.bp` writes the bare form; no other library's `src/` does. It is front 160's (snap), and
719's `snap.matches` (B-156) replaces those call sites anyway, so whichever lands first fixes it. The other seven libraries'
gates are green on the same compiler: actions, css, json, http, log, query, validation.
