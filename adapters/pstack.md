# Adapter: cursor/plugins — pstack — data only, no router logic

Suite: https://github.com/cursor/plugins/tree/main/pstack · optional=true
· plugin-channel ONLY (no npx).

## Contract mapping

| Namespaced id | Contract | Role |
|---|---|---|
| `pstack:poteto-mode` | plan | non-Go feature/bug/perf/refactor design |
| `pstack:tdd` | implement | non-Go only; never for Go |
| `pstack:interrogate` | review/adversarial | multi-model attack; only run-proven findings survive |
| `pstack:principle-prove-it-works` | review | the evidence ladder (compiles ≠ evidence) |
| `pstack:principle-separate-before-serializing-shared-state` | plan | concurrency design (also feeds the Go frontier) |
| `pstack:principle-model-the-domain` | plan | domain modeling |
| `pstack:principle-test-behavior-not-implementation` | implement | TDD contract alignment |
| `pstack:technical-writing` / `pstack:unslop` | docs | writing quality |
| `pstack:recall` / `pstack:ketchup` | staleness | context freshness |
| `pstack:setup-pstack` | setup | suite bootstrap |

## Install (plugin channel only)

- `/add-plugin pstack` (Cursor) or `/plugin marketplace add cursor/plugins` +
  `/plugin install pstack@cursor-plugins`
- Fallback: clone `cursor/plugins` to a pinned location and record the root

No npx — a skills-dir `poteto-mode` copy is classified manual-clone, never
canonical.

## Detection

Marker signature: plugin manifest `name == "pstack"` AND
`skills/poteto-mode/` present. Globs: `~/.cursor/plugins/**/.cursor-plugin/plugin.json`
(highest version wins), `~/.claude/plugins/cache/cursor-plugins/pstack/*/.claude-plugin/plugin.json`,
`~/.codex/plugins/*/plugin.json`.

## Skipped Cursor-only steps

Bugbot, Automations, cloud agents, `/loop`, Custom Modes, benny automations —
one-line skip notes in the playbooks; not part of the BAK contract surface.
pstack ships no mr/babysit skill — the builtin `babysit` covers the mr contract
for all lanes.
