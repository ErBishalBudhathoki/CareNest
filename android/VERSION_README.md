# App Versioning and Deployment Automation

This directory contains scripts to automate the versioning and deployment process for app releases. The scripts handle version code increments, version name updates, release notes generation, and deployment to Google Play.

## How to Use

### View Current Version

To check the current version code and version name:

```bash
./update_version.sh --current-version
```

### Minor Version Update

For minor updates (increments version code by 0.1):

```bash
./update_version.sh --minor
```

When the decimal part reaches 1.0, the integer part will automatically increment by 1.

### Major Version Update

For major updates (increments version code by 1):

```bash
./update_version.sh --major
```

### Generate Release Notes Template

To generate a release notes template for the current version:

```bash
./update_version.sh --release-notes
```

This will create a file named `release_notes_YYYY.MM.DD.txt` with sections for new features, bug fixes, improvements, and other changes.

## Version Management

- **Version Code**: Format X.Y where:
  - X: Integer part that increases with major updates or when Y reaches 1.0
  - Y: Decimal part that increases by 0.1 with each minor update
- **Version Name**: Set to the current date in YYYY.MM.DD format

Note: Only the integer part (X) is used for the actual Android version code in the Play Store, as Android requires integer version codes.

## Deployment with Fastlane

A deployment script is provided to automate the process of updating versions, generating release notes, and deploying to Google Play:

```bash
./deploy_with_notes.sh [options]
```

### Options

- `--minor`: Perform a minor version update (0.1 increment)
- `--major`: Perform a major version update (1.0 increment)
- `--development`: Deploy to internal testing track
- `--production`: Deploy to production track
- `--skip-build`: Skip the Flutter build step

### Example Usage

```bash
# Minor update and deploy to production
./deploy_with_notes.sh --minor --production

# Major update and deploy to internal testing
./deploy_with_notes.sh --major --development
```

### Detailed Documentation

For more detailed information about the deployment process, see [FASTLANE_DEPLOYMENT.md](./FASTLANE_DEPLOYMENT.md).

## Manual Deployment Process

If you prefer to deploy manually instead of using the automated script, follow these steps:

1. Run the appropriate version update command (--minor or --major)
2. Generate release notes with --release-notes
3. Fill in the release notes template
4. Build the app bundle with `flutter build appbundle --flavor production --release`
5. Deploy to Google Play Store with `fastlane deploy_production`

Alternatively, use the automated script which combines all these steps:

```bash
./deploy_with_notes.sh --minor --production
```

## Notes

- The script automatically updates the `local.properties` file with the new version information
- Version code must always be higher than the previous release on Google Play Store
- The version name is automatically set to the current date