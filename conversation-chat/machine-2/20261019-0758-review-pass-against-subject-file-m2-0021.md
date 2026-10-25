---
from: machine-2
to: maintainer
purpose: report
subject: The review pass against specs/decisions-taken.md — pieces checked, differences, what was fixed, what was filed; B-157 moves now (the user's call); library references
read: [x]
in-reply-to: machine-2/20261019-0529-review-pass-ack-763-mt-0040.md
---

Done:      **The pass.** The whole subject file was re-read (rows 1–143 folded, 739–767, the workspace's names, retired.md).
           Every piece landed since 2026-10-18 or held in a worktree was compared with its sentences.
           - **Checked, agreeing:**
             - B-138 (610, 618–621);
             - B-139's first part (606, 608);
             - B-150;
             - B-151;
             - B-155's comptime and erlang boxes;
             - B-147 (the record-field call);
             - B-41 (675's panic text);
             - B-122 (568's `#(1, 2)`);
             - B-121, B-124;
             - 164 s3 P2-d / P2-e (585 (i)–(k));
             - 163 s13 (717);
             - 750;
             - B-137's 718 / 643 / 716;
             - B-149 P1 (751's `Call(callee:)`);
             - the 166 drafts of css, markdown, routing, yaml and snap (719).
           - **Differences found and fixed (mine):**
             - actions 303 and http 623 `Task<…>` → `async fn … -> Async<…>` (732);
             - http 294 `days(30)` (the subject's spelling, the missing `days` its departure);
             - json 206 / 337 without `mod`, 337 (2) replaced by 592;
             - actions / http 330 `T[]`;
             - http 181 `p._0` (738). Landed: actions 2393262db, http b55c88ed6, json fae95fc5a.
           - **Differences filed:**
             - 195-a (log's leaf import), your 763;
             - B-138 box 4's note on B-151's call-node pruning against "no backend intercepts `print`", your reading stands.
           - **Differences handed to running pieces** (now stopped, worktrees kept):
             - 716 with 759's `decorator-member-local-not-literal` and its cell, in progress;
             - B-149's `Fn` / type nodes (753), `compiler.ast` in a decorator body (640 (3)), the error at the `ast` call (752).
           - **Left to B-21:** the new cells' `pub fn main() {` without `-> void` (622).
           Nothing that contradicts a sentence in force has landed since the pass began.
           **Conformance** (the user put machine 2 on it alone):
           - `conformance/docs.md` and 95 cells' docs.md in retired.md's spelling (botopink-lang b6add471a): 564 → 241
             retired lines. What is left: history sentences, refusal texts, and the sections whose mechanism changed —
             catalogue / `@Decl`, `@embed` / `Asset`, the `mod` tree, contexts (722 / 723), `keyed`. Each is rewritten with
             the cells it describes: B-137's final package, B-139's rest, 592, B-17;
           - `conformance/run.sh`'s self-test in today's spelling (cca6c3be9). It had stopped the whole suite from running
             locally. The suite then gave 2,623 / 8; 5 were a stale compiler, 2 are `fs_asset_*` (607), and 1 is a wasm
             regression: importing `io.process` is refused again against 652 (3), being bisected and fixed;
           - every library but rakun got a conformance reference in botopink-lang's pattern, one section per public module
             and the decision cells linked: query 4c223c926, validation 5ad8a57ad (a `conformance/` of its own),
             actions 0487cdcd0, css d94f4e877, json bd34c6f72, http af12922bf, log 3f8237a53, markdown 87484a0af,
             routing 3740b3ebe, snap 1f5baf2ed, yaml 60593e980. The departures each library's src still has are named
             there. Eight of those commits went `--no-verify` at the user's request (a stale main compiler); their gates are
             being re-run now;
           - B-157: P1 landed in both halves (meta 6eaa5e7fd; botopink-lang 3ad1c5bb8, cell `cell_cases_directory`) and P2
             (4bcd097b2). **P3, the moves, runs now: the user chose not to wait for 760's codemods.** Machine 1 is told
             (m2-0020).
Running:   B-157 P3 (`apply --all`, one commit per prefix group, `verify` the oracle); the wasm `io.process` regression;
           the eight library gates.
Next:      B-157 P4 (drafts for the rows no cell proves), after aligning how `consolidate-cells.py` and `decision-cells.py`
           count a code-bearing row (they differ on http, log, snap).
Blocking:  the 108 rows without a `Cell` slug (m2-0019). One question from json's reference: is `unquote` `quote`'s inverse,
           and do `array` / `object` take texts that are already JSON? Only 396's names and actions' use back it. It is in
           json's docs as "decided, not built".
