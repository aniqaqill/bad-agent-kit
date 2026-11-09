# Race / concurrency lens (mandatory findings class)

Gate: `go test -race` + `goleak.VerifyNone`. Caveat: -race fires only on
executed paths, so every concurrent path needs a test that exercises it.

Check, in order:
1. Ownership — which goroutine owns each shared datum; is it named in the spec?
2. Separate-before-serializing — could the shared write target be eliminated?
3. Mixed atomic/non-atomic access to one variable (never allowed)
4. Loop-variable capture in goroutines (vet loopclosure)
5. WaitGroup misuse: Add before go, Done via defer (vet, staticcheck SA2)
6. Send-on-closed-channel risk: only the owner closes (race detector)
7. Goroutine leaks: every `go` has a reachable exit via ctx/done (goleak)
8. Mutex copying: non-pointer, non-embedded, all access via owning methods
   (vet copylocks)
9. Channel buffer 0/1 or justified
10. ctx propagation into every goroutine; `defer cancel()` everywhere
