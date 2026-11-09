---
name: go-review
description: Review Go changes on two axes — standards (GO_RULES.md, Effective Go, SOLID-Go, security best practices, goperf lenses) and spec. Use when reviewing Go changes before merge.
---

# go-review

Explicit-only wrapper. Call the Skill tool with **code-review** on its two
parallel axes; inject the Go specifics below into both review contexts.

## Standards axis — Go sources

- `../go-tdd/references/GO_RULES.md` — the canonical contract (read it; do not restate it)
- Effective Go — https://go.dev/doc/effective_go
- SOLID Go design — https://dave.cheney.net/2016/08/20/solid-go-design
- Security best practices — https://go.dev/doc/security/best-practices
- Performance — https://goperf.dev (hot paths only)

## Lenses

`references/lenses/` — perf, race, security, solid. Race/concurrency findings
are a mandatory findings class, gated on `go test -race`.

## Rules rot

At review close: any rule in GO_RULES.md whose sensor never ran in this change
gets deleted. A rule with no sensor is advice; a rule whose sensor never fires
is rot.
