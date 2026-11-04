---
scope: >-
  Request-scoped state as cardume atoms read and written through `use`, cardume as a library with
  Recoil's model and its two stores, `Cookie<T>` and its noun hooks, which atoms an island may read,
  and atom effects. Contexts and `use` itself are contexts-and-components; `Cookie<T>`'s declaration
  (294) and `http` are actions-http-log-routing-i18n; a `comptime` value-or-type parameter (297) is
  syntax-and-comptime-parameters.
terms:
  - '`atom`'
  - '`Atom<T>`'
  - '`atomValue`'
  - '`atomSetter`'
  - '`atomState`'
  - '`atomReset`'
  - '`loadable`'
  - '`transaction`'
  - '`selector`'
  - '`atomFamily`'
  - '`Cookie<T>`'
  - '`cookieValue`'
  - '`cookieState`'
  - '`cookieSetter`'
  - '`cookieReset`'
  - '`#[clientOnly]`'
  - '`rakun-cardume`'
  - '`RequestContext`'
  - '`HookUse`'
  - '`persistLocal`'
  - '`syncSearchParam`'
related:
  - 'contexts-and-components'
  - 'actions-http-log-routing-i18n'
  - 'rakun'
  - 'pages-routing-and-stages'
  - 'markup-and-rakun-bpp'
  - 'syntax-and-comptime-parameters'
open:
  - '943 (2): if B-17''s hooks list carries the argument for `use context` alone, a 144 row extends `HookUse` to every hook''s module-level `val` argument'
  - '944: `persistLocal` / `syncSearchParam` are a later step after a measured need; 136 step 8 is deferred'
binds:
  - '`03-bundled-libs/104` step 6'
  - '`05-jhonstart/26` step 12'
  - '`07-onze/53`'
  - '`08-bpp/122`, 123, 127'
  - '`09-cardume/136`'
  - '`machine-1/136` step 6'
  - '`machine-1/136` step 8'
  - '`machine-1/144` B-17 (if the hooks list lacks the argument)'
retired:
  - '`LocalKey<T>(name)`'
first-step: 295
last-step: 944
in-force: 5
superseded: 0
---
# request-state-and-cookies — atoms, cardume, `Cookie<T>`

**Request state is atoms read and written through `use`; a cookie is declared once, typed, its hooks nouns in cardume's family; `cardume` is a library of its own with Recoil's model in botopink's spelling.**

(1) Atoms, `use`, the root context — 295.

(2) cardume's model, its two stores and hooks — 296.

(3) `Cookie<T>`'s hooks — 400.

(4) An island's atom reads, `#[clientOnly]` — 943.

(5) Atom effects — 944.

Steps: 294, 295, 296, 297, 400, 736, 893, 943, 944
Binds: 104 step 6 · `05-jhonstart/26` step 12 · 123 · 127 · `07-onze/53` · `09-cardume/136` · `01-compiler/01-checker` step 26 · `03-bundled-libs/104` step 6 · `08-bpp/122`, 123, 127

## Record

