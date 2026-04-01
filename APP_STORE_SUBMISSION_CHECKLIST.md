# App Store Submission Checklist

Use this in order.

## 1. Apple Setup

- Enroll in the Apple Developer Program
- Accept the latest Apple agreements
- Create the app record in App Store Connect
- Confirm bundle ID is `com.CareNest.app`
- Configure signing team, certificate, and provisioning profile

## 2. Device Validation

- Build the release app on your Mac
- Install the release/TestFlight build on a real iPhone
- Verify login, scheduling, attendance, messaging, invoices, notifications, and deletion request flow
- Verify universal links and associated domains on-device
- Verify background location behavior on-device if that feature is included in the submitted build

## 3. App Store Metadata

- Add app name, subtitle, description, and keywords
- Add pricing and availability
- Add support URL: `https://bishalbudhathoki.com/carenest/support/`
- Add privacy policy URL: `https://bishalbudhathoki.com/carenest/privacy-policy/`
- Complete age rating questionnaire
- Complete export compliance answers
- Upload screenshots for required iPhone sizes

## 4. Privacy And Compliance

- Confirm the privacy policy explicitly states the 90-day deletion retention model
- Confirm the privacy policy explains what data is retained, why it is retained, and what is deleted or anonymized later
- Complete App Privacy answers for Firebase Auth, Messaging, Storage, Crashlytics, App Check, location, documents, notifications, media access, and any AI-related processing
- If AI features send personal data to an external provider, disclose that in both the privacy policy and App Privacy answers

## 5. Review Notes

- Open [APP_STORE_REVIEW_NOTES.md](/Users/bishal/Developer/invoice/APP_STORE_REVIEW_NOTES.md)
- Replace the demo-account placeholders
- Replace the support-email placeholder
- Paste the final block into App Store Connect `Review Notes`
- Double-check that the credentials are active and work on the build you upload

## 6. Upload And Submit

- Upload the build to TestFlight / App Store Connect
- Install and sanity-check the uploaded build from TestFlight
- Add the final review notes and demo credentials
- Submit for review

## 7. Post-Submit Watchlist

- Be ready to answer reviewer questions from the support email quickly
- Be ready to provide updated demo credentials if the original account expires
- Be ready to explain background location and the 90-day retention model clearly if Apple asks
