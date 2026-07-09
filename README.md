# Solo Squad

> **One developer. The whole playbook. On demand.**

> *Satu developer. Satu tim virtual. Dipanggil saat perlu.*

**Bahasa Indonesia** · **English**

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-green.svg)](./CHANGELOG.md)

**Author:** [BlackCoffeee](https://github.com/BlackCoffeee) · **Release:** [v1.0.0](./RELEASE-NOTES.md)

---

You know the week. Monday you greenfield a feature. Wednesday you're the only one who understands the auth flow. Friday production is on fire and the standup is just you, talking to yourself.

Solo Squad puts a full-stack team inside **Cursor** — scout, blueprint, backend, frontend, test, review, security, ship — each one a **`/solo-*` command**. Active when you invoke it. Silent when you don't. No always-on persona eating your context. No imaginary coworkers in every chat.

And yes: **solo-ponytail** ships with the squad — [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) as `/solo-ponytail`, already wired in. Same prefix. On demand. No separate setup.

**19 skills · on demand · bilingual · community skills already wired in**

---

## Why Solo Squad exists

Most of what Solo Squad does already exists — as excellent skills from other people. Addy Osmani's review and security playbooks. sergdort's grill-me interviews. DietrichGebert's ponytail. Taste Skill. Web pentest. Shipping checklists. ADRs.

Solo Squad does **not** reinvent those. It **wires them into one playbook**: same `/solo-*` prefix, same install, same scout→ship order, bilingual descriptions, on demand only.

You still get the benefit of those upstream skills. You just don't have to hunt them down, rename them, chain them by hand, or figure out which one comes after which. The recipe is the product.

Credit where it's due: [ATTRIBUTION.md](./ATTRIBUTION.md).

---

## Before / after

| Without Solo Squad | With Solo Squad |
|--------------------|-----------------|
| "Build me a booking system" → agent guesses scope, over-builds, skips tests | `/solo-scout` → `/solo-blueprint` → `/solo-backend /solo-ponytail` → `/solo-test` → `/solo-review` |
| "Is this secure?" → generic checklist in chat | `/solo-security audit full-app` → `/solo-pentest staging` |
| "Ship it" → semver guess, no changelog | `/solo-dependabot` → `/solo-test` → `/solo-ship` |
| Date picker → flatpickr + wrapper + CSS debate | `/solo-ponytail` → `<input type="date">` |

Forgot a command? **`/solo-help`**. That's the cheat sheet. That's also a skill.

---

## Documentation / Dokumentasi

| | Indonesia | English |
|---|-----------|---------|
| **Overview** | [docs/id/README.md](./docs/id/README.md) | [docs/en/README.md](./docs/en/README.md) |
| **Full guide** | [docs/id/SOLO-SQUAD.md](./docs/id/SOLO-SQUAD.md) | [docs/en/SOLO-SQUAD.md](./docs/en/SOLO-SQUAD.md) |

---

## Quick install

Here's all it takes:

```bash
git clone https://github.com/BlackCoffeee/solo-squad.git
cd solo-squad
chmod +x scripts/*.sh
./scripts/install.sh              # prompts: id or en
./scripts/install.sh --lang id    # Indonesian skill descriptions
./scripts/install.sh --lang en    # English skill descriptions
```

Restart Cursor → **`/solo-help`**

**Installing on macOS, Linux, or Windows:** [Indonesia](./docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows) · [English](./docs/en/SOLO-SQUAD.md#installing-on-macos-linux-and-windows)

Skill descriptions follow the language you pick at install. The skill instructions themselves stay in English — that's normal for Cursor agents.

---

## Meet the squad

| Command | What it does |
|---------|--------------|
| `/solo-scout` | Interview assumptions, nail the scope |
| `/solo-blueprint` | Phases, tasks, Mermaid diagrams |
| `/solo-backend` / `/solo-frontend` | Build it — with best practices already included |
| `/solo-ponytail` | Don't over-build it |
| `/solo-test` / `/solo-review` | Prove it, then gate the merge |
| `/solo-security` / `/solo-pentest` | Audit the code, then break staging |
| `/solo-dependabot` | Triage CVEs before you deploy |
| `/solo-ship` / `/solo-docs` | Tag, changelog, document |

Full catalog: **`/solo-help`** · deep dive: [SOLO-SQUAD.md](./docs/en/SOLO-SQUAD.md)

---

## Other links

- [CHANGELOG.md](./CHANGELOG.md) — version history
- [RELEASE-NOTES.md](./RELEASE-NOTES.md) — v1.0.0 release notes
- [ATTRIBUTION.md](./ATTRIBUTION.md) — upstream credits (Addy Osmani, sergdort, DietrichGebert/ponytail, …)
- [PLATFORMS.md](./PLATFORMS.md) — Cursor today; more platforms planned
- [LICENSE](./LICENSE) — MIT. The shortest license that works.

---

> Root `SOLO-SQUAD.md` redirects to `docs/id/`. The real docs live in `docs/id/` and `docs/en/`.
