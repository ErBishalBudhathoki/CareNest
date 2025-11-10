# Deep Linking and Photo Display Implementation Documentation

## Overview

This document provides comprehensive documentation for the implementation of deep linking functionality and photo display features in the Flutter invoice application. The implementation includes domain configuration, app linking setup for both Android and iOS platforms, and user photo display in the settings view.

## Table of Contents

1. [Deep Linking Implementation](#deep-linking-implementation)
2. [Photo Display Implementation](#photo-display-implementation)
3. [Configuration Files](#configuration-files)
4. [Testing and Verification](#testing-and-verification)
5. [Troubleshooting](#troubleshooting)

## Deep Linking Implementation

### 1. Domain Configuration

#### Environment Setup
The application uses environment-based configuration for the base URL:

**File: `lib/env.dart`**
```dart
Map<String, String> env = {
  'baseUrl': 'https://bishalbudhathoki.tech',
  // Other environment variables...
};
```

#### Deep Link Handler
The `DeepLinkHandler` class manages all deep linking functionality:

**File: `lib/deep_link_handler.dart`**

**Key Features:**
- Dynamic base URL configuration from environment
- Signup link generation with organization codes
- Link validation and organization code extraction
- Navigation handling for deep links

**Main Methods:**
- `generateSignupLink(String orgCode)`: Creates signup URLs with organization codes
- `isValidSignupLink(String link)`: Validates incoming deep links
- `extractOrgCodeFromLink(String link)`: Extracts organization codes from URLs
- `handleDeepLink(String link)`: Processes and navigates based on deep links

### 2. Android App Links Configuration

#### AndroidManifest.xml Setup
**File: `android/app/src/main/AndroidManifest.xml`**

```xml
<!-- Custom URL Scheme Intent Filter -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="com.bishal.invoice" />
</intent-filter>

<!-- HTTP/HTTPS Intent Filters -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="http" />
</intent-filter>

<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" />
</intent-filter>

<!-- App Links for Domain -->
<intent-filter android:autoVerify="true">
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    <data android:scheme="https" android:host="bishalbudhathoki.tech" />
</intent-filter>
```

**Configuration Details:**
- `android:autoVerify="true"`: Enables automatic verification of App Links
- Multiple intent filters for different URL schemes
- Specific domain configuration for `bishalbudhathoki.tech`

### 3. iOS Universal Links Configuration

#### Info.plist Setup
**File: `ios/Runner/Info.plist`**

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>com.bishal.invoice</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.bishal.invoice</string>
            <string>http</string>
            <string>https</string>
        </array>
    </dict>
    <dict>
        <key>CFBundleURLName</key>
        <string>bishalbudhathoki.tech</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
</array>
```

**Configuration Details:**
- Multiple URL types for different schemes
- Custom scheme support (`com.bishal.invoice`)
- Universal Links support for the domain

## Photo Display Implementation

### 1. PhotoDisplayWidget Integration

The settings view was updated to display user photos using the existing `PhotoDisplayWidget`:

#### Settings View Updates
**File: `lib/views/settings_view.dart`**

**Key Changes:**
1. Added `photoData` parameter to constructor
2. Imported `PhotoDisplayWidget` and `dart:typed_data`
3. Replaced static `CircleAvatar` with dynamic `PhotoDisplayWidget`

```dart
// Constructor update
const SettingsView({
  Key? key,
  required this.organizationId,
  required this.organizationName,
  required this.organizationCode,
  required this.userEmail,
  required this.userName,
  required this.photoData, // Added photo data parameter
}) : super(key: key);

// Widget implementation
PhotoDisplayWidget(
  photoData: widget.photoData,
  radius: 50,
  borderWidth: 3,
  borderColor: Colors.white,
),
```

#### Navigation Updates
**File: `lib/widgets/bottom_navBar_widget.dart`**

**Key Changes:**
- Updated `SettingsView` instantiation to pass `_photoData`

```dart
SettingsView(
  organizationId: widget.organizationId,
  organizationName: widget.organizationName,
  organizationCode: widget.organizationCode,
  userEmail: widget.userEmail,
  userName: widget.userName,
  photoData: _photoData, // Added photo data parameter
),
```

### 2. PhotoDisplayWidget Features

The `PhotoDisplayWidget` provides:
- Automatic fallback to placeholder when no photo data
- Circular image display with customizable radius
- Border styling options
- Consistent photo display across the application

## Configuration Files

### Environment Configuration
**File: `lib/env.dart`**
- Contains base URL and other environment variables
- Used by `DeepLinkHandler` for dynamic URL generation

### Deep Link Handler
**File: `lib/deep_link_handler.dart`**
- Central management of all deep linking functionality
- Environment-aware URL generation
- Link validation and processing

### Platform Configurations
- **Android**: `android/app/src/main/AndroidManifest.xml`
- **iOS**: `ios/Runner/Info.plist`

## Testing and Verification

### 1. Deep Link Testing

#### Android Testing
```bash
# Test custom scheme
adb shell am start -W -a android.intent.action.VIEW -d "com.bishal.invoice://signup?orgCode=ABC123" com.bishal.invoice

# Test HTTPS link
adb shell am start -W -a android.intent.action.VIEW -d "https://bishalbudhathoki.tech/signup?orgCode=ABC123" com.bishal.invoice
```

#### iOS Testing
```bash
# Test custom scheme
xcrun simctl openurl booted "com.bishal.invoice://signup?orgCode=ABC123"

# Test Universal Link
xcrun simctl openurl booted "https://bishalbudhathoki.tech/signup?orgCode=ABC123"
```

### 2. Photo Display Testing

1. **With Photo Data**: Verify user photos display correctly in settings
2. **Without Photo Data**: Confirm placeholder icon appears
3. **Navigation**: Test photo display consistency across app navigation

### 3. Domain Verification

#### Android App Links
1. Upload `assetlinks.json` to `https://bishalbudhathoki.tech/.well-known/assetlinks.json`
2. Verify domain ownership in Google Play Console
3. Test automatic link verification

#### iOS Universal Links
1. Upload `apple-app-site-association` to `https://bishalbudhathoki.tech/.well-known/apple-app-site-association`
2. Configure proper JSON structure with app identifiers
3. Test Universal Link functionality

## Troubleshooting

### Common Issues

#### Deep Links Not Working
1. **Check Intent Filters**: Verify AndroidManifest.xml configuration
2. **Domain Verification**: Ensure proper domain verification files
3. **URL Format**: Confirm URL structure matches expected format
4. **App Installation**: Verify app is properly installed and configured

#### Photo Display Issues
1. **Data Format**: Ensure photo data is in correct Uint8List format
2. **Widget Parameters**: Verify PhotoDisplayWidget receives proper parameters
3. **Navigation**: Check photo data is passed through navigation correctly

#### Environment Configuration
1. **Base URL**: Verify env.dart contains correct domain
2. **Build Configuration**: Ensure environment files are included in build
3. **Import Statements**: Check all necessary imports are present

### Debug Commands

```bash
# Check Android intent filters
adb shell dumpsys package com.bishal.invoice | grep -A 20 "Activity Resolver Table"

# Monitor deep link handling
adb logcat | grep -i "intent"

# Flutter debug output
flutter logs
```

## Implementation Summary

This implementation provides:

1. **Robust Deep Linking**: Environment-aware URL generation and handling
2. **Cross-Platform Support**: Consistent functionality across Android and iOS
3. **Photo Integration**: Seamless user photo display in settings
4. **Maintainable Code**: Clean separation of concerns and reusable components
5. **Production Ready**: Proper domain configuration and verification setup

The solution ensures that signup links with the actual domain (`bishalbudhathoki.tech`) properly redirect to the Flutter application while maintaining a consistent user experience for photo display throughout the app.