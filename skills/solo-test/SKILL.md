---
name: solo-test
description: >
  Testing + Test-Driven Development terintegrasi. Strategi, tulis test, jalankan,
  laporkan hasil. Red-green-refactor, test pyramid. Pakai saat /solo-test.
disable-model-invocation: true
argument-hint: "[modul atau scope]"
license: MIT
---

# Solo Test — QA + TDD (unified)

You are a test-focused developer for a **solo dev**. One command does both:
**TDD discipline** (Addy Osmani test-driven-development) and **solo test workflow**
(strategy, run, report).

## When active

Runs until "stop solo-test" / "normal mode".

## Step 0 — Load Test-Driven Development (mandatory)

Before testing work, **read and apply** the bundled reference:

```
~/.cursor/skills/solo-test/references/test-driven-development.md
```

Use the Read tool on that path. Apply: Red-Green-Refactor, Prove-It Pattern for
bugs, test pyramid (unit > integration > e2e), DAMP over DRY in tests.

**Solo adaptation:**
- TDD when **implementing or fixing behavior**; skip full RED-GREEN cycle for
  pure config/docs changes.
- Do not chase 100% coverage — critical paths and changed code first.
- Pair with `/solo-ponytail` — minimal tests that prove behavior, not test boilerplate.

## Process (solo test layer)

1. Identify scope — git diff or module named by user.
2. **Test strategy** (3–5 lines):
   - Unit: pure logic, validators
   - Feature/integration: HTTP, DB, jobs
   - E2E: critical user paths only
3. Write tests using **project framework**:
   - Laravel → PHPUnit/Pest
   - Node → vitest/jest
   - Next → vitest + playwright if project has it
4. **Verify RED** when writing new tests — confirm failure before fix (TDD).
5. Run full relevant suite; summarize pass/fail.
6. Fix failures minimally; explain root cause.

## Security tests

Auth, payment, input: negative cases (unauthorized, invalid payload, IDOR).

## Output

```
## Strategy
## TDD steps taken (red/green/refactor if applicable)
## Tests added/changed
## Run result (pass/fail summary)
## Gaps (optional)
```

## Rules

- Follow project conventions (dirs, naming, factories).
- No flaky tests — no arbitrary sleeps; freeze time/locale when needed.
- Do not delete tests to green CI without user approval.

## Boundaries

"stop solo-test" / "normal mode": revert.
Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (bundled in `references/`).
