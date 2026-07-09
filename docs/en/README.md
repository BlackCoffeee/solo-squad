# Solo Squad

> **One developer. The whole playbook. On demand.**

> *Satu developer. Satu tim virtual. Dipanggil saat perlu.*

A **virtual team** you call when you need it — for solo full-stack developers on **Cursor**. Scout to ship, security on demand, community skills already wired in.

**Language:** English · [Bahasa Indonesia](../id/README.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../../LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](../../CHANGELOG.md)

**Author:** [BlackCoffeee](https://github.com/BlackCoffeee) · **Release:** [v1.0.0](../../RELEASE-NOTES.md)

---

## Quick start (Cursor)

```bash
git clone https://github.com/BlackCoffeee/solo-squad.git
cd solo-squad
chmod +x scripts/*.sh
./scripts/install.sh --lang en    # English skill descriptions
# ./scripts/install.sh --lang id  # Indonesian descriptions
```

The installer prompts for language when run interactively. Restart Cursor → type **`/solo-help`**

**Installing on macOS / Linux / Windows:** see [SOLO-SQUAD.md → Installing](./SOLO-SQUAD.md#installing-on-macos-linux-and-windows)

---

## What is Solo Squad?

Not a single skill — a **playbook + 19 skill wrappers**.

Almost every Solo Squad capability uses **existing community skills** (Addy Osmani, sergdort, DietrichGebert/ponytail, Taste Skill, and more) — kept under `references/`. Solo Squad does **not** rewrite those from scratch. The work is the recipe: one `/solo-*` prefix, a scout→ship order, bilingual install, and activation only when you ask.

So others get the same benefit **without assembling that stack themselves**.

- Activate only when you invoke `/skill-name` (`disable-model-invocation: true`)
- Include **solo-ponytail** (so you don't over-build while coding)
- **Two languages:** pick the skill description language at install (`--lang id` or `--lang en`)
- Upstream credits: [ATTRIBUTION.md](../../ATTRIBUTION.md)

| Command | What it's for |
|---------|---------------|
| `/solo-help` | Cheat sheet for all commands |
| `/solo-status` | Check which skills are still active |
| `/solo-add-feature` | Add feature to existing app |
| `/solo-scout` → `/solo-blueprint` | Analysis & planning |
| `/solo-backend` / `/solo-frontend` | Implementation + best practices |
| `/solo-test` / `/solo-review` | QA & review |
| `/solo-security` / `/solo-pentest` | Code audit & staging runtime |
| `/solo-dependabot` | GitHub Dependabot alerts |
| `/solo-ship` / `/solo-docs` | Release & documentation |
| `/solo-ponytail` | Keep the code from over-building |

**Full docs:** [SOLO-SQUAD.md](./SOLO-SQUAD.md) (includes `/solo-ponytail` guide)

---

## Repo structure

```text
solo-squad/
├── README.md              # Language hub (root)
├── docs/
│   ├── id/                # Indonesian documentation
│   └── en/                # English documentation
├── locales/
│   ├── descriptions.id.json
│   └── descriptions.en.json
├── skills/
└── scripts/
    ├── install.sh         # → ~/.cursor/skills/ + --lang
    ├── apply-locale.py
    └── …
```

---

## Install options

```bash
./scripts/install.sh                  # asks for language (id/en)
./scripts/install.sh --lang en        # English descriptions
./scripts/install.sh --lang id        # Indonesian descriptions
./scripts/install.sh --dry-run
SOLO_LANG=id ./scripts/install.sh
SOLO_SKILLS_DIR=/custom/path ./scripts/install.sh
```

After install, the language choice is saved in `~/.cursor/skills/.solo-squad-lang`.

---

## Keeping things updated

```bash
./scripts/bundle-update.sh
./scripts/solo-skills-audit.sh --check
./scripts/solo-ponytail-diff.sh --check
```

---

## Security

- Every skill: `disable-model-invocation: true`
- No executables in the skill root (only `references/`)
- Periodic checks via the scripts above

---

## Attribution

Wrapper & docs: **BlackCoffeee** (MIT).  
Community references we ship: see [ATTRIBUTION.md](../../ATTRIBUTION.md).

---

## Platform

| Platform | Status |
|----------|--------|
| Cursor | ✅ |
| Antigravity, VS Code, Gemini CLI | 🔜 [PLATFORMS.md](../../PLATFORMS.md) |

---

## Disclaimer

Independent project — not affiliated with Cursor or upstream skill authors.
