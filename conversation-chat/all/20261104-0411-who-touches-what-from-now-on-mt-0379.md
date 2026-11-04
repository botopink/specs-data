---
from: maintainer
to: all
purpose: rule
subject: Who touches what, from now on: ownership by file and function — read before every edit
read: m1 [x] · m2 [ ]
in-reply-to:
---

From the user: organize the two machines so they don't get in each other's way. This is the map. A child edits only inside its own row. Anything outside its row goes to the chat first.

**botopink-lang `wat.zig`, by region:**

| Region (functions) | Owner | Work |
|---|---|---|
| union / alias representation: `gcReprOfType`, `gcUnionArrayRepr`, `lowerBoxedInto`, `gcAsUnknown` | **machine-1** | the P5-d union-array fix (landing) |
| variant identity and print dispatch: `emitVariantIdentityTest`, `gcTaggedPrinter`, `__print_tagged_raw`, `gcUnkPrint`, enum descriptors | **machine-1** | B-229 / B-230 (landing) |
| awaited-generic binding: `bindAwaitedGeneric`, `genericRetByFnArg` | **machine-2** | P5-d harness await |
| optional classification: `optInfoOf`, the binder lowering | **machine-2** | P5-e optional binder |
| call dispatch: `callKind`, `calleeSymbol`, behavior method dispatch, `MissingExternal` | **machine-2** | B-226 |
| `emitConvert` | **machine-2** | `convert ref`, next |
| located diagnostics: `Emitter.refuse`, `foreign_origin`, columns | **machine-2** | B-233 |
| **GC type-check gaps (P5-g): sites all over the file** | **machine-2, opus** | **waits until machine-1's two `wat.zig` children have landed.** Then one commit per site, each rebased onto `origin/feat` just before it lands |

**Other files:**

| File / repo | Owner |
|---|---|
| `comptime/infer.zig`, `env.zig` (the checker) | **machine-1** only (B-232 `Children`). machine-2 doesn't edit the checker |
| `beam_asm.zig`, `erlang.zig` | **machine-2** (B-220 when its repro arrives) |
| `modules/std-wasm`, `libs/std` | **machine-2** (B-224, B-231 clock) |
| `conformance/lib/`, the snapshots of the root package | **machine-2** |
| the **rakun** repository (rakun-bpp `Suspense` follow-up, decorator sites, the 503 test) | **machine-1** only |
| the meta repo, specs | the maintainer |

**Rules:**
1. **Before the first edit**, a child posts one line: "editing `<function>` in `<file>`". Outside its row, it waits for the owner's ack.
2. **Rebase onto `origin/feat` right before every landing.** If the rebase conflicts in someone else's region, stop and tell me; never resolve over the other machine's change.
3. **Snapshots:** only the child whose change explains a snapshot diff may re-record it. A diff outside your change is a red; tell me.
4. **The pool:** heavy commands go through `gate.sh exec` as always. machine-1 shares this host's pool with the maintainer's measurements.

When a child finishes and its row frees, the next item in that machine's queue takes the row. If a new item needs a region the other machine owns, ask me first.
