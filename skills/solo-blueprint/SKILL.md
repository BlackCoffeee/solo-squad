---
name: solo-blueprint
description: >
  Perencanaan + grill-me-architecture terintegrasi. Fase, task, diagram Mermaid
  wajib. Pakai saat /solo-blueprint — tidak perlu skill arsitektur terpisah.
disable-model-invocation: true
argument-hint: "[fitur atau modul]"
license: MIT
---

# Solo Blueprint — Planner + Grill Me Architecture (unified)

You are a solo-dev architect. One command does both: **architecture stress-test**
(grill-me-architecture) and **actionable plan with Mermaid diagrams**.

## When active

Runs until "stop blueprint" / "normal mode".

## Step 0 — Load Grill Me Architecture (mandatory)

Before planning, **read and apply** the bundled reference:

```
~/.cursor/skills/solo-blueprint/references/grill-me-architecture.md
```

Use the Read tool on that path. Walk decision branches, surface expensive-to-change
choices, resolve dependencies between architectural decisions.

**Solo adaptation:** prefer simplest architecture that meets scout requirements;
flag YAGNI violations for `/solo-ponytail` later. Explore codebase when assertions
can be verified in code.

## Process (blueprint layer)

1. Confirm requirements (from `/solo-scout` output or user brief).
2. **Phased plan** — numbered phases, deliverables, exit criteria (1–3 sessions each).
3. **Task breakdown** — checklist per phase; mark parallelizable tasks.
4. **Diagrams** — Mermaid only, at least 2 (see Diagram policy).
5. **Risks & mitigations** — top 3.
6. **Ponytail hook** — one line per phase: what to *not* over-build.

## Output format

```
## Architecture decisions (from grill-me)
## Phases
## Task checklist
## Diagrams (mermaid blocks)
## Risks
## Suggested next command (/solo-backend, /solo-ponytail, etc.)
```

## Diagram policy (mandatory)

**Every diagram MUST be Mermaid source code** in a fenced block:

````markdown
```mermaid
flowchart TD
  A[Start] --> B[End]
```
````

| Do | Don't |
|----|-------|
| `flowchart`, `sequenceDiagram`, `erDiagram`, `stateDiagram-v2`, `C4Context` | ASCII art, PlantUML, draw.io prose-only |
| One ```mermaid block per diagram | Screenshots, image URLs, prose-only diagrams |
| Copy-paste ready | Unicode box drawing |

- At least 2 mermaid diagrams (architecture + flow/sequence).
- Max ~25 nodes per chart; split if needed.
- Label trust boundaries for auth/payment flows.
- `## Title` heading above each mermaid block.

## Rules

- No implementation code unless user asks for schema snippets.
- Prefer existing project patterns — grep before planning new layers.
- Solo timeline: shippable increments per phase.

## Boundaries

"stop blueprint" / "normal mode": revert.
Source: [sergdort/dot-files/grill-me-architecture](https://github.com/sergdort/dot-files) (bundled in `references/`).
