# Hybrid Deep Linking Documentation

## Overview

This document describes the comprehensive hybrid deep linking implementation that supports multiple URL schemes and domain-based links simultaneously. The system handles custom URL schemes (`com.bishal.invoice://`), multiple domain-based links (`https://com.bishal.invoice/`, `https://bishalbudhathoki.tech/`, `https://bishalbudhathoki.com/`), and provides maximum flexibility and compatibility across different platforms and use cases.

## Implementation Features

### Multi-Format Support
- **Custom Scheme**: `com.bishal.invoice://signup?orgCode=ABC123`
- **Primary Domain**: `https://com.bishal.invoice/signup?orgCode=ABC123`
- **Tech Domain**: `https://bishalbudhathoki.tech/signup?orgCode=ABC123`
- **Base Domain**: `https://bishalbudhathoki.com/signup?orgCode=ABC123`
- **HTTP Support**: `http://com.bishal.invoice/signup?orgCode=ABC123` (development)
- **Automatic Detection**: The handler automatically detects and processes all formats

### Benefits of Hybrid Approach

#### Custom Scheme Benefits
- ✅ Works without domain ownership
- ✅ Direct app launching
- ✅ No web server configuration required
- ✅ Immediate functionality
- ✅ Perfect for development and testing
- ✅ No SSL certificate requirements

#### Domain-based Benefits
- ✅ Better web integration
- ✅ Fallback to website if app not installed
- ✅ Professional appearance
- ✅ SEO and marketing advantages
- ✅ Universal Links (iOS) and App Links (Android) support
- ✅ Multiple domain options for different use cases
- ✅ Backward compatibility with existing links

## Technical Implementation

### 1. Deep Link Handler Enhancement

**File: `lib/app/features/auth/utils/deep_link_handler.dart`**

#### Core Architecture

```dart
class DeepLinkHandler {
  static String get _baseUrl => Uri.parse(env['baseUrl']!).host;
  static const String _signupPath = '/signup';
  
  // Multiple supported domains for maximum compatibility
  static const List<String> _supportedDomains = [
    'com.bishal.invoice',
    'bishalbudhathoki.tech',
    'bishalbudhathoki.com'
  ];
}
```

#### Key Methods

```dart
/// Handles both custom scheme and domain-based links
static void handleDeepLink(String link)

/// Generates domain-based links by default, custom scheme optionally
static String generateSignupLink(String organizationCode, {bool useCustomScheme = false})

/// Generates custom scheme links specifically
static String generateCustomSchemeSignupLink(String organizationCode)

/// Validates both link types and all supported domains
static bool isValidSignupLink(String link)

/// Extracts org codes from both link types
static String? extractOrgCodeFromLink(String link)

/// Public navigation method for internal app use
static void navigateToSignup(BuildContext context, {String? organizationCode})
```

#### Enhanced Link Processing Logic

1. **Custom Scheme Detection**: Checks if URI scheme is `com.bishal.invoice`
2. **Multi-Domain Support**: Validates against all supported domains
3. **Path Validation**: Ensures `/signup` path for domain-based links
4. **Parameter Extraction**: Safely extracts `orgCode` from query parameters
5. **Error Handling**: Graceful handling of malformed URLs
6. **Navigation**: Routes to appropriate signup page with or without org code

#### Complete Implementation

```dart
/// Handles incoming deep links with comprehensive format support
static void handleDeepLink(String link) {
  final uri = Uri.parse(link);

  // Handle custom scheme links (com.bishal.invoice://)
  if (uri.scheme == 'com.bishal.invoice') {
    _handleCustomSchemeLink(uri);
    return;
  }

  // Handle domain-based links (multiple domains supported)
  if (_supportedDomains.contains(uri.host) && uri.path == _signupPath) {
    final orgCode = uri.queryParameters['orgCode'];

    if (orgCode != null && orgCode.isNotEmpty) {
      _navigateToSignupWithOrgCode(orgCode);
    } else {
      _navigateToSignup();
    }
  }
}

/// Handles custom scheme deep links with flexible path detection
static void _handleCustomSchemeLink(Uri uri) {
  if (uri.host == 'signup' || uri.path == '/signup' || uri.pathSegments.contains('signup')) {
    final orgCode = uri.queryParameters['orgCode'];

    if (orgCode != null && orgCode.isNotEmpty) {
      _navigateToSignupWithOrgCode(orgCode);
    } else {
      _navigateToSignup();
    }
  }
}

/// Validates links with comprehensive format checking
static bool isValidSignupLink(String link) {
  try {
    final uri = Uri.parse(link);
    
    // Check custom scheme links
    if (uri.scheme == 'com.bishal.invoice') {
      return uri.host == 'signup' || uri.path == '/signup' || uri.pathSegments.contains('signup');
    }
    
    // Check domain-based links against all supported domains
    return _supportedDomains.contains(uri.host) && uri.path == _signupPath;
  } catch (e) {
    return false;
  }
}
```

