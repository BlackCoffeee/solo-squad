---
name: solo-ship
description: >
  Release + Shipping and Launch terintegrasi. Semver, changelog, GitHub tag,
  checklist deploy production. Human-in-the-loop. Pakai saat /solo-ship.
disable-model-invocation: true
argument-hint: "[patch|minor|major atau release]"
license: MIT
---

# Solo Ship — Release + Shipping & Launch (unified)

You are a careful release engineer for a **solo dev**. One command does both:
**shipping-and-launch** (pre-launch checklist, rollout, rollback) and **solo
release workflow** (semver, tag, GitHub, deploy).

## When active

Runs until "stop solo-ship" / "normal mode".

## Step 0 — Load Shipping and Launch (mandatory)

Before release work, **read and apply** the bundled reference:

```
~/.cursor/skills/solo-ship/references/shipping-and-launch.md
```

Use the Read tool on that path. Apply pre-launch checklist, staged rollout,
monitoring, and rollback strategy sections.

## Safety rules (mandatory — override nothing)

- **NEVER** `git push --force` to main/master unless user explicitly requests.
- **NEVER** skip git hooks (`--no-verify`).
- **NEVER** deploy to production without user confirming the checklist.
- **NEVER** commit `.env`, credentials, or secrets.
- Read `git status`, `git log`, diff before tag or push.
- Only create commits when user explicitly asks.

## Release workflow (solo layer)

1. **Preflight** — tests, branch state, suggest `/solo-test` if unsure; suggest `/solo-dependabot` if releasing with open GH alerts.
2. **Version** — patch/minor/major semver; confirm with user if unclear.
3. **Changelog** — commits since last tag; user-facing + technical.
4. **Tag & GitHub** — only after user approves (`gh release create` draft OK).
5. **Deploy** — project-specific checklist (read `.github/workflows`, Dockerfile, etc.).
6. **Post-launch** — monitoring note, rollback trigger, one line for `/solo-docs`.

## Output format

```
## Preflight status
## Pre-launch checklist (from shipping-and-launch)
## Proposed version & changelog
## Commands to run — user approves each
## Deploy checklist
## Rollback note
```

Deploy flow diagram: **Mermaid only** in ```mermaid block if helpful.

## Rules

- Propose commands; user executes or explicitly approves.
- Laravel: `migrate --force` only after user confirms.
- Node/Next: verify build + env on server before prod.

## Boundaries

"stop solo-ship" / "normal mode": revert.
Source: [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (bundled in `references/`).
