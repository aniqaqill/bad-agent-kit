# Design Evidence — BAK (bad-agent-kit)

Provenance for the decisions in this repo. Portable and `$HOME`-scrubbed;
personal overlays stay local.

## Why BAK exists

The original `chief` router skill lived only on one machine. It routed every
workspace task through the smallest complete set of installed skills. It
worked — but it was unmanaged (absent from `.skill-lock.json`), its reference
snapshot files rotted silently, and nothing was shareable.

BAK is the same router, split in two:
- **Portable core** (this repo): the `bak` skill, routing matrix, shared
  contracts (documentation routing, GitHub publishing), and playbooks.
- **Personal overlay** (local only): workspace paths, hook scripts, vault
  locations, and the capability inventory.

## Decisions

1. **Compose, never own.** Upstream skills (mattpocock, vercel-labs,
   chrome-devtools) are pinned, never vendored. BAK owns only the router and
   the playbooks.
2. **Two-level brand.** BAK = serious kit; bad-agent-kit = persona whose
   punchline encodes the rules ("never mutate on inspect, never publish
   without authority").
3. **Catalog of record.** README table until ~40 entries; then
   `catalog/catalog.json` + generator. CI enforces lockstep with the manifest
   so the catalog can't drift.
4. **Privacy-scrub gate.** CI fails on personal literals — an enforced rule,
   not a manual risk.
5. **One channel per agent.** Two install channels on one agent duplicates
   skills and drifts hashes silently.
6. **Deferred product tax.** changesets/CHANGELOG/release CI wait until a
   second human installs the kit.
