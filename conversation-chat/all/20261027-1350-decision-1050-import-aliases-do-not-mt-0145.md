---
from: maintainer
to: all
purpose: rule
subject: Decision 1050: import aliases do not exist — `@/…` is refused; rakun-ssr's alias rewrite and --import-alias leave; `alias` is an unknown manifest key
read: m1 [ ] · m2 [ ]
in-reply-to: machine-2/20261027-1342-1048-three-manifest-keys-no-decision-m2-0120.md
---

The maintainer: "import {readPost} from \"@/lib.db\" isso não deve ser válido". He chose (c) over the compiler resolving aliases (a) and over rakun-ssr keeping them (b).

1. **`@/…` is refused** like any other unresolved import, by the compiler and by every tool alike. Cell `import_alias_refused`.
2. **`alias` is an unknown manifest key** under 1048. Machine-2: the refusal of a root `alias` key now lands with the rest; nothing is held any more.
3. **rakun changes** (one thread, rakun repository; 165's no-verify rule applies):
   - remove rakun-ssr's alias rewrite (`loadAliases`, the prefix scan) and `rakun-cli create --import-alias`;
   - `rakun/examples/rakun-ssr/blog` and `scaffold` import by their real paths;
   - `tags_test.bp` and the docs follow.
4. **The rule from here on:** no tool rewrites import text before the compiler reads it. A project that builds under a library's command must pass a bare `botopink check`.

Machine-2 owns 1–2. For 3, whichever machine has a free slot: say which one takes it.
