---
name: go-review
description: Review Go changes on two axes — standards (GO_RULES.md, Effective Go, SOLID-Go, security best practices, goperf lenses) and spec. Self-contained two-axis review; optional adversarial pass via pstack:interrogate when detected. Use when reviewing Go changes before merge.
---

# go-review

Self-contained Go review phase — no external suite required. Runs the review
pipeline from [../bak/references/review-pipeline.md](../bak/references/review-pipeline.md)
with the Go standards sources below.

## Inline two-axis review

Run two parallel fresh-context sub-agents, axes reported separately — never
cross-axis reranked:

1. **Standards axis** — GO_RULES.md (`../go-tdd/references/GO_RULES.md`, read
   it; do not restate it) + Effective Go (go.dev/doc/effective_go) + SOLID-Go
   (dave.cheney.net/2016/08/20/solid-go-design) + security best practices
   (go.dev/doc/security/best-practices) + goperf.dev (hot paths only).
2. **Spec axis** — the originating issue/spec: did the change do what was
   asked, nothing more, nothing less.

Phase 0 deterministic sensors (gofmt / vet / golangci-lint / govulncheck /
-race) must be clean BEFORE agent review — never escalate lint to agent review.

## Lenses

`references/lenses/` — perf, race (mandatory findings class, gated on
`go test -race`), security, solid, logging (OPTIONAL — judgment only, never a
gate).

## Optional adversarial pass

If `pstack:interrogate` is detected present AND opted in, run it as phase 3;
keep only findings a run proves. Otherwise record a one-line skip note.

## Rules rot

At review close: any rule in GO_RULES.md whose sensor never ran in this change
gets deleted. A rule with no sensor is advice; a rule whose sensor never fires
is rot.
