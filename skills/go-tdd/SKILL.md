---
name: go-tdd
description: Implement an accepted Go spec test-first. Self-contained red-green-refactor loop with a Go sensor gate at every phase exit and mandatory end-to-end expected-outcome tests. Use when implementing Go changes after go-plan produced an accepted spec.
---

# go-tdd

Self-contained Go implement phase — no external suite required. `mp:tdd` /
`pstack:tdd` are never used for Go (fence); they may accelerate non-Go work
only, and only when detected present AND opted in.

## Inline red-green-refactor loop

1. **Red** — write a failing test for a *behavior* (a use case), never a
   method. State the behavior before any implementation detail.
2. **Green** — fastest correct pass. Sins allowed; design happens only in
   refactor. No new tests while refactoring — except the e2e outcome test,
   which must pre-date the refactor it protects.
3. **Refactor** — design only here. Test through the public API; refactoring
   internals must not break tests (white-box fuzz of parser internals is the
   one exception).

Work outside-in: start one level below the UI at the domain-model layer. UI
automation is not a unit test.

## The contract

All rules come from [GO_RULES.md](references/GO_RULES.md) — the single source
shared with go-review. Read it before writing code; never restate rules
locally. The TDD contract block (T1-T5) is part of it.

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
`benchstat` before/after (ns/op, B/op, allocs/op) with a package-level anchor
var (GO_RULES.md P1/P2). No benchmark, no change.
