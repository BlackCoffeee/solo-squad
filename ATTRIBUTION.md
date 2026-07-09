# Attribution — Bundled Community Skills

Solo Squad **wraps and orchestrates** community skills. The following upstream
projects are bundled (copied into `skills/*/references/`) or adapted. Thank you
to the original authors.

## Solo Squad wrappers (this repo)

| Component | Author | License |
|-----------|--------|---------|
| `skills/solo-*`, docs, scripts | [BlackCoffeee](https://github.com/BlackCoffeee) | MIT ([LICENSE](./LICENSE)) |
| `skills/solo-help/references/solo-squad-help.{id,en}.md` | BlackCoffeee | MIT — installed as `solo-squad-help.md` |
| `skills/solo-dependabot/references/dependabot-github-audit.md` | BlackCoffeee | MIT |

## Bundled references (third party)

| Solo skill | Reference file | Upstream | License |
|------------|----------------|----------|---------|
| solo-modernize | improve-codebase-architecture.md | [mattpocock/skills](https://github.com/mattpocock/skills) | Check upstream |
| solo-modernize, solo-add-feature | incremental-implementation.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |
| solo-scout | grill-me-product.md | [sergdort/dot-files](https://github.com/sergdort/dot-files) | MIT (adapted from Matt Pocock) |
| solo-blueprint | grill-me-architecture.md | [sergdort/dot-files](https://github.com/sergdort/dot-files) | MIT |
| solo-backend | engineering-best-practices.md | [skylarng89/engineering-best-practices-skill](https://github.com/skylarng89/engineering-best-practices-skill) | Check upstream |
| solo-frontend | taste-skill.md | [Leonxlnx/taste-skill](https://github.com/Leonxlnx/taste-skill) | Check upstream |
| solo-test | test-driven-development.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |
| solo-review | code-review-and-quality.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |
| solo-security | security-and-hardening.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |
| solo-pentest | web-pentest.md | [briiirussell/cybersecurity-skills](https://github.com/briiirussell/cybersecurity-skills) | MIT |
| solo-ship | shipping-and-launch.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |
| solo-docs | documentation-and-adrs.md | [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) | MIT |

## Ponytail (solo-ponytail) — keep coding lean

| Skill | Upstream | Notes |
|-------|----------|-------|
| solo-ponytail, solo-ponytail-review | [DietrichGebert/ponytail](https://github.com/DietrichGebert/ponytail) | Adapted; diff via `scripts/solo-ponytail-diff.sh` |
| solo-ponytail-ultra | Solo Squad extension | Based on Ponytail persona |
| solo-ponytail-status | Solo Squad | BlackCoffeee |

## Update bundled files

```bash
./scripts/bundle-update.sh
```

Verify: `./scripts/solo-skills-audit.sh`

## Disclaimer

Solo Squad is **not affiliated** with Cursor, Anthropic, Google, or upstream
skill authors. Community references are bundled for convenience; always review
upstream licenses before redistribution.
