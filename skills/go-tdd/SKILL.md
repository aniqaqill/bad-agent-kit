---
name: go-tdd
description: Implement an accepted Go spec test-first. Delegates to tdd at pre-agreed seams with a Go sensor gate at every phase exit, and mandatory end-to-end expected-outcome tests. Use when implementing Go changes after go-plan produced an accepted spec.
---

# go-tdd

Explicit-only wrapper. Call the Skill tool with **tdd** at the pre-agreed seams
from the spec. Every phase exit is a Go sensor run — "it compiles" is not
evidence.

## The contract

All rules come from [GO_RULES.md](references/GO_RULES.md) — the single source
shared with go-review. Read it before writing code; never restate rules
locally.

## Fail-fast sensor chain (run at every phase exit)

1. `gofmt -l .` — zero output
2. `go vet ./...` — zero findings (copylocks, atomic, loopclosure, lostcancel)
3. `golangci-lint run` — zero findings (config: assets/.golangci.yml)
4. `govulncheck ./...` — no known vulnerabilities
5. `go test -race ./...` — green; `goleak` on any package that starts goroutines

A missing binary is not a free pass — install it or use the documented
degraded-mode fallback in [toolchain-setup.md](references/toolchain-setup.md).

## End-to-end outcome tests (required)

Beyond unit tests, at least one test exercises the expected end-to-end outcome:
the real binary against the real artifact where feasible. The expected outcome
is an acceptance condition, and acceptance conditions must be tested, not
assumed.

## Perf discipline (pstack)

Optimize only on a pprof-identified hot path. Every perf change ships
`benchstat` before/after (ns/op, B/op, allocs/op). No benchmark, no change.
