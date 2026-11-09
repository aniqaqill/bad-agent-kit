# GO_RULES.md — the canonical Go contract

One line per rule + its `[sensor]`. Tiered: HARD gates block; REVIEW lenses are
judgment; EVIDENCE gates apply to hot paths only. go-tdd and go-review both read
this file — never restate rules locally, and delete any rule whose sensor never
runs (rules rot).

## HARD — failing blocks the phase exit

1. `gofmt -l` and `goimports -l` print nothing — machine formatting is the standard. `[gofmt -l]`
2. `go vet ./...` is clean — copylocks, atomic, loopclosure, lostcancel. `[go vet]`
3. `golangci-lint run` is clean with assets/.golangci.yml. `[golangci-lint]`
4. `govulncheck ./...` finds no known vulnerabilities. `[govulncheck]`
5. `go test -race ./...` is green; `goleak.VerifyNone` in every package that starts goroutines. `[go test -race, goleak]`
6. Every exported declaration has a doc comment beginning with its name. `[revive exported-comments]`
7. Errors handled: no unchecked returns, no `==`/string matching — `errors.Is`/`errors.As` only. `[errcheck, errorlint]`
8. `%w` for in-app wrapping, `%v` only at API/system boundaries; error strings lowercase, no trailing punctuation. `[wrapcheck, staticcheck ST1005]`
9. `context.Context` is the explicit first parameter; never stored in a struct or global; `defer cancel()` for every derived context. `[go vet lostcancel, containedctx]`
10. Every `go` statement has a reachable exit: blocking ops sit in `select { ... case <-ctx.Done(): return }`. `[goleak, review]`
11. `wg.Add` before `go`, `defer wg.Done()`; prefer `errgroup.WithContext` when errors exist. `[go vet, go test -race]`
12. Channel senders close their channel (`defer close(out)`); receivers never close it; buffer capacity 0 or 1 unless justified. `[go test -race, review]`
13. Mutex as a non-pointer, non-embedded field; all access through the owning struct's methods. `[go vet -copylocks]`
14. `crypto/rand`, never `math/rand` for anything security-relevant; no secrets in logs/errors; deadlines on every network I/O. `[gosec]`
15. Fuzz tests exist for every parser/decoder of untrusted input. `[go test -fuzz]`
16. At least one end-to-end expected-outcome test: the real binary against the real artifact. `[go test ./... e2e]`

## REVIEW — judgment lenses, no direct sensor

17. SOLID-Go by name: rigidity, fragility, immobility, complexity, verbosity — call them out with the specific violation. `[review]`
18. Model the domain: sealed-interface state machines over scattered booleans. `[review]`
19. One package = one responsibility; no `common`/`utils` catch-alls. `[gocyclo, funlen, review]`
20. Consumer-defined narrow interfaces; accept interfaces, return structs (`Save(io.Writer)`, not `Save(*os.File)`). `[revive iface-*, review]`
21. Zero value of every exported type usable without initialization. `[review]`

## EVIDENCE — hot paths only, triggered by pprof

22. Every perf claim ships `benchstat` before/after: ns/op, B/op, allocs/op — never folklore. `[go test -bench -benchmem, benchstat]`
23. Preallocate when size is known (`make([]T, 0, n)`); order struct fields largest-to-smallest. `[prealloc, fieldalignment]`
24. `sync.Pool` only for short-lived reusable scratch; verify stack residency with escape analysis before claiming zero-cost. `[go build -gcflags=-m=2]`

## Upkeep

At review close: delete any rule whose sensor never ran in this change. A rule
with no sensor is advice; a rule whose sensor never fires is rot.