| # | Id | Rule in force | Binds | Cell |
|---|---|---|---|---|
| 295 | nat-c4 | Request state is atoms read and written through `use`: `pub val currentUser = atom(…);` declares a request-scoped atom of any `T` (cardume's `Atom<T>`, 296), its identity the declaration, no string key (281); middleware writes `val setUser = use atomSetter(currentUser); setUser(u);`; a page, component, handler or action reads `use atomValue(currentUser)` → `?User`; cookies follow the same pattern (294, 400); middleware, route handlers and actions answer `Component<Response>` so they may `use`; the request is the root context `RequestContext`, provided by rakun's pipeline (354); rakun's and rakun-bpp's hooks act over the same atoms; `LocalKey<T>(name)` and its run-time name clash are removed | 104 step 6 · 123 · 127 · `05-jhonstart/26` step 12 · `07-onze/53` | request_state_atoms |
| 296 | (cardume) | `cardume` is a library of its own (`repository/cardume`, `botopink/cardume`), one concern: shared state (113), with Recoil's model in botopink's spelling: `atom`, `selector` (sync and async), `atomFamily` / `selectorFamily`, `Loadable`, `transaction` (synchronous, atomic, atoms only), `atomCallback`, `snapshot`; no string key (281). One atom type, two places to live: the core imports neither framework; a store per request (295's request locals are cardume atoms) and a store per page in the browser, shared by its islands, both in `rakun-cardume` (893); each store spells the same hooks (`atomValue`, `atomState`, `atomSetter`, `atomReset`, `loadable`, `transaction`; a type as its implicit atom, 297), reading the store from a root context its framework provides (354). `Cookie<T>` stays in `http` (294) | `09-cardume/136` · 123 · 104 step 6 | cardume_shared_state_library |
| 400 | atm-a | A cookie's hooks are nouns in cardume's family; for `Cookie<T>` (294, in `http`): `use cookieValue(sessionCookie)` → `?T` (`null` when absent or undecodable); `use cookieState(sessionCookie)` → a `State<T>`-shaped `.value` / `.set(v)`; `use cookieSetter(sessionCookie)` → `fn(v: T)`; `use cookieReset(sessionCookie)` → `fn()`, the cookie cleared. A page reads only: `cookieState`, `cookieSetter`, `cookieReset` in a render are refused at build (122); writes and clears happen in a middleware, a route handler or an action, the attributes always the declaration's; rakun-bpp's `state` / `effect` / `memo` / `ref` / `reducer` and cardume's hooks are unchanged | `03-bundled-libs/104` step 6 · `05-jhonstart/26` step 12 · `08-bpp/122`, 123, 127 · `07-onze/53` · `09-cardume/136` | cookie_hooks_are_nouns |
| 943 | atm-c · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: `repository/cardume` does not exist (136 step 0) and `rakun-cardume` holds both stores (893); `HookUse.context` carries a module-level `val`'s declaration handle (839, 576 (7)); rejected: (a) every atom's `T` encodable — a DOM handle or a function forbidden in any atom; (c) refused at run time; `clientAtom(…)` — a second spelling of 278's `#[clientOnly]`) | An atom holds any `T`; an island's read set is checked at build over the hooks list; an atom an island reads whose `T` is not encodable is declared `#[clientOnly] pub val draft = atom(…);`, else an error at the island's `use` naming the atom and `T`; 278's `#[clientOnly]` reaches a `val` (282). (1) Encodable is 354 (6)'s: a `#[validated]` type's `encode` (327) or a type 294 accepts; the server seeds only the atoms an island read that are not `#[clientOnly]`; a `#[clientOnly]` atom read on the server is refused at the `use` (186's rule for a hook). (2) The read set is the `HookUse` entries of the island's hooks list whose argument is an atom `val` (`use atomValue(x)`, `atomState`, `atomSetter`, `atomReset`, `loadable`), the handle carried as 839 carries it for `use context(ctx)`; if B-17's list carries the argument for `use context` alone, a 144 row extends `HookUse` to every hook's module-level `val` argument. (3) 136 step 6 is written for this; cell `island_atom_read_set_checked` (rakun-cardume), red on the parent | `machine-1/136` step 6 · `machine-1/144` B-17 (if the hooks list lacks the argument) | island_atom_read_set_checked |
| 944 | atm-d · ((the maintainer, 2026-10-21: "pode colocar o fable para tomar elas" — decided by the fable at the maintainer's delegation; measured: cardume has no code (136); rejected: (b) `persistLocal("cart")` — a string key (281); (c) `persistLocal` and `syncSearchParam`) · (process) | No atom effect in the first cut: the store lands first; `persistLocal` / `syncSearchParam` are their own step after a measured need, one function per concern, keyed by the declaration, never a string (281); 136 step 8 is deferred, its box kept for that step | `machine-1/136` step 8 |  |
