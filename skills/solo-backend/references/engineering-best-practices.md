---
# ──────────────────────────────────────────────────────────────────
#  AgentSkills.io open standard — agentskills.io/specification
#  Compatible with: Claude Code, Cursor, Windsurf, Copilot,
#                   Kilo Code, OpenCode, Goose, Codex CLI
# ──────────────────────────────────────────────────────────────────
bundled-for: solo-backend
source: https://github.com/skylarng89/engineering-best-practices-skill/SKILL.md
updated: 2026-07-07

# Required ─────────────────────────────────────────────────────────
name: engineering-best-practices-2026
description: >
  Comprehensive 2026 engineering best practices for agentic coding.
  Apply when writing, reviewing, or refactoring code across Node.js,
  Next.js, NestJS, Java, Spring Boot, Python, Elixir, Phoenix,
  Erlang, Rust, Go, React, Vue, Nuxt, Astro, and SQL/NoSQL databases.
  Covers security (OWASP Top 10, zero trust, supply-chain hardening),
  performance (async I/O, caching, connection pooling, N+1 prevention),
  idempotency, atomicity, concurrency, observability (OpenTelemetry,
  structured logging), and accessibility (WCAG 2.2 AA). Includes
  per-stack version baselines, idiomatic patterns, known CVEs and
  gotchas (e.g. Next.js CVE-2025-29927, Valkey 9.1 RC), and
  pre-merge/pre-production checklists. Use for any programming task
  regardless of language or framework.

license: MIT

# Optional ─────────────────────────────────────────────────────────
compatibility: >
  No runtime dependencies. Pure instructional skill.
  Works with any agent that supports the AgentSkills.io 0.2+ spec.
  Tested on Claude Code, Cursor, Windsurf, and Kilo Code.

metadata:
  # Authorship
  author: Patrick Aziken
  author_handle: skylarng89
  author_url: https://github.com/skylarng89
  contact: patrick@upperloftcreations.com
  organization: Upperloft Creations Limited
  organization_url: https://upperloftcreations.com

  # Versioning — follows CalVer: YYYY.MINOR.PATCH
  version: "2026.1.1"
  release_date: "2026-05-20"
  changelog:
    - version: "2026.1.1"
      date: "2026-05-20"
      notes: >
        Initial public release. Covers 16 stacks with 2026 baselines.
        Incorporates Next.js CVE-2025-29927 mitigation, Spring Boot 4 /
        Java 25 virtual threads, Nuxt 4 srcDir layout, Astro 5 islands,
        Valkey 9.0.x pin, and supply-chain attack guidance.

  # Marketplace / discovery
  category: development
  subcategory: best-practices
  tags:
    - nodejs
    - nextjs
    - nestjs
    - java
    - spring-boot
    - python
    - elixir
    - phoenix
    - erlang
    - rust
    - golang
    - react
    - vue
    - nuxt
    - astro
    - sql
    - nosql
    - security
    - performance
    - accessibility
    - idempotency
    - concurrency
    - observability
    - owasp
    - ci-cd
    - best-practices
    - 2026

  # Source & provenance
  repository: https://github.com/clouddaddy/engineering-best-practices-skill
  homepage: https://upperloftcreations.com/skills/engineering-best-practices
  issues: https://github.com/clouddaddy/engineering-best-practices-skill/issues

  # Quality signals
  effort: high # low | medium | high
  maturity: stable # experimental | beta | stable
  last_reviewed: "2026-05-20"
  review_cadence: quarterly
---

# Engineering Best Practices — 2026 Edition

> A comprehensive SKILL.md for LLMs and AI coding agents.  
> Apply these rules when generating, reviewing, or refactoring code across all listed stacks.

---

## Table of Contents

