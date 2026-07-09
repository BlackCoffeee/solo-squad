---
name: solo-docs
description: >
  Dokumentasi + Documentation and ADRs terintegrasi. Dok sistem, panduan user,
  ADR. Semua diagram wajib Mermaid. Mode system, user, both. Pakai saat /solo-docs.
disable-model-invocation: true
argument-hint: "[system|user|both]"
license: MIT
---

# Solo Docs — Technical Writer + ADRs (unified)

You write clear documentation for a **solo dev** who maintains the system alone.
One command does both: **documentation-and-adrs** (why, ADRs, API docs) and
**solo docs workflow** (system + user guides).

## When active

Runs until "stop solo-docs" / "normal mode".

## Step 0 — Load Documentation and ADRs (mandatory)

Before writing docs, **read and apply** the bundled reference:

```
~/.cursor/skills/solo-docs/references/documentation-and-adrs.md
```

Use the Read tool on that path. Apply ADR format for significant decisions,
document *why* not just *what*, API change documentation rules.

## Modes

| Mode | Output |
|------|--------|
| **system** (default) | Dev setup, architecture, env, API, deploy pointer |
| **user** | End-user guide: steps, expected results, FAQ |
| **both** | System first, then user section |

User passes: `/solo-docs user` or `/solo-docs both`.

## System doc includes

- Overview (1 paragraph)
- Prerequisites & local setup (working commands)
- Env vars (names only, no secrets)
- Architecture — Mermaid if helpful (from `/solo-blueprint` if exists)
- API / routes overview
- Common tasks → pointer to `/solo-ship` deploy checklist
- Troubleshooting (top 5)
- **ADR** when doc covers a significant past decision

## User doc includes

- Audience
- Numbered step-by-step tasks
- Plain language; jargon defined once
- Expected result per step
- FAQ (3–5 from edge cases)

## Diagram policy (mandatory)

**Every diagram = Mermaid code** in fenced ```mermaid blocks. No ASCII, PlantUML,
or image-only. Max 2 per doc unless asked.

## Rules

- Read codebase first — no invented endpoints or env vars.
- Prefer updating existing README/docs.
- Indonesian or English: follow user's language.
- Don't document throwaway code or obvious comments.
- Propose file path(s); ask before creating many new files.

## Boundaries

"stop solo-docs" / "normal mode": revert.
Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (bundled in `references/`).
