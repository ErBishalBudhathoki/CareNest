# GitHub Security Configuration

This document describes the security configuration for this repository.

## Branch Protection Rules

Configure these settings in GitHub: **Settings → Branches → Add branch protection rule**

### Main Branch Protection

| Setting | Value |
|---------|-------|
| Branch name pattern | `main` |
| Require a pull request before merging | ✅ |
| Require approvals | 1 |
| Dismiss stale PR approvals when new commits are pushed | ✅ |
| Require review from Code Owners | ❌ (optional) |
| Require status checks to pass before merging | ✅ |
| Require branches to be up to date before merging | ✅ |
| Status checks required | `security-scan`, `test` |
| Require conversation resolution before merging | ✅ |
| Require signed commits | ❌ (optional) |
| Require linear history | ✅ |
| Include administrators | ✅ |
| Restrict pushes that create files | ❌ |
| Allow force pushes | ❌ |
| Allow deletions | ❌ |

### Dev Branch Protection (Backend Only)

| Setting | Value |
|---------|-------|
| Branch name pattern | `dev` |
| Require a pull request before merging | ❌ (for faster iteration) |
| Require status checks to pass before merging | ✅ |
| Status checks required | `security-scan` |
| Allow force pushes | ❌ |
| Allow deletions | ❌ |

## Required Status Checks

### Frontend (carenest)
- `security-scan` - Trivy vulnerability scan
- `test` - Unit tests (if configured)

### Backend (carenest_backend)
- `security-scan` - Trivy + TruffleHog scans
- `test` - Unit and integration tests

## Secrets Configuration

### GitHub Secrets Required

| Secret | Description | Used In |
|--------|-------------|---------|
| `WIF_PROVIDER` | Workload Identity Federation provider | Backend deploy |
| `WIF_SERVICE_ACCOUNT` | GCP service account email | Backend deploy |
| `ANDROID_KEYSTORE_BASE64` | Base64 encoded keystore | Android release |
| `ANDROID_KEYSTORE_PASSWORD` | Keystore password | Android release |
| `ANDROID_KEY_ALIAS` | Key alias | Android release |
| `ANDROID_KEY_PASSWORD` | Key password | Android release |
| `GOOGLE_PLAY_API_KEY` | Google Play API JSON | Play Store deploy |
| `SLACK_WEBHOOK_URL` | Slack webhook (optional) | Notifications |

### Google Secret Manager Secrets

Backend secrets are stored in Google Secret Manager:
- `app-secrets-dev` - Development secrets (consolidated)
- `app-secrets-prod` - Production secrets (consolidated)

## Security Workflows

| Workflow | Trigger | Purpose |
|----------|---------|---------|
| `codeql.yml` | Push to main, weekly | Code analysis |
| `secret-scan.yml` | Push, PR, daily | Detect leaked secrets |
| `dependabot.yml` | Weekly | Dependency updates |

## Pre-commit Hooks

Both repos have pre-commit hooks that scan for:
- MongoDB connection strings with credentials
- Firebase/Google API keys
- AWS access keys
- Stripe keys
- Generic secrets (password, token, api_key patterns)

### Bypass (Emergency Only)
```bash
git commit --no-verify
```

## Incident Response

1. Rotate compromised credentials immediately
2. Use `git filter-repo` to remove from history
3. Force push cleaned history
4. Update all services with new credentials
