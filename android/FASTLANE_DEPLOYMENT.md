# Fastlane Deployment Guide

## Overview

This project has two verified Android release flows:

- **Internal testing** — bump minor version, build production AAB (URLs from `.env`), upload to Play internal testing
- **Production release** — bump version, review release notes, build production AAB, upload to Play production

The production flavor always builds from `lib/main_production.dart`.

---

## Backend URL Configuration

> **No backend URL is hardcoded anywhere in source code or scripts.**

All backend URLs are read at **build time** from the project-root `.env` file and injected into the compiled binary via `--dart-define`. The `.env` file is **gitignored** — never committed.

### Relevant `.env` keys

```
DEVELOPMENT_URL=<your-dev-cloud-run-url>/
PRODUCTION_URL=<your-prod-cloud-run-url>/api/
```

> The actual values are in the local `.env` file (gitignored). Never hardcode URLs here.

> **Internal testing automatically uses the dev backend (`DEVELOPMENT_URL`).**  
> Google Play requires the production package ID (`com.bishal.invoice`), which uses `lib/main_production.dart`.
> `deploy_internal_minor.sh` ensures that `--dart-define=PRODUCTION_URL="$DEVELOPMENT_URL"` is injected so the app communicates directly with the dev backend server.

### How the internal deployment script injects the URL

`deploy_internal_minor.sh` parses `.env` at runtime and passes:

```bash
flutter build appbundle --flavor production -t lib/main_production.dart ... \
  --dart-define=PRODUCTION_URL="$DEVELOPMENT_URL" \
  --dart-define=DEVELOPMENT_URL="$DEVELOPMENT_URL"
```

`lib/config/build_config.dart` reads these with no hardcoded defaults:

```dart
static const String productionBaseUrl = String.fromEnvironment('PRODUCTION_URL');
static const String developmentBaseUrl = String.fromEnvironment('DEVELOPMENT_URL');
```

---

## Prerequisites

- Fastlane installed locally (`gem install fastlane` or via Bundler)
- Google Play service account key at `android/fastlane/google-play-service-key.json`
- Valid Android signing config (`android/key.properties` + keystore)
- `.env` file at project root with `PRODUCTION_URL` and `DEVELOPMENT_URL` set
- Run commands from the project root unless noted

---

## Internal Testing

### One-shot internal flow (recommended)

Run from the project root:

```bash
./android/deploy_internal_minor.sh
```

What it does:

1. Validates `.env` exists and that `PRODUCTION_URL` / `DEVELOPMENT_URL` are set
2. Normalises URLs to always end with `/api/`
3. `./android/update_version.sh --minor` — bumps patch + versionCode
4. `flutter build appbundle --flavor production -t lib/main_production.dart --release \`  
   `  --dart-define=PRODUCTION_URL=... --dart-define=DEVELOPMENT_URL=...`
5. `fastlane android upload_internal_aab` — uploads to Play internal track
6. Auto-rollback: if the build or upload fails, `pubspec.yaml` and `local.properties` are restored to the pre-bump state

Notes:
- Internal testing does **not** require release notes editing
- Fastlane uses a default internal changelog when needed
- Tested end-to-end against Google Play internal testing (latest: `4.4.4+173`)

### Upload-only internal flow

If the AAB is already built and you do **not** want another version bump:

```bash
cd android
fastlane android upload_internal_aab
# or with Bundler:
bundle exec fastlane android upload_internal_aab
```

---

## Production Release

### Full production flow

```bash
./android/deploy_with_notes.sh --minor --production
```

This flow:

1. Bumps the version
2. Generates or reuses release notes (`android/release_notes_<VERSION>.txt`)
3. Pauses for you to edit release notes
4. Builds the production AAB (also reads URLs from `.env`)
5. Uploads to the Play production track

### Production upload-only flow

```bash
cd android
fastlane android upload_production_aab
```

---

## Versioning

Format: `MAJOR.MINOR.PATCH+VERSION_CODE`

| Flag | Effect |
|------|--------|
| `--minor` | Increments PATCH + versionCode |
| `--major` | Increments MINOR, resets PATCH, increments versionCode |

> Google Play requires a strictly increasing integer `versionCode`.

---

## Current Release History

| Version | Track | Notes |
|---------|-------|-------|
| 4.4.4+172 | Internal | First build with URL injected via `--dart-define` |
| 4.4.4+173 | Internal | URLs sourced from `.env` via deploy script |
| 4.4.6+174 | Internal | `.env`-driven URL — no hardcoded URLs anywhere |

---

## Common Commands

```bash
# From project root
./android/deploy_internal_minor.sh       # Internal: bump + build + upload (reads .env)

# From android/ directory
./update_version.sh --current-version    # Show current version
./update_version.sh --minor              # Bump only (no build/upload)
./deploy_with_notes.sh --minor --production  # Full production flow
fastlane android upload_internal_aab     # Upload pre-built AAB to internal
fastlane android upload_production_aab   # Upload pre-built AAB to production
```

---

## Troubleshooting

### "PRODUCTION_URL is not set in .env"
Make sure the `.env` file exists at the project root and contains a `PRODUCTION_URL=...` line with no leading spaces.

### "AAB not found"
The build step failed. Check the Flutter build output above the error. Common causes: signing config missing, Gradle version mismatch.

### Version rollback
If the upload fails after the version bump, the script automatically restores `pubspec.yaml` and `local.properties` via the `rollback_version` trap.

### Fastlane Gemfile warning
If you see `you didn't use bundle exec`, it's a warning only — not an error. Fastlane still runs correctly. To silence it, use `bundle exec fastlane ...` instead.
