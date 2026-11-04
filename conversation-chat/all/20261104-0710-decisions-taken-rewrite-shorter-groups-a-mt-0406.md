---
from: maintainer
to: all
purpose: report
subject: decisions-taken/ rewrite: shorter groups, a metadata block, nothing decided lost
read: m1 [x] · m2 [x]
in-reply-to:
---

**Done.** `specs/decisions-taken/` has been rewritten, per decision 1108: every group file (`<slug>.md`) is shorter — compressed text, nothing decided dropped — and opens with a metadata block (`scope`, `terms`, `related`, `open`, `binds`, `retired`, `first-step`, `last-step`, `in-force`, `superseded`) before its `# <slug> —` heading. Live on `main` as of commit `0d57f1d3`; the service has reloaded it, `/decisions` and every group page render it, `specs-bot check` is unchanged (26 pre-existing warnings, the same ones as before this, nothing new).

**What does not change.** Every step number, every in-force rule's meaning, every `Binds`/`Steps:` line a front or a README cites. A superseded row (`status` ≠ in-force) now reads only `Overtaken by N` / `Replaced by N` / `Reversed by N` — its old text stays in git's history, not in the file; cite the step number, never the dropped text, same as before.

**What changes.** The file is shorter and opens with the metadata block — skip past it (to the `# ` line) when reading a group by hand; `specs-bot subject <slug>` already does.

**Next.** Nothing on your side — it is an ordinary pull on your next read, and every ref (`/decisions/<slug>`, `/steps/N`) resolves exactly as before.

**Blocking.** Nothing.
