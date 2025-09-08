# Flutter Project Configuration Documentation

## Overview

This document provides a comprehensive guide to the configuration setup for the Invoice application, including flavor management, Firebase configuration, Fastlane deployment automation, and GitHub Actions CI/CD pipeline.

## Table of Contents

1. [Project Structure](#project-structure)
2. [Flavor Configuration](#flavor-configuration)
3. [Firebase Configuration](#firebase-configuration)
4. [Fastlane Setup](#fastlane-setup)
5. [GitHub Actions CI/CD](#github-actions-cicd)
6. [Versioning Automation](#versioning-automation)

## Project Structure

The project is organized with the following key directories:

```
/Users/pratikshatiwari/StudioProjects/invoice/
├── android/                  # Android project files
│   ├── app/                  # Android app module
│   │   ├── src/              # Source code
│   │   │   ├── development/  # Development flavor specific files
│   │   │   ├── production/   # Production flavor specific files
│   │   │   └── main/         # Common files
│   ├── fastlane/             # Android Fastlane configuration
├── ios/                      # iOS project files
│   ├── Runner/               # iOS app module
│   │   ├── Config/           # Configuration files
│   │   │   ├── Development/  # Development flavor specific files
│   │   │   └── Production/   # Production flavor specific files
│   ├── fastlane/             # iOS Fastlane configuration
├── .github/                  # GitHub configuration
│   └── workflows/            # GitHub Actions workflows
└── lib/                      # Dart/Flutter source code
```

## Flavor Configuration

### Android Flavor Configuration

The Android app is configured with two flavors: `development` and `production`. These are defined in the `android/app/build.gradle` file:

```gradle
flavorDimensions "default"
productFlavors {
    development {
        dimension "default"
        applicationIdSuffix ".dev"
        versionNameSuffix "-dev"
        resValue "string", "app_name", "Invoice Dev"
    }
    production {
        dimension "default"
        resValue "string", "app_name", "Invoice"
    }
}
```

### iOS Flavor Configuration

The iOS app uses different configurations for development and production builds:

- `Development` configuration with bundle ID `com.bishal.invoice.dev`
- `Production` configuration with bundle ID `com.bishal.invoice`

The configuration files are located in:

- `/Users/pratikshatiwari/StudioProjects/invoice/ios/Flutter/Release-Development.xcconfig`
- `/Users/pratikshatiwari/StudioProjects/invoice/ios/Flutter/Release.xcconfig` (for Production)

## Firebase Configuration

### Android Firebase Configuration

Firebase configuration files for Android are placed in flavor-specific directories:

- Development: `/Users/pratikshatiwari/StudioProjects/invoice/android/app/src/development/google-services.json`
- Production: `/Users/pratikshatiwari/StudioProjects/invoice/android/app/src/production/google-services.json`

These files were copied from the original `google-services.json` located in the `android/app` directory.

### iOS Firebase Configuration

Firebase configuration files for iOS are placed in flavor-specific directories:

- Development: `/Users/pratikshatiwari/StudioProjects/invoice/ios/Runner/Config/Development/GoogleService-Info.plist`
- Production: `/Users/pratikshatiwari/StudioProjects/invoice/ios/Runner/Config/Production/GoogleService-Info.plist`

These files were copied from the original `GoogleService-Info.plist` located in the `ios/Runner` directory.

## Fastlane Setup

### Android Fastlane Configuration

Fastlane is configured for Android deployment with the following files:

1. **Appfile** (`/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/Appfile`):
   ```ruby
json_key_file("google-play-service-key.json")
```

2. **Fastfile** (`/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/Fastfile`):
   ```ruby
default_platform(:android)

platform :android do
  desc "Increment version code"
  lane :increment_version_code do
    path = "../local.properties"
    re = /flutter\.versionCode=(\d+)/
    s = File.read(path)
    versionCode = s[re, 1].to_i
    s[re, 1] = (versionCode + 1).to_s
    f = File.new(path, 'w')
    f.write(s)
    f.close
  end

  desc "Deploy a new version to the internal track"
  lane :deploy_development do
    increment_version_code
    gradle(
      task: "bundle",
      build_type: "Release",
      flavor: "development",
    )
    upload_to_play_store(
      track: "internal",
      json_key: "google-play-service-key.json",
      package_name: "com.bishal.invoice.dev"
    )
  end

  desc "Deploy a new version to the production track"
  lane :deploy_production do
    increment_version_code
    gradle(
      task: "bundle",
      build_type: "Release",
      flavor: "production",
    )
    upload_to_play_store(
      track: "production",
      json_key: "google-play-service-key.json",
      package_name: "com.bishal.invoice"
    )
  end
end
```

3. **Google Play Service Key** (`/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/google-play-service-key.json`):
   - This is a placeholder file that needs to be replaced with the actual Google Play API key.

### iOS Fastlane Configuration

Fastlane is configured for iOS deployment with the following files:

1. **Appfile** (`/Users/pratikshatiwari/StudioProjects/invoice/ios/fastlane/Appfile`):
   ```ruby
app_identifier("com.bishal.invoice") # The bundle identifier of your app
# apple_id("[[APPLE_ID]]") # Your Apple email address
```

2. **Fastfile** (`/Users/pratikshatiwari/StudioProjects/invoice/ios/fastlane/Fastfile`):
   ```ruby
default_platform(:ios)

platform :ios do
  desc "Increment build number"
  lane :increment_build_number do
    increment_build_number(xcodeproj: "Runner.xcodeproj")
  end

  # desc "Push a new development build to TestFlight"
  # lane :deploy_development do
  #   increment_build_number(xcodeproj: "Runner.xcodeproj")
  #   build_app(workspace: "Runner.xcworkspace", scheme: "development", 
  #             export_method: "app-store",
  #             export_options: {
  #               provisioningProfiles: { 
  #                 "com.bishal.invoice.dev" => "match AppStore com.bishal.invoice.dev"
  #               }
  #             })
  #   upload_to_testflight
  # end

  # desc "Push a new production build to TestFlight"
  # lane :deploy_production do
  #   increment_build_number(xcodeproj: "Runner.xcodeproj")
  #   build_app(workspace: "Runner.xcworkspace", scheme: "production", 
  #             export_method: "app-store",
  #             export_options: {
  #               provisioningProfiles: { 
  #                 "com.bishal.invoice" => "match AppStore com.bishal.invoice"
  #               }
  #             })
  #   upload_to_testflight
  # end
end
```

## GitHub Actions CI/CD

The CI/CD pipeline is configured using GitHub Actions in the file `.github/workflows/flutter_ci.yml`:

```yaml
name: Flutter CI/CD

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]
  workflow_dispatch:
    inputs:
      deploy_target:
        description: 'Deploy target (development or production)'
        required: true
        default: 'development'
        type: choice
        options:
          - development
          - production

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.19.0'
          channel: 'stable'
      - run: flutter pub get
      - run: flutter analyze
      
      # Build Android APK based on deploy_target or pull_request
      - name: Build Android APK (Development)
        if: github.event_name == 'pull_request' || (github.event_name == 'workflow_dispatch' && github.event.inputs.deploy_target == 'development')
        run: flutter build apk --flavor development
      
      - name: Build Android APK (Production)
        if: github.event_name == 'push' || (github.event_name == 'workflow_dispatch' && github.event.inputs.deploy_target == 'production')
        run: flutter build apk --flavor production
      
      # Setup Ruby and Fastlane
      - uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.0'
          bundler-cache: true
      - name: Install Fastlane
        run: gem install fastlane
      
      # Deploy to Google Play
      - name: Deploy to Google Play
        if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
        env:
          GOOGLE_PLAY_API_KEY: ${{ secrets.GOOGLE_PLAY_API_KEY }}
        run: |
          echo "$GOOGLE_PLAY_API_KEY" > android/fastlane/google-play-service-key.json
          cd android
          fastlane deploy_${{ github.event.inputs.deploy_target || 'production' }}
      
      # iOS Certificate Setup (commented out for future use)
      # - name: Setup iOS certificates
      #   if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
      #   uses: apple-actions/import-codesign-certs@v1
      #   with:
      #     p12-file-base64: ${{ secrets.IOS_P12_CERTIFICATE }}
      #     p12-password: ${{ secrets.IOS_P12_PASSWORD }}
      
      # Deploy to TestFlight (commented out for future use)
      # - name: Deploy to TestFlight
      #   if: github.event_name == 'push' || github.event_name == 'workflow_dispatch'
      #   env:
      #     APPLE_API_KEY: ${{ secrets.APPLE_API_KEY }}
      #     APPLE_API_ISSUER: ${{ secrets.APPLE_API_ISSUER }}
      #   run: |
      #     cd ios
      #     fastlane deploy_${{ github.event.inputs.deploy_target || 'production' }}
```

## Versioning Automation

Versioning is automated using Fastlane and local properties files:

### Android Versioning

The Android version code is stored in `android/local.properties`:

```properties
flutter.versionCode=1
flutter.versionName=2023.02.02
```

The `increment_version_code` lane in the Android Fastfile increments this value before each deployment.

### iOS Versioning

The iOS build number is managed using Fastlane's `increment_build_number` action, which updates the build number in the Xcode project.

## Deployment Flow Diagram

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│  Code Changes   │────▶│  GitHub Push   │────▶│ GitHub Actions  │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └────────┬────────┘
                                                         │
                                                         ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│   App Store     │◀────│  iOS Fastlane  │◀────│ Build & Test    │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └────────┬────────┘
                                                         │
                                                         ▼
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│   Google Play   │◀────│Android Fastlane │◀────│ Version Bump    │
│                 │     │                 │     │                 │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

## Required Secrets for CI/CD

The following secrets need to be added to the GitHub repository for the CI/CD pipeline to work:

1. `GOOGLE_PLAY_API_KEY`: The Google Play API key in JSON format
2. `IOS_P12_CERTIFICATE`: The iOS P12 certificate in base64 format (for future use)
3. `IOS_P12_PASSWORD`: The password for the iOS P12 certificate (for future use)
4. `APPLE_API_KEY`: The Apple API key (for future use)
5. `APPLE_API_ISSUER`: The Apple API issuer (for future use)

## Files Created or Modified

### Created Files

1. `/Users/pratikshatiwari/StudioProjects/invoice/ios/Runner/Config/Development/GoogleService-Info.plist`
2. `/Users/pratikshatiwari/StudioProjects/invoice/ios/Runner/Config/Production/GoogleService-Info.plist`
3. `/Users/pratikshatiwari/StudioProjects/invoice/android/app/src/development/google-services.json`
4. `/Users/pratikshatiwari/StudioProjects/invoice/android/app/src/production/google-services.json`
5. `/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/google-play-service-key.json` (placeholder)
6. `/Users/pratikshatiwari/StudioProjects/invoice/ios/fastlane/Appfile`
7. `/Users/pratikshatiwari/StudioProjects/invoice/ios/fastlane/Fastfile`

### Modified Files

1. `/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/Appfile`
2. `/Users/pratikshatiwari/StudioProjects/invoice/android/fastlane/Fastfile`
3. `/Users/pratikshatiwari/StudioProjects/invoice/android/local.properties` (added `flutter.versionCode=1`)
4. `/Users/pratikshatiwari/StudioProjects/invoice/.github/workflows/flutter_ci.yml`

## Conclusion

This documentation provides a comprehensive overview of the configuration setup for the Invoice application. By following this guide, you can understand how the project is structured, how flavors are configured, how Firebase is set up for different environments, how Fastlane is used for deployment automation, and how GitHub Actions is configured for CI/CD.