# P0 Security Remediation — Secrets & Bundle ID Fixes

**Status**: Complete & verified (CI green)
**Date**: 2026-08-08
**Frontend commit**: `ef20be8` (branch `main`, pushed)
**Backend commit**: `af29b02` (branch `dev`, pushed, auto-deployed)

---

## Backend Deployment Rule (per owner)

- The backend repo is **`ErBishalBudhathoki/CareNest_backend`** (Node.js/Express).
- It has a `dev` branch and a `main` branch.
- `dev` is the working branch: it must be **100% working** at all times, then merged to `main`.
- **Never push to backend `main` directly.**
- **Pushing to `dev` automatically deploys** to the Google Cloud development server
  (Cloud Run service `backend-dev`, project `invoice-660f3`, region `australia-southeast1`)
  via workflow **`backend-deploy-dev-hybrid.yml`**.
- Merge `dev → main` only when the dev server is confirmed healthy.

---

## Why This Was Done

A release-readiness audit found three **P0 (release-blocking)** issues:

1. **Secrets bundled in the app binary (both Android & iOS)** — `.env` (Gmail app password,
   MongoDB Atlas URI/password, EmailJS keys, Google Maps keys, Firebase App Check debug token)
   was shipped inside the APK/AAB/IPA as a Flutter asset. Anyone with the binary could extract them.
2. **Invoice email sent from the phone with a bundled Gmail app password** — the device held SMTP
   credentials and emailed invoices directly. This both leaked the credential and was unreliable.
3. **iOS bundle ID mismatch** — production built as `com.CareNest.app` while
   `GoogleService-Info.plist` and `firebase_options.dart` were `com.bishal.invoice`.
   Firebase auth/Messaging/App Check would break in the production iOS build.

---

## Fixes

### 1. Secrets removed from the app binary (frontend)

- Removed `.env` from `pubspec.yaml` Flutter assets.
- Created **`lib/config/build_config.dart`** — compile-time config via `String.fromEnvironment`
  (passed with `--dart-define`). Only **non-secret** values are defined at build time:
  - `PRODUCTION_URL`
  - `DEVELOPMENT_URL`
  - `UNIVERSAL_LINK_HOST`
  - `RECAPTCHA_SITE_KEY`
- Rewrote `lib/config/env/production.dart` and `lib/config/env/development.dart` to read
  from `BuildConfig` instead of `dotenv`.
- Updated `lib/app/features/auth/utils/deep_link_handler.dart` to use
  `BuildConfig.universalLinkHost`.
- All three entrypoints (`lib/main.dart`, `lib/main_production.dart`, `lib/main_development.dart`)
  no longer call `dotenv.load` or read `.env`; reCAPTCHA site key now comes from `BuildConfig`.
- `lib/firebase_options.dart` `_getEnv` now switches on a const `String.fromEnvironment` value.
- Removed `flutter_dotenv` dependency. Cleaned `test/photo_functionality_test.dart`.
- CI: `flutter_ci_optimized.yml` extracts `PRODUCTION_URL`, `DEVELOPMENT_URL`,
  `UNIVERSAL_LINK_HOST` from the restored `.env` (via the `ENV_FILE` secret) and passes them
  as `--dart-define` to both the release AAB and debug APK builds.

### 2. Invoice email moved to the backend (frontend + backend)

- **Backend**: new `POST /sendInvoiceEmail` endpoint
  (`routes/invoicingEmailLegacyRoutes.js` + `controllers/invoicingEmailController.js`)
  using **server-side** SMTP credentials (`SMTP_ADMIN_EMAIL`, `SMTP_PASSWORD`),
  SMTP2GO host `mail.smtp2go.com:587`. It decodes the base64 PDF attachment and emails the invoice.
- **Frontend**: `InvoiceEmailService` now base64-encodes the PDF and calls
  `ApiMethod.sendInvoiceEmail` (`lib/backend/api_method.dart`) instead of using the device SMTP.
- Removed the `mailer` dependency. No email credentials exist in the app anymore.

### 3. iOS bundle ID aligned (frontend)

- `ios/Flutter/Production.xcconfig`: `PRODUCT_BUNDLE_IDENTIFIER = com.bishal.invoice`
- `ios/Runner.xcodeproj/project.pbxproj`: replaced the 3 inline `com.CareNest.app`
  entries with `com.bishal.invoice`.
- Now consistent with `GoogleService-Info.plist` (`BUNDLE_ID com.bishal.invoice`) and
  `firebase_options.dart` (`iosBundleId`). No Firebase console changes required.

---

## Verification

- Frontend CI run **`31250303568`** (pushed `main`, commit `ef20be8`):
  - Security & Quality Checks (incl. `dart format --set-exit-if-changed` + `flutter analyze --fatal-infos`): ✅ success
  - Run Tests: ✅ success
  - Build Android (debug): ✅ success
  - Build Android (release): ✅ success
  - Deploy job: skipped (push-triggered run; deploys only on `workflow_dispatch`)
- Backend CI run **`31250317912`** (pushed `dev`, commit `af29b02`):
  - Backend Deploy - Development (Hybrid Secure): ✅ success → `sendInvoiceEmail` live on Cloud Run `backend-dev`
- `node --check` passed on the new backend route/controller files.

---

## What Changed (files)

### Frontend (`ErBishalBudhathoki/CareNest`, `main`, commit `ef20be8`)
- `.github/workflows/flutter_ci_optimized.yml` — passes `--dart-define` in build step
- `ANDROID_PLAY_DEPLOYMENT.md` — notes updated (`.env` unbundled; backend email)
- `APP_STORE_READINESS.md` — bundle ID updated to `com.bishal.invoice`
- `ios/Flutter/Production.xcconfig` — bundle ID
- `ios/Runner.xcodeproj/project.pbxproj` — bundle ID (×3)
- `lib/config/build_config.dart` — **new** compile-time config
- `lib/config/env/production.dart`, `lib/config/env/development.dart` — BuildConfig-based
- `lib/app/features/auth/utils/deep_link_handler.dart` — universal link host
- `lib/backend/api_method.dart` — added `sendInvoiceEmail`
- `lib/app/features/invoice/services/invoice_email_service.dart` — calls backend
- `lib/firebase_options.dart` — const env switch
- `lib/main.dart`, `lib/main_production.dart`, `lib/main_development.dart` — no dotenv
- `pubspec.yaml` — removed `.env` asset, `flutter_dotenv`, `mailer`
- `test/photo_functionality_test.dart` — cleaned

### Backend (`ErBishalBudhathoki/CareNest_backend`, `dev`, commit `af29b02`, auto-deployed)
- `routes/invoicingEmailLegacyRoutes.js` — route for `POST /sendInvoiceEmail`
- `controllers/invoicingEmailController.js` — controller using server-side SMTP creds

---

## Next Steps (remaining release blockers)

- **P1**: Release-build PII logging — `api_method.dart:411,427` (full request/response bodies),
  `main.dart:219` (full FCM tokens), `encryption_utils_io.dart` (plaintext passwords in debug).
- **P1**: AI disclosure/consent — Gemini used at `api_method.dart:7019` and
  `lib/app/features/invoice/views/invoice_ai_dashboard.dart:156`; add disclosure + consent.
- **P1**: Real-device iOS release-build test.
- **P2**: Notification permission requested at app launch; plaintext JWT in SharedPreferences;
  ~36 TODOs; remove `main.dart.backup` and dead deps.
