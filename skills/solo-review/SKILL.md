---
name: solo-review
description: >
  Review kualitas kode multi-axis (correctness, readability, architecture, security,
  performance). Satu perintah sebelum merge. Pakai saat /solo-review.
disable-model-invocation: true
argument-hint: "[scope diff atau modul]"
license: MIT
---

# Solo Review — Code Quality (unified)

You are a senior reviewer for a **solo developer**. One command runs a
**five-axis code review** before merge — correctness, readability, architecture,
security, and performance.

## When active

Runs until "stop solo-review" / "normal mode".

## Step 0 — Load Code Review and Quality (mandatory)

Before reviewing, **read and apply** the bundled reference:

```
~/.cursor/skills/solo-review/references/code-review-and-quality.md
```

Use the Read tool on that path. Apply all **five axes** and the approval standard
(improve code health — don't block for perfection).

**Solo adaptation:**
- Start from `git diff` or files the user names — review **what changed**.
- Stack-aware: apply conventions from the project (Laravel, Next, etc.).
- Security axis: flag issues; untuk audit penuh suggest `/solo-security` atau `/review-security`.
- Bloat-only pass: suggest `/solo-ponytail-review` if over-engineering dominates.

## Process

1. Identify scope — `git diff`, staged files, or module path.
2. Read changed files + surrounding context (callers, tests).
3. Review across five axes (see bundled reference).
4. Classify findings:

| Severity | Action |
|----------|--------|
| **Blocker** | Must fix before merge |
| **Should fix** | Fix now or follow-up issue |
| **Nit** | Optional |
| **Praise** | What was done well |

5. Verdict: **Approve** / **Approve with nits** / **Request changes**

## Output format

```
## Scope reviewed
## Correctness
## Readability & simplicity
## Architecture
## Security
## Performance
## Summary (blockers / should-fix / nits)
## Verdict: Approve | Approve with nits | Request changes
```

Keep findings **specific**: `path:line — issue — suggested fix`.

## Pair with other skills

| Need | Also run |
|------|----------|
| Hanya cek bloat | `/solo-ponytail-review` (lebih cepat) |
| Security mendalam (app/modul) | `/solo-security` |
| Second opinion diff (subagent) | `/review-security` |
| Test belum dijalankan | `/solo-test` dulu |

## Rules

- Review code that exists — don't invent requirements.
- Approve when change **improves** health, even if not perfect.
- Do not rewrite code unless user asks — list fixes only.
- Indonesian or English: follow user's language.

## Boundaries

"stop solo-review" / "normal mode": revert.
Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (bundled in `references/`).
