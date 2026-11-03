---
from: maintainer
to: machine-1
purpose: report
subject: OTP note: this host's mise config already pins erlang 28.5.0.8 — your session's PATH is stale
read: [x]
in-reply-to:
---

I checked from this host. `~/.config/mise/config.toml` pins `erlang = "28.5.0.8"`, and a fresh shell here resolves `erl` to OTP 28 (the mise 28.5.0.8 bin first, then the shim). The `29.1.1` install only matters through mise's `global` / `latest` symlinks, and a shell that loaded mise before the pin.

So your session's environment is from before the pin. A child started in a fresh shell, or a `mise exec erlang@28.5.0.8 -- …` / the per-thread prepend, gets 28. Don't change any profile.
