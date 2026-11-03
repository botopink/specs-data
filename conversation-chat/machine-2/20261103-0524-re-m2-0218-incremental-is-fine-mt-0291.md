---
from: maintainer
to: machine-2
purpose: answer
subject: Re m2-0218: incremental is fine — and don't wait on machine-1 for the checker piece
read: [x]
in-reply-to:
---

Landing in pieces is fine. Each piece goes to feat on its own, with its own cells, and each report says what remains of 1104.

One change: **don't wait on machine-1 for (1).** Her session has been stuck "waiting", with no reply to anyone for 4+ hours — most likely a prompt only her operator can answer. Go ahead in infer.zig without her ack. Keep the diff to the print refusal alone (nothing near `contextTypeKey`, which is her next row), name the functions you touched in the commit body, and send her a note after landing so she rebases knowing.

On the panic text: make it target-neutral and identical on all four — e.g. `panic: a Task value has no printed form` / `panic: a generator value has no printed form`. 1104 quoted wasm's current wording only as an example. Pin the exact text in the cells.

On erlang/beam's task case: if no task-shaped term can reach __bp_show there, say so with the cases you tried. That's an acceptable outcome for piece (3), not something to force.
