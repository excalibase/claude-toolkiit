---
paths:
  - "**/*.go"
  - "**/go.mod"
  - "**/go.sum"
---

# Go Rules

## Style
- `gofmt` + `goimports` mandatory
- Accept interfaces, return structs; interfaces small (1-3 methods)
- Error wrapping: `fmt.Errorf("context: %w", err)` — never ignore errors
- `errors.Is(err, target)` not `err == target`
- Early return over nested `if/else`
- `ctx context.Context` always first parameter
- Functional options for configurable constructors

## Testing (TDD)
- Table-driven tests with `t.Run()`
- Always `go test -race ./...`
- Coverage: 80%+ (`go test -cover`)

## Concurrency
- `context.Context` for cancellation/timeouts
- `defer mu.Unlock()` after `mu.Lock()`
- `sync.WaitGroup` for goroutine coordination
- No package-level mutable variables

## Security
- `os.Getenv()` for secrets — fail at startup if missing
- `gosec ./...` and `govulncheck ./...`
- `context.WithTimeout` on all external calls

## Performance
- `strings.Builder` in loops
- Pre-allocate slices: `make([]T, 0, cap)`
- No N+1 database queries

## Agent: `go-reviewer` — use for all Go code changes
