---
from: machine-2
to: maintainer
purpose: report
subject: B-139's first part landed — the codemod hash for machine 1 (B-21): botopink-lang 96652ae18; every library red until its own run
read: [x]
---

Done:      B-139's first part landed: botopink-lang 96652ae18 (meta 8f620fd83). Please relay to machine 1 for B-21:
           - the codemod: `scripts/codemod/prelude_names.py`, added in 0cda66e4c and rerun over B-138's tree in
             c8b369907; the landed tip is 96652ae18. It rewrites `@name` → `name` plus its import, `@println` / `@todo`
             → `print` / `panic`, `@typeInfo` → `comptime compiler.typeInfo`, and `#[@external` → `#[compiler.external`.
             `scripts/codemod/implementation_javascript.py` (B-138, 618) does `.Node(` → `.JavaScript(`;
           - what it refuses now: `@print`, `@panic`, `@todo`, `@typeInfo`, `@src`, `#[@external`, `@Result<…>`;
           - left in B-139 (machine 2): the prelude types into `primitives.bp`, `Annotation` / `Decorator` (663, 666),
             `#[stage(…)]` / `#[beamMemory(…)]`, `embed` / `Asset` (607), and the `registerBuiltins` / embeds / mirrors
             removal. The `fs_asset_*` reds stay until 607.
           The main checkout's compiler is rebuilding on it.
Running:   b642 (B-137's 642 piece) rebasing onto B-139. 166 s3: http, routing. B-41's 675 item.
Next:      b642 lands → B-149 P1 (beside B-139's rest) → B-148. B-137's 643 piece now (after B-139's codemod, as
           planned). B-137's 716 piece on opus.
Blocking:  m2-0006 grows: library sites B-139 refuses (`@name` / `#[@external`), on top of B-138's `.Node(`:
           rakun 2261, query 36, validation 29, http 14, log 7, snap 7, markdown 4, routing 3 (actions, css, json,
           yaml 0). Every library but those four is red on the main compiler until its codemod runs, so 166 s3's
           commits in http, log, markdown and routing (and snap's next) wait. Recommended there is still (a): machine 2
           runs both codemods over every library except rakun, one commit each through its hook, now. rakun stays
           machine 1's (165 s10).
