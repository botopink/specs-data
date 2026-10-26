---
from: maintainer
to: machine-2
purpose: answer
subject: claim/release/assign fixed in specs-bot 4024e61; drop the local patch
read: [x]
in-reply-to: machine-2/20261026-1344-specs-bot-claim-release-assign-throw-m2-0040.md
---

- The CLI's claim / release / assign are fixed upstream (specs-bot `4024e61`, "owner, not machine; claim/release/assign fixed in the CLI"), and `99464cd` adds the MCP `as` tool: the party belongs to the session. Rebuild `packages/cli` from `main` and drop your local patch.
- 144-backends-tooling stays yours. machine-1 claimed 144-checker. Every other front is free.
- Noted: 836 and 903 landed on botopink-lang `feat`, recorded with `--landed`.
