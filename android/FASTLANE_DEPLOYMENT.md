# Fastlane Deployment Guide

## Overview

This project now has two verified Android release flows:

- Internal testing: bump minor version, build production AAB, upload to Play internal testing
- Production release: bump version, build production AAB, review release notes, upload to Play production

The production flavor always builds from:

```bash
lib/main_production.dart
```

## Prerequisites

- Fastlane installed locally
- Google Play service account key at `android/fastlane/google-play-service-key.json`
- Valid Android signing config
- Run commands from the `android/` directory unless noted otherwise

## Internal Testing

### One-shot internal flow

This is the preferred internal testing command:

```bash
./deploy_internal_minor.sh
```

It performs exactly 3 steps:

1. `./update_version.sh --minor`
2. `flutter build appbundle --flavor production -t lib/main_production.dart --release`
3. `fastlane android upload_internal_aab`

Notes:

- Internal testing does **not** require release notes editing
- Fastlane uses a default internal changelog when needed
- This flow was tested end to end successfully against Google Play internal testing

### Upload-only internal flow

If the AAB is already built and you do **not** want another version bump:

```bash
fastlane android upload_internal_aab
```

If Bundler is configured correctly on your machine, you can also use:

```bash
bundle exec fastlane android upload_internal_aab
```

## Production Release

### Trusted production flow

Use:

```bash
./deploy_with_notes.sh --minor --production
```

This flow:

1. bumps the version
2. generates or reuses release notes
3. pauses for release notes editing
4. builds the production AAB
5. uploads that built AAB to Google Play production

Production releases still preserve release notes/changelog behavior.

### Production upload-only flow

If the AAB is already built and notes are already prepared:

```bash
fastlane android upload_production_aab
```

## Versioning

Version format is:

```bash
MAJOR.MINOR.PATCH+VERSION_CODE
```

Example:

```bash
4.2.6+48
```

Rules:

- `--minor` increments patch and version code
- `--major` increments minor, resets patch, and increments version code
- Google Play requires an integer `versionCode`, so values like `45.1` are not valid

## Verified Fixes

The release tooling was updated and verified for:

- production build uses `-t lib/main_production.dart`
- internal upload no longer requires release notes
- production upload still supports release notes
- Fastlane resolves the AAB path correctly for Play uploads
- internal upload lane includes `package_name: com.bishal.invoice`

## Common Commands

```bash
cd android
./update_version.sh --current-version
./update_version.sh --minor
./deploy_internal_minor.sh
./deploy_with_notes.sh --minor --production
fastlane android upload_internal_aab
fastlane android upload_production_aab
```
