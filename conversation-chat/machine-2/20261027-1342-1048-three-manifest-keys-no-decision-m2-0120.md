---
from: machine-2
to: maintainer
purpose: question
subject: 1048: three manifest keys no decision covers (rakun-ssr's `alias`, bpmp's `botopink` / `requires`, a fixture)
read: [ ]
in-reply-to:
---

The 1048 thread has measured, and stopped before cleaning. The new parser refuses 13 of the 3061 tracked `botopink.json`. 10 of them were already refused on purpose (the `bad/` fixtures and drafts). No manifest has `typings` or `$schema`. These three points have no decision:

1. **`alias` is a real field, read by rakun-ssr.** `rakun-ssr/src/types.bp` `loadAliases` reads the `alias` object of a project's `botopink.json` (the `@/components` and `@/lib` import aliases), and rakun-cli's `create --import-alias` writes it. Two tracked examples carry it: `rakun/examples/rakun-ssr/blog` and `rakun/examples/rakun-ssr/scaffold`. Deleting the key breaks their `@/` imports.
   (a) `alias` becomes a known root field of the manifest.
   (b) rakun-ssr's alias map moves to `rakun-ssr.json`. That is a rakun change: `loadAliases`, `create.bp`, the two examples and the docs.
   (c) Remove it from the examples and let the empty map apply.
   Recommendation: (b). The compiler never reads `alias`, and 1048 keeps `botopink.json` to the compiler's own keys.
2. **bpmp's root keys `botopink` and `requires`.** bpmp reads and writes `botopink` (the compiler-version constraint) and `requires` (constraints per dependency), and `bpmp add` writes `requires`. No tracked manifest uses either. (a) Both are known root fields. (b) Refuse them; bpmp moves them elsewhere. Recommendation: (a). bpmp is the compiler's own package tool, and refusing what it writes breaks `bpmp add`.
3. **A rakun fixture.** `rakun/modules/rakun/test/fixtures/autoconfig/deps-object/botopink.json` has `"rakun-mail": {"version": "0.0.1"}`. `version` is unknown in `dependencies.<name>`. The fixture is only read as text, by `conditions_test.bp`, for the dependency names. (a) Change it to `{"path": "../rakun-mail"}`. (b) Keep it as a refused fixture. Recommendation: (a).

Also: the workspace key is `workspaces`, not `members` as 1006 words it, and it is already known.
