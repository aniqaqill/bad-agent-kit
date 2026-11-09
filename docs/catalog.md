# BAK Catalog of Record

Every row below is a pin (`manifest/upstream-sources.txt`) or a BAK-owned skill
(`local:`). Lockstep with `manifest/upstream-sources.txt` and
`manifest/providers.toml`, CI-enforced — edit all three together.

| Skill | Source | Install | Workflow position |
|---|---|---|---|
| `bak` | this repo | `pi install npm:bad-agent-kit` | router — start of every task |
| `go-plan` | this repo | `pi install npm:bad-agent-kit` | Go plan — frontier interview + spec |
| `go-tdd` | this repo | `pi install npm:bad-agent-kit` | Go implement — sensor gates + e2e |
| `go-review` | this repo | `pi install npm:bad-agent-kit` | Go review — two-axis + lenses |
| `babysit` | this repo | `pi install npm:bad-agent-kit` | MR babysitter — builtin |
| `triage` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill triage --agent cursor -y` | plan intake |
| `to-spec` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill to-spec --agent cursor -y` | plan spec |
| `to-tickets` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill to-tickets --agent cursor -y` | plan tickets |
| `tdd` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill tdd --agent cursor -y` | implement (non-Go) |
| `code-review` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill code-review --agent cursor -y` | review |
| `handoff` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill handoff --agent cursor -y` | mr handoff |
| `grilling` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill grilling --agent cursor -y` | plan stress-test |
| `wayfinder` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill wayfinder --agent cursor -y` | large/uncertain |
| `setup-matt-pocock-skills` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill setup-matt-pocock-skills --agent cursor -y` | suite setup |
| `research` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill research --agent cursor -y` | docs research |
| `codebase-design` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill codebase-design --agent cursor -y` | plan design |
| `diagnosing-bugs` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill diagnosing-bugs --agent cursor -y` | diagnosis |
| `domain-modeling` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill domain-modeling --agent cursor -y` | docs GLOSSARY/ADRs |
| `improve-codebase-architecture` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill improve-codebase-architecture --agent cursor -y` | plan architecture |
| `prototype` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill prototype --agent cursor -y` | plan probes |
| `grill-with-docs` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill grill-with-docs --agent cursor -y` | plan grill |
| `implement` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill implement --agent cursor -y` | implement |
| `implement-spec` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill implement-spec --agent cursor -y` | implement spec |
| `migrate-to-shoehorn` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill migrate-to-shoehorn --agent cursor -y` | implement tests |
| `scaffold-exercises` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill scaffold-exercises --agent cursor -y` | docs scaffolding |
| `grill-me` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill grill-me --agent cursor -y` | plan grill |
| `teach` | [mattpocock/skills](https://github.com/mattpocock/skills) | `npx skills@latest add mattpocock/skills -g --skill teach --agent cursor -y` | docs teach |
| `poteto-mode` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | plan (pstack) |
| `tdd` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | implement (non-Go) |
| `interrogate` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | review adversarial |
| `technical-writing` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | docs writing |
| `unslop` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | docs writing |
| `recall` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | docs freshness |
| `ketchup` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | docs freshness |
| `setup-pstack` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | suite setup |
| `principle-separate-before-serializing-shared-state` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | plan principle |
| `principle-prove-it-works` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | review principle |
| `principle-model-the-domain` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | plan principle |
| `principle-test-behavior-not-implementation` | [cursor/plugins — pstack](https://github.com/cursor/plugins/tree/main/pstack) | `/add-plugin pstack` (plugin channel only) | implement principle |
