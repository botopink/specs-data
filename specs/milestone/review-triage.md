---
milestone: 1.0.12-beta
---
# Review triage — the open delegated decisions

The 139 rows that `specs-bot review --open` lists (814–955) — the decisions taken at the maintainer's delegation —
read one by one with `specs-bot step <n>` (2026-10-26) and none marked reviewed. Each row
was checked for: a contradiction with an in-force row or a retired form; a cell named and plausible (a one-liner or a process
row needs none); a rule that answers the question its id names; and whether it is a process rule or a language rule (process rows
are marked *(process)*). Rows 957–963, answered today, were read as part of the record.

- **C — looks wrong**: 2 — a contradiction or a mismatch, naming the row.
- **B — needs a look**: 39 — a broad language surface, an overlap with another row (most often a row a later one amends
  while it stays in force), or loose or stale wording.
- **A — holds up**: 98 — consistent, narrow, matching its question.

Once the maintainer answers, the rows approved are marked with `specs-bot reviewed <n>`, and each row rejected opens a pending
question (`specs-bot pending-add`).

## C — looks wrong

| Step | Rule (one line) | Reason |
|---|---|---|
| 953 | Track 05's nine rakun-bpp choices stand; 31-a's raise-through-host-cell mechanism confirmed, signature left to nat-d6/lg2-l. | Contradicts 924 (signals are data, no raise) and 929: its (3) confirms that `notFound()` / `redirect(url)` raise through a host cell and cites `-> noreturn` and catch-by-type, which 924 rejected. |
| 955 | Track 07's nine rakun-ssr choices stand under current names; 49-a and 68-d amended, 50-a under 506 (3) and 71. | Contradicts 928: its (7) says the public-env manifest entries carry `RAKUN_SSR_PUBLIC_`, a prefix 928 deletes for `#[publicEnv]`. Also no cell for a code-bearing bundle. |
