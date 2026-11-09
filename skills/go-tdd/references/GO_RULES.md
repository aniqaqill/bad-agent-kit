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
25. P1 — bench runs are `-count>=10`; reject deltas with variance >5% or p>0.05. `[benchstat]`
26. P2 — every benchmark anchors its result to a package-level var (a side-effect-free body is dead-code-eliminated); verify with `-gcflags=-S` when ns/op looks implausible. `[go test -gcflags=-S, review]`
27. P3 — never optimize without a correctness test pinning current behavior. `[go test ./...]`
28. P4 — profile one thing at a time; block/mutex profiles only after CPU+alloc bottlenecks are gone. `[review]`
29. P5 — hot paths stream instead of slurp: io.Reader/io.Writer pipelines, io.ReaderFrom/io.WriterTo where io.Copy is hot; never read whole payloads into []byte. `[review, go test -benchmem]`

## Perf anti-folklore (verified against Go >= 1.13; re-check goperf.dev before applying to newer toolchains)

30. P6 — APIs must not force allocations on callers: `Read(buf []byte)` over `Read() ([]byte, error)`; one representation (string OR []byte), no hot-path conversions. `[review]`
31. P7 — do not remove defer for perf without a benchstat-proven win (defer is stack-allocated since 1.13); avoid runtime.SetFinalizer (nondeterministic, GC-hostile); never call cgo in tight loops. `[review, benchstat, grep SetFinalizer]`
32. P8 — go.mod `go` directive uses the latest released Go (version floor). `[go.mod go directive]`

## Goroutine lifecycle (Cheney: never start a goroutine without knowing how it will stop)

33. G1 — every `go` statement names its exit condition: channel close, ctx.Done, WaitGroup, or program lifetime. 'Runs until program exit' is a named exception, never the norm. `[goleak, review]`
34. G2 — channel-draining goroutines (`for range ch`) exit only when ch is closed — the spec names who closes ch and when; never start a drain loop on a channel whose closer is unknown. `[go test -race, review]`
35. G3 — any goroutine exempted from goleak (IgnoreTopFunction) appears in the spec with its stop story. `[goleak ignore list, review]`
36. G4 — unbounded `go` per request/loop iteration is a leak vector; bound concurrency with worker pools, buffered-channel semaphores, or errgroup.SetLimit. `[review, go test -race]`

## TDD contract (agilewarrior lessons learned)

37. T1 — the trigger for a new test is a behavior (use case), never a method; state the behavior before any implementation detail. `[review]`
38. T2 — test through the public API only; refactoring internals must not break tests. `[golangci-lint testpackage, review]` — exception: white-box fuzz of parser internals (rule 15).
39. T3 — work outside-in: start one level below the UI at the domain-model layer; UI automation is not a unit test. `[review]`
40. T4 — red goes green as fast as possible, sins allowed; design only in refactor; no new tests while refactoring. `[review]` — exception: the e2e test pre-dates the refactor it protects (rule 16).
41. T5 — tests depend on contracts/public interfaces, not implementation; behavior-named (given/when/then) tests beat many coupled ones. Coupling is the enemy, not duplication. `[review]`

## API design (Bloch)

42. B1 — when in doubt leave it out: unexport until needed; export only what is usable at zero value. `[revive exported, review]`
43. B2 — easy to use, hard to misuse: typed APIs over stringly data, fail fast at compile time, zero values over sentinel nils, return zero-length slices not nil, don't make the client do what the library could. `[review, revive iface-*]`
44. B3 — every new exported API ships a use-case Example test that compiles in CI before implementation is done. `[go test examples]`
45. B4 — names are the API: consistency, symmetry, reads like prose; if naming is hard the design is wrong. `[revive exported-comments, review]`
46. B5 — keep APIs free of implementation details; minimize mutability (immutable = thread-safe); embed only for true is-a, never to reuse implementation. `[review]`
47. B6 — consistent parameter ordering; avoid long same-type param lists — config structs / functional options. `[revive argument-limit, review]`

## Logging (OPTIONAL — lives in go-review/references/lenses/logging.md, never a gate)

48. L1-L5 — two levels suffice; never log.Fatal/panic in libraries; log once at the boundary; no package-level logger globals; a warning is info or error. `[review, optional]`

## Upkeep

At review close: delete any rule whose sensor never ran in this change. A rule
with no sensor is advice; a rule whose sensor never fires is rot.
