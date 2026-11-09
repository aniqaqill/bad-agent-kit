# BAK Routing Matrix

Use this matrix as a decision aid, not a reason to invoke every matching skill.
Explicit user skill mentions and current skill trigger rules win. Prefer one
top-level workflow plus only the supporting disciplines it needs.

Routes are per-provider: `mp:*` = mattpocock suite, `pstack:*` = pstack suite,
`builtin` = BAK-owned. A provider route is live only with two-step proof
(pinned in `manifest/providers.toml` AND detected on disk). Absent optional
provider ⇒ builtin fallback, with a one-line skip note.

## Go fence (absolute invariant — evaluated before any route)

`go.mod` present in the active repo ⇒ `$go-plan` / `$go-tdd` / `$go-review`
ONLY. `mp:tdd` and `pstack:tdd` are never routed for Go work. The go-* skills
are self-contained (inline frontier interview / red-green-refactor / two-axis
review); delegation to a provider is conditional (present AND opted in) and
never load-bearing.

## Core SDLC routes (plan → implement → review → mr)

| Intent | mattpocock route | pstack route | builtin fallback |
|---|---|---|---|
| Plan a feature/change (non-Go) | `mp:triage` → `mp:to-spec` → `mp:to-tickets` | `pstack:poteto-mode` | inline frontier interview + spec synthesis |
| Plan a Go feature/change | never routed | never routed | `$go-plan` (fence) |
| Implement accepted spec (non-Go) | `mp:tdd` at agreed seams | `pstack:tdd` | inline red-green-refactor |
| Implement accepted Go spec | never routed | never routed | `$go-tdd` (fence) |
| Review changes (non-Go) | `mp:code-review` | `pstack:interrogate` (adversarial) | builtin two-axis (review-pipeline.md) |
| Review Go changes | never routed | `pstack:interrogate` optional pass | `$go-review` (fence) |
| Babysit an MR/PR | — | — | `$babysit` (builtin, gh+git) |

## Supporting routes

| Intent | Primary route | Supporting route or constraint |
|---|---|---|
| Configure a repo for the mattpocock suite | `$setup-matt-pocock-skills` | Only when the suite is detected present |
| Stress-test a general plan | `mp:grilling` or `$grill-me` | builtin fallback: inline frontier interview |
| Stress-test a plan while building domain docs | `$grill-with-docs` | May use `$domain-modeling` |
| Research primary sources | `mp:research` | builtin: web tools + `$research` |
| Diagnose broken/failing/slow behavior | `mp:diagnosing-bugs` | builtin: diagnosis loop (playbooks/diagnosis.md) |
| Prototype a design question | `mp:prototype` | builtin: throwaway probe |
| Establish terminology / record decisions | `mp:domain-modeling` | builtin: GLOSSARY/ADR updates |

## Fallback rules

1. Use an explicitly named skill even if the matrix suggests another route.
2. Prefer the advertised-and-pinned catalog, but require two-step proof (pin
   AND on-disk) before trusting any route. Disk discovery alone may find
   unavailable, disabled, stale, or malformed skills; verify before use.
3. If two routes overlap, choose the more specific one and use the other only
   for a distinct supporting job.
4. If no skill materially improves the task, proceed directly with ordinary
   reasoning and the relevant tools.
5. Do not use a connector unless it is present and authorized in the current
   session. Do not substitute public web search for private connected data.
