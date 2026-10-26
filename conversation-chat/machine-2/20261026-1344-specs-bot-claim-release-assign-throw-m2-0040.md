---
from: machine-2
to: maintainer
purpose: report
subject: specs-bot claim/release/assign throw '{} is not iterable'; fix inside; 144-backends-tooling claimed
read: [ ]
in-reply-to:
---

- `specs-bot claim` / `release` / `assign` fail on every front with `✗ {} is not iterable` (specs-bot c74135b), dry run included. In `packages/cli/src/write.ts` the three actions call `write("front.claim", { front }, o)`. That passes the commander options as `texts`, so the loop `for (const k of texts)` throws. It also passes the op name, where `writeBody` wants the table key (`claim`). `--apply` and `--landed` never reach the body either.
- The fix, built locally on machine 2 and not pushed:

```diff
       .command("claim")
       .argument("<front>", "the front's folder (150-rakun) or its number")
       .description("take a free front to work it: this machine becomes its owner"),
-  ).action(async (front: string, o) => write("front.claim", { front }, o));
+  ).action(async (front: string, o) => write("claim", { ...o, front }));
 
   common(
     program
       .command("release")
       .argument("<front>", "the front's folder or its number")
       .description("let a front go: it has no owner again (its owner or the maintainer)"),
-  ).action(async (front: string, o) => write("front.release", { front }, o));
+  ).action(async (front: string, o) => write("release", { ...o, front }));
 
   common(
     program
       .argument("<front>", "the front's folder or its number")
       .requiredOption("--to <machine>", "machine-1, machine-2 or machine-3")
       .description("give a front to a machine, whoever held it (the maintainer only)"),
-  ).action(async (front: string, o) => write("front.assign", { front, to: o.to }, o));
+  ).action(async (front: string, o) => write("assign", { ...o, front, to: o.to }));
 
   // ── decisions ──────────────────────────────────────────────────────────────────────────────────────────
 
```

- With it, machine 2 claimed `144-backends-tooling`, the only front it works now: d904 (904–906), d900 (900), primblk2 (B-148 rows), P-C (B-162 on wasm, 164) and ci768 (`feat`'s pipeline reds, 768's queue).
- Landed today on botopink-lang `feat`: 836 and 903, each recorded with `--landed`.
