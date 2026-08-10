# Apple Push Notifications (APNs) & Firebase Setup Guide

**Status:** iOS push notifications are **NOT yet working** — there is no Apple Developer account, so the app never receives an APNs token, which blocks FCM token generation on iOS. Everything else in the app works.

**Firebase project:** `invoice-660f3` · **GCM sender:** `406509736623` · **iOS bundle ID:** `com.bishal.invoice` (debug: `com.bishal.invoice.dev`)

---

## Why iOS push currently doesn't work

The iOS flow is a chain — if any link is missing, push silently fails:

```
Apple Developer account
        │  (creates App ID + APNs key)
        ▼
APNs key (.p8) uploaded to Firebase Console
        │  (FCM uses this to reach iOS devices)
        ▼
iOS app gets an APNs device token  ← currently NEVER happens (no dev account)
        │
        ▼
FCM turns APNs token into an FCM token  ← skipped on iOS when APNs token is null
        │
        ▼
App registers FCM token with backend (`registerFcmToken`)
        │
        ▼
Backend sends via Firebase Admin SDK → FCM → device
```

In `lib/app/services/notificationservice/firebase_messaging_service.dart`:
```dart
if (Platform.isIOS) {
  final apnsToken = await FirebaseMessaging.instance.getAPNSToken();
  if (apnsToken == null) {
    debugPrint('DEBUG_FCM: APNS token not available, skipping FCM token retrieval.');
    return;   // <-- iOS push stops here today
  }
}
final fcmToken = await FirebaseMessaging.instance.getToken();
```

Without a device, look for `DEBUG_FCM: APNS token not available` in the iOS logs — that is the exact skip point.

---

## Already configured (no action needed)

| Item | Location |
|---|---|
| `aps-environment` entitlement | `ios/Runner/RunnerDebug.entitlements` (development) & `RunnerRelease.entitlements` (production) |
| Background mode `remote-notification` | `ios/Runner/Info.plist` → `UIBackgroundModes` |
| Notification usage description | `ios/Runner/Info.plist` → `NSUserNotificationsUsageDescription` |
| `GoogleService-Info.plist` | `ios/Runner/GoogleService-Info.plist` (bundle `com.bishal.invoice`, project `invoice-660f3`) |
| Firebase Messaging wiring | `FirebaseMessagingService`, background handler, `FcmTokenManager` (registers token to backend) |
| Local notifications fallback | `LocalNotificationService` (`flutter_local_notifications`) |
| iOS deployment target | 15.5 (APNs needs ≥ 10) |
| Backend push sending | Firebase Admin SDK → FCM (`backend/config/firebase.js`, `firebase-admin-config.js`) — needs only the Firebase **service account key**, not APNs credentials |

---

## What you must create in your Apple Developer account

| # | Item | Consumed by |
|---|---|---|
| 1 | **App ID with Push Notifications capability** for `com.bishal.invoice` (and `.dev` for debug) | `aps-environment` entitlement + App Store provisioning |
| 2 | **APNs Auth Key (.p8)** — one key, shared by all your apps | Uploaded to Firebase Console → Cloud Messaging → APNs |
| 3 | APNs Certificates (optional alternative to the .p8 key) | Same Firebase Console section |
| 4 | **Development + distribution provisioning profiles** for the App IDs | Xcode automatic signing (team `R563NC9YPA`) / fastlane |
| 5 | Bundle IDs actually registered in Apple Dev | `com.bishal.invoice`, `com.bishal.invoice.dev` |

---

## Firebase Console steps (after you have the Apple ID)

1. Confirm the iOS app in project `invoice-660f3` uses bundle ID `com.bishal.invoice` (matches `GoogleService-Info.plist`).
2. **Project settings → Cloud Messaging → Apple app configuration** → upload the **.p8 APNs key** (needs the Key ID and Team ID).
3. No backend changes required — the backend already sends through FCM.

---

## ⚠️ Caveats to check once you get a real device

1. **`FirebaseAppDelegateProxyEnabled = <false/>`** in `ios/Runner/Info.plist`
   - Disables Firebase's AppDelegate swizzling (common when `location` background plugins are used).
   - This makes the `firebase_messaging` plugin rely on `FlutterAppDelegate` to forward APNs callbacks.
   - **Test `getAPNSToken()` on a physical device.** If it always returns `null`, either set this to `<true/>` or add APNs registration forwarding in `ios/Runner/AppDelegate.swift`. This is the most common silent breakage point.

2. **Simulators cannot receive APNs** — always test on a physical iPhone.

3. **Expected iOS log on a working setup:** `DEBUG_FCM: FCM Token: <token>`
   Current (broken) log: `DEBUG_FCM: APNS token not available, skipping FCM token retrieval.`

---

## End-to-end verification checklist (once a device is available)

- [ ] App ID with Push capability exists for `com.bishal.invoice`
- [ ] APNs .p8 key uploaded to Firebase Console for project `invoice-660f3`
- [ ] Build & run on a physical iPhone
- [ ] Log shows `FCM Token: ...` (not "APNS token not available")
- [ ] Backend receives the token (`registerFcmToken`)
- [ ] Send a test message from Firebase Console → device receives it
