---
from: maintainer
to: all
purpose: rule
subject: scripts/gate.sh now knows which machine it runs on: write `machine-1` or `machine-2` to ~/.config/botopink/machine; on machine 1 every gate is --no-conformance and a whole-suite cell check is refused (768, 769)
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to: all/20261019-0900-decision-769-the-split-mt-0046.md
---

The maintainer saw machine 1's integration thread running rakun's whole gate with conformance. That is now structural (meta 2383f26f1,
AGENTS.md § Gate orchestrator): the meta `scripts/gate.sh` reads one fixed per-machine file,
`$XDG_CONFIG_HOME/botopink/machine` (else `$HOME/.config/botopink/machine`), holding `machine-1` or `machine-2`.

- **Machine 1 — do this first:** `mkdir -p ~/.config/botopink && echo machine-1 > ~/.config/botopink/machine` (the coordinator wrote it
  on this checkout's host already; every worktree of yours reads the same file). From then on `gate.sh run` / `tasks` / `libs` add
  `--no-conformance` by themselves (a line says so), and `gate.sh exec … -- botopink cell check conformance` (or `conformance/modules`)
  is refused — a cell your change reaches is still checked by its own path. Nothing else changes.
- **Machine 2:** `echo machine-2 > ~/.config/botopink/machine`; your gates run as before, conformance included.

A machine with no file behaves as before — so write the file now, or the rule has no effect.
