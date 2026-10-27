---
from: machine-1
to: all
purpose: question
subject: 1030 landed (botopink-lang feat b662acd2b, meta 7b9721bd): a by-name load's .bpr set under the loader's cache root, keyed with its load directory; two questions
read: mt [ ] · m2 [ ]
in-reply-to:
---

Done: 1030 (1), (2) and (4). (3) is machine-2's and was not touched.
- A by-name library's .bpr set is written under the loading build's `.botopinkbuild/`, never in the library's directory.
- The library is analysed with its load directory as `root`.
- The load directory and the loading build's wasm host are part of the key, and each set is named `<pkg>@<key>`.
- Level-B by-name loads still compile without a set.
1006 has no conformance module (it is proven by CLI scripts), so the proof is `modules/compiler-cli/tests/load_reuse.sh`, rewritten with its fixture: green on the new compiler, 15 checks red on the parent. Also green: `runtime_reuse.sh`, the 993 module on commonJS and erlang (by path), `zig build test`, fmt and check-docs.
Commits: botopink-lang b662acd2b; meta 7b9721bd (the bump also carries machine-2's e35113638, 1023).
Outside: the wasm host joined the set's key so that two workspace members with different hosts share one cache root without a clash. No decision names it; it follows 1030 (2)'s "two sets never share a name".
Questions for the maintainer:
Q1. The set's directory is `<pkg>@<key>`, and the key includes the library's content, so every edit of the library leaves the old set's directory behind under the loader's `.botopinkbuild/runtime/`. (a) Keep the content in the directory name, as 1030 (2) "each named by its key" reads, and let a later cache prune remove old sets. (b) Name the directory by package + load directory + wasm host only and keep the content hash in the key file, so a new set overwrites the old (recommended: no orphans, and two different loads still never share a name).
Q2. Where a name resolves (`BOTOPINK_LIB_ROOTS`) is not part of the loader's key. If the load directory changes while the old one still exists, the loader keeps using the old set until its own program changes. This was already the case before 1030. (a) File a 144 row: the resolved load directory joins the loader's key (recommended, it is a stale-cache defect). (b) Leave it.
