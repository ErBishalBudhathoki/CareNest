# App Store Review Notes

Paste the section below into App Store Connect `Review Notes` after replacing the remaining placeholders.

## Paste-Ready Review Notes

App purpose:
CareNest is a care operations app for providers, workers, clients, and authorized family members. The iOS build supports scheduling, attendance, invoicing, secure messaging, service confirmations, and family access workflows.

Reviewer access:
- Demo account email: `REPLACE_WITH_REVIEW_EMAIL`
- Demo account password: `REPLACE_WITH_REVIEW_PASSWORD`
- Demo organization code: `REPLACE_IF_NEEDED`
- Test phone / OTP notes: `REPLACE_IF_NEEDED`

Support and privacy:
- Support URL: https://bishalbudhathoki.com/carenest/support/
- Privacy policy URL: https://bishalbudhathoki.com/carenest/privacy-policy/
- Support email: `carenest@bishalbudhathoki.com`

Account deletion:
Users can initiate account deletion directly inside the app from Settings. The app does not send users to email or an external website to begin deletion. Deletion requests enter the internal `ACCOUNT_DELETION` workflow. When approved, the user account is deactivated immediately and permanent deletion is scheduled for 90 days later. During that retention window, only records required for payroll, tax, audit, safeguarding, accounting, legal, and care-service obligations are retained. The retention period exists for legal and compliance reasons, not for convenience or marketing.

Permissions used in this build:
- Location: used during scheduled visits for navigation, attendance verification, arrival reminders, and care-service workflows
- Notifications: used for appointments, invoices, and attendance reminders
- Camera and photo library: used for receipts, documents, and profile photos
- Microphone and speech recognition: used for voice notes and speech-to-text entry

Background location:
Background location is only used around active care visits to support arrival reminders and attendance workflows. It is not used for advertising or unrelated tracking.

Live tracking:
The legacy live-tracking screen is gated out of the App Store release build until the production socket endpoint is enabled. Reviewers should not encounter a localhost or staging-only tracking flow in this submission.

AI disclosure:
If AI-assisted invoice or care-plan features are enabled in the submitted build, the privacy policy and App Privacy answers should disclose any external AI processing of user content.

## Final Fill Checklist

- Replace `REPLACE_WITH_REVIEW_EMAIL`
- Replace `REPLACE_WITH_REVIEW_PASSWORD`
- Replace `REPLACE_IF_NEEDED`
- Replace `REPLACE_WITH_SUPPORT_EMAIL`
- Remove any line that does not apply to the submitted build

