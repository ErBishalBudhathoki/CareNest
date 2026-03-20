# Security Guidelines for CareNest App

## Supported Versions

| Version | Supported          |
| ------- | ------------------ |
| main    | :white_check_mark: |
| dev     | :white_check_mark: |

## Sensitive Files Protection

This project contains several sensitive files that should **never** be committed to the repository. The `.gitignore` file has been configured to exclude these files, but developers should be aware of them:

### API Keys and Service Accounts

- `google-play-service-key.json` - Google Play API key for app deployment
- `firebase-service-account.json` - Firebase service account credentials
- `google-services.json` - Firebase configuration for Android
- `GoogleService-Info.plist` - Firebase configuration for iOS

### Environment Variables

- `.env` - Contains sensitive API keys, passwords, and configuration
- Any file matching `*.env.*` pattern (except `.env.example`)

### Keystores and Certificates

- `*.jks` - Java KeyStore files
- `*.keystore` - Android keystore files
- `*.p8` - Apple Push Notification service keys
- `*.p12` - PKCS #12 certificates
- `*.key` - Private key files
- `*.mobileprovision` - iOS provisioning profiles

## Reporting a Vulnerability

If you discover a security vulnerability:

1. **Do NOT** open a public issue
2. Email security reports to: [security@example.com]
3. Include: description, steps to reproduce, potential impact

### Response Timeline

- **Acknowledgment**: Within 48 hours
- **Initial Assessment**: Within 7 days
- **Critical Fix**: Within 14 days

## Security Best Practices

### For Contributors

1. **Never commit secrets** - Use environment variables
2. **Use `.env.example`** as a template, never commit actual `.env` files
3. **Pre-commit hooks** are installed - they scan for accidental secret commits
4. **Review PRs carefully** - Check for accidentally exposed credentials

### Firebase Configuration

The `firebase_options.dart` file reads API keys from `.env` file. These keys are:
- Restricted by Firebase Security Rules
- Restricted by package name/bundle ID
- Safe to use but should be rotated if compromised

## Security Features

### Current Protections

- ✅ Pre-commit hooks for secret detection
- ✅ Trivy vulnerability scanning in CI/CD
- ✅ Dependabot for dependency updates
- ✅ CodeQL for code analysis
- ✅ Obfuscated release builds
- ✅ Signed APKs/AABs for Android

### Branch Protection

- Main branch requires PR reviews
- Status checks must pass before merge
- No force pushes to protected branches

## Incident Response

If a security incident occurs:

1. **Rotate compromised credentials immediately**
2. **Review git history for exposure**
3. **Use `git filter-repo` to remove secrets from history**
4. **Force push cleaned history**
5. **Update all affected services with new credentials**