# BAK Glossary

- **BAK** — Batman Agents Kit. The serious public brand: router + marketplace + orchestrator.
- **bad-agent-kid** — the persona. The joke IS the rule: don't be the bad agent kid.
- **bak** — the router skill itself (`skills/bak/SKILL.md`). Formerly `chief`.
- **Catalog of record** — the single source of truth for what's listed; README table today, `catalog/catalog.json` + generator past ~40 entries. Never hand-edit both.
- **Compose, never own** — BAK pins and documents upstream skills; it does not fork or vendor them.
- **Playbook** — a documented chain of skills for one class of real work (e.g. triage → to-spec → to-tickets → tdd → code-review → handoff).
- **Routing matrix** — `skills/bak/references/routing-matrix.md`: trigger → smallest complete route.
- **One channel per agent** — never install the same skill via two channels on one agent (silent hash drift).
- **Privacy-scrub gate** — CI that fails on `$HOME`-literal leaks and personal-infra inventory before publish.
