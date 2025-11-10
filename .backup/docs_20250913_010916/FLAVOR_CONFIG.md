# Flavor Configuration Guide

## Overview

This project has been configured with multiple flavors to support different environments:

- **Development**: For development and testing purposes
- **Production**: For production releases

## Configuration Details

### Environment Configuration

Environment-specific configurations are located in:

```
lib/config/env/
├── development.dart
├── production.dart
└── environment.dart
```

### Entry Points

Separate entry points have been created for each flavor:

```
lib/
├── main_development.dart
├── main_production.dart
```

## Running the App

### Android

To run the development flavor:

```bash
flutter run --flavor development -t lib/main_development.dart
```

To run the production flavor:

```bash
flutter run --flavor production -t lib/main_production.dart
```

### iOS

To run the development flavor:

```bash
flutter run --flavor development -t lib/main_development.dart
```

To run the production flavor:

```bash
flutter run --flavor production -t lib/main_production.dart
```

## Building the App

### Android

To build the development APK:

```bash
flutter build apk --flavor development -t lib/main_development.dart
```

To build the production APK:

```bash
flutter build apk --flavor production -t lib/main_production.dart
```

To build the development AAB (App Bundle):

```bash
flutter build appbundle --flavor development -t lib/main_development.dart
```

To build the production AAB (App Bundle):

```bash
flutter build appbundle --flavor production -t lib/main_production.dart
```

### iOS

To build the development IPA:

```bash
flutter build ios --flavor development -t lib/main_development.dart
```

To build the production IPA:

```bash
flutter build ios --flavor production -t lib/main_production.dart
```

## Fastlane Integration

Fastlane has been configured for Android to automate the build and deployment process:

### Android

To deploy the development version to Google Play (internal testing):

```bash
cd android && fastlane deploy_development
```

To deploy the production version to Google Play (production track):

```bash
cd android && fastlane deploy_production
```

## Version Code Auto-increment

The version code is automatically incremented when deploying using Fastlane. The implementation is in the `android/fastlane/Fastfile`.

## App Icons

Different app icons have been configured for each flavor using `flutter_launcher_icons` in `pubspec.yaml`.

To generate the icons for all flavors:

```bash
flutter pub run flutter_launcher_icons
```

## CI/CD Integration

A GitHub Actions workflow has been set up in `.github/workflows/flutter_ci.yml` to automate the build and deployment process.