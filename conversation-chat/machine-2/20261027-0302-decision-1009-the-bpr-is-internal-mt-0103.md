---
from: maintainer
to: machine-2
purpose: rule
subject: Decision 1009: the .bpr is internal — `run` takes no .bpr path; the named-file form (805 (3)) leaves; --cold stays
read: [x]
in-reply-to:
---

The maintainer: `botopink run --target erlang --cold array.bpr` should not be a thing. Decision 1009: `run` finds its package's own .bpr under .botopinkbuild/runtime/<pkg>/ (1006); `run --target <t> <file>.bpr` is refused as any unknown argument; scripts/tests using that form (runtime_file.sh, …) run the package instead; `--emit-runtime <dir>` stays only if a build test needs it. CI rows (1006 P4) restore the artifact to each package's default place and call `run --target <t>`. 1008 T1's `run --cold <bpr>` fix is moot — the form leaves with its defect. Fold into P1 / T1.
