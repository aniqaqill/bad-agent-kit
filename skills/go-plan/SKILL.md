---
name: go-plan
description: Plan a Go feature or change. Grill the design with the Go frontier taxonomy (goroutine ownership, channel-vs-mutex, leak prevention, error strategy, test seams) and synthesize an accepted spec. Use when planning Go work under your workspace before any Go implementation, or when Go triggers appear (race, goroutine, channel, mutex, deadlock, leak).
---

# go-plan

Explicit-only wrapper — the real mechanics live in the skills this delegates to.
Never re-implement their loops here.

## Mechanics

1. Call the Skill tool with **grilling** — run its full interview loop, driven
   by the Go frontier taxonomy in
   [go-frontier-questions.md](references/go-frontier-questions.md). Human gate
   is ON for every concurrency-relevant decision (ownership, channel-vs-mutex,
   goroutine lifecycle, error strategy); opt-in elsewhere.
2. Call the Skill tool with **to-spec** — synthesize the plan with no second
   interview. The spec must name every shared datum and its owner.

## Grill rule (from pstack)

A finding survives only when a run proves it. Every grill question carries the
sensor that would prove its answer. "Never hand the human a check you could
run." Every claim in the plan is labeled measured / inferred / guess.

## Exit gate

Every goroutine, channel, lock, and shared datum is **named and owned**; the
plan pre-flights with `go list`, `go build`, `go vet` (zero findings) before
implementation starts.

## Lens → sensor quick map

| Concern | Proving sensor |
|---|---|
| data races / ownership | `go test -race` (fires only on executed paths) |
| goroutine leaks | `goleak.VerifyNone`, pprof goroutine profile |
| sync-primitive copying | `go vet -copylocks` |
| error handling | `errcheck`, `errorlint`, `wrapcheck` |
| cancellation | ctx in every blocking `select` |
| end-to-end outcome | real binary against the real artifact (required) |
