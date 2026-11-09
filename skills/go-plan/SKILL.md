---
name: go-plan
description: Plan a Go feature or change. Runs the complete Go frontier interview (goroutine ownership, channel-vs-mutex, leak prevention, error strategy, test seams) and synthesizes an accepted spec — self-contained, no external suite required. Use when planning Go work under your workspace before any Go implementation, or when Go triggers appear (race, goroutine, channel, mutex, deadlock, leak).
---

# go-plan

Self-contained Go plan phase — no external suite required. Optionally, if
`mp:grilling` is detected AND the user opts in, call the Skill tool with
grilling as a harder interview; otherwise run the inline interview below.

## Inline frontier interview

Drive [go-frontier-questions.md](references/go-frontier-questions.md) — the
five frontier questions, whole frontier per round:

1. **Ownership** — which goroutine owns each shared datum; how ownership transfers
2. **Channel vs mutex vs eliminate** — separate-before-serializing first
3. **Leak prevention** — ctx propagation + exit path for every goroutine
4. **Error strategy** — opaque/behavior-asserted; who wraps, who handles
5. **Test seam** — highest public boundary; e2e outcome test planned up front

Human gate is ON for every concurrency-relevant decision; opt-in elsewhere.
Fact-finding runs with fresh-context sub-agents hunting goroutine spawn sites,
channel closers, and -race CI wiring.

## Grill rule (from pstack)

A finding survives only when a run proves it. Every grill question carries the
sensor that would prove its answer. Never hand the human a check you could
run. Every claim in the plan is labeled measured / inferred / guess.

## Spec synthesis

After the interview, synthesize the spec directly (no second interview): name
every shared datum and its owner, pin the seams, list the acceptance
conditions including the e2e expected-outcome test.

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
