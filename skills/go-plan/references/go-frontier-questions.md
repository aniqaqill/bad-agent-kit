# Go Frontier Questions

Drive the grilling interview with these five. Each carries the research-backed
recommended answer and the sensor that proves it.

## 1. Ownership — which goroutine owns this shared value?

**Recommended (Effective Go + Share-by-Communicating codewalk):** transfer of
ownership via channels. A shared value has exactly one goroutine-owner at any
moment: "sending a Resource pointer on a channel passes ownership of the
underlying data from the sender to the receiver." Producer closes its outbound
channel after the last send; consumers range until close.

- After sending a value on a channel, never touch it again.
- Only the goroutine that owns an outbound channel may close it.

**Sensor:** `go test -race` catches unsynchronized send/close; `go vet -copylocks`
catches mutex copying. Ownership itself is a convention — sensors catch its
violations.

## 2. Channel or mutex — or eliminate the sharing entirely?

**Recommended (Go wiki MutexOrChannel + 100 Go Mistakes #57):** parallel
goroutines mutating shared data → mutex; concurrent goroutines coordinating or
transferring ownership → channel. First ask: can we eliminate the shared write
target entirely (pstack: separate-before-serializing-shared-state)? "We need a
lock" is a smell to justify, not a default answer.

- Ownership transfer → channel
- Caches/guarded state → mutex (non-pointer, non-embedded field)
- Read-mostly → `sync.RWMutex`
- Single-word state / copy-on-write → atomic
- Semaphore / rate limit → buffered channel
- Buffer capacity 0 or 1, or a documented justification (Uber)

**Sensor:** `-race` clean for whatever mode is chosen; `go test -timeout` for
coordination hangs.

## 3. Leak prevention — how does every goroutine exit?

**Recommended (go.dev pipelines + context + errgroup):** the caller that starts
work owns its lifetime: `ctx, cancel := ...; defer cancel()`. Every blocking
send/receive wrapped in `select { case ch <- v: case <-ctx.Done(): return }`.
Owner closes channels (`defer close(out)`). Prefer `errgroup.WithContext` over
raw WaitGroup when errors exist; `wg.Add` before `go`, `defer wg.Done()`.
Buffer size 1 for "send one result" channels. Any package that starts
goroutines gets `goleak.VerifyNone` in tests.

**Sensor:** `goleak.VerifyNone` / `VerifyTestMain`; pprof goroutine profile in
production.

## 4. Error strategy — sentinel, wrap, or opaque?

**Recommended (Cheney SOLID-Go + Go 1.13 blog + Google best-practices):**
opaque errors preferred; when callers must branch, assert behavior not type
(`Temporary() bool` probes, `errors.Is` on narrow contracts). `%w` by default
in-app; `%v` at API/system boundaries to hide third-party internals. Handle
once — log XOR return, never both. Libraries return and wrap; only the
top-level handler (main/HTTP) logs or maps to status codes.

**Sensor:** `errcheck`, `errorlint`, `wrapcheck`, `staticcheck` ST1005.

## 5. Test seam — where do tests live?

**Required:** the highest possible package boundary or exported identifier that
lets an implementer build without asking another question. Fixes the TDD
vertical slices. **End-to-end expected-outcome tests are mandatory**: the
expected outcome is an acceptance condition, and acceptance conditions must be
tested — at least one test runs the real binary against the real artifact, not
a mocked approximation.
