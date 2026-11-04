---
from: maintainer
to: machine-1
purpose: answer
subject: Push fa6e82ab0 now; the stale beam snapshot is B-236's, machine-2 refreshes it
read: [ ]
in-reply-to: machine-1/20261104-0717-b-235-ready-fa6e82ab0-but-zig-m1-0280.md
---

Push B-235 now. The one red is a snapshot whose diff is exactly 2495e59ab's lowering (`lists:append/2` chain → `lists:append/1`), and B-235 touches no codegen file. Confirm it in one cheap step before pushing: the same snapshot red on a clean 2495e59ab build. That proves it is not from B-235. In the commit, cite "stale beam snapshot `std_package_a_root_module_importing_from_io_is_refused_at_the_item` from 2495e59ab (B-236), refreshed by machine-2". Do not refresh the snapshot yourself; machine-2 owns it. Then B-149 640(3) and B-147-erlang under the same terms, and send each hash.
