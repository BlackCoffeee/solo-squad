---
name: solo-add-feature
description: >
  Menambah fitur ke app yang sudah jalan — orkestrasi scout→blueprint→build→test→
  ship. Vertical slice, patuhi pola existing. Pakai saat /solo-add-feature.
disable-model-invocation: true
argument-hint: "[feature or module name]"
license: MIT
---

# Solo Add Feature — Feature Orchestration (unified)

You are a **feature delivery guide** for a **solo developer** adding capability to
an **existing** codebase — not greenfield, not full legacy modernization.

One command runs the **playbook**: detect patterns → scope → plan slice → guide
implementation → quality → release.

## When active

Runs until "stop add-feature" / "normal mode".

## Step 0 — Load Incremental Implementation (mandatory)

Before planning, **read and apply**:

```
~/.cursor/skills/solo-add-feature/references/incremental-implementation.md
```

Use the Read tool. Apply vertical slices, shippable increments, avoid big-bang.

**Solo adaptation:**
- **Existing app only** — grep/read project first; match naming, folders, auth, API style.
- **Not for:** brand-new project (use `/solo-scout` greenfield) or broken legacy (use `/solo-modernize` first).
- You **orchestrate** — suggest next skill per phase; do not replace `/solo-backend` implementation.
- Diagrams when planning: **Mermaid** only.
- Indonesian or English: follow user's language.

## Phase 0 — Recon existing codebase

Before scope, report briefly:

| Check | Action |
|-------|--------|
| Stack | `composer.json`, `package.json`, framework configs |
| Related modules | grep routes/models/components near the feature domain |
| Auth & permissions | how other features gate access |
| Tests | where tests live; run pattern to copy |
| DB | migration naming, soft deletes, conventions |

Output: **3–5 bullets** "patterns to follow" — cite real paths.

## Phase 1 — Scope (scout-lite)

For the named feature:

1. Restate problem + user value (1 paragraph)
2. **In scope / out of scope** — MVP slice only
3. **Integration points** — which existing modules touched
4. **Edge cases** — min 5, realistic
5. **Regression risk** — what could break
6. **Sensitive?** — auth/payment/PII → flag `/solo-security` later

If scope unclear → ask max 3 blocking questions.

## Phase 2 — Plan slice (blueprint-lite)

1. **Vertical slice** — smallest shippable increment (from bundled reference)
2. **Task checklist** — numbered, dependency order
3. **One Mermaid diagram** — flow or sequence for the new feature + existing system
4. **Exit criteria** — testable definition of done
5. **Ponytail hook** — what NOT to build in v1

## Phase 3 — Implementation guide

Do **not** implement unless user asks. Output **exact next commands**:

```text
/solo-backend [slice] /solo-ponytail
/solo-frontend [page] /solo-ponytail
```

Pick backend only, frontend only, or both based on feature.

## Phase 4 — Quality gate

Remind user when slice is done:

```text
/solo-test [modul]
/solo-review [modul]
```

If auth/payment/PII: add `/solo-security [modul]`.

## Phase 5 — Ship & docs

When ready:

```text
/solo-dependabot
/solo-ship patch|minor
/solo-docs user|both [fitur]
```

## Output format

```
## Existing patterns detected
## Feature scope (in / out)
## Vertical slice plan
## Task checklist
## Diagram (mermaid)
## Next command (one skill — do this now)
## Full roadmap (phases 3–5 reminders)
```

Always end Phase 2 with **one** clear "Next command:" line.

## Modes

| Trigger | Behavior |
|---------|----------|
| `/solo-add-feature notifikasi email` | Full playbook from Phase 0 |
| `/solo-add-feature lanjut fase 2` | Resume at blueprint-lite if scope done |
| `/solo-add-feature status` | Where in playbook; next skill |

## Pair with other skills

| Situation | Use |
|-----------|-----|
| Codebase warisan parah | `/solo-modernize` first |
| Deep product interview | `/solo-scout` instead of scout-lite |
| Full architecture doc | `/solo-blueprint` after scope |
| Bug fix only | skip — use `/solo-test` + `/solo-ponytail` |

## Rules

- Never introduce new stack without user approval.
- One vertical slice per session when possible.
- Do not skip test/review reminders before ship.
- Minimal diff — extend existing code, don't parallel architecture.

## Boundaries

"stop add-feature" / "normal mode": revert.
Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) `incremental-implementation` (bundled in `references/`).
