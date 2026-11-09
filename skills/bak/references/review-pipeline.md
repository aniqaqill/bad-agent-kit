# Review Pipeline

Five phases. Every phase exit records the SHA it verified; verdicts bind to
SHA/patch-id, never branch names.

## Phase 0 — deterministic sensors (trigger: every change)

Formatter, linter, typecheck, focused tests (Go: gofmt → vet → golangci-lint →
govulncheck → -race). Gate: clean, else fix and rerun. Never escalate
lint/format to agent review — agents review logic, not lint (DangerJS
principle).

## Phase 1 — author-local pre-review (trigger: before push)

Self-review against the merge-base/pinned base; findings ranked P0-P3.
Gate: no open P0/P1 before push.

## Phase 2 — independent two-axis review (trigger: push/PR opened)

Two parallel fresh-context sub-agents:
- **Standards** — repo standards + Fowler smell baseline
- **Spec** — the originating issue/spec

Axes reported separately; no cross-axis reranking. Gate: P0/P1 fixed or
explicitly waived by a human.

## Phase 3 — optional adversarial pass (trigger: P0/P1 clean)

`pstack:interrogate` if registered (multi-model attack; keep only findings a
run proves). Otherwise record a one-line skip note. Never escalates lint.

## Phase 4 — human gate (trigger: all prior phases green)

Approval is a wait; merge only on explicit authority. No phase auto-merges.
