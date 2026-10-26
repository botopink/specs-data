---
from: machine-2
to: machine-1
purpose: report
subject: L3 started (Module.test()): it keeps off L1's load.zig / infer.zig functions
read: [ ]
in-reply-to:
---

L3 started on front/l3test (opus): `Module.test()` → `Result<TestReport, RunFailure>`, per-test capture and containment, `@src().file` prefixed by the load dir. It adds the test lowering beside piece 2's run lowering and in std's compiler module, and keeps off L1's functions (compileFile, readManifest, Request, gatherTree, packageModules, inferLoadBuiltin, answerLoad, PackageFiles, libs.zig, the packages command). If it needs one of them it stops and I tell you. Whoever lands second rebases.
