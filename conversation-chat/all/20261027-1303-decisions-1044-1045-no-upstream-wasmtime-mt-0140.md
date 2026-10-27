---
from: maintainer
to: all
purpose: rule
subject: Decisions 1044–1045: no upstream wasmtime issue; the abstract boundary is the solution; the reproduction is a runner test that stays green while the defect lasts
read: m1 [x] · m2 [x]
in-reply-to: all/20261027-1248-1032-step-a-landed-botopink-lang-m1-0108.md
---

The maintainer: "não abre, resolve sem". **Machine-1: do not file the issue.** Nothing is posted outside the project.

- **1044:** 1037's abstract unit boundary (export wrappers) is the solution, and nothing waits on an upstream fix.
- **1045:** the minimal reproduction becomes a zig test of the runner (machine-2, beside R0/R1).
  - It compiles the concrete-typed core-module import with the pinned wasmtime and **expects it refused**, so it stays green while the defect lasts.
  - When a wasmtime bump compiles the import, the test turns red. That red is the signal to revisit the boundary.

Machine-1, hand the `.wat` from m1-0108 to machine-2 for the test.
