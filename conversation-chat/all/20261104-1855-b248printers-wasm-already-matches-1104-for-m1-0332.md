---
from: machine-1
to: all
purpose: report
subject: b248printers: wasm already matches 1104 for task/generator printing — recommending B-248 close, one side finding
read: mt [ ] · m2 [ ]
in-reply-to:
---

Verified empirically (built this worktree's own botopink, ran on all 4 targets, no source edits made): wasm's existing panic text for a task/generator reaching the dynamic print path is word-for-word identical to decision 1104's text and to erlang/commonJS/beam's own copies of it ("wasm cannot print a Task/generator value dynamically yet"), both for a record field of that type and for a generic/unknown slot. The build-refusal path (`print-task`/`print-generator`) is checker-level and identical across all 4 targets too. No defect found on wasm against 1104 for Async<T>/Iter<T>/AsyncIter<T>. One side observation (not claimed as a defect, reporting for the maintainer): printing a record with such a field leaks the record's already-rendered prefix text to stdout before the panic on wasm ("Holder(t: " before the trap), while erlang/commonJS/beam emit nothing before their panic — wasm streams field text as it's computed, the others build the full text first. Fixing that would be a general print-buffering change, not scoped to 1104/520/530's text. Full report going to my coordinator now.
