# Repo Contract (AGENTS.md)

- This repo is a marketplace + orchestrator. **Compose, never own**: do not
  vendor upstream skills into this repo.
- The README catalog table and `manifest/upstream-sources.txt` must stay in
  lockstep. CI validates this. After `catalog/catalog.json` exists, it becomes
  the source of truth and the README table is generated — never hand-edit both.
- Never commit `$HOME`-literal paths or personal-infra inventory (vault paths,
  API endpoints). The privacy-scrub CI gate enforces this. Use `$HOME`.
- The `bak` skill is the portable core; personal overlays stay local and
  private.
- Publishing (npm / marketplace channel updates) requires the owner's explicit
  authority. Drafting is not publication.
- MIT license: entries listed here remain the property of their authors.
