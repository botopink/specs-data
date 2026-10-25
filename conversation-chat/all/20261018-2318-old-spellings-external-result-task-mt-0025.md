---
from: maintainer
to: all
purpose: rule
subject: Old spellings still on feat — `#[@External.<Target>]`, `@Result`, `@Task<@Result<T, E>>`: rakun's 249 code sites (machine 1), 22 comment and `////` lines in std and the cells (machine 2); the spec tree is being swept
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261019-0009-decision-files-moved-to-specs-mt-0024.md
---

The maintainer (2026-10-18/19) flagged `@Result`, `@Task`, `@Task<@Result<T, E>>` and `#[@External.<Target>]`: "isso não é
assim mais". The forms in force are `Result<T, E>`, `Async<T>` (`async fn`), `Async<Result<T, E>>`, `Component<R>`
(`component fn`), `#[compiler.external(.Erlang("m:f"), .JavaScript("…"), .Wasm(…))]` (`@External.Beam` gone, `.Node` →
`.JavaScript`), `terminal.print`, `panic`, `compiler.typeInfo`, `syntax x: T` for `@Expr<T>`, `syntax decl: unknown` for `@Decl`
(§ host-functions, § body-markers-async-and-iter, § syntax-and-comptime-parameters of `specs/decisions-taken.md`). Measured on
`feat` now:

- **Machine 1 — rakun: 249 real `#[@External.<Target>(…)]` sites in `.bp` code** (`repository/rakun/modules/**`). m1-0003 says both
  codemods are applied and staged, waiting on routing / snap / css; m2-0013 reports those three landed on `feat`. Rebase and commit
  through rakun's hook now; nothing else waits on the maintainer for it.
- **Machine 2 — botopink-lang: 22 lines, all comments or `////` doc lines**, the code already migrated: `libs/std/src/`
  (`io/clock.bp` ×3, `io/random.bp`, `beam.bp`, `encoding.bp`, `erlang.bp`, `hash.bp`, `json.bp` ×2, `math.bp`, `primitives.bp` ×2,
  `types.bp`, `unicode.bp`) and the cells' `////` headers / comments (`behavior_host_value_wasm_refused`,
  `bodyless_method_without_binding`, `erlang_host_sidecar_shipped`, `external_erlang_host_module_missing`, `external_method_local`,
  `external_wasm_std_outside_std`, `host_erlang_task_result`, `host_node_task_result`, `lambda_element_method`,
  `manifest_targets_host_binding`; tests `behavior_host_dispatch`, `bodyless_fn`, `external_host` ×2, `external_markers`,
  `mocks_decorator_double`, `mocks_handwritten_double`, `module_init`). A `////` line is the cell's reference (480), so it is not
  a comment to leave: respell them in B-137's next piece — `#[compiler.external(.Erlang("mod:fun"))]`, `.JavaScript`, `@Stage.Any`
  → the current stage word — and let `prelude_names.py` rewrite comments too, so no library keeps the old text.
- **The spec tree** (`specs/1.0.12-beta/**`, about 940 occurrences — `@Result` 167, `@Task` 101, `@Decl` 104, `@External` 88,
  `@Component` 87, `@Expr` 75, `@TypeInfo` 68, `@print` 59, …) is being respelled by a coordinator thread now; history sentences
  (a rename, a codemod) keep the old name. Until it lands, read a README box's old spelling as its current form, and write only
  the current spelling in any text you add.
