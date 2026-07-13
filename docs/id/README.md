# Solo Squad

> **Satu developer. Satu tim virtual. Dipanggil saat perlu.**

> *One developer. The whole playbook. On demand.*

Tim virtual yang bisa dipanggil saat perlu, untuk solo full-stack developer di **Cursor** — dari scout sampai ship, keamanan on demand, plus skill komunitas yang sudah diracik.

**Bahasa:** Indonesia · [English](../en/README.md)

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](../../LICENSE)
[![Version](https://img.shields.io/badge/version-2.0.0-green.svg)](../../CHANGELOG.md)

**Author:** [BlackCoffeee](https://github.com/BlackCoffeee) · **Release:** [v2.0.0](../../RELEASE-NOTES.md)

---

## Quick start (Cursor)

```bash
git clone https://github.com/BlackCoffeee/solo-squad.git
cd solo-squad
chmod +x scripts/*.sh
./scripts/install.sh --lang id    # deskripsi skill Bahasa Indonesia
# ./scripts/install.sh --lang en  # English skill descriptions
```

Installer akan menanyakan bahasa jika dijalankan interaktif. Restart Cursor → ketik **`/solo-help`**

**Install di macOS / Linux / Windows:** lihat [SOLO-SQUAD.md → Cara install](./SOLO-SQUAD.md#cara-install-di-macos-linux-dan-windows)

---

## Apa itu Solo Squad?

Bukan satu skill — **playbook + 19 skill wrapper**.

Hampir setiap kemampuan Solo Squad memakai **skill milik orang lain yang sudah ada** (Addy Osmani, sergdort, DietrichGebert/ponytail, Taste Skill, dll.) — disimpan di `references/`. Solo Squad **tidak** menulis ulang semuanya dari nol. Yang dikerjakan: meracik, menyelaraskan prefix `/solo-*`, urutan scout→ship, install bilingual, dan aktivasi on demand.

Tujuannya sederhana: orang lain **tidak harus meracik dari awal** untuk mendapat manfaat yang sama.

- Hanya aktif saat Anda panggil `/nama-skill` (`disable-model-invocation: true`)
- Termasuk **solo-ponytail** (supaya coding tidak membengkak)
- **Dua bahasa:** pilih bahasa deskripsi skill saat install (`--lang id` atau `--lang en`)
- Kredit upstream: [ATTRIBUTION.md](../../ATTRIBUTION.md)

| Perintah | Untuk apa |
|----------|-----------|
|----------|----------------|
| `/solo-help` | Cheat sheet semua command |
| `/solo-status` | Cek skill yang masih aktif |
| `/solo-add-feature` | Tambah fitur ke app existing |
| `/solo-scout` → `/solo-blueprint` | Analisis & rencana |
| `/solo-backend` / `/solo-frontend` | Implementasi + best practices |
| `/solo-test` / `/solo-review` | QA & review |
| `/solo-security` / `/solo-pentest` | Audit kode & runtime staging |
| `/solo-dependabot` | Alert GitHub Dependabot |
| `/solo-ship` / `/solo-docs` | Release & dokumentasi |
| `/solo-ponytail` | Coding tanpa over-engineering |

**Dokumentasi lengkap:** [SOLO-SQUAD.md](./SOLO-SQUAD.md) (termasuk panduan `/solo-ponytail`)

---

## Struktur repo

```text
solo-squad/
├── README.md              # Hub bahasa (Anda di sini)
├── docs/
│   ├── id/                # Dokumentasi Indonesia
│   └── en/                # English documentation
├── locales/
│   ├── descriptions.id.json
│   └── descriptions.en.json
├── skills/                # Skill siap install
└── scripts/
    ├── install.sh         # --platform cursor|antigravity + --lang
    ├── apply-locale.py
    └── …
```

---

## Opsi install

```bash
./scripts/install.sh --lang id                         # Cursor (default)
./scripts/install.sh --platform antigravity --lang id  # Antigravity
./scripts/install.sh --dry-run
SOLO_LANG=en ./scripts/install.sh
SOLO_SKILLS_DIR=/custom/path ./scripts/install.sh
```

Setelah install, bahasa tersimpan di `.solo-squad-lang` pada path platform (lihat [PLATFORMS.md](../../PLATFORMS.md)).

---

## Perawatan

```bash
./scripts/bundle-update.sh
./scripts/solo-skills-audit.sh --check
./scripts/solo-ponytail-diff.sh --check
```

---

## Keamanan

- Semua skill: `disable-model-invocation: true`
- Tidak ada executable di root skill (hanya `references/`)
- Audit berkala lewat script di atas

---

## Atribusi

Wrapper & docs: **BlackCoffeee** (MIT).  
Referensi komunitas yang dibawa: lihat [ATTRIBUTION.md](../../ATTRIBUTION.md).

---

## Platform

| Platform | Status |
|----------|--------|
| Cursor | ✅ `~/.cursor/skills/` |
| Antigravity | ✅ `~/.gemini/config/skills/` — [PLATFORMS.md](../../PLATFORMS.md) |
| VS Code, Gemini CLI, Claude Code | 🔜 [PLATFORMS.md](../../PLATFORMS.md) |

---

## Disclaimer

Proyek independen — tidak afiliasi Cursor atau pembuat skill upstream.
