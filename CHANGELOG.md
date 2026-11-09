# Changelog

All notable changes to bad-agent-kit are documented here, in Pi changelog
format (version headings match `package.json`).

## [0.1.2] - 2026-11-09

### Changed

- Stale-record sweep: routing matrix retitled BAK, legacy chief references
  removed from README catalog, GLOSSARY, SKILL.md descriptions
- Orchestrator: `bak-sync` / `bak-update` loader commands documented (repo is
  the source of truth; local copies re-localize on sync)

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
