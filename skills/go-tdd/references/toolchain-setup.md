# Toolchain setup & degraded mode

## Install the gate binaries once

```bash
go install github.com/golangci/golangci-lint/v2/cmd/golangci-lint@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install golang.org/x/perf/cmd/benchstat@latest
go install go.uber.org/goleak/cmd/goleak@latest  # or use as a test dependency
go get go.uber.org/goleak                          # test dependency form (preferred)
```

Verify: `golangci-lint version`, `govulncheck -version`.

## Degraded mode (missing binary)

A missing sensor is a degraded phase, not a skipped one:

| Missing | Degraded substitute |
|---|---|
| govulncheck | `golangci-lint run` (gosec linter) + `go list -m -u all` review |
| golangci-lint | `go vet ./...` + `staticcheck ./...` |
| staticcheck | `go vet ./...` (covers copylocks/atomic/loopclosure/lostcancel) |
| benchstat | manual ns/op comparison — but label the claim `[unverified]` |
| goleak | `runtime.NumGoroutine()` before/after assertions in the test |

Note in the handoff which sensors ran degraded and why; the missing binary
becomes the first task of the next session.
