# Dependabot GitHub Audit — Reference (Solo Squad)

Bundled reference for `/solo-dependabot`. Based on [GitHub REST API — Dependabot alerts](https://docs.github.com/en/rest/dependabot/alerts) and supply-chain triage patterns from [addyosmani/agent-skills](https://github.com/addyosmani/agent-skills) (`security-and-hardening`).

## Prerequisites

1. **GitHub CLI (`gh`)** installed and authenticated:
   ```bash
   which gh && gh auth status
   # Windows (Git Bash / WSL): gh --version && gh auth status
   ```

2. **If `gh` is missing** — suggest install for the user's OS (do not assume Homebrew):

   | OS | Install |
   |----|---------|
   | macOS | `brew install gh` |
   | Linux | [cli.github.com](https://cli.github.com/) — e.g. `sudo apt install gh` on Debian/Ubuntu |
   | Windows | `winget install GitHub.cli` · or `choco install gh` · or installer from [cli.github.com](https://cli.github.com/) |

3. **If not logged in** — user runs once in their terminal (interactive):
   ```bash
   gh auth login
   ```
   Choose: GitHub.com → HTTPS → Login with browser. For **private** repos, ensure scope **`security_events`** (classic PAT) or fine-grained with **Dependabot alerts: read**.

4. **Alternative without `gh auth login`:** set a token in the environment (never commit):
   ```bash
   export GH_TOKEN=ghp_xxxx   # PAT with security_events
   ```
   Agent may use `curl` + `GH_TOKEN` if `gh` is not logged in but the token is set.

5. Repo must have **Dependabot alerts** enabled (Settings → Security → Dependabot).

### Cursor / agent — izin shell

Perintah `gh` **gagal di sandbox** default. Agent wajib menjalankan preflight dan fetch dengan izin penuh (`all`), bukan hanya network.

### Fallback manual (tanpa API)

Jika `gh` tidak terpasang **dan** tidak ada `GH_TOKEN`:

- Local audit: `composer audit`, `npm audit`
- Link manual: `https://github.com/{owner}/{repo}/security/dependabot`
- Jangan klaim "0 alert" — status GitHub = **belum diverifikasi**

## Resolve repository

From current workspace:

```bash
git remote get-url origin
# → infer owner/repo from github.com:owner/repo.git or github.com/owner/repo
```

User may pass `owner/repo` explicitly.

### Fetch via GH_TOKEN (tanpa gh login)

```bash
OWNER=sarimulia
REPO=spmb
curl -fsSL \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GH_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&per_page=100"
```

API Dependabot **selalu butuh autentikasi** (401 tanpa token) — bahkan untuk repo public.

```bash
OWNER=your-org
REPO=your-repo

gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&per_page=100"
```

### Useful query filters

| Parameter | Values | Use |
|-----------|--------|-----|
| `state` | `open`, `fixed`, `dismissed`, `auto_dismissed` | Default audit: `open` |
| `severity` | `critical`, `high`, `medium`, `low` | Focus critical/high first |
| `ecosystem` | `npm`, `composer`, `pip`, `maven`, `go`, `nuget`, `rubygems`, `rust` | Per stack |
| `scope` | `runtime`, `development` | Prioritize `runtime` |
| `sort` | `created`, `updated`, `epss_percentage` | EPSS = exploit likelihood |

Examples:

```bash
# Critical + high only
gh api "/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&severity=critical,high&per_page=100"

# npm runtime only
gh api "/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&ecosystem=npm&scope=runtime&per_page=100"
```

### Pretty summary with jq

```bash
gh api "/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&per_page=100" \
  --jq '.[] | {number, severity, package: .security_vulnerability.package.name, ecosystem: .security_vulnerability.package.ecosystem, vulnerable: .security_vulnerability.vulnerable_version_range, patched: .security_vulnerability.first_patched_version.identifier, cve: .security_vulnerability.cve_id, html_url}'
```

### Count by severity

```bash
gh api "/repos/${OWNER}/${REPO}/dependabot/alerts?state=open&per_page=100" \
  --jq 'group_by(.security_vulnerability.severity) | map({severity: .[0].security_vulnerability.severity, count: length})'
```

## Organization-wide (optional)

Requires org owner or security manager:

```bash
gh api "/orgs/${ORG}/dependabot/alerts?state=open&severity=critical,high&per_page=100"
```

## Single alert detail

```bash
gh api "/repos/${OWNER}/${REPO}/dependabot/alerts/${ALERT_NUMBER}"
```

## Cross-check: local dependency audit

Dependabot (GitHub) and local audit can differ. After listing GH alerts, run stack-appropriate commands in the repo:

| Stack | Command |
|-------|---------|
| Node/npm | `npm audit --audit-level=moderate` |
| Node (CI) | `npm ci && npm audit` |
| PHP/Composer | `composer audit` |
| Python | `pip-audit` or `uv pip audit` if available |
| Go | `govulncheck ./...` |

Report **both** GitHub Dependabot state and local audit — note gaps (e.g. alert open on GH but fix already merged locally).

## Triage decision tree

```
Dependabot alert (open)
├── Severity: critical or high
│   ├── Runtime dependency + reachable? → Fix before next deploy (blocker)
│   └── Dev-only / not reachable? → Fix soon; track in backlog
├── Severity: moderate
│   └── Runtime? → Next release cycle
└── Severity: low
    └── Batch with regular dependency updates
```

**Key questions:**
- Is the vulnerable code path reachable in production?
- Is there a patched version? (`first_patched_version`)
- Is the fix a major bump requiring regression tests?
- Was alert dismissed? Check `state` and `dismissed_reason` if reviewing history.

## Remediation actions (suggest only — user approves)

1. Bump dependency to patched version in lockfile.
2. Run tests (`/solo-test`).
3. If no patch: consider alternative package, override with documented risk + review date.
4. Re-run Dependabot check after merge.
5. Before production release: pair with `/solo-ship` preflight.

## Security rules

- **Never** print or commit tokens, `GH_TOKEN`, or full API responses with secrets.
- **Never** dismiss alerts on GitHub without user explicit approval.
- **Never** `npm audit fix --force` without user approval (can break deps).
- Rate-limit: paginate if `per_page=100` returns full page — fetch next page.

## Red flags

- Critical/high open alerts on `runtime` scope
- Same CVE open > 30 days
- Dismissed alerts without documented reason
- Dependabot disabled but app is public/production
- Lockfile not committed (`package-lock.json`, `composer.lock`)

## Output fields to report

For each open alert:

| Field | Source |
|-------|--------|
| Alert # | `number` |
| Severity | `security_vulnerability.severity` |
| Package | `security_vulnerability.package.name` |
| Ecosystem | `security_vulnerability.package.ecosystem` |
| Vulnerable range | `security_vulnerability.vulnerable_version_range` |
| Patched version | `security_vulnerability.first_patched_version.identifier` |
| CVE | `security_vulnerability.cve_id` |
| Scope | `dependency.scope` |
| Link | `html_url` |
| Recommendation | Triage + suggested bump |
