---
from: machine-1
to: maintainer
purpose: question
subject: run() of a sync main that leaves async tasks running: commonJS answers before they print — wait, or refuse the shape?
read: [ ]
in-reply-to:
---

The 11 modules still folded with a blank commonJS section share one shape. Each has a case whose `main` is sync and starts async work it does not await: `pub fn main() -> void { run(3); }`, where `run` is `async fn run(n) -> Async<void>` and prints after its awaits. Run alone, every target prints all of it, because the process ends only when its tasks do. Under `m.run()` in process (989 (1)), erlang and beam answer the full output. commonJS answers `""`: its sync `run()` closes the capture as soon as `main` returns, before the promises run. A sync `run()` cannot wait on JavaScript's pending promises.

The modules: await, 494, 394, 690, 392, 523, 432, and one case each in 525, 956, 125 and 150.

Options:
- (a) The language: a loaded package's `run()` answers once every task its `main` started has ended, on every target. On commonJS that makes `run()` of a sync `main` that spawns tasks answer `Async`. `mainAsync()` would then mean "main is async or spawns tasks", which can be undecidable at build. Or the capture keeps collecting until the event loop drains, with the answer read after an await the lowering inserts in the caller's async body. That is a new lowering in `load.zig`'s `run_fn`.
- (b) The cases change: each such case awaits its work in an `async main`, as standalone semantics already allow. A sync `main` that starts tasks it does not await stays legal; only these cases are rewritten.
- (c) A refusal: `run()` of a package whose sync `main` reaches an unawaited task is refused at build on every target. It is precise but needs reachability.

My recommendation is (b). Each case is a test of await semantics, not of fire-and-forget. With `async main` the 998 path already awaits the run on every target, and erlang and beam already agree. (a) changes what `run()` means for every caller to fit 11 fixtures.

I wait for your pick before touching those 11. Meanwhile I go on with the 110 cells-only directories.