1. [Universal Principles](#universal-principles)
2. [Node.js](#nodejs)
3. [Next.js](#nextjs)
4. [NestJS](#nestjs)
5. [Java](#java)
6. [Spring Boot](#spring-boot)
7. [Python](#python)
8. [Elixir](#elixir)
9. [Phoenix](#phoenix)
10. [Erlang](#erlang)
11. [Rust](#rust)
12. [Go (Golang)](#go-golang)
13. [React](#react)
14. [Vue](#vue)
15. [Nuxt](#nuxt)
16. [Astro](#astro)
17. [SQL / NoSQL](#sql--nosql)

---

## Universal Principles

> These apply to **every** language and framework below. Never violate them.

### Security

- **Zero trust by default.** Authenticate and authorise at every layer — not just at the edge/middleware.
- Validate and sanitise all input at the boundary (schema validation: Zod, Joi, class-validator, Pydantic, etc.).
- Never log sensitive data (passwords, tokens, PII, card numbers).
- Use **TLS 1.3** for all transport. Enforce HTTPS; reject plaintext.
- Store secrets in environment variables or a secrets manager (Vault, AWS Secrets Manager). Never commit them.
- Apply OWASP Top 10 mitigations by default (injection, broken auth, XSS, CSRF, SSRF, etc.).
- Pin dependency versions. Run `audit`/`trivy`/`snyk` in CI on every push.
- Follow principle of least privilege for service accounts, DB roles, and IAM policies.

### Performance

- Profile before optimising. Use APM (OpenTelemetry, Jaeger, Zipkin) and structured metrics.
- Prefer async/non-blocking I/O for I/O-bound work; use worker threads/processes for CPU-bound tasks.
- Cache aggressively at the right layer (CDN → app cache → DB query cache). Invalidate explicitly.
- Use connection pooling for all databases. Tune pool sizes per workload.
- Avoid N+1 queries. Use eager loading / DataLoader / batch fetching.
- Paginate all list endpoints. Never return unbounded result sets.

### Idempotency

- All mutating HTTP endpoints (POST, PUT, PATCH, DELETE) that can be retried **must** be idempotent.
- Use client-supplied or server-generated idempotency keys stored in a deduplication table with TTL.
- Design background jobs and message consumers to be idempotent (at-least-once delivery is the norm).

### Atomicity & Transactions

- Wrap multi-step mutations in database transactions. Commit only on full success; roll back on any error.
- In distributed systems, use the **Saga pattern** (choreography or orchestration) instead of distributed 2PC.
- Apply **optimistic locking** (`version`/`updated_at` columns) for high-contention rows.
- Use **database-level constraints** (UNIQUE, FK, CHECK) as the last line of defence.

### Concurrency

- Avoid shared mutable state. Prefer message-passing, immutable data structures, and actors.
- Use language-native concurrency primitives (goroutines, BEAM processes, virtual threads, async/await).
- Protect shared state with appropriate synchronisation (mutexes, channels, STM, CRDT).
- Design for **backpressure**: bounded queues, circuit breakers, and rate limiting.

### Observability

- Emit structured logs (JSON) with correlation IDs, trace IDs, severity, and timestamps.
- Instrument with OpenTelemetry: traces + metrics + logs unified under one SDK.
- Define SLOs/SLAs; alert on burn rate, not just thresholds.
- Health check endpoints: `/health` (liveness) and `/ready` (readiness) for every service.

### Accessibility (UI)

- Follow WCAG 2.2 AA as the minimum. Target AAA for public-facing products.
- Use semantic HTML elements. Do not abuse `<div>` and `<span>`.
- Every interactive element must be keyboard navigable and focus-visible.
- Provide ARIA roles/labels only when semantic HTML is insufficient.
- Test with screen readers (NVDA, VoiceOver) and automated tools (axe-core, Lighthouse).
- Ensure colour contrast ratio ≥ 4.5:1 for normal text, ≥ 3:1 for large text.

### Error Handling

- Fail fast and loud in development; fail gracefully in production.
- Never swallow errors silently (`catch(e) {}`).
- Return structured error responses: `{ code, message, details?, traceId }`.
- Distinguish between operational errors (client errors, network) and programmer errors (bugs).
- Use typed error hierarchies per language; avoid stringly-typed errors.

### API Design

- REST: follow resource-oriented design; use HTTP verbs semantically; return appropriate status codes.
- Version APIs from day one (`/v1/`). Never break existing clients.
- Document with OpenAPI 3.1 / AsyncAPI. Keep docs co-located with code (generated, not manual).
- GraphQL: enforce query depth and complexity limits. Use DataLoader to batch.
- Rate-limit all public endpoints. Return `429` with `Retry-After`.

### CI/CD

- Fail fast: lint → type-check → unit test → integration test → security scan → build → deploy.
- Enforce branch protection; require passing CI before merge.
- Use semantic versioning (`semver`). Tag releases. Auto-generate changelogs.
- Prefer immutable artefacts (container images tagged with Git SHA). Never use `latest` in production.

---

## Node.js

> Baseline: **Node.js 22 LTS** (Active) or **Node.js 24** (Current). Avoid EOL versions.

### Project Structure

```
src/
  config/        # env validation (zod/envalid)
  routes/        # thin HTTP handlers
  services/      # business logic
  repositories/  # data access
  middleware/
  utils/
  types/
```

### Runtime & Performance

- Use `--enable-source-maps` and `--experimental-vm-modules` where applicable.
- Enable `--max-old-space-size` appropriate to container RAM.
- Use `worker_threads` for CPU-bound tasks; never block the event loop.
- Use `AsyncLocalStorage` for request-scoped context (correlation IDs) — never thread-locals or globals.
- Profile with `clinic.js` (flame, bubbleprof, heap profiler) before optimising.
- Use `pino` for logging (fastest JSON logger); avoid `console.log` in production.

### Security

- Use `helmet` on every Express/Fastify app. Configure CSP explicitly — don't use defaults.
- Apply `cors` with an explicit allowlist; never `origin: '*'` in production.
- Rate-limit with `express-rate-limit` or `@fastify/rate-limit`. Use Redis store in multi-instance deployments.
- Validate all request bodies/params/queries with Zod or Joi **before** they reach business logic.
- Use `argon2` or `bcrypt` for password hashing (never `md5`, `sha1`, `sha256` alone).
- Sanitise HTML output with `DOMPurify` (browser) or `sanitize-html` (server).
- Set `NODE_ENV=production` to disable verbose error leakage.
- Audit dependencies: `npm audit --audit-level=high` in CI; automate with Dependabot or Renovate.
- Avoid `eval()`, `new Function()`, `child_process.exec()` with user input. Use `execFile()` with args array.

### Async & Concurrency

- Prefer `async/await` over callbacks and raw Promises `.then()` chains.
- Always `await` Promises — never fire-and-forget unless error handling is explicit.
- Use `Promise.allSettled()` when partial failure is acceptable; `Promise.all()` when it is not.
- Handle `unhandledRejection` and `uncaughtException` events; log and exit cleanly.
- Use streaming (`stream.pipeline`) for large data; never buffer entire files into memory.

### Module System

- Use ESM (`"type": "module"`) for new projects. Avoid mixing CJS and ESM.
- Import only what you need; avoid `import * from`.
- Use path aliases (`@/` → `src/`) via `tsconfig.json` `paths` + a bundler resolver.

### TypeScript (Strongly Recommended)

- Use `"strict": true` in `tsconfig.json`. No `any` without justification.
- Define explicit return types on all public functions.
- Use `unknown` instead of `any` for external data; narrow with type guards.
- Use `satisfies` operator to validate object shapes without widening types.

### Dependency Management

- Lock to exact versions in CI (`npm ci`).
- Use `.npmrc` to set `save-exact=true`.
- Prefer `pnpm` for monorepos (strict isolation, disk efficiency).
- Remove unused dependencies regularly. Use `depcheck`.

---

## Next.js

> Baseline: **Next.js 15.2.3+** (patches CVE-2025-29927). Use **App Router** for all new projects.

### Architecture

- Prefer **React Server Components (RSC)** by default; add `'use client'` only when you need browser APIs, event handlers, or React state.
- Keep Server Components lean — they run on every request (unless cached). Heavy logic belongs in services.
- Use **Server Actions** for form mutations. Validate with Zod server-side before any DB operation.
- Co-locate route segments: `app/(auth)/login/page.tsx`, `app/api/v1/users/route.ts`.

### Security

- **Never rely solely on Middleware for auth** (CVE-2025-29927 lesson). Re-verify identity in every Route Handler, Server Action, and Data Access Layer (DAL).
- Implement a DAL: a single module responsible for all DB access, where auth checks live.
- Use `HttpOnly; Secure; SameSite=Strict` cookies for sessions. Never store tokens in `localStorage`.
- Set session `maxAge`: 24h for standard users, 15 minutes for admin routes. Rotate session ID on privilege escalation.
- Configure `Content-Security-Policy`, `X-Frame-Options`, `X-Content-Type-Options` via `next.config` headers.
- Never use `dangerouslySetInnerHTML`. If you must, sanitise with `DOMPurify` first.
- Set up SSRF allowlists in `images.remotePatterns` and `fetch` wrappers.
- CSRF: use the built-in Server Action CSRF protection; add explicit token for legacy form routes.

### Performance

- Use `next/image` for all images: it handles lazy-loading, WebP conversion, and size optimisation.
- Use `next/font` for fonts: self-hosted, zero layout shift.
- Leverage **Partial Pre-rendering (PPR)** (Next.js 15): static shell + dynamic holes with Suspense.
- Mark expensive Server Components with `export const dynamic = 'force-dynamic'` only when truly needed.
- Use `unstable_cache` / `revalidateTag` for fine-grained cache invalidation.
- Measure with Lighthouse CI + Core Web Vitals in CI pipeline.
- Keep client bundle minimal: `import dynamic from 'next/dynamic'` for heavy client components.

### Data Fetching

- Fetch in Server Components where possible — no API round trip, direct DB/service access.
- Use React `cache()` to deduplicate requests within a single render pass.
- For client-side data: use React Query / SWR with proper stale-while-revalidate strategies.

### Error Handling

- Implement `error.tsx` at each route segment boundary for isolated error recovery.
- Implement `not-found.tsx` for 404 handling.
- Never expose stack traces or internal paths to the client.

---

## NestJS

> Baseline: **NestJS 11+**, Node.js 22 LTS.

### Architecture

- Follow the **Modular Architecture**: one module per domain (`UserModule`, `AuthModule`, `PaymentModule`).
- Keep Controllers thin: validate input, delegate to Services, return HTTP response.
- Services contain business logic; Repositories/DAOs contain data access.
- Use **DTOs** with `class-validator` + `class-transformer` + global `ValidationPipe` (`{ whitelist: true, forbidNonWhitelisted: true }`).
- Use **Guards** for authentication/authorization; **Interceptors** for cross-cutting (logging, transform); **Filters** for error mapping.

### Security

- Apply `ThrottlerGuard` globally. Override per-route for sensitive endpoints (auth, password reset).
- Use `@nestjs/passport` + `passport-jwt`. Validate JWT on every protected route via `JwtAuthGuard`.
- Never store sensitive config in code. Use `@nestjs/config` with Joi schema validation of env vars.
- Apply Helmet via `app.use(helmet())` in `main.ts`.
- Enable CORS explicitly: `app.enableCors({ origin: allowlist, credentials: true })`.
- Use `casl` or a custom RBAC Guard for fine-grained permission checks beyond simple role checks.

### Performance

- Use **Fastify adapter** (`@nestjs/platform-fastify`) over Express in high-throughput scenarios.
- Apply response serialisation with `ClassSerializerInterceptor` + `Exclude()` to prevent data leakage.
- Use `CacheInterceptor` with Redis for expensive read-heavy endpoints.
- Use NestJS queues (`@nestjs/bull` or `@nestjs/bullmq`) for async background processing.
- Use `async` on all service/repository methods. Never use synchronous file I/O.

### Testing

- Unit test Services and Guards in isolation with Jest mocks.
- Integration test Modules with `@nestjs/testing` `Test.createTestingModule()`.
- E2E test with `supertest` against the full application.

---

## Java

> Baseline: **Java 21 LTS** minimum. **Java 25 LTS** for new projects (released Sep 2025).

### Modern Language Features

- Use **Records** for immutable data carriers instead of verbose POJOs.
- Use **Sealed Classes** + **Pattern Matching** (`switch` expressions) for exhaustive type hierarchies.
- Use **Text Blocks** for multi-line strings (SQL, JSON, HTML). Never concatenate SQL strings.
- Use `var` for local type inference where the type is obvious from context.
- Use `Optional<T>` correctly: only as a return type for nullable values, not in fields or parameters.
- Prefer immutable collections: `List.of()`, `Map.of()`, `Set.of()`.

### Concurrency — Virtual Threads (Java 21+)

- Use **Virtual Threads** (`Thread.ofVirtual()`) for I/O-bound work. They are lightweight; millions can exist simultaneously.
- **Do not pool virtual threads** — create a new one per task. `Executors.newVirtualThreadPerTaskExecutor()`.
- Java 24+: virtual threads no longer pin on `synchronized` (JEP 491). Still avoid long `synchronized` blocks.
- Use **Structured Concurrency** (`StructuredTaskScope`, preview in Java 25) to manage lifecycle of forked subtasks.
- Use **Scoped Values** (Java 21+) instead of `ThreadLocal` for context propagation with virtual threads.
- Reserve platform threads and reactive programming for truly CPU-bound workloads.

### Security

- Use `PreparedStatement` or JPA named parameters — never string-concatenate SQL.
- Hash passwords with `bcrypt` or `argon2` (`spring-security-crypto`). Never SHA-\* alone.
- Validate all external input at the boundary with Bean Validation (`@Valid`, `@NotNull`, `@Size`).
- Use `SecurityManager`-equivalent controls: restrict reflection, file access in untrusted code.
- Keep dependencies updated. Use `dependency-check-maven` or Snyk in CI.
- Do not deserialise untrusted data with Java's native deserialisation. Prefer JSON/Protobuf.

### Performance

- Tune GC: prefer **ZGC** or **G1GC** for latency-sensitive services; **Shenandoah** for consistent pause targets.
- Use **Class Data Sharing (CDS)** and **AOT compilation** (Project Leyden) for faster startup.
- Use connection pooling: HikariCP (default in Spring Boot) with tuned `maximumPoolSize`.
- Avoid unnecessary boxing/unboxing. Use primitive streams (`IntStream`, `LongStream`) for bulk numeric ops.
- Profile with async-profiler before optimising.

### Code Quality

- Apply `@Nullable` / `@NonNull` annotations (JSpecify for Spring Boot 4+) consistently.
- Enforce via SpotBugs, Checkstyle, and PMD in CI.
- Write unit tests with JUnit 5 + AssertJ. Use Testcontainers for integration tests.
- Keep cyclomatic complexity low. Extract methods. Prefer composition over inheritance.

---

## Spring Boot

> Baseline: **Spring Boot 4.0** (Spring Framework 7, Java 17 min, Java 25 optimised). Spring Boot 3.5 for projects not yet on SB4.

### Configuration

- Use `application.yml` over `application.properties` for readability.
- Validate configuration with `@ConfigurationProperties` + `@Validated` + Bean Validation annotations.
- Never hardcode credentials. Use Spring Cloud Config, Vault, or environment variables.
- Use **profiles** (`spring.profiles.active`) for environment separation. Never deploy dev configs to production.

### Concurrency & Performance

- Enable virtual threads: `spring.threads.virtual.enabled=true` (Spring Boot 3.3+).
- Use `@Async` with a virtual thread executor for background tasks.
- Use Spring WebFlux (Project Reactor) only when you need **backpressure-aware reactive streams** (e.g., streaming large datasets). For standard CRUD, virtual threads + WebMVC is simpler and equally performant.
- Use Spring Cache (`@Cacheable`, `@CacheEvict`) backed by Redis for expensive read operations.
- Enable HTTP/2 in production (`server.http2.enabled=true`).

### Security (Spring Security 6+)

- Use the `SecurityFilterChain` bean approach. Avoid extending `WebSecurityConfigurerAdapter` (removed in Spring Security 6).
- Apply method-level security with `@PreAuthorize("hasRole('...')")` in service methods — not just at the controller layer.
- Use CSRF protection for browser-facing apps. Disable only for stateless APIs with JWT.
- Configure CORS via `CorsConfigurationSource` bean — not `@CrossOrigin` per-controller.
- Use Spring's `PasswordEncoder` (`BCryptPasswordEncoder` or `Argon2PasswordEncoder`).
- Validate JWT audience (`aud`) and issuer (`iss`) claims. Use short expiry (15–60 minutes) + refresh tokens.

### Data Access

- Use **Spring Data JPA** with QueryDSL or **Criteria API** for dynamic queries.
- Avoid `@Transactional` on public methods of the same class (proxy bypassed). Use self-injection or separate service layer.
- Set `spring.jpa.open-in-view=false`. Lazy loading outside a transaction causes `LazyInitializationException`.
- Use **Testcontainers** with `@SpringBootTest` for integration tests with real databases.
- Manage schema with **Flyway** or **Liquibase**. Never auto-ddl (`spring.jpa.hibernate.ddl-auto=validate` in production).

### Observability

- Include `spring-boot-starter-actuator` + `micrometer-tracing-bridge-otel`.
- Export metrics to Prometheus; traces to Jaeger/Tempo.
- Expose `/actuator/health`, `/actuator/metrics`, `/actuator/prometheus`. Secure all other actuator endpoints.
- Use structured logging with Logback + `logstash-logback-encoder`.

---

## Python

> Baseline: **Python 3.12+**. Use **3.13** for new projects. Enforce types everywhere.

### Project Structure

```
src/
  app/
    api/       # FastAPI routers / Django views
    services/  # business logic
    models/    # ORM models
    schemas/   # Pydantic schemas
    core/      # config, security, db
  tests/
pyproject.toml
```

### Type Safety

- Use type hints on **all** functions and class attributes (`def fn(x: int) -> str`).
- Run `mypy --strict` or `pyright` in CI. Zero type errors before merge.
- Use `TypedDict` for dict structures; `dataclass` or Pydantic models for data carriers.
- Use `Protocol` for structural typing instead of ABCs where appropriate.

### Async & Performance

- Use `asyncio` with `FastAPI` or `Starlette` for async web services.
- Use `async def` for all I/O-bound functions. Do not call blocking functions from async context — use `asyncio.run_in_executor()` or `anyio.to_thread.run_sync()`.
- Use `uvicorn` + `gunicorn` (multiple workers) in production.
- Use `httpx` (async) not `requests` (sync) inside async services.
- Profile with `py-spy` or `austin` for CPU bottlenecks; `memray` for memory.
- Use `__slots__` on high-frequency classes to reduce memory overhead.

### Security

- Validate all input with **Pydantic v2** models (`BaseModel`, `model_validator`). It is both schema validation and parsing.
- Use `passlib` with `argon2` or `bcrypt` for passwords.
- Use `python-jose` or `PyJWT` for JWT handling with explicit algorithm whitelisting (`algorithms=["RS256"]`).
- Parameterise all SQL queries. Never use f-strings for SQL.
- Use `bandit` for static security analysis in CI.
- Pin dependencies in `requirements.txt` or `pyproject.toml`. Use `pip-audit` in CI.
- Avoid `pickle` for untrusted data. Prefer JSON or MessagePack.

### Dependency & Environment Management

- Use `uv` (2024+ standard) for fast dependency resolution and virtual environment management.
- Define all dependencies in `pyproject.toml` with version constraints. Lock with `uv lock`.
- Never install packages globally on production servers; always use a virtual environment.

### Testing

- Use `pytest` with `pytest-asyncio` for async tests.
- Use `hypothesis` for property-based testing on data transformation logic.
- Achieve ≥80% coverage; mandate 100% on security-critical paths.
- Use `factory_boy` or `polyfactory` for test data generation.

---

## Elixir

> Baseline: **Elixir 1.17+**, **OTP 27+**.

### Core Principles

- Embrace the **BEAM actor model**: processes are cheap (300–2700 bytes). Spawn liberally.
- **Let it crash**: write the happy path; use supervisors to recover from failures.
- Prefer **immutable data**. All values are immutable; functions return new values.
- Use **pattern matching** everywhere — function heads, case, with, receive.
- Use **pipelines** (`|>`) for readable data transformations.

### Concurrency & OTP

- Build with **OTP behaviours**: `GenServer`, `GenStateMachine`, `Supervisor`, `DynamicSupervisor`.
- Design supervision trees deliberately: which processes are critical vs. transient.
- Use `Task.async/await` for parallel work with bounded concurrency; `Task.async_stream` with `max_concurrency` for bulk processing.
- Use `Registry` for process discovery; `pg` for distributed process groups.
- Avoid long-running computations in a single process — they block the scheduler. Offload to a worker pool (`poolboy`, `nimble_pool`) or a `Task`.
- Use `GenStage` / `Broadway` for backpressure-aware data pipelines.

### Fault Tolerance

- Supervision strategy: `:one_for_one` for independent workers; `:rest_for_one` for ordered dependencies; `:one_for_all` for tightly coupled groups.
- Set appropriate `max_restarts` and `max_seconds` on supervisors.
- Use `:ets` for in-memory shared state (it survives process crashes); `:persistent_term` for read-heavy global config.

### Performance

- Profile with `:fprof`, `eflambe`, or Erlang's built-in `:erlang.trace`.
- Avoid creating large binaries in hot paths — match on binaries with efficient pattern match, not string concatenation.
- Use `Stream` for lazy evaluation of large collections; `Enum` eagerly evaluates.
- For CPU-bound NIFs, use **Rustler** (Rust NIFs) — safer than C NIFs, no segfault risk.

### Security

- Sanitise all user input before rendering. Use `Phoenix.HTML.safe_to_string` / `html_escape`.
- Use `Argon2` (`argon2_elixir`) for password hashing.
- Store secrets in `config/runtime.exs` reading from environment variables. Never in `config.exs`.
- Use `guardian` or `joken` for JWT with algorithm pinning.
- Validate all external data with `Ecto.Changeset` or `Schematic`.

---

## Phoenix

> Baseline: **Phoenix 1.7+**, Ecto 3.11+.

### Architecture

- Follow the **Context** pattern: group related schemas, changesets, and queries behind a context module (e.g., `Accounts`, `Catalog`).
- Controllers only: parse params, call context, render response. Zero business logic in controllers.
- Use **changesets** for all data validation and transformation — both web and programmatic.
- Separate read and write concerns: query functions return data; command functions return `{:ok, result}` or `{:error, changeset}`.

### Real-Time (Phoenix Channels & LiveView)

- Use **Phoenix LiveView** for interactive UIs without writing custom JS (stateful WebSocket-backed).
- Use **Phoenix Channels** for multiplayer/pubsub patterns not suited to LiveView.
- Scale PubSub across nodes with `Phoenix.PubSub` + Redis or `libcluster` for distributed Erlang.
- Limit LiveView socket assigns to what the template actually renders — don't store large binaries in socket.

### Performance

- Enable HTTP/2 with Cowboy 2.x.
- Use Ecto's `Repo.stream` for large dataset processing (avoids loading all records into memory).
- Use `preload` explicitly; never rely on implicit lazy loading (Ecto has none — you'll get `%Ecto.Association.NotLoaded{}`).
- Cache rendered fragments with `:cache_store` in LiveView or `ConCache`/`Cachex` for data.
- Use `telemetry` events + Prometheus exporter (`prom_ex`) for metrics.

### Security

- Use `Phoenix.Token` for signed, expiring tokens (password reset, email confirm).
- Enable CSRF protection in `Router` (`plug :protect_from_forgery`).
- Set strict CSP, `X-Frame-Options`, and other security headers in `Plug.Conn` plugs.
- Rate-limit with `PlugAttack` or `Hammer`.
- Validate all route params — never pass raw `conn.params` to Ecto functions.
- Use `Ecto.Changeset` to whitelist permitted fields explicitly.

---

## Erlang

> Baseline: **OTP 27+**.

### Core Principles

- Think in **processes**. Each process has its own heap, GC, and mailbox — true isolation.
- Use OTP behaviours (`gen_server`, `gen_statem`, `supervisor`) instead of raw `spawn`.
- Write defensive receives with timeouts to avoid mailbox leaks.
- Use **dialyzer** (static analysis via success typing) in CI — it catches real bugs.
- Use **proper** or **PropEr** for property-based testing.

### Reliability

- Design for **crash isolation**: a crashing process should not cascade. Supervisors restart it.
- Use `:mnesia` for distributed, in-memory, or disk-based storage that needs ACID across nodes.
- Use **releases** (`rebar3 release` or `mix release`) for production deployment — self-contained, no runtime install needed.
- Hot code upgrades: use `appup` files for critical systems that cannot tolerate downtime.

### Performance

- Prefer **binary pattern matching** over string manipulation — binaries are efficient, linked lists of chars are not.
- Avoid large message passing — send references/pids, not large data structures.
- Tune scheduler count to match CPU topology. Use `:erlang.system_info(:schedulers_online)`.
- Use `ets` for lock-free concurrent in-memory data access from multiple processes.

---

## Rust

> Baseline: **Rust 1.80+ (stable)**. Use `rustup` to manage toolchains.

### Ownership & Memory Safety

- Understand the **borrow checker** — it is the correctness guarantee, not an obstacle. Work with it.
- Prefer owned data in structs; borrow in function signatures where possible.
- Use `Arc<T>` for shared ownership across threads; `Rc<T>` only in single-threaded contexts.
- Use `Mutex<T>` / `RwLock<T>` to protect shared mutable state. Prefer message passing (`mpsc`, `tokio::sync::mpsc`) over shared state.
- Avoid `unsafe` blocks. When necessary, isolate them, document invariants, and wrap in a safe abstraction.
- Use `#[must_use]` on functions returning `Result` or `Option`.

### Error Handling

- Use `Result<T, E>` for all fallible operations. Never `.unwrap()` in production code — use `?` operator or explicit handling.
- Define domain-specific error enums. Use `thiserror` for library crates; `anyhow` for application crates.
- Propagate errors with context: `ctx_err.context("while reading config")`.

### Async (Tokio)

- Use **Tokio** as the async runtime for network services. Use `async_std` only for specific use cases.
- Use `tokio::spawn` for independent async tasks. Use `JoinSet` to manage multiple tasks.
- Avoid blocking calls in async context: use `tokio::task::spawn_blocking` for CPU-bound or blocking I/O.
- Use `tower` middleware stack for HTTP services (timeout, retry, load-shed, rate-limit).
- Use `axum` or `actix-web` for HTTP APIs. Both are production-grade.

### Performance

- Zero-cost abstractions: iterators, generics, and traits compile down to efficient code.
- Use `cargo flamegraph` or `perf` for profiling. Use `criterion` for micro-benchmarks.
- Prefer stack allocation. Box only when you need heap or dynamic dispatch.
- Use `bytes::Bytes` for cheap cloning of network buffers (reference-counted).
- Enable LTO (`lto = true`) and `codegen-units = 1` in release profile for maximum optimisation.

### Security

- Use `cargo audit` in CI to check for known CVEs in dependencies.
- Use `cargo deny` to enforce license and duplicate dependency policies.
- Sanitise with `cargo +nightly fuzz` (libFuzzer-based) for parsing code.
- Never construct SQL or shell commands via string formatting.

---

## Go (Golang)

> Baseline: **Go 1.23+** (use the latest stable: **Go 1.24** as of early 2026).

### Project Layout

Follow the [standard Go project layout](https://github.com/golang-standards/project-layout):

```
cmd/          # main packages (one per binary)
internal/     # private packages (not importable externally)
pkg/          # public reusable packages
api/          # OpenAPI/proto definitions
```

- Use `internal/` aggressively to enforce encapsulation.

### Idiomatic Go

- Errors are values. Return `(T, error)`. Check every error explicitly — no exceptions.
- Use `errors.Is()` and `errors.As()` for error inspection. Wrap errors with `fmt.Errorf("ctx: %w", err)`.
- Use `context.Context` as the **first parameter** of every function that does I/O, RPC, or could be cancelled.
- Use the `context` package for deadlines, cancellation, and request-scoped values. Do not use goroutine-local state.
- Prefer small interfaces. The best interface has 1–3 methods. Accept interfaces, return concrete types.
- Use `defer` for resource cleanup (close, unlock). Always `defer resp.Body.Close()`.

### Concurrency

- Goroutines are cheap (~2KB). Spawn per request/task.
- Always pair goroutines with a done channel or `sync.WaitGroup` to avoid goroutine leaks.
- Use channels for communication; `sync.Mutex` for protecting shared state only when channels are awkward.
- Use `errgroup` (`golang.org/x/sync/errgroup`) to manage groups of goroutines with error propagation.
- Detect races: run tests with `go test -race`. Fix all data races — they are undefined behaviour.

### Performance

- Use `pprof` (`net/http/pprof`) for CPU, memory, goroutine, and mutex profiling.
- Use `sync.Pool` to reuse expensive-to-allocate objects (byte buffers).
- Pre-allocate slices and maps with known capacity: `make([]T, 0, n)`, `make(map[K]V, n)`.
- Use `strings.Builder` and `bytes.Buffer` for string/byte accumulation.
- Benchmark with `go test -bench`. Use `benchstat` to compare results.

### Security

- Sanitise all SQL with `database/sql` prepared statements. Use `pgx` or `sqlc` over raw string queries.
- Validate input with `go-playground/validator` or `go-ozzo-validation`.
- Use `crypto/rand` for random values, never `math/rand`.
- Use `golang.org/x/crypto/argon2` or `bcrypt` for passwords.
- Set timeouts on all HTTP clients and servers (`ReadTimeout`, `WriteTimeout`, `IdleTimeout`).
- Run `govulncheck` and `staticcheck` in CI.

---

## React

> Baseline: **React 19**. Use with TypeScript always.

### Component Design

- **Single Responsibility**: one component does one thing. Extract when a component exceeds ~150 lines.
- Prefer **function components** with hooks. No class components.
- Use **composition** over deeply nested prop drilling. Lift state only as high as necessary.
- Use **compound components** and **render props** for flexible, reusable UI primitives.
- Colocate component, styles, and tests in the same directory.

### State Management

- Local UI state: `useState`, `useReducer`.
- Shared/server state: **React Query (TanStack Query)** or **SWR** — not Redux for remote data.
- Global client state: **Zustand** (lightweight) or **Jotai** (atomic) — avoid Redux unless you have complex state machines.
- Use `useTransition` and `useDeferredValue` for non-urgent state updates (keeps UI responsive).

### Performance

- Memoize sparingly and correctly: `useMemo` for expensive computations, `useCallback` for stable function references passed to memoised children, `React.memo` for expensive pure components.
- Use `key` prop correctly on lists — use stable IDs, never array index (causes reconciliation bugs).
- Use `Suspense` + `lazy()` for code splitting. Split at route boundaries at minimum.
- Avoid anonymous function creation in JSX render methods for components that re-render frequently.
- Use `useId()` for stable SSR-safe IDs.
- Profile with React DevTools Profiler before optimising renders.

### Accessibility

- Use `<button>` for actions, `<a>` for navigation. Never make `<div>` clickable.
- All images: `alt` attribute — descriptive for content images, `alt=""` for decorative.
- Manage focus explicitly on modal open/close and route transitions.
- Use `aria-live` regions for dynamic content updates (toasts, status messages).
- Use `useId()` to link `<label>` to form inputs reliably.
- Test with `@testing-library/react` (queries by accessible role/label, not DOM structure).

### Security

- Never use `dangerouslySetInnerHTML` with unsanitised data.
- Do not store auth tokens in `localStorage` — use `HttpOnly` cookies.
- Avoid `eval()` or `new Function()`.
- Validate form data client-side for UX; always re-validate server-side.

---

## Vue

> Baseline: **Vue 3.5+** with **Composition API** and `<script setup>`. TypeScript always.

### Composition API

- Use `<script setup>` for all components. It's terser and has better type inference.
- Organise composables in `src/composables/` — each is a focused, reusable reactive logic unit.
- Use `defineProps<{}>()` and `defineEmits<{}>()` with TypeScript generics for type-safe props/events.
- Use `defineModel()` (Vue 3.4+) for two-way binding composables — replaces manual emit+prop patterns.

### Reactivity

- Use `ref()` for primitives; `reactive()` for objects (but be aware of destructuring losing reactivity).
- Use `computed()` for derived state — it's cached and lazy.
- Use `watchEffect()` for side effects that depend on multiple reactive sources automatically.
- Use `watch()` when you need the old and new value, or lazy/eager control.
- **Never mutate props directly.** Emit events or use `defineModel()`.

### Performance

- Use `v-memo` on repeated templates with stable data.
- Use `shallowRef()` and `shallowReactive()` for large objects where deep reactivity is unnecessary.
- Virtualise long lists: `vue-virtual-scroller` or `tanstack-virtual`.
- Use `defineAsyncComponent()` for lazy-loading heavy components.
- Keep `v-if` and `v-for` on different elements — `v-if` takes priority and breaks `v-for` expectations.

### State Management

- **Pinia** is the official standard. No Vuex for new projects.
- Keep stores focused: one store per domain entity/feature.
- Use `storeToRefs()` to destructure store state without losing reactivity.
- Use store actions for async operations; keep getters pure.

### Accessibility

- Same rules as React accessibility. Vue has no special exemptions.
- Use `v-bind` to spread ARIA attributes dynamically from props when building component libraries.

---

## Nuxt

> Baseline: **Nuxt 4** (or Nuxt 3.15+ stable). Uses Vue 3 and Nitro server engine.

### Project Structure (Nuxt 4 `srcDir: 'app/'`)

```
app/
  components/
  composables/
  layouts/
  middleware/
  pages/
  plugins/
  stores/
server/
  api/
  middleware/
  routes/
  utils/
public/
nuxt.config.ts
```

### Rendering Strategies

- Choose per-route: `definePageMeta({ ssr: false })` for client-only; default is SSR.
- Use `useFetch` / `useAsyncData` in pages for SSR-compatible data fetching with hydration.
- Use `$fetch` directly in server routes and event handlers (no client overhead).
- Avoid mixing client-only code in SSR context. Use `<ClientOnly>` wrapper or `process.client` guard.

### Performance

- Use `nuxt/image` for automatic image optimisation.
- Use `nuxt/fonts` for self-hosted, no-FOIT fonts.
- Enable ISR (Incremental Static Regeneration) with Nitro: `routeRules: { '/blog/**': { isr: 60 } }`.
- Use `useNuxtApp().$router` for programmatic navigation — don't import Vue Router directly.
- Configure `experimental.viewTransition: true` for smooth page transitions.

### Security

- Use Nuxt Security module (`nuxt-security`) for automatic security headers, rate limiting, and CSRF.
- Never expose server-only env vars to the client: use `runtimeConfig.secretKey` (server-only) vs `runtimeConfig.public.apiUrl` (client-safe).
- Validate all `server/api/` inputs with Zod or H3's `getValidatedBody`.
- Use `useCookie` with `httpOnly: true, secure: true, sameSite: 'strict'` for auth cookies.

### Server Routes (Nitro)

- `server/api/` for API endpoints. `server/middleware/` for global server middleware.
- Use `defineEventHandler` with H3 utilities (`readBody`, `getQuery`, `setHeader`).
- Validate input at every handler: `const body = await readValidatedBody(event, schema.parse)`.
- Use Nitro's built-in storage (`useStorage`) for KV, cache, and session backends.

---

## Astro

> Baseline: **Astro 5+**. Content-first, islands architecture.

### Core Principles

- **Zero JS by default.** Ship HTML and CSS. Add JS only with `client:*` directives.
- Use Astro for content-heavy sites (marketing, docs, blogs). Pair with React/Vue/Svelte for interactive islands.
- Server-first: most logic runs at build time or on the server — not the browser.

### Islands Architecture

- Use `client:load` sparingly — only for above-the-fold interactive components.
- Prefer `client:idle` (load after browser is idle) for non-critical UI.
- Use `client:visible` (load when scrolled into view) for below-fold components.
- Use `client:only="react"` for components that must never SSR (e.g., auth-dependent UI).

### Content Collections

- Define schemas with Zod in `src/content/config.ts`. Type-safe content guaranteed.
- Use `getCollection()` and `getEntry()` — never raw `import.meta.glob` for content files.
- Co-locate content images for automatic Astro Image optimisation.

### Performance

- Use `<Image>` from `astro:assets` for all images. Automatic WebP, sizing, lazy-load.
- Prefer static output (`output: 'static'`) for maximum CDN cacheability.
- Use `output: 'server'` or `output: 'hybrid'` only for dynamic routes.
- Enable `experimental.contentLayer` for faster content processing.
- Pre-render API-backed pages with revalidation using Astro server adapters (Vercel, Netlify, Node).

### Security

- Use Astro middleware (`src/middleware.ts`) for auth on server-rendered routes.
- Never expose private env vars in Astro components — use `import.meta.env.SECRET_KEY` only in `server.ts` / `.server.ts` files.
- Set security headers in the server adapter config or a CDN WAF.

---

## SQL / NoSQL

### Universal Database Principles

- **Schema migrations**: always use a versioned migration tool (Flyway, Liquibase, Alembic, Ecto migrations, golang-migrate). Never manual DDL in production.
- All migrations must be **backwards-compatible** when doing zero-downtime deployments (add column before removing old one; expand then contract).
- Use **connection pooling**: PgBouncer (PostgreSQL), ProxySQL (MySQL/MariaDB). Size pools per CPU and service type.
- Set `statement_timeout` and `lock_timeout` on all DB connections to prevent runaway queries from blocking.
- Implement **soft deletes** (`deleted_at TIMESTAMP`) for auditable data. Hard delete is fine for ephemeral data.
- Use **UTC** for all timestamps. Store as `TIMESTAMPTZ` (PostgreSQL) or `DATETIME` with explicit UTC handling.

### PostgreSQL Best Practices

- Use `TIMESTAMPTZ` not `TIMESTAMP`. Use `UUID` for distributed primary keys.
- Define foreign keys. Use `ON DELETE RESTRICT` by default; consider `CASCADE` only intentionally.
- Index foreign key columns. Analyse query plans with `EXPLAIN (ANALYSE, BUFFERS)` regularly.
- Use **partial indexes** for common filtered queries: `CREATE INDEX ON orders (user_id) WHERE status = 'pending'`.
- Use **covering indexes** (`INCLUDE`) to avoid heap fetches on hot read paths.
- Prefer `JSONB` over `JSON` for semi-structured data (indexed, binary-parsed).
- Avoid `SELECT *` in application queries. Always select explicit columns.
- Use `COPY` for bulk imports — 10–100× faster than `INSERT` row-by-row.
- Enable `pg_stat_statements` to identify slow queries. Run `VACUUM ANALYSE` regularly (or ensure autovacuum is tuned).
- Multi-tenancy: use **schema-per-tenant** for moderate tenant counts with strong isolation, or **row-level security (RLS)** for high-scale SaaS.

### MySQL / MariaDB Best Practices

- Use `InnoDB` engine exclusively. Never MyISAM for new tables.
- Use `utf8mb4` charset and `utf8mb4_unicode_ci` collation everywhere.
- Prefer `BIGINT UNSIGNED` for auto-increment PKs. Size matters at scale.
- Set `innodb_buffer_pool_size` to 70–80% of dedicated DB server RAM. Never approach container RAM limit.
- Use `EXPLAIN FORMAT=JSON` for query analysis.
- Avoid stored procedures for complex business logic — keep logic in application code.

### MongoDB Best Practices

- **Schema design first**: model data for your access patterns, not relational normalisation.
- Use **validation rules** (`$jsonSchema`) at the collection level to enforce schema.
- Always create indexes for query predicates and sort fields. Use `explain("executionStats")` to verify.
- Use `writeConcern: { w: "majority" }` for durability. Use `readConcern: "majority"` for strong reads.
- Use **transactions** (multi-document, replica set required) for atomicity across documents.
- Use Atlas or enable replica sets in self-hosted deployments — standalone MongoDB is not production-ready.
- Never embed unbounded arrays in documents. Use referencing when arrays can grow indefinitely.
- Use `$lookup` sparingly — it signals a possible schema design issue. Prefer pre-joined documents for hot read paths.

### Redis / Valkey Best Practices

- Use Redis (or Valkey 7+) as a **cache, session store, and pub/sub broker** — not a primary database.
- Always set `TTL` on cache keys. Never store data without expiry unless intentional.
- Use **Redis Cluster** or Sentinel for production HA. Single-node Redis is not fault-tolerant.
- Use `MULTI/EXEC` transactions or **Lua scripts** for atomic read-modify-write operations.
- Use distinct key namespaces: `{service}:{entity}:{id}` (e.g., `auth:session:uuid`).
- Protect with `requirepass` and TLS in production. Bind to internal network only — never expose Redis publicly.
- Use Valkey `9.0.x` for production (9.1 resolved to RC as of 2025).

### Key-Value & Time-Series

- **DynamoDB**: model with single-table design; define access patterns before choosing keys.
- **Cassandra**: design for write-heavy, time-series workloads; denormalise per query.
- **InfluxDB / TimescaleDB**: use for metrics/telemetry data. Partition by time. Set data retention policies.

### Query & Access Patterns

- Use an **ORM/query builder** for CRUD; raw SQL for complex analytics and performance-critical queries.
- Never generate SQL by string interpolation. Use parameterised queries or ORM abstractions.
- Analyse and optimise slow queries with `EXPLAIN ANALYSE`. Add indexes after profiling — don't pre-optimise.
- Apply **database-level column encryption** (`pgcrypto`, MongoDB FLE, MySQL AES functions) for PII and financial data at rest.

---

## Cross-Cutting Checklists

### Pre-Merge Checklist (Every PR)

- [ ] Input validation at all entry points
- [ ] No secrets in code or logs
- [ ] Errors handled and returned with structure (never swallowed)
- [ ] Unit tests for business logic, integration tests for DB/external calls
- [ ] No N+1 queries introduced
- [ ] New endpoints documented (OpenAPI/AsyncAPI)
- [ ] Accessibility: semantic HTML, ARIA, keyboard nav checked for UI changes
- [ ] `npm audit` / `cargo audit` / `pip-audit` clean
- [ ] Database migrations backwards-compatible
- [ ] No hardcoded config values (use env vars)

### Pre-Production Checklist

- [ ] TLS 1.3 enforced on all endpoints
- [ ] Rate limiting on all public-facing endpoints
- [ ] Health and readiness endpoints returning correct status
- [ ] Structured logging with correlation IDs flowing through all services
- [ ] Metrics exported (Prometheus/OpenTelemetry)
- [ ] Alerts defined on SLO burn rate
- [ ] Secrets rotated from dev/staging values
- [ ] Database connection pooling configured and sized
- [ ] Backup and restore procedure tested
- [ ] Runbook for each service documented

---

## License

```
MIT License

Copyright (c) 2026 Patrick Aziken / Upperloft Creations Limited

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

---

_Version 2026.1.0 — Released May 2026 by [Upperloft Creations Limited](https://upperloftcreations.com).  
Review quarterly; open issues at https://github.com/skylarng89/engineering-best-practices-skill/issues_
