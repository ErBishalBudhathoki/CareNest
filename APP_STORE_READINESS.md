# App Store Readiness

## Code And Build

- [x] `flutter analyze` passes
- [x] `flutter test` passes
- [x] `flutter build ios --release --no-codesign` passes locally
- [x] CocoaPods dependencies resolve cleanly after refreshing pod specs if needed
- [x] Production iOS app name shows `CareNest`
- [x] Production bundle identifier is set to the intended App Store value: `com.CareNest.app`
- [x] `ITSAppUsesNonExemptEncryption` is set in `ios/Runner/Info.plist`
- [x] Release builds do not expose the localhost live-tracking route

## iOS Capabilities

- [ ] Push Notifications capability is enabled for the iOS target and App ID
- [ ] Associated Domains capability is enabled for:
- `applinks:bishalbudhathoki.com`
- `applinks:bishalbudhathoki.tech`
- [ ] Apple App Check is configured for iOS if release builds will enforce it

## Privacy And Review

- [x] Reviewer notes draft exists in `APP_STORE_REVIEW_NOTES.md`
- [ ] Reviewer notes explain why background location is required for clock-in reminders and attendance workflows
- [ ] Reviewer notes explain why microphone, speech recognition, camera, photo library, and notifications are used
- [ ] App Privacy answers in App Store Connect cover Firebase Auth, Messaging, Storage, Crashlytics, App Check, location, documents, and user content
- [ ] Privacy policy URL is live, public, and explicitly describes the 90-day deletion retention policy
- Privacy policy URL: `https://bishalbudhathoki.com/carenest/privacy-policy/`
- Support URL: `https://bishalbudhathoki.com/carenest/support/`
- [x] Account deletion flow is reachable in-app and starts from the settings screen
- [ ] Deep links and universal links are verified on iOS devices

## App Store Connect

- [ ] Apple Developer account is active
- [ ] App record, bundle identifier, and signing team are configured
- [ ] Screenshots are prepared for required iPhone sizes
- [ ] App description, keywords, support URL, and marketing URL are ready
- [ ] Age rating questionnaire is completed
- [ ] Export compliance answers are completed
- [ ] TestFlight internal build is uploaded and installs on a real device

## Remaining Risks

- P1 Reviewer access is still a likely rejection risk until you enter working demo credentials in App Store Connect review notes. The MCP directly flagged login and authentication issues during review as a relevant rejection pattern.
- P1 Privacy policy and support URLs are now known, but the privacy policy still needs to explicitly describe what data is retained, why it is retained, and the 90-day deletion timeline.
- P1 Account deletion is now aligned to the 90-day retention model, but it still needs a production verification pass to confirm the request workflow, admin approval, deactivation, and scheduled deletion all behave as expected end-to-end.
- P1 You expose AI features in lib/backend/api_method.dart:7019 and lib/app/features/invoice/viewsinvoice_ai_dashboard.dart:156. If user data is sent to an external AI provider, you need disclosure and likely a consent moment.
- P1 A physical iPhone release-build test is still outstanding, and this is your highest remaining pre-submit validation gap.
- P1 App Store screenshots, privacy policy URL, support URL, and final App Store Connect metadata are still pending.

## Your Answers Change The Audit Like This

- No physical iPhone release-build test yet: this is now a real pre-submit gap, not a minor note.
- No screenshots yet: fine for now, but required before submission.
- Demo credentials in review notes: good, that removes one likely rejection if the account works.
- First Apple submission: the remaining risk is mostly Apple setup, not coding.

## First Apple Submission Checklist

- [ ] Enroll in Apple Developer Program
- [ ] Accept the latest Apple license agreement
- [ ] Create the app record in App Store Connect
- [ ] Make sure bundle ID exactly matches com.CareNest.app
- [ ] Set signing team / distribution cert / provisioning
- [ ] Add pricing and availability
- [ ] Add privacy policy URL, support URL, screenshots, age rating, export compliance answers
- [ ] Test a release build on a real iPhone before upload

## Bottom Line

Codebase health is much better than before, and the app now builds for iOS release. The account deletion flow, review notes, and readiness checklist now match the 90-day retention model. I still would not submit until the real-device release test, privacy policy wording, support/privacy page presentation, and final reviewer credentials are ready.
