# Configuration Documentation

This document provides comprehensive information about all configuration files, environment variables, and platform-specific settings used in the Invoice application.

## Table of Contents

1. [Environment Variables](#environment-variables)
2. [Backend Configuration](#backend-configuration)
3. [Frontend Configuration](#frontend-configuration)
4. [Platform-Specific Configuration](#platform-specific-configuration)
5. [Firebase Configuration](#firebase-configuration)
6. [Development vs Production](#development-vs-production)
7. [Security Considerations](#security-considerations)

## Environment Variables

### Backend Environment Variables

The backend uses a `.env` file located in the project root. All environment variables are loaded using `dotenv.config()`.

#### Database Configuration
```bash
# MongoDB connection string
MONGODB_URI=mongodb://localhost:27017/invoice_db
```

#### Server Configuration
```bash
# Server port (defaults to 8080 if not specified)
PORT=8080

# Node.js environment
NODE_ENV=development  # or 'production'

# Serverless deployment flag
SERVERLESS=false  # Set to true for serverless deployments
```

#### Email Configuration
```bash
# Admin email for system notifications
ADMIN_EMAIL=admin@example.com
EMAIL_FOR_OTP=admin@example.com

# Email authentication (Gmail App Password)
APP_PASSWORD=your_gmail_app_password
EMAIL_PASSWORD=your_gmail_app_password

# Alternative email configuration
EMAIL_USER=your_email@gmail.com
EMAIL_PASS=your_app_password
```

#### Security Configuration
```bash
# JWT secret for token signing
JWT_SECRET=your_jwt_secret_key

# Encryption key for sensitive data
ENCRYPTION_KEY=your_encryption_key
```

#### Firebase Admin SDK Configuration
```bash
# Firebase project configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY_ID=your-private-key-id
FIREBASE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----\nYour Private Key Here\n-----END PRIVATE KEY-----\n"
FIREBASE_CLIENT_EMAIL=your-client-email@your-project.iam.gserviceaccount.com
FIREBASE_CLIENT_ID=your-client-id
FIREBASE_CLIENT_CERT_URL=https://www.googleapis.com/robot/v1/metadata/x509/your-client-email%40your-project.iam.gserviceaccount.com

# Optional Firebase configuration (with defaults)
FIREBASE_AUTH_URI=https://accounts.google.com/o/oauth2/auth
FIREBASE_TOKEN_URI=https://oauth2.googleapis.com/token
FIREBASE_AUTH_CERT_URL=https://www.googleapis.com/oauth2/v1/certs
FIREBASE_UNIVERSE_DOMAIN=googleapis.com
```

#### Debug and Development
```bash
# Recurring expenses debug mode
DEBUG_RECURRING_EXPENSES=true

# Price validation debug mode
DEBUG_VALIDATION=true

# Migration configuration
LEGACY_MONGODB_URI=mongodb://localhost:27017/legacy_db
MIGRATION_BATCH_SIZE=50
MIGRATION_LOGGING=true
DEFAULT_ORGANIZATION_ID=default_org

# Price validation settings
DEFAULT_STATE=NSW
DEFAULT_PROVIDER_TYPE=standard
ENABLE_PRICE_VALIDATION=true
PRICE_VALIDATION_TIMEOUT=30000
```

### Frontend Environment Variables

The Flutter app uses a `.env` file in the project root, loaded using the `flutter_dotenv` package.

#### API Configuration
```bash
# Development API URL
DEBUG_URL=http://localhost:8080

# Production API URL
RELEASE_URL=https://your-production-api.com

# Email configuration for invoice service
EMAIL_ADDRESS=your_email@gmail.com
EMAIL_PASSWORD=your_app_password

# ReCAPTCHA configuration
RECAPTCHA_SITE_KEY=your_recaptcha_site_key
```

## Backend Configuration

### Database Configuration (`backend/config/database.js`)

```javascript
class DatabaseConfig {
  constructor() {
    this.uri = process.env.MONGODB_URI;
    this.client = null;
    this.db = null;
  }

  // Methods: getClient(), connect(), getDatabase()
}
```

**Features:**
- MongoDB connection management
- Connection pooling
- Error handling and retry logic
- Database instance caching

### Firebase Configuration (`backend/config/firebase.js`)

```javascript
class FirebaseConfig {
  constructor() {
    this.admin = null;
    this.messaging = null;
  }

  // Methods: getAdmin(), getMessaging(), verifyMessaging()
}
```

**Features:**
- Firebase Admin SDK initialization
- Firebase Cloud Messaging setup
- Service verification

### File Upload Configuration (`backend/config/multer.js`)

```javascript
class MulterConfig {
  constructor() {
    this.uploadDir = path.join(__dirname, '..', 'uploads');
    this.ensureUploadDir();
  }

  // Methods: getStorage(), getFileFilter(), getUpload()
}
```

**Features:**
- File upload handling
- Supported formats: JPEG, JPG, PNG, HEIF, HEIC, PDF
- Unique filename generation
- Directory management

## Frontend Configuration

### Environment Configuration (`lib/config/env/`)

#### Base Configuration (`environment.dart`)
```dart
class AppConfig {
  static Flavor flavor = Flavor.development;
  
  static String get baseUrl => _Config.baseUrl;
  static bool get enableLogging => _Config.enableLogging;
  static String get flavorName => _Config.flavorName;
}
```

#### Development Configuration (`development.dart`)
```dart
class _DevelopmentConfig {
  static String get baseUrl => dotenv.env['DEBUG_URL']!;
  static bool get enableLogging => true;
  static String get flavorName => 'Development';
}
```

#### Production Configuration (`production.dart`)
```dart
class _ProductionConfig {
  static String get baseUrl => dotenv.env['RELEASE_URL']!;
  static bool get enableLogging => false;
  static String get flavorName => 'Production';
}
```

### Flutter Dependencies (`pubspec.yaml`)

#### Core Dependencies
- `get: ^4.6.6` - State management
- `get_storage: ^2.1.1` - Local storage
- `http: ^1.2.0` - HTTP client
- `flutter_dotenv: ^5.1.0` - Environment variables

#### Firebase Dependencies
- `firebase_core: ^3.4.0` - Firebase core
- `firebase_messaging: ^15.2.0` - Push notifications
- `firebase_storage: ^12.2.0` - File storage
- `firebase_app_check: ^0.3.1` - App verification
- `firebase_auth: ^5.2.0` - Authentication

#### UI/UX Dependencies
- `image_picker: ^1.0.7` - Image selection
- `file_picker: ^8.0.0+1` - File selection
- `cached_network_image: ^3.3.1` - Image caching
- `flutter_local_notifications: ^17.2.1+2` - Local notifications

## Platform-Specific Configuration

### Android Configuration

#### Build Configuration (`android/app/build.gradle`)

```gradle
android {
    namespace "com.bishal.invoice"
    compileSdkVersion 36
    
    defaultConfig {
        applicationId "com.bishal.invoice"
        minSdkVersion flutter.minSdkVersion
        targetSdk 35
        multiDexEnabled true
    }
    
    flavorDimensions "environment"
    
    productFlavors {
        development {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
            resValue "string", "app_name", "Invoice Dev"
        }
        
        production {
            dimension "environment"
            resValue "string", "app_name", "Invoice"
        }
    }
}
```

#### Firebase Dependencies
```gradle
implementation platform('com.google.firebase:firebase-bom:34.1.0')
implementation 'com.google.firebase:firebase-analytics'
implementation 'com.google.firebase:firebase-auth'
implementation "com.google.firebase:firebase-appcheck-playintegrity"
```

#### Keystore Configuration
- Uses `key.properties` file for release signing
- Supports debug and release build types
- ProGuard enabled for release builds

### iOS Configuration

#### Info.plist Settings (`ios/Runner/Info.plist`)

```xml
<key>CFBundleIdentifier</key>
<string>$(PRODUCT_BUNDLE_IDENTIFIER)</string>

<key>CFBundleDisplayName</key>
<string>$(DISPLAY_NAME)</string>

<key>FirebaseAppDelegateProxyEnabled</key>
<false/>

<key>FirebaseMessagingAutoInitEnabled</key>
<true/>
```

#### URL Schemes
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.bishal.invoice</string>
        </array>
    </dict>
</array>
```

## Firebase Configuration

### Configuration Files

#### Android Firebase Configuration
- **Development**: `android/app/src/development/google-services.json`
- **Production**: `android/app/src/production/google-services.json`

#### iOS Firebase Configuration
- **Development**: `ios/Runner/Config/Development/GoogleService-Info.plist`
- **Production**: `ios/Runner/Config/Production/GoogleService-Info.plist`

### Firebase Options (`lib/firebase_options.dart`)

```dart
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }
}
```

### Firebase Services

1. **Firebase Core**: Base Firebase functionality
2. **Firebase Messaging**: Push notifications (FCM)
3. **Firebase Auth**: User authentication
4. **Firebase Storage**: File uploads
5. **Firebase App Check**: App verification

## Development vs Production

### Development Environment

#### Backend
- `NODE_ENV=development`
- Detailed error messages in API responses
- Debug logging enabled
- Local MongoDB instance
- Development Firebase project

#### Frontend
- Debug URL pointing to local backend
- Logging enabled
- Development Firebase configuration
- Debug build with `.dev` suffix

### Production Environment

#### Backend
- `NODE_ENV=production`
- Generic error messages
- Minimal logging
- Production MongoDB cluster
- Production Firebase project

#### Frontend
- Release URL pointing to production backend
- Logging disabled
- Production Firebase configuration
- Release build with optimizations

## Security Considerations

### Environment Variables
- Never commit `.env` files to version control
- Use `.env.example` as a template
- Rotate secrets regularly
- Use strong, unique values for JWT_SECRET and ENCRYPTION_KEY

### Firebase Security
- Keep Firebase configuration files secure
- Use separate Firebase projects for development and production
- Enable Firebase App Check for API protection
- Regularly review Firebase security rules

### Database Security
- Use MongoDB connection strings with authentication
- Enable MongoDB access control
- Use SSL/TLS for database connections
- Regularly update database credentials

### API Security
- Use HTTPS in production
- Implement rate limiting
- Validate all input data
- Use JWT tokens for authentication
- Enable CORS with specific origins

## Configuration Files Summary

| File | Purpose | Environment | Status |
|------|---------|-------------|--------|
| `.env.example` | Environment template | All | ✅ Active |
| `backend/config/database.js` | Database configuration | Backend | ✅ Active |
| `backend/config/firebase.js` | Firebase Admin SDK | Backend | ✅ Active |
| `backend/config/multer.js` | File upload configuration | Backend | ✅ Active |
| `lib/config/env/environment.dart` | App environment config | Frontend | ✅ Active |
| `lib/config/env/development.dart` | Development config | Frontend | ✅ Active |
| `lib/config/env/production.dart` | Production config | Frontend | ✅ Active |
| `lib/firebase_options.dart` | Firebase platform config | Frontend | ✅ Active |
| `pubspec.yaml` | Flutter dependencies | Frontend | ✅ Active |
| `android/app/build.gradle` | Android build config | Android | ✅ Active |
| `ios/Runner/Info.plist` | iOS app configuration | iOS | ✅ Active |
| `package.json` | Node.js dependencies | Backend | ✅ Active |

## Troubleshooting

### Common Configuration Issues

1. **Missing Environment Variables**
   - Ensure `.env` file exists and contains all required variables
   - Check `.env.example` for reference

2. **Firebase Configuration Errors**
   - Verify Firebase configuration files are in correct directories
   - Ensure Firebase project settings match environment

3. **Database Connection Issues**
   - Verify MongoDB URI format and credentials
   - Check network connectivity and firewall settings

4. **Build Failures**
   - Ensure all dependencies are installed
   - Check platform-specific configuration files
   - Verify keystore configuration for Android releases

### Configuration Validation

To validate your configuration:

1. **Backend**: Run `node -e "console.log(process.env)"` to check environment variables
2. **Frontend**: Check debug output during app initialization
3. **Firebase**: Monitor Firebase console for connection status
4. **Database**: Test MongoDB connection using MongoDB Compass or CLI

This documentation should be updated whenever new configuration options are added or existing ones are modified.