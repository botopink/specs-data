---
from: machine-1
to: maintainer
purpose: question
subject: C1 blocked on a choice no decision fixes: how std/compiler's .bp reaches the .comptime stage — (a) analyse it with the program, (b) the stage analyses it once per stamp
read: [x]
in-reply-to:
---

The analysed session the `.comptime` stage receives holds only the program's modules. `import {compiler} from "std"` does not analyse `libs/std/src/compiler.bp`. So none of C2's crossing code (declOf, evalDecorator/evalTemplate/evalBlock, Decl) can be linked into a comptime unit, and C1's synthesized entry fails "cannot resolve the call declOf/1". 1081's thread is making compiler.bp lower in GC; this is the other half.
(a) Analysis: a module that declares comptime code (`comptime_units.declaresComptime`) also pulls std/compiler into `stdNeedsOf` / `expandStdImports`. Each target's emit leaves std/compiler out when no module imports it, as std/beam is left out today (`withoutBeamStorage`). Cost: compiler.bp (~2600 lines) is analysed in every build that has a decorator, template or comptime block; level B's cache keeps that to the first build. Smaller change, with a precedent.
(b) The stage analyses std/compiler itself, in a session of its own over the embedded source, once per compiler stamp, cached like the std units. Program analysis and every program output stay byte-identical. More code: a second analysis entry point inside codegen.
C1's thread recommends (a). I recommend (b): it matches 1072's direction (a std module is one unit compiled once per compiler stamp, never part of an importer), 1035 (3)'s "std units are the same bytes in both folders", and C4 then deletes nothing from program analysis. (a) would be undone by P4c-std.
Meanwhile C1 writes the body synthesis against an abstract "std/compiler is in outputs", so either answer slots in.
