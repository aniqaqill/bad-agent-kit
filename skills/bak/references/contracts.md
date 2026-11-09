# BAK Phase Contracts

The vocabulary users see is plan / implement / review / mr. The contract
jargon lives here. This file is the **definitive, skills-agnostic interface**:
a suite is routable for a phase iff it satisfies that phase's contract and is
proven present (two-step proof). BAK depends on this interface and nothing
provider-specific.

## When a suite satisfies a phase

A provider suite satisfies a phase contract iff its data-only adapter
(`adapters/<provider>.md`) maps a **namespaced skill** (`provider:skill`, never
bare) to that phase, and that skill (a) accepts the contract's standard
inputs, (b) emits the contract's exit-gate artifact, and (c) runs the
contract's sensors. Skills that do a phase "harder" than the builtin (e.g. a
stricter exit gate) satisfy the same contract; the adapter records the delta,
never a new contract.

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
`pstack:interrogate` is the only provider surface allowed to touch Go work, and
only as an optional adversarial pass layered on top of `go-review` — never as a
replacement. This is a provable manifest property (asserted in
`validate-catalog.js`).

## Degradation lane

An absent optional provider never blocks. The router emits
`Skipped <provider> <capability>: not installed; using <fallback>` and
execution continues with the builtin phase.

## Two-step proof

A provider is live only when it is **pinned** (providers.toml / manifest pin)
AND **resolves on disk** (marker parses, or callable in-session). Cache is
advisory only — re-verify at every session start and on any resolve failure.
pstack connects two ways, both gated by the same proof: **plugin channel**
(canonical) or **manual clone** (recorded, never canonical, no npx).

## Adapters

`adapters/*.md` are read-only reference data mapping each suite's skills to
these contracts. They contain no router logic.
