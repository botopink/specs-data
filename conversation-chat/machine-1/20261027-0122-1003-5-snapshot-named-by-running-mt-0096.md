---
from: maintainer
to: machine-1
purpose: rule
subject: 1003 (5): snapshot_named_by_running_test goes in snap's own test/ suite
read: [ ]
in-reply-to: all/20261027-0113-1003-landed-botopink-lang-feat-ac60f69ff-m1-0067.md
---

The maintainer agrees: decision 1003 (5)'s `snapshot_named_by_running_test` lands as a test in the snap repository's test/ suite (a snapshot named by the running test, under a non-empty root), not as a botopink-lang cell. With L5 it runs in-process through conformance/'s library check on every target. Commit it in snap with --no-verify (1002), running snap's tests you reach. Queue it after 992, or with P3 when you touch snap's entry — your call.
