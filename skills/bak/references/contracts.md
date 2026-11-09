# BAK Phase Contracts

The vocabulary users see is plan / implement / review / mr. The contract
jargon lives here. A provider satisfies a contract when its skill delivers the
trigger, accepts the inputs, and meets the exit gate and sensors.

## Contracts

### plan
- **trigger**: a feature, bug, or refactor needs design before code
- **inputs**: user objective, repo state, applicable docs
- **exit gate**: design artifact naming every decision the implement phase
  needs; every shared datum / seam / acceptance condition named and owned
- **sensors**: repo-specific pre-flight (Go: `go list`, `go build`, `go vet`)

### implement
- **trigger**: an accepted plan/spec exists
- **inputs**: plan artifact, pre-agreed seams
- **exit gate**: red-green-refactor complete at the seams; sensor chain clean;
  e2e expected-outcome test passing (real artifact, not mocked)
- **sensors**: deterministic chain, cheapest first (Go: gofmt → vet →
  golangci-lint → govulncheck → -race + goleak)

### review
- **trigger**: a change is candidate for merge
- **inputs**: diff vs merge-base, originating issue/spec, standards sources
- **exit gate**: standards axis + spec axis reported separately; P0/P1 fixed
  or explicitly waived by a human; findings bound to SHA/patch-id
- **sensors**: phase 0 deterministic sensors must be clean BEFORE agent review

### mr
- **trigger**: an open MR/PR under the orchestrator's care
- **inputs**: merge authority mode (check/drive/threads-only/background)
- **exit gate**: terminal state reached (merged / closed / merge-ready /
  retries-exhausted / human-needed)
- **sensors**: CI status, merge-base ancestry, review-thread state

## Namespacing (mandatory)

Provider skills are referenced by namespace — `mp:tdd` vs `pstack:tdd` —
never by bare name. Suites collide (both ship tdd/teach; pstack adds
recall/reflect/correct). Under pi, first-discovered-wins silently shadows the
other; the router must not let discovery order pick the winner.

## Go fence (absolute invariant)

`go.mod` present in the active repo ⇒ `go-plan` / `go-tdd` / `go-review` only.
`mp:tdd` and `pstack:tdd` are never routed for Go work regardless of presence.
This is a provable manifest property (asserted in `validate-catalog.js`).

## Degradation lane

An absent optional provider never blocks. The router emits
`Skipped <provider> <capability>: not installed; using <fallback>` and
execution continues with the builtin phase.

## Two-step proof

A provider is live only when it is **pinned** (providers.toml / manifest pin)
AND **resolves on disk** (marker parses, or callable in-session). Cache is
advisory only — re-verify at every session start and on any resolve failure.

## Adapters

`adapters/*.md` are read-only reference data mapping each suite's skills to
these contracts. They contain no router logic.
