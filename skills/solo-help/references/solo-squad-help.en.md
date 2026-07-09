# Solo Squad — Command Reference (Help)

Quick guide to all commands. Full docs: `docs/en/SOLO-SQUAD.md` in the solo-squad repo.

---

## Meta

| Command | Use for |
|---------|---------|
| `/solo-help` | Show this command list |
| `/solo-help [category]` | Filter: `plan`, `build`, `quality`, `release`, `solo-ponytail`, `security` |
| `/solo-help [skill-name]` | Detail one skill, e.g. `scout`, `dependabot` |
| `/solo-status` | Check which skills are **still active** in this chat |

**Stop skill:** `normal mode` or `stop [name]` · **Two skills at once:** `/solo-backend /solo-ponytail`

---

## Phase 0 — Legacy

| Command | Use for |
|---------|---------|
| `/solo-modernize` | Audit legacy app: stack, EOL dependencies, risks, migration strategy (strangler/incremental) |
| `/solo-modernize [goal]` | e.g. `upgrade Laravel 8 to 12`, `monolith to Inertia` |

**When:** Legacy app before scout/rewrite. **Next:** `/solo-scout` one phase at a time.

---

## Planning

| Command | Use for |
|---------|---------|
| `/solo-scout` | Problem analysis, assumption interview, scope in/out, edge cases, stack recommendations |
| `/solo-scout [feature]` | e.g. `campus booking system`, `phase 1 auth module` |
| `/solo-add-feature` | Add feature to **existing app** — orchestrates scope→slice→next skill |
| `/solo-add-feature [feature]` | e.g. `PDF export`, `WhatsApp booking notification` |
| `/solo-blueprint` | Phase plan, task checklist, **Mermaid** diagrams required |
| `/solo-blueprint [module]` | e.g. `booking module`, `auth strangler migration` |

**When:** New idea/feature (scout) · feature on existing app (add-feature) · migration phase (blueprint).

---

## Implementation

| Command | Use for |
|---------|---------|
| `/solo-backend` | Backend: Laravel/API, migrations, models, auth, validation, OWASP |
| `/solo-backend [module]` | e.g. `PDF export API`, `payment webhook` |
| `/solo-frontend` | Frontend: pages, components, API wiring, Taste Skill (anti-slop UI) |
| `/solo-frontend [page]` | e.g. `admin dashboard`, `landing page` |
| `/solo-backend /solo-ponytail` | Minimal backend — anti over-engineering |
| `/solo-frontend /solo-ponytail` | Minimal frontend |

**When:** After blueprint. Stack auto-detected from project.

---

## Ponytail — don't over-build

| Command | Use for |
|---------|---------|
| `/solo-ponytail` | Lazy senior dev: YAGNI, stdlib first, simplest working solution while **coding** |
| `/solo-ponytail lite` | Slightly looser Ponytail |
| `/solo-ponytail-ultra` | Extreme: challenge requirements, delete before adding, one-liners |
| `/solo-ponytail-review` | Review diff for **bloat** only — what can be removed/simplified |
| `/solo-ponytail-status` | Check if Ponytail is **active in this chat** — answer: `YES` or `NO` |

**When:** During implementation (`/solo-ponytail`) or simplification check (`/solo-ponytail-review`). **Stop:** `stop solo-ponytail`.

---

## Quality & security

| Command | Use for |
|---------|---------|
| `/solo-test` | Test strategy, TDD red-green-refactor, run suite, report |
| `/solo-test [scope]` | e.g. `auth module`, `checkout regression` |
| `/solo-review` | 5-axis review before merge: correctness, readability, architecture, security, performance |
| `/solo-review [scope]` | e.g. `git diff`, `booking module` |
| `/solo-security` | Security audit: STRIDE threat model, OWASP, existing app |
| `/solo-security audit full-app` | Full application audit |
| `/solo-security [module]` | e.g. `auth module`, `payment` |
| `/solo-pentest` | Web pentest on staging/localhost — OWASP WSTG, runtime verification |
| `/solo-pentest staging [URL]` | e.g. `staging https://staging.app.com auth module` |
| `/solo-pentest localhost:8000` | Localhost pentest |
| `/solo-dependabot` | GitHub Dependabot alerts + triage + cross-check npm/composer audit |
| `/solo-dependabot critical` | Critical + high only |
| `/solo-dependabot owner/repo` | Specific GitHub repo |
| `/review-security` | **Cursor subagent** — security second opinion on diff (not a Solo skill) |

**When:** Before merge (`review`), existing app (`security` → `pentest` staging), before deploy (`dependabot`).

**Dependabot:** Needs `gh` + `gh auth login` (or `GH_TOKEN`). Install: macOS `brew install gh` · Linux [cli.github.com](https://cli.github.com/) · Windows `winget install GitHub.cli`.

---

## Release & documentation

| Command | Use for |
|---------|---------|
| `/solo-ship` | Release: semver, changelog, GitHub tag, deploy checklist, rollback |
| `/solo-ship patch` | Patch release |
| `/solo-ship minor` | Minor release |
| `/solo-docs` | Developer documentation (default) |
| `/solo-docs system` | Dev setup, architecture, API, env |
| `/solo-docs user` | End-user guide |
| `/solo-docs both` | System + user |
| `/solo-docs ADR [topic]` | Architecture Decision Record |

**When:** After test + review. Ship requires your confirmation for production deploy.

---

## Short workflows

```text
Legacy:     modernize → scout → blueprint → build+solo-ponytail → test → review → dependabot → ship → docs
Greenfield: scout → blueprint → build+solo-ponytail → test → review → dependabot → ship → docs
Add feature: add-feature → build+solo-ponytail → test → review → dependabot → ship → docs
App audit:  security → pentest staging → test → dependabot → ship
Hotfix:     test → solo-ponytail fix → test → review → ship patch
```

---

## Stop commands

| Type | Turns off |
|------|-----------|
| `stop scout` | `/solo-scout` |
| `stop add-feature` | `/solo-add-feature` |
| `stop blueprint` | `/solo-blueprint` |
| `stop modernize` | `/solo-modernize` |
| `stop solo-backend` | `/solo-backend` |
| `stop solo-frontend` | `/solo-frontend` |
| `stop solo-test` | `/solo-test` |
| `stop solo-review` | `/solo-review` |
| `stop solo-security` | `/solo-security` |
| `stop solo-pentest` | `/solo-pentest` |
| `stop solo-dependabot` | `/solo-dependabot` |
| `stop solo-ship` | `/solo-ship` |
| `stop solo-docs` | `/solo-docs` |
| `stop solo-ponytail` | Ponytail |
| `normal mode` | All persona skills |

---

## Quick situations

| I want to… | Command |
|------------|---------|
| See all commands | `/solo-help` |
| Check active skills | `/solo-status` |
| Check existing app | `/solo-security audit full-app` |
| Pentest staging | `/solo-pentest staging [URL]` |
| Check Dependabot CVEs | `/solo-dependabot` |
| New feature from scratch | `/solo-scout` |
| New feature on existing app | `/solo-add-feature` |
| Review before merge | `/solo-test` then `/solo-review` |
| Code without bloat | `/solo-ponytail` or `/solo-backend /solo-ponytail` |
| Safe deploy | `/solo-dependabot` → `/solo-test` → `/solo-ship` |
