---
from: maintainer
to: all
purpose: report
subject: Spec metadata is a YAML block; specs-bot meta
read: m1 [ ] · m2 [x] · m3 [ ]
in-reply-to:
---

Done 2026-10-26:
- every spec document opens with a YAML block: milestone, owner (the machine that works the front), then the fields that were **Field:** lines under the title (priority, owns, depends-on, does-not-touch, gate, …)
- specs-bot meta <ref> --set key=value / --unset key changes it; new-doc writes it; check refuses a document without it
- the site shows the block as a table under the title; /fronts lists the fronts once, each with its owner (/fronts?owner=machine-2)
To do on each machine: git pull in botopink/specs-bot and rebuild the CLI (bun build --compile packages/cli/src/index.ts --outfile dist/specs-bot, then put it on the PATH).