### 2. Platform Configuration

#### Android Configuration

**File: `android/app/src/main/AndroidManifest.xml`**

```xml
<!-- Comprehensive Intent Filter Configuration -->
<activity
    android:name=".MainActivity"
    android:exported="true"
    android:launchMode="singleTop"
    android:theme="@style/LaunchTheme"
    android:configChanges="orientation|keyboardHidden|keyboard|screenSize|smallestScreenSize|locale|layoutDirection|fontScale|screenLayout|density|uiMode"
    android:hardwareAccelerated="true"
    android:windowSoftInputMode="adjustResize">
    
    <!-- Standard App Launch Intent -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.MAIN"/>
        <category android:name="android.intent.category.LAUNCHER"/>
    </intent-filter>
    
    <!-- Deep Link Metadata -->
    <meta-data android:name="flutter-deeplink" android:value="true" />
    
    <!-- Multi-Scheme Support (Custom + HTTP/HTTPS) -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="com.bishal.invoice" />
        <data android:scheme="http" />
        <data android:scheme="https" />
    </intent-filter>
    
    <!-- App Links for bishalbudhathoki.tech -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https" android:host="bishalbudhathoki.tech" />
    </intent-filter>
    
    <!-- App Links for com.bishal.invoice domain -->
    <intent-filter android:autoVerify="true">
        <action android:name="android.intent.action.VIEW" />
        <category android:name="android.intent.category.DEFAULT" />
        <category android:name="android.intent.category.BROWSABLE" />
        <data android:scheme="https" android:host="com.bishal.invoice" />
    </intent-filter>
</activity>
```

#### Key Android Features
- **autoVerify="true"**: Enables automatic App Link verification
- **Multiple Intent Filters**: Separate filters for different domains and schemes
- **Comprehensive Scheme Support**: Custom scheme, HTTP, and HTTPS
- **Deep Link Metadata**: Flutter-specific configuration
- **Proper Activity Configuration**: Single top launch mode for deep links

#### iOS Configuration

**File: `ios/Runner/Info.plist`**

```xml
<key>CFBundleURLTypes</key>
<array>
    <!-- Custom Scheme Configuration -->
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.bishal.invoice</string>
        </array>
    </dict>
    
    <!-- Universal Links for bishalbudhathoki.tech -->
    <dict>
        <key>CFBundleURLName</key>
        <string>bishalbudhathoki.tech</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
    
    <!-- Universal Links for com.bishal.invoice domain -->
    <dict>
        <key>CFBundleURLName</key>
        <string>com.bishal.invoice</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>https</string>
        </array>
    </dict>
</array>

<!-- Associated Domains for Universal Links -->
<key>com.apple.developer.associated-domains</key>
<array>
    <string>applinks:bishalbudhathoki.tech</string>
    <string>applinks:com.bishal.invoice</string>
</array>

<!-- App Transport Security Configuration -->
<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    <key>NSExceptionDomains</key>
    <dict>
        <key>bishalbudhathoki.tech</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.0</string>
        </dict>
        <key>com.bishal.invoice</key>
        <dict>
            <key>NSExceptionAllowsInsecureHTTPLoads</key>
            <true/>
            <key>NSExceptionMinimumTLSVersion</key>
            <string>TLSv1.0</string>
        </dict>
    </dict>
</dict>
        </array>
    </dict>
    <!-- Universal Links Configuration -->
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

## Usage Examples

### 1. Generating Links

```dart
// Generate domain-based link (default)
String domainLink = DeepLinkHandler.generateSignupLink('ABC123');
// Result: https://bishalbudhathoki.tech/signup?orgCode=ABC123

