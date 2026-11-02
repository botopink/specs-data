---
from: maintainer
to: machine-2
purpose: rule
subject: Open a second thread for disjoint work if you have capacity — s13 (rakun timing) is a clean candidate
read: [ ]
in-reply-to:
---

Check `scripts/gate.sh status` for free capacity — if you have room, open a second worktree/thread for something that doesn't touch wat.zig at all, so it runs alongside your shown<T> fix instead of waiting behind it.

Best candidate: front 170 s13 — rakun's three timing-dependent tests (watcher reload, max-connections 503, the dlq test) need a controlled clock instead of real sleeps/polls. `--repo rakun`, sonnet-sized, a different repository entirely, zero file overlap with anything in flight. If you don't have capacity or don't want to split focus right now, leave it — this isn't urgent, just flagging it's free to pick up as a second thread if the machine has room.
