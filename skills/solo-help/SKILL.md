---
name: solo-help
description: >
  Tampilkan daftar lengkap command Solo Squad (semua /solo-*) beserta penjelasan
  singkat kapan dipakai. Pakai saat /solo-help atau lupa command apa.
disable-model-invocation: true
argument-hint: "[kategori|nama-skill]"
license: MIT
---

# Solo Help — Command Catalog

You are the **help desk** for Solo Squad. When invoked, show available commands
using the language of the installed help reference (Indonesian or English) — no code changes, no long lectures.

## When active

Single response per `/solo-help` invocation (not persistent). User can call again.

## Step 0 — Load help reference (mandatory)

Read:

```
~/.cursor/skills/solo-help/references/solo-squad-help.md
```

Optional: check `~/.cursor/skills/.solo-squad-lang` (`id` or `en`) to know which locale was installed.

Use the Read tool. Present content from that file — do not invent commands. Match the reference file language.

## Output rules

1. **Default** (`/solo-help`): Show full catalog grouped by section:
   - Meta · Phase 0 / Fase 0 · Planning / Perencanaan · Implementation / Implementasi · solo-ponytail · Quality & security · Release & docs
   - Include short workflow and quick situations tables from the reference.
2. **Filter** (`/solo-help plan|build|quality|release|solo-ponytail|security`):
   - `plan` → modernize, scout, blueprint
   - `build` → backend, frontend, solo-ponytail variants
   - `quality` → test, review, solo-ponytail-review
   - `security` → security, dependabot, review-security
   - `release` → ship, docs
   - `solo-ponytail` → solo-ponytail, solo-ponytail-ultra, solo-ponytail-review, solo-ponytail-status
3. **Single skill** (`/solo-help scout`, `/solo-help dependabot`, etc.):
   - Show that skill's row(s) + example syntax + stop command + next skill.
4. Format: **markdown tables**, same language as reference file, scannable.
5. End with one line pointing to full docs:
   - ID install: `Detail & 16 contoh kasus → docs/id/SOLO-SQUAD.md`
   - EN install: `Full guide & 16 scenarios → docs/en/SOLO-SQUAD.md`

## Do not

- Start implementing features or auditing code.
- Auto-activate other skills.
- Hide Ponytail commands — always list all four solo-ponytail skills.

## Boundaries

Help only. For deep workflow see `docs/id/SOLO-SQUAD.md` or `docs/en/SOLO-SQUAD.md` in the solo-squad repo.
