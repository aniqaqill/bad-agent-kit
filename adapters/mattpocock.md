# Adapter: mattpocock/skills — data only, no router logic

Suite: https://github.com/mattpocock/skills · optional=true

## Contract mapping

| Namespaced id | Contract | Role |
|---|---|---|
| `mp:triage` | plan/intake | issue intake, labels, tracker state |
| `mp:to-spec` | plan/spec | synthesize spec, no second interview |
| `mp:to-tickets` | plan/tickets | split spec into tracer-bullet tickets |
| `mp:grilling` | plan/stress-test | design-tree interview (harder than builtin) |
| `mp:tdd` | implement | red-green-refactor at pre-agreed seams (non-Go only) |
| `mp:code-review` | review | standards + spec axes in parallel |
| `mp:handoff` | mr/handoff | continuation context, artifacts by path |

## Detection

Canonical root: `~/.agents/skills/{tdd,triage,to-spec,to-tickets,handoff,setup-matt-pocock-skills,code-review}/SKILL.md`.
Shadow copies (recorded, never canonical): `~/.claude/plugins/cache/*mattpocock*/*/.claude-plugin/plugin.json`, `~/.codex/plugins/*mattpocock*/plugin.json`.

## Install channels

- Claude Code: `claude plugin install mattpocock-skills@claude-plugins-official`
- Codex: `codex plugin add mattpocock-skills@mattpocock`
- skills.sh: `npx skills@latest add mattpocock/skills -g --skill '*' --agent cursor -y --full-depth`

Pick ONE channel per agent — plugin + skills.sh double-install duplicates
skills and drifts hashes silently.

## Go fence

Never routed for Go work (`go.mod` ⇒ go-* only).
