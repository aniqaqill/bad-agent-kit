# BAK Glossary

- **BAK** — Bad-Agent Kit. The acronym is the joke: the router + marketplace + orchestrator that keeps you from shipping one.
- **bad-agent-kit** — the package/repo name; BAK for short. 🦇 batman is theming only.
- **bak** — the router skill itself (`skills/bak/SKILL.md`). Pure dispatch.
- **Provider** — an optional pinned suite of skills: mattpocock/skills, pstack. Runs only with two-step proof.
- **Adapter** — a data-only file (`adapters/*.md`) mapping a provider's skills to BAK phase contracts. No router logic.
- **Contract** — a workflow phase interface: trigger, inputs, exit gate, sensors. The four: plan / implement / review / mr.
- **Go fence** — absolute routing invariant: `go.mod` ⇒ go-plan/go-tdd/go-review only; providers never serve the Go lane.
- **Degradation lane** — absent optional provider ⇒ builtin fallback + one-line skip note. Never a quality cliff.
- **Two-step proof** — a provider is live only when pinned (providers.toml) AND resolved on disk.
- **Canonical path / dedupe** — one install root per provider wins; other copies are shadow copies, never double-routed.
- **Catalog of record** — `docs/catalog.md` ↔ `manifest/upstream-sources.txt` ↔ `providers.toml`; CI-enforced lockstep.
- **Review pipeline** — five phases: deterministic sensors → author pre-review → two-axis review → optional adversarial → human gate; SHA-bound exits.
- **MR babysitter** — the `babysit` skill: conflicts → threads → CI order, flake/retry/stale-base classification, terminal states.
- **Playbook** — a documented chain of skills for one class of real work, with provider route + builtin fallback per step.
- **Routing matrix** — `skills/bak/references/routing-matrix.md`: intent → per-provider route → builtin fallback.
- **Rules rot** — a rule whose sensor never fires gets deleted at review close.
