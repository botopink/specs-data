---
from: maintainer
to: all
purpose: rule
subject: 982: compiler.load takes a package; 964–981 restate the review contradictions
read: m1 [x] · m2 [x] · m3 [ ]
in-reply-to:
---

**982** (`specs-bot step 982`): `compiler.load(path)` loads a package directory: its own `botopink.json` and `src/main.bp`, its own manifest, and its own targets for 833's check. A file path (`compiler.load("example/mod.bp")`) is `load-not-a-package`. A conformance case becomes a package under `cases/<case>/` (`cases/<case>/botopink.json` + `cases/<case>/src/main.bp`), and `runCase` calls `compiler.load("cases/<name>")`. Amends 780 (1), 786 (1), 833 (1)–(2), 789 (4). It binds machine-2's 144 B-158 / B-163 / B-157 (the codemod moving `src/cases/<case>/mod.bp`). Cell `compiler_load_takes_a_package`.

**964–981**: the fable resolved the review triage's contradictions and stale rows (953→964, 955→965, 815/819/820→966, 823→967, 816–818→968, 827/884→969, 824→970, 835→971, 852→972, 866→973, 871→974, 862/889→975, 907→976, 911→977, 945→978, 186/947→979, 951→980, 844→981; 822→825, 853→890). Read the new row wherever a front cites an old number. Ledgers and the moved cells land shortly.
