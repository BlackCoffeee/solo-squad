# Solo Squad v1.0.0

**Released:** 2026-07-09  
**Tag:** `v1.0.0`

One developer. The whole playbook. On demand.

This is the first public release of **Solo Squad** — a curated set of Cursor Agent Skills that wires community playbooks into one `/solo-*` workflow (scout → ship), bilingual install, and on-demand activation.

---

## Highlights

- **19 skills** under one prefix — help, status, modernize, scout, add-feature, blueprint, backend, frontend, ponytail family, test, review, security, pentest, dependabot, ship, docs
- **Bilingual** — Indonesian or English skill descriptions at install (`--lang id|en`)
- **Install once** — macOS, Linux, Windows (Git Bash / WSL) → `~/.cursor/skills/`
- **Community skills already wired** — you get the benefit without assembling the stack yourself ([ATTRIBUTION.md](./ATTRIBUTION.md))
- **Ponytail included** — [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) as `/solo-ponytail`, on demand

---

## Install

```bash
git clone https://github.com/BlackCoffeee/solo-squad.git
cd solo-squad
chmod +x scripts/*.sh
./scripts/install.sh --lang id    # or --lang en
```

Restart Cursor → `/solo-help` · check what's on → `/solo-status`

Full install notes: [docs/id](./docs/id/SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows) · [docs/en](./docs/en/SOLO-SQUAD.md#installing-on-macos-linux-and-windows)

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
| Changelog | [CHANGELOG.md](./CHANGELOG.md) | same |

---

## Requirements

- [Cursor](https://cursor.com/)
- `git`, `python3`, bash (Git Bash or WSL on Windows)
- For `/solo-dependabot`: [GitHub CLI](https://cli.github.com/) (`gh`) + `gh auth login` (or `GH_TOKEN`)

---

## License

[MIT](./LICENSE) — BlackCoffeee. Upstream skill authors retain their licenses; see [ATTRIBUTION.md](./ATTRIBUTION.md).
