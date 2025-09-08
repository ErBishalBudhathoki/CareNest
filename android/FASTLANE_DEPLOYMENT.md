# Fastlane Deployment Guide

## Overview

This guide explains how to deploy the Invoice app to Google Play using Fastlane with release notes.

## Prerequisites

- Fastlane installed and configured
- Google Play Service Account key (JSON) in `android/fastlane/google-play-service-key.json`
- Flutter project built with release AAB

## Deployment Process

### 1. Update Version and Generate Release Notes

Before deploying, update the app version and generate release notes:

```bash
# Navigate to the android directory
cd android

# Check current version
./update_version.sh --current-version

# For minor updates (increments by 0.1)
./update_version.sh --minor

# For major updates (increments by 1.0)
./update_version.sh --major

# Generate release notes template
./update_version.sh --release-notes
```

### 2. Edit Release Notes

The release notes template is generated at `android/release_notes_YYYY.MM.DD.txt`. Edit this file to include details about your release:

```
# Release Notes for Invoice App - Version YYYY.MM.DD

## New Features
- Added new payment method
- Improved invoice template selection

## Bug Fixes
- Fixed crash when opening large invoices
- Resolved issue with tax calculation

## Improvements
- Faster loading of invoice history
- Reduced app size

## Other Changes
- Updated dependencies
- Improved error messages
```

### 3. Build the App

Build the app using Flutter:

```bash
# For production release
flutter build appbundle --flavor production --release
```

### 4. Deploy with Fastlane

Deploy to Google Play using Fastlane:

```bash
# Navigate to the android directory
cd android

# Deploy to production
fastlane deploy_production

# Or deploy to internal testing
fastlane deploy_development
```

Fastlane will automatically:
1. Increment the version code
2. Find and use the release notes file based on the current version name
3. Create a metadata directory with changelogs for Google Play
4. Upload the AAB to Google Play with the release notes

## Troubleshooting

### Release Notes Not Found

If the release notes file is not found, Fastlane will use a default message: "Bug fixes and performance improvements". To ensure your release notes are used:

1. Make sure the release notes file is named correctly: `release_notes_YYYY.MM.DD.txt`
2. Verify the version name in `local.properties` matches the date in the filename
3. Ensure the file is in the `android` directory

Note: Fastlane now creates a metadata directory with changelogs automatically during deployment. The release notes from your file will be copied to the appropriate changelog file for Google Play.

### Version Code Issues

If you encounter version code conflicts with Google Play:

1. Check the current version on Google Play Console
2. Update your local version code to match or exceed it:
   ```bash
   # Edit local.properties manually or use the update_version.sh script
   ```

## Additional Resources

- [Fastlane Documentation](https://docs.fastlane.tools)
- [Google Play Publishing API](https://developers.google.com/android-publisher)