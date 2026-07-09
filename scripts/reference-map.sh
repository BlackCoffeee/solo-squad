# Shared reference map for Solo Squad scripts.
# Sourced by solo-skills-audit.sh and bundle-update.sh

# Format: skill_name|ref_filename|upstream_url
REFERENCE_MAP=(
  "solo-modernize|improve-codebase-architecture.md|https://raw.githubusercontent.com/mattpocock/skills/main/skills/engineering/improve-codebase-architecture/SKILL.md"
  "solo-modernize|incremental-implementation.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/incremental-implementation/SKILL.md"
  "solo-scout|grill-me-product.md|https://raw.githubusercontent.com/sergdort/dot-files/main/grill-me-product/SKILL.md"
  "solo-add-feature|incremental-implementation.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/incremental-implementation/SKILL.md"
  "solo-blueprint|grill-me-architecture.md|https://raw.githubusercontent.com/sergdort/dot-files/main/grill-me-architecture/SKILL.md"
  "solo-backend|engineering-best-practices.md|https://raw.githubusercontent.com/skylarng89/engineering-best-practices-skill/main/SKILL.md"
  "solo-frontend|taste-skill.md|https://raw.githubusercontent.com/Leonxlnx/taste-skill/main/skills/taste-skill/SKILL.md"
  "solo-test|test-driven-development.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/test-driven-development/SKILL.md"
  "solo-review|code-review-and-quality.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/code-review-and-quality/SKILL.md"
  "solo-security|security-and-hardening.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/security-and-hardening/SKILL.md"
  "solo-pentest|web-pentest.md|https://raw.githubusercontent.com/briiirussell/cybersecurity-skills/trunk/skills/web-pentest/SKILL.md"
  "solo-ship|shipping-and-launch.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/shipping-and-launch/SKILL.md"
  "solo-docs|documentation-and-adrs.md|https://raw.githubusercontent.com/addyosmani/agent-skills/main/skills/documentation-and-adrs/SKILL.md"
)

SOLO_SKILLS=(
  solo-help solo-status solo-modernize solo-scout solo-add-feature solo-blueprint solo-backend solo-frontend
  solo-test solo-review solo-security solo-pentest solo-dependabot solo-ship solo-docs
  solo-ponytail solo-ponytail-ultra solo-ponytail-review solo-ponytail-status
)

# Custom references (no upstream diff): solo-help, solo-dependabot

# Upstream diff for solo-ponytail (local skill name → upstream path in DietrichGebert/ponytail)
SOLO_PONYTAIL_UPSTREAM_MAP=(
  "solo-ponytail:skills/ponytail/SKILL.md"
  "solo-ponytail-review:skills/ponytail-review/SKILL.md"
)

SOLO_PONYTAIL_LOCAL_ONLY=(
  solo-ponytail-ultra
  solo-ponytail-status
)