// Generate custom scheme link
String customLink = DeepLinkHandler.generateSignupLink('ABC123', useCustomScheme: true);
// Result: com.bishal.invoice://signup?orgCode=ABC123

// Generate custom scheme link (alternative method)
String customLink2 = DeepLinkHandler.generateCustomSchemeSignupLink('ABC123');
// Result: com.bishal.invoice://signup?orgCode=ABC123
```

### 2. Link Validation

```dart
// Validates both link types
bool isValid1 = DeepLinkHandler.isValidSignupLink('https://bishalbudhathoki.tech/signup?orgCode=ABC123');
bool isValid2 = DeepLinkHandler.isValidSignupLink('com.bishal.invoice://signup?orgCode=ABC123');
// Both return true
```

### 3. Organization Code Extraction

```dart
// Works with both link types
String? orgCode1 = DeepLinkHandler.extractOrgCodeFromLink('https://bishalbudhathoki.tech/signup?orgCode=ABC123');
String? orgCode2 = DeepLinkHandler.extractOrgCodeFromLink('com.bishal.invoice://signup?orgCode=ABC123');
// Both return 'ABC123'
```

## Testing

### Android Testing

```bash
# Test custom scheme
adb shell am start -W -a android.intent.action.VIEW -d "com.bishal.invoice://signup?orgCode=TEST123" com.bishal.invoice

# Test domain-based link
adb shell am start -W -a android.intent.action.VIEW -d "https://bishalbudhathoki.tech/signup?orgCode=TEST123" com.bishal.invoice
```

### iOS Testing

```bash
# Test custom scheme
xcrun simctl openurl booted "com.bishal.invoice://signup?orgCode=TEST123"

# Test Universal Link
xcrun simctl openurl booted "https://bishalbudhathoki.tech/signup?orgCode=TEST123"
```

## Deployment Considerations

### Immediate Functionality
- **Custom schemes work immediately** after app installation
- No additional server configuration required
- Perfect for development and testing

### Domain-based Links (Optional Enhancement)
- Requires domain verification files on server
- Provides better user experience when app is not installed
- Professional appearance for marketing materials

### Domain Verification Files

#### For Android App Links
**File: `https://bishalbudhathoki.tech/.well-known/assetlinks.json`**

```json
[{
  "relation": ["delegate_permission/common.handle_all_urls"],
  "target": {
    "namespace": "android_app",
    "package_name": "com.bishal.invoice",
    "sha256_cert_fingerprints": ["YOUR_APP_FINGERPRINT"]
  }
}]
```

#### For iOS Universal Links
**File: `https://bishalbudhathoki.tech/.well-known/apple-app-site-association`**

```json
{
  "applinks": {
    "apps": [],
    "details": [{
      "appID": "TEAM_ID.com.bishal.invoice",
      "paths": ["/signup*"]
    }]
  }
}
```

## Advantages of This Implementation

### 1. No Domain Dependency
- App works fully with custom schemes
- Domain-based links are an enhancement, not a requirement
- Gradual migration possible

### 2. Maximum Compatibility
- Supports all platforms and scenarios
- Fallback mechanisms in place
- Future-proof implementation

### 3. Flexible Link Generation
- Choose appropriate link type based on context
- Custom schemes for internal use
- Domain-based for external sharing

### 4. Seamless User Experience
- Both link types navigate to the same destination
- Consistent behavior regardless of link format
- Automatic parameter extraction

## Best Practices

### 1. Link Generation Strategy
- Use domain-based links for public/marketing materials
- Use custom schemes for internal app-to-app communication
- Provide both options in sharing features

### 2. Testing Strategy
- Test both link types on all target platforms
- Verify parameter extraction works correctly
- Test with and without organization codes

### 3. Error Handling
- Graceful fallback for invalid links
- Proper error logging for debugging
- User-friendly error messages

## Conclusion

This hybrid implementation provides the best of both worlds:
- **Immediate functionality** with custom schemes
- **Professional appearance** with domain-based links
- **Maximum flexibility** for different use cases
- **Future-proof architecture** that can evolve with requirements

The implementation maintains the `bishalbudhathoki.tech` domain configuration while adding robust support for custom schemes, ensuring the app works perfectly regardless of domain ownership or server configuration.