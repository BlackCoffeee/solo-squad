# Solo Squad v2.0.0

**Released:** 2026-07-13  
**Tag:** `v2.0.0`

One developer. The whole playbook. On demand — now on **Cursor** and **Antigravity**.

This release adds first-class Antigravity install support alongside the existing Cursor workflow. Same `/solo-*` skills, bilingual install, on-demand activation where the host supports it.

Previous release: [v1.0.0](./CHANGELOG.md#100--2026-07-09) (Cursor-only).

---

## Highlights

- **Dual platform** — `./scripts/install.sh --platform cursor|antigravity`
  - Cursor → `~/.cursor/skills/`
  - Antigravity → `~/.gemini/config/skills/` (AGY / CLI / IDE)
- **Path rewrite on install** — Antigravity installs get `SKILL.md` paths rewritten to the Antigravity skills home
- **19 skills** under one `/solo-*` prefix — unchanged from 1.0.0
- **Bilingual** — Indonesian or English skill descriptions (`--lang id|en`)
- **Platform docs** — [PLATFORMS.md](./PLATFORMS.md)

---

## Install

```bash
git clone https://github.com/BlackCoffeee/solo-squad.git
cd solo-squad
chmod +x scripts/*.sh

# Cursor (default)
./scripts/install.sh --lang id

# Antigravity
./scripts/install.sh --platform antigravity --lang id
```

Restart Cursor or Antigravity / `agy` → `/solo-help` · check what's on → `/solo-status`

Full notes: [docs/id](./docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows) · [docs/en](./docs/en/SOLO-SQUAD.md#installing-on-macos-linux-and-windows) · [PLATFORMS.md](./PLATFORMS.md)

---

## What's in the box

| Area | Commands |
|------|----------|
| Meta | `/solo-help`, `/solo-status` |
| Plan | `/solo-modernize`, `/solo-scout`, `/solo-add-feature`, `/solo-blueprint` |
| Build | `/solo-backend`, `/solo-frontend`, `/solo-ponytail*` |
| Quality | `/solo-test`, `/solo-review`, `/solo-security`, `/solo-pentest`, `/solo-dependabot` |
| Ship | `/solo-ship`, `/solo-docs` |

---

## Docs

| | Indonesia | English |
|---|-----------|---------|
| Overview | [docs/id/README.md](./docs/id/README.md) | [docs/en/README.md](./docs/en/README.md) |
| Full guide | [docs/id/SOLO-SQUAD.md](./docs/id/SOLO-SQUAD.md) | [docs/en/SOLO-SQUAD.md](./docs/en/SOLO-SQUAD.md) |
| Platforms | [PLATFORMS.md](./PLATFORMS.md) | same |
| Changelog | [CHANGELOG.md](./CHANGELOG.md) | same |

---

## Requirements

- [Cursor](https://cursor.com/) and/or [Antigravity](https://antigravity.google/)
- `git`, `python3`, bash (Git Bash or WSL on Windows)
- For `/solo-dependabot`: [GitHub CLI](https://cli.github.com/) (`gh`) + `gh auth login` (or `GH_TOKEN`)

---

## License

[MIT](./LICENSE) — BlackCoffeee. Upstream skill authors retain their licenses; see [ATTRIBUTION.md](./ATTRIBUTION.md).
