# App Versioning and Deployment Automation

This directory contains the Android release scripts used for Google Play internal testing and production releases.

## Current Version Format

The app uses standard Flutter semver plus Android build code:

```bash
MAJOR.MINOR.PATCH+VERSION_CODE
```

Example:

```bash
4.2.6+48
```

Important:

- `versionName` is `MAJOR.MINOR.PATCH`
- `versionCode` is the integer after `+`
- Google Play only accepts integer version codes

## Version Script

### Show current version

```bash
./update_version.sh --current-version
```

### Minor update

```bash
./update_version.sh --minor
```

Behavior:

- increments patch
- increments version code

Example:

```bash
4.2.5+47 -> 4.2.6+48
```

### Major update

```bash
./update_version.sh --major
```

Behavior:

- increments minor
- resets patch to `0`
- increments version code

Example:

```bash
4.2.6+48 -> 4.3.0+49
```

## Internal Testing Release

Preferred command:

```bash
./deploy_internal_minor.sh
```

This runs:

1. minor version bump
2. production AAB build
3. internal Play upload

Internal testing does not require manual release notes.

If the bundle is already built:

```bash
fastlane android upload_internal_aab
```

## Production Release

Preferred command:

```bash
./deploy_with_notes.sh --minor --production
```

Production release still includes the release-notes editing step.

If the bundle is already built and notes are already ready:

```bash
fastlane android upload_production_aab
```

## Build Command

Production bundles are built with:

```bash
flutter build appbundle --flavor production -t lib/main_production.dart --release
```

## Documentation

For full deployment details, see:

- [FASTLANE_DEPLOYMENT.md](./FASTLANE_DEPLOYMENT.md)
