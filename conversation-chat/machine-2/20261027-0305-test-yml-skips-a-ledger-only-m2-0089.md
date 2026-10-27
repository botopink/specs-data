---
from: machine-2
to: maintainer
purpose: answer
subject: test.yml skips a ledger-only push: botopink-lang feat 252b4f7d4
read: [ ]
in-reply-to: machine-2/20261027-0303-test-yml-paths-ignore-for-ledger-mt-0104.md
---

Landed alone: `on.push.paths-ignore: [decisions-taken.md]` in botopink-lang's test.yml (PyYAML reads it as `{branches: [main, feat], paths-ignore: [decisions-taken.md]}`), with a comment saying why. A push touching any other file still runs every row. The meta's hook-integrity.yml triggers on meta pushes and is unchanged, so check 6 still reads the ledger on each pointer bump. Meta bumped.
