# Perf lens (goperf.dev — hot paths only)

Trigger: pprof marks a function hot. Never review perf folklore otherwise.

- Escape analysis: `go build -gcflags=-m=2` — allocations must be claimed, not assumed
- Pooling: `sync.Pool` only for short-lived reusable scratch, verified by escape analysis
- Prealloc: `make([]T, 0, n)` where size is known; `prealloc`, `fieldalignment`
- Interface boxing on hot paths — value vs pointer receivers
- GC pressure: `GOGC` only after `go tool pprof` shows it matters
- Worker pools: bounded concurrency, `errgroup.SetLimit`

Evidence required: `go test -bench -benchmem` + `benchstat` before/after
(ns/op, B/op, allocs/op). No benchmark → finding is labeled `[unverified]`.
