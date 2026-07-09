# Solo Squad — Command Reference (Help)

Panduan cepat semua perintah. Dokumentasi lengkap: `docs/id/SOLO-SQUAD.md` di repo solo-squad.

---

## Meta

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-help` | Menampilkan daftar command ini |
| `/solo-help [kategori]` | Filter: `plan`, `build`, `quality`, `release`, `solo-ponytail`, `security` |
| `/solo-help [nama-skill]` | Detail satu skill, mis. `scout`, `dependabot` |
| `/solo-status` | Cek skill mana yang **masih aktif** di chat ini |

**Stop skill:** `normal mode` atau `stop [nama]` · **Dua skill sekaligus:** `/solo-backend /solo-ponytail`

---

## Fase 0 — Warisan

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-modernize` | Audit app lama: stack, dependency EOL, risiko, strategi migrasi (strangler/incremental) |
| `/solo-modernize [tujuan]` | Contoh: `upgrade Laravel 8 ke 12`, `monolith ke Inertia` |

**Kapan:** App warisan sebelum scout/rewrite. **Lanjut:** `/solo-scout` satu fase saja.

---

## Perencanaan

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-scout` | Analisis masalah, wawancara asumsi, scope in/out, edge case, rekomendasi stack |
| `/solo-scout [fitur]` | Contoh: `sistem booking kampus`, `fase 1 modul auth` |
| `/solo-add-feature` | Tambah fitur ke **app existing** — orkestrasi scope→slice→next skill |
| `/solo-add-feature [fitur]` | Contoh: `export PDF`, `notifikasi WhatsApp booking` |
| `/solo-blueprint` | Rencana fase, task checklist, diagram **Mermaid** wajib |
| `/solo-blueprint [modul]` | Contoh: `modul booking`, `migrasi auth strangler` |

**Kapan:** Ide/fitur baru (scout) · fitur di app jadi (add-feature) · fase migrasi (blueprint).

---

## Implementasi

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-backend` | Backend: Laravel/API, migration, model, auth, validasi, OWASP |
| `/solo-backend [modul]` | Contoh: `API export PDF`, `webhook payment` |
| `/solo-frontend` | Frontend: halaman, komponen, API wiring, Taste Skill (anti-slop UI) |
| `/solo-frontend [halaman]` | Contoh: `dashboard admin`, `landing page` |
| `/solo-backend /solo-ponytail` | Backend minimal — anti over-engineering |
| `/solo-frontend /solo-ponytail` | Frontend minimal |

**Kapan:** Setelah blueprint. Stack terdeteksi otomatis dari project.

---

## Ponytail — jangan over-engineering

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-ponytail` | Senior dev malas: YAGNI, stdlib first, solusi paling sederhana saat **coding** |
| `/solo-ponytail lite` | Ponytail sedikit lebih longgar |
| `/solo-ponytail-ultra` | Ekstrem: tantang requirement, hapus sebelum tambah, one-liner |
| `/solo-ponytail-review` | Review diff fokus **bloat** saja — apa yang bisa dihapus/disederhanakan |
| `/solo-ponytail-status` | Cek apakah Ponytail **aktif di chat ini** — jawaban: `YA` atau `TIDAK` |

**Kapan:** Saat implementasi (`/solo-ponytail`) atau cek simplifikasi (`/solo-ponytail-review`). **Stop:** `stop solo-ponytail`.

---

## Kualitas & keamanan

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-test` | Strategi test, TDD red-green-refactor, jalankan suite, laporan |
| `/solo-test [scope]` | Contoh: `modul auth`, `regression checkout` |
| `/solo-review` | Review 5 axis sebelum merge: correctness, readability, architecture, security, performance |
| `/solo-review [scope]` | Contoh: `git diff`, `modul booking` |
| `/solo-security` | Audit keamanan: threat model STRIDE, OWASP, app sudah jadi |
| `/solo-security audit full-app` | Audit seluruh aplikasi |
| `/solo-security [modul]` | Contoh: `modul auth`, `payment` |
| `/solo-pentest` | Pentest web staging/localhost — OWASP WSTG, verifikasi runtime |
| `/solo-pentest staging [URL]` | Contoh: `staging https://staging.app.com modul auth` |
| `/solo-pentest localhost:8000` | Pentest lokal |
| `/solo-dependabot` | Cek alert Dependabot GitHub + triage + cross-check npm/composer audit |
| `/solo-dependabot critical` | Hanya critical + high |
| `/solo-dependabot owner/repo` | Repo GitHub tertentu |
| `/review-security` | **Subagent** Cursor — second opinion keamanan pada diff (bukan skill Solo) |

**Kapan:** Sebelum merge (`review`), app jadi (`security` → `pentest` staging), sebelum deploy (`dependabot`).

**Dependabot:** Butuh `gh` + `gh auth login` (atau `GH_TOKEN`). Install: macOS `brew install gh` · Linux [cli.github.com](https://cli.github.com/) · Windows `winget install GitHub.cli`.

---

## Release & dokumentasi

| Command | Digunakan untuk |
|---------|-----------------|
| `/solo-ship` | Release: semver, changelog, tag GitHub, checklist deploy, rollback |
| `/solo-ship patch` | Release patch |
| `/solo-ship minor` | Release minor |
| `/solo-docs` | Dokumentasi developer (default) |
| `/solo-docs system` | Setup dev, arsitektur, API, env |
| `/solo-docs user` | Panduan end-user |
| `/solo-docs both` | Sistem + user |
| `/solo-docs ADR [topik]` | Architecture Decision Record |

**Kapan:** Setelah test + review. Ship butuh konfirmasi Anda untuk deploy prod.

---

## Alur singkat

```text
Warisan:  modernize → scout → blueprint → build+solo-ponytail → test → review → dependabot → ship → docs
Greenfield: scout → blueprint → build+solo-ponytail → test → review → dependabot → ship → docs
Add fitur:  add-feature → build+solo-ponytail → test → review → dependabot → ship → docs
App audit:  security → pentest staging → test → dependabot → ship
Hotfix:     test → solo-ponytail fix → test → review → ship patch
```

---

## Perintah stop

| Tulis | Matikan |
|-------|---------|
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
| `normal mode` | Semua persona skill |

---

## Situasi cepat

| Saya mau… | Command |
|-----------|---------|
| Lihat semua command | `/solo-help` |
| Cek skill yang aktif | `/solo-status` |
| Cek app yang sudah jadi | `/solo-security audit full-app` |
| Pentest staging | `/solo-pentest staging [URL]` |
| Cek CVE Dependabot | `/solo-dependabot` |
| Fitur baru dari nol | `/solo-scout` |
| Fitur baru di app jadi | `/solo-add-feature` |
| Review sebelum merge | `/solo-test` lalu `/solo-review` |
| Coding tanpa bloat | `/solo-ponytail` atau `/solo-backend /solo-ponytail` |
| Deploy aman | `/solo-dependabot` → `/solo-test` → `/solo-ship` |
