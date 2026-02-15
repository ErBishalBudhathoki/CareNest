# Development Firebase Configuration

## Missing: google-services.json

This directory needs a `google-services.json` file for the development flavor.

## How to Get It

### Step 1: Register Development App in Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project: **invoice-660f3**
3. Click ⚙️ → Project Settings
4. Scroll to "Your apps"
5. Click "Add app" → Android
6. Enter package name: **com.bishal.invoice.dev**
7. Enter app nickname: **CareNest Dev**
8. Click "Register app"

### Step 2: Add Debug SHA-256

```bash
# Get debug SHA-256
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android | grep SHA256
```

Copy the SHA-256 value, then:
1. In Firebase Console, find "CareNest Dev" app
2. Click "Add fingerprint"
3. Paste SHA-256
4. Click "Save"

### Step 3: Download google-services.json

1. In Firebase Console, on "CareNest Dev" app page
2. Click "Download google-services.json"
3. Save to this directory: `android/app/src/development/google-services.json`

### Step 4: Enable Services

In Firebase Console, for the "CareNest Dev" app:
1. Enable Authentication → Email/Password
2. Enable App Check → Debug provider
3. Configure any other services you need

### Step 5: Test

```bash
flutter clean
flutter pub get
flutter run --flavor development
```

## Expected File Structure

```
android/app/src/development/
├── README.md (this file)
└── google-services.json (download from Firebase Console)
```

## Package Name

The google-services.json file should contain:
```json
{
  "client": [
    {
      "client_info": {
        "android_client_info": {
          "package_name": "com.bishal.invoice.dev"
        }
      }
    }
  ]
}
```

## See Also

- Complete guide: `docs/FIREBASE_MULTI_FLAVOR_SETUP.md`
- SHA-256 setup: `docs/FIREBASE_SHA256_SETUP_GUIDE.md`
