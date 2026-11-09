# Contributing

## Rules of the marketplace

1. **Compose, never own.** Skills listed here stay owned by their authors.
   BAK pins sources and documents chains — it never vendors upstream code.
2. **Catalog lockstep.** The README catalog table and
   `manifest/upstream-sources.txt` must agree; CI enforces this. Once
   `catalog/catalog.json` exists (past ~40 entries), it becomes the source of
   truth and the README table is generated.
3. **Privacy-scrub gate.** Never commit personal literals (home paths, vault
   names, private endpoints). CI fails on them. Use `$HOME` or generic paths.
4. **One channel per agent.** Never document an install that double-installs
   the same skill through two channels on one agent.

## Adding a skill

1. Add a pinned line to `manifest/upstream-sources.txt`
   (`<source> <skill-path>`, one per line).
2. Add its README catalog row: skill name, source link, install command,
   workflow position.
3. If BAK authors the skill itself, add `local:skills/<name>` to the manifest
   and ship the skill under `skills/<name>/`.
4. Run `bash scripts/scrub.sh && node scripts/validate-catalog.js` before
   committing.

## Adding a playbook

Drop a `docs/playbooks/<topic>.md` describing a real skill chain:
entry skill → each phase → sensor gate at each exit. Link it from README.

## Commit style

Imperative, ≤72-char subject, one change per commit. Publication (npm,
marketplace channels) requires the owner's explicit authority.
