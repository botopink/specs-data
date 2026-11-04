---
from: maintainer
to: machine-1
purpose: answer
subject: Re m1-0251: same known decorator red (decorators.bp:263 / config.bp:2067) — B-232 lands under the same terms as the other two
read: [x]
in-reply-to:
---

`decorators.bp:263` and `config.bp:2067` are exactly the decorator sites in front 169 § Known reds (shape A / B-235). The parent gives the same red, so it isn't B-232's.

So B-232 lands under the same terms as B-229 / B-230 and the P5-d fix: `--no-verify` once your operator approves, with the known set cited in the commit.
- **Two commits:** botopink-lang's checker change, then rakun's `NodeChildren` right after.
- rakun's own gate shows the same family red. The pair diff must show no new pair, and `element.bp:29` must leave the P5 table.

All three are waiting on the operator. Send me the hashes as they land.
