# Developer Guide

## Overview

This guide provides instructions for developers working on the Invoice application, covering how to use the different flavors, run the application, and understand the CI/CD pipeline.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Project Setup](#project-setup)
3. [Running the Application](#running-the-application)
4. [Using Flavors](#using-flavors)
5. [Firebase Configuration](#firebase-configuration)
6. [Fastlane Usage](#fastlane-usage)
7. [CI/CD Pipeline](#cicd-pipeline)
8. [Versioning](#versioning)

## Prerequisites

- Flutter SDK (version 3.19.0 or later)
- Android Studio / Xcode
- Git
- Ruby (for Fastlane)
- Fastlane installed (`gem install fastlane`)

## Project Setup

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd invoice
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Set up Firebase configuration files:
   - For Android: Place the appropriate `google-services.json` files in:
     - `android/app/src/development/`
     - `android/app/src/production/`
   - For iOS: Place the appropriate `GoogleService-Info.plist` files in:
     - `ios/Runner/Config/Development/`
     - `ios/Runner/Config/Production/`

4. Set up Google Play API key (for Android deployment):
   - Place your Google Play API key JSON file at `android/fastlane/google-play-service-key.json`

5. Set up Apple certificates (for iOS deployment):
   - Configure your Apple Developer account credentials in `ios/fastlane/Appfile`

## Running the Application

### Development Flavor

```bash
# For Android
flutter run --flavor development

# For iOS
flutter run --flavor development -d "iPhone 16 Plus"
```

### Production Flavor

```bash
# For Android
flutter run --flavor production

# For iOS
flutter run --flavor production -d "iPhone 16 Plus"
```

## Using Flavors

The application is configured with two flavors:

### Development

- Android:
  - Application ID: `com.bishal.invoice.dev`
  - App Name: "Invoice Dev"
  - Version Name Suffix: "-dev"

- iOS:
  - Bundle ID: `com.bishal.invoice.dev`
  - Configuration: `Release-Development`

### Production

- Android:
  - Application ID: `com.bishal.invoice`
  - App Name: "Invoice"

- iOS:
  - Bundle ID: `com.bishal.invoice`
  - Configuration: `Release`

## Firebase Configuration

The application uses separate Firebase configurations for each flavor:

- Development: Uses Firebase project configured for the development environment
- Production: Uses Firebase project configured for the production environment

If you need to update the Firebase configuration:

1. Download the new configuration files from the Firebase Console
2. Replace the files in the appropriate directories:
   - Android: `android/app/src/development/` and `android/app/src/production/`
   - iOS: `ios/Runner/Config/Development/` and `ios/Runner/Config/Production/`

## Fastlane Usage

### Android

```bash
cd android

# Deploy to internal track (Development)
fastlane deploy_development

# Deploy to production track (Production)
fastlane deploy_production

# Only increment version code
fastlane increment_version_code
```

### iOS

```bash
cd ios

# Increment build number
fastlane increment_build_number

# Deploy to TestFlight (Development) - Uncomment in Fastfile first
# fastlane deploy_development

# Deploy to TestFlight (Production) - Uncomment in Fastfile first
# fastlane deploy_production
```

## CI/CD Pipeline

The project uses GitHub Actions for CI/CD. The workflow is defined in `.github/workflows/flutter_ci.yml`.

### Automatic Triggers

- **Pull Requests to `main`**: Runs tests and builds the development APK
- **Push to `main`**: Runs tests, builds the production APK, and deploys to Google Play production track

### Manual Triggers

You can manually trigger the workflow from the GitHub Actions tab with the following options:

- **Deploy Target**: Choose between `development` and `production`

### Required Secrets

The following secrets need to be configured in the GitHub repository:

- `GOOGLE_PLAY_API_KEY`: The Google Play API key in JSON format
- `IOS_P12_CERTIFICATE`: The iOS P12 certificate in base64 format (for future use)
- `IOS_P12_PASSWORD`: The password for the iOS P12 certificate (for future use)
- `APPLE_API_KEY`: The Apple API key (for future use)
- `APPLE_API_ISSUER`: The Apple API issuer (for future use)

## Versioning

### Android

The Android version code is stored in `android/local.properties`:

```properties
flutter.versionCode=1
flutter.versionName=2023.02.02
```

The `increment_version_code` lane in the Android Fastfile automatically increments the version code before each deployment.

### iOS

The iOS build number is managed using Fastlane's `increment_build_number` action, which updates the build number in the Xcode project.

## Troubleshooting

### Common Issues

1. **Firebase Configuration Missing**
   - Ensure the Firebase configuration files are placed in the correct directories for each flavor

2. **Google Play API Key Issues**
   - Verify that the `google-play-service-key.json` file is valid and has the correct permissions

3. **iOS Certificate Problems**
   - Check that your Apple Developer account has the correct provisioning profiles and certificates

4. **Flavor Build Failures**
   - Ensure that all flavor-specific resources and configurations are properly set up

### Getting Help

If you encounter issues not covered in this guide, please:

1. Check the [detailed documentation](./FLAVOR_CICD_DOCUMENTATION.md) for more information
2. Review the [CI/CD workflow diagrams](./docs/CICD_WORKFLOW.md) for a visual understanding of the process
3. Contact the project maintainers for assistance