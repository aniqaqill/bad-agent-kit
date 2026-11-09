# Changelog

All notable changes to bad-agent-kit are documented here, in Pi changelog
format (version headings match `package.json`).

## [0.2.0] - 2026-11-09

### Added

- Provider/adapter model: mattpocock, pstack, vercel-labs, chrome-devtools are
  OPTIONAL pinned providers (two-step proof: pin + on-disk detection)
- pstack as a first-class optional provider (plugin-channel only), including
  the manifest pins and data-only adapters (adapters/*.md)
- Phase contracts (plan/implement/review/mr) in bak/references/contracts.md
- Review pipeline (5 phases, SHA-bound exits) + MR babysitter loop
- Builtin `babysit` skill (gh + git, no external suite required)
- scripts/detect-providers.sh: two-step provider detection writing
  ~/.config/bak/providers.json (advisory only)
- Go lane de-wrappered: go-plan/go-tdd/go-review are fully self-contained
  (inline frontier interview / red-green-refactor / two-axis review);
  provider delegation is conditional, never load-bearing
- GO_RULES.md hardened with the 5 audited resources: Cheney perf workshop
  (P1-P8), Cheney never-start-a-goroutine (G1-G4), TDD lessons (T1-T5),
  Bloch API design (B1-B6), optional non-enforcing logging guidance (L1-L5)
- CI: upstream path-existence job (catches moved/deleted pins)

### Changed

- Fixed 6 stale mattpocock pins (grilling/migrate-to-shoehorn/scaffold-exercises
  moved; request-refactor-plan/resolving-merge-conflicts/qa removed upstream)
- Manifest upgraded to provider-grouped rows with channel, roles,
  required|optional, and checked date
- bootstrap.sh is detection-first; external suites install only via
  --providers flag; update.sh no longer runs blanket global updates
- Routing matrix is per-provider (mp:* / pstack:* / builtin) with the Go
  fence stated as an absolute invariant
- README: provider-layer diagrams, plan→implement→review→mr framing,
  per-provider install channels

## [0.1.2] - 2026-11-09

### Changed

- Stale-record sweep: routing matrix retitled BAK, legacy chief references
  removed from README catalog, GLOSSARY, SKILL.md descriptions
- Orchestrator: `bak-sync` / `bak-update` loader commands (repo is the source
  of truth; local copies re-localize on sync)

## [0.1.1] - 2026-11-09

### Changed

- Single public identity: BAK now expands to **Bad-Agent Kit** (native
  acronym); Batman remains theming only (🦇, tagline), never the name.

## [0.1.0] - 2026-11-09

### Added

- `bak` router skill (formerly chief): thin workspace router, portable core
- Curated skills catalog: README table in lockstep with `manifest/upstream-sources.txt`
- Go-first skill family: `go-plan` (grilling → to-spec), `go-tdd` (sensor gates
  + e2e outcome tests), `go-review` (two-axis + perf/race/security/solid lenses)
- `GO_RULES.md`: 24 sensor-tagged rules in HARD/REVIEW/EVIDENCE tiers
- Playbooks: feature-work, diagnosis, research-docs, go-work
- CI: privacy-scrub gate + catalog lockstep validation
- Bootstrap/update scripts; Claude Code plugin marketplace manifest; pi-package manifest
- Design evidence with `$HOME`-scrubbed provenance
