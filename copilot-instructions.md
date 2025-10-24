# GitHub Copilot Instructions (Repository)

## Tech Baseline
- Language: **Go 1.25**
- DB: **PostgreSQL 13** (if needed)
- Web: **Echo v4** with proper middlewares.
- DB driver: **pgx (pgxpool)** — do **not** use `database/sql`.
- Config: **caarlos0/env v10** with `.env` loaded via **godotenv** if file exists.
- Logging: **log/slog** with **JSON** handler everywhere (no `fmt.Println`).
- Validation: **go-playground/validator/v10**. Validate request bodies; use `json` and `validate` tags.

## Project Layout
- **Single entrypoint:** `main.go` in the **repo root** (no multiple `cmd/`).
- Keep structure minimal and clear. Prefer small, focused functions. Avoid unnecessary layers.

## Coding Style & Practices
- Idiomatic Go; format with `gofmt`/`goimports`. Group imports: stdlib → third-party → internal.
- Use `context.Context` for all I/O (HTTP handlers, DB, external calls).
- Error handling: wrap with `%w`; return clear, actionable errors (never leak internals to clients).
- Dependency injection over globals: pass `*pgxpool.Pool`, `*slog.Logger`, and validators explicitly.
- Concurrency: prefer channels/WaitGroups; document ownership; protect shared state with mutexes when needed.
- Keep functions ~50 lines or less; refactor when larger.
- Document exported identifiers with GoDoc comments.

## Echo Conventions
- Register middlewares: request ID, recover, secure headers, JSON access logging.
- Handlers:
  - Bind JSON to typed structs with `json` tags.
  - Validate using `validator` before use; on failure return **400** with field-level error details.
  - Responses are JSON only; consistent envelope is acceptable, but keep it minimal.
- Provide `GET /healthz` (liveness) and DB connectivity check (readiness if applicable).

## Database (pgx)
- Use `pgxpool.Pool` with context-aware methods.
- On startup: open pool, ping DB, log server version; warn if not 13.x.
- SQL must be parameterized; prefer prepared statements for hot paths.
- Close pool on shutdown and use time-bounded contexts.

## Configuration
- Load `.env` early with **godotenv** (if present), then parse with **caarlos0/env**.
- All fields must specify `env:"NAME"` plus `,required` or `envDefault`.
- Durations as strings (`"5s"`, `"30s"`) and parsed into `time.Duration`.
- Maintain a **`.env.example`** that mirrors config fields and shows sample values.

## Logging (slog JSON)
- Initialize a JSON slog handler at startup.
- Use appropriate levels (`Info`, `Warn`, `Error`); avoid noisy debug in production.

## Validation & JSON
- Every request/response struct must include `json` tags.
- Validate request bodies with `validate` tags (`required`, length, format).
- Return machine-readable validation errors (field → constraints). Do not expose internal error messages.

## Reliability & Shutdown
- HTTP server with read/write timeouts.
- Graceful shutdown on SIGINT/SIGTERM with a bounded context; drain connections; close DB pool.
- Avoid random sleeps in tests or code; use proper synchronization.

## Tests & Tooling
- Table-driven tests; use `t.Parallel()` when safe.
- Use `testify/require` for clarity.
- Provide minimal integration test for DB connectivity where feasible.

## Security & Compliance
- Secure headers middleware enabled; set CORS only when necessary.
- Never log secrets or full tokens. Redact sensitive fields.
- Use least-privilege DB role for the app.

## When Generating Code
- Produce **fully compilable** Go 1.25 code that is **minimal yet production-ready**.
- Adhere strictly to: Echo + pgxpool + caarlos0/env (explicit tags, no prefix) + godotenv + slog JSON + validator.
- Single `main.go` at repo root; no extra layers or frameworks.
- Include graceful shutdown, health endpoint, config parsing/validation, DB pool setup, structured logging, and a sample validated JSON endpoint.
- Prefer clarity over cleverness; follow best practices and idioms.

## Reviews & Explanations
- When asked to review, identify concrete issues (style, safety, errors, validation, logging, shutdown) and propose succinct fixes before providing revised snippets.
- Justify recommendations with idiomatic Go and minimalism in mind.

## Commit Messages
- Use **Conventional Commits** (`feat:`, `fix:`, `refactor:`, `chore:`).
- Subject ≤ 72 chars, imperative mood; optional body for context.

## Development Loop — Run After Each Change
Copilot should propose or assume the following **exact sequence** for local feedback after edits (short-circuit on failure):

1. **Tidy modules:** `go mod tidy`
2. **Format:** `go fmt ./...`
3. **Imports:** `goimports -w .` (if available)
4. **Static checks:**
   - `go vet ./...`
   - If present, `golangci-lint run` (fast, enable default linters; no long-running extras)
   - Optionally `staticcheck ./...` when configured
5. **Vulnerability scan:** `govulncheck ./...` (if installed)
6. **Unit tests:** `go test -race -count=1 ./...`
7. **Build sanity:** `go build .`
8. **Run app (when requested):** `go run .`
   - Ensure `.env` is loaded (via godotenv in code) and required envs are present.
9. **Before commit:** repeat steps 2–6 and ensure no new warnings.
