# Contributing

## Rules of the marketplace

1. **Compose, never own.** Skills listed here stay owned by their authors.
   BAK pins sources and documents chains — it never vendors upstream code.
2. **Providers are optional pinned suites.** A provider (mattpocock, pstack)
   runs only with two-step proof: pinned in `manifest/providers.toml` AND
   detected on disk. Absence never blocks — the degradation lane falls back
   to builtin phases with a skip note.
3. **Go fence is absolute.** `go.mod` ⇒ go-plan/go-tdd/go-review only; the
   go-* skills must stay `local:` in the manifest (CI asserts this).
4. **Catalog lockstep.** `docs/catalog.md` ↔ `manifest/upstream-sources.txt` ↔
   `providers.toml`; CI enforces all three.
5. **Privacy-scrub gate.** Never commit personal literals (home paths, vault
   names, private endpoints). Use `$HOME` or generic paths.
6. **One channel per agent per provider.** Never document an install that
   double-installs a skill through two channels on one agent.

## Adding a provider skill

1. Add a row to the provider's group in `manifest/upstream-sources.txt`
   (`<provider> | <source> | <skill-path> | <channel> | <roles> | optional | <checked>`).
2. Add/refresh the one-line pin in `manifest/providers.toml`.
3. If the skill satisfies a phase contract, add a row to the provider's
   `adapters/<provider>.md` mapping.
4. Add the catalog row to `docs/catalog.md`.
5. Run `bash scripts/scrub.sh && node scripts/validate-catalog.js` before
   committing.

## Adding a BAK-owned skill

1. Create `skills/<name>/SKILL.md` (+ `agents/openai.yaml`).
2. Add `local:<name> | skills/<name>/SKILL.md | builtin | <roles> | required | <checked>`
   to the manifest.
3. Add `./skills/<name>` to `package.json` `pi.skills` and a `docs/catalog.md`
   row.
4. Ship it to the local machine with `bak-sync`.

## Adding a playbook

Drop a `docs/playbooks/<topic>.md` describing a real skill chain with provider
route + builtin fallback per step, sensor gate at each exit. Link it from
README.

## Commit style

Imperative, ≤72-char subject, one change per commit. Publication (npm,
marketplace channels) requires the owner's explicit authority.
