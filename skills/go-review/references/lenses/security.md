# Security lens (go.dev/doc/security/best-practices)

Gate: `govulncheck ./...` clean; gosec zero findings.

- Tainted input validated at trust boundaries; fuzz tests for every
  parser/decoder of untrusted input (`go test -fuzz`)
- `crypto/rand` for anything security-relevant; `math/rand` never
- No secrets in logs, errors, or struct String() methods
- Deadlines on every network I/O (ctx.WithTimeout); no `noctx` HTTP calls
- Resource closure: bodyclose, sqlclosecheck
- Go directive version floor in go.mod (drops unsupported toolchain CVEs)
- Dependency hygiene: `go list -m -u all` reviewed; minimal transitive surface
