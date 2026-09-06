# CareNest — Billing & Payments: What Was Completed and What You Need to Do

**Date:** 2025-09-06
**Status:** Implementation complete — manual configuration required

---

## ✅ What was implemented today

### 1. Organization subscription (AUD 9.99/month)
- Built a new subscription screen (`lib/app/features/organization/views/subscription_view.dart`) with the Bauhaus design and full `intl` localization.
- Added a client-side wrapper (`AppSubscriptionService`) that loads the store product and starts the purchase.
- Added server-side receipt verification for **Apple** and **Google** (`services/billing/entitlementService.js`, `appleReceiptVerifier.js`, `googlePlayReceiptVerifier.js`).
- Created an `Entitlement` model that stores the verified subscription state, expiry, grace period, and revocation.
- Added an access gate (`middleware/billing/requireEntitlement.js`) that blocks paid features when the organization subscription is not active.
- **The app never trusts the mobile client** — the backend must verify the receipt before the organization is unlocked.

### 2. Invoice payments (Stripe)
- Fixed the Connect onboarding endpoint mismatch and added live status validation.
- Added a **secure OAuth flow** for organizations that already have a Stripe account (`POST /api/billing/connect/oauth/start` → `GET /public/connect/oauth/callback`).
- Added a **hosted public checkout link** (`POST /api/billing/hosted-checkout/grant`) that the client opens in a browser. The link is single-use, expires, and is bound to the invoice amount and connected account.
- Added Stripe **PaymentSheet** for in-app invoice payments (`services/stripe_payment_service.dart`).
- Added the required Android changes (`FlutterFragmentActivity`, AppCompat themes, ProGuard rules).

### 3. Recurring invoice payments
- Built a **consent dialog** (`services/recurring_payment_service.dart`) that explains the cadence, amount, and cancellation rights.
- Added a **recurring agreement** model and backend service (`services/billing/recurringAgreementService.js`).
- Added an **auto-charge scheduler** (`services/billing/recurringChargeService.js`) that creates child invoices and charges the saved payment method off-session.
- Added cancellation (`DELETE /api/billing/recurring-agreements/:id`).

### 4. Webhooks
Updated `controllers/webhookController.js` to handle:
- `payment_intent.succeeded`
- `checkout.session.completed`
- `setup_intent.succeeded`
- `account.updated`

### 5. Tests & documentation
- Added unit tests for the entitlement, hosted checkout, and OAuth services.
- Added repository tests for the new payment endpoints.
- Created the setup guide: `BILLING_AND_PAYMENTS_SETUP.md`.

---

## 🔧 What you need to do manually

### A. App store subscription (AUD 9.99/month)

1. **Create the products in both stores:**
   - **Apple App Store Connect** → Features → In-App Purchases → Subscriptions → create a subscription group and a monthly product (e.g. `carenest_monthly`, AUD 9.99, 1 month).
   - **Google Play Console** → Monetize → Subscriptions → create a monthly product (e.g. `carenest_monthly`, AUD 9.99, 1 month).

2. **Add the product IDs to the build config:**
   - Open `lib/config/build_config.dart` and replace the placeholders:
     ```dart
     static const String iosMonthlySubscriptionId = 'carenest_monthly';
     static const String androidMonthlySubscriptionId = 'carenest_monthly';
     ```
   - Or pass them at build time:
     ```bash
     flutter build apk --dart-define=IOS_MONTHLY_SUBSCRIPTION_ID=carenest_monthly \
                      --dart-define=ANDROID_MONTHLY_SUBSCRIPTION_ID=carenest_monthly
     ```

3. **Set the backend environment variables** (see `BILLING_AND_PAYMENTS_SETUP.md` section 1.3):
   - `APPLE_APP_BUNDLE_ID`, `APPLE_ISSUER_ID`, `APPLE_KEY_ID`, `APPLE_PRIVATE_KEY`
   - `GOOGLE_PLAY_PACKAGE_NAME`, `GOOGLE_PLAY_CLIENT_EMAIL`, `GOOGLE_PLAY_PRIVATE_KEY`
   - **Never commit these keys to git.**

### B. Stripe Connect

1. **Enable Stripe Connect** in your Stripe dashboard (Settings → Connect → Get started).
2. **Choose the account type:**
   - **Standard** for the Account Link onboarding flow (new accounts).
   - **OAuth** for linking existing accounts (requires a **Client ID** from the Connect settings).
3. **Set the OAuth redirect URI** in the Stripe dashboard to:
   ```
   https://<your-backend-domain>/public/connect/oauth/callback
   ```
4. **Set the environment variables:**
   - `STRIPE_SECRET_KEY`
   - `STRIPE_PUBLISHABLE_KEY`
   - `STRIPE_WEBHOOK_SECRET`
   - `STRIPE_CONNECT_CLIENT_ID` (for OAuth)
   - `STRIPE_CONNECT_REDIRECT_URI` (for OAuth)

### C. Public hosted payment links

1. **Choose a public HTTPS domain** for the success/cancel URLs (e.g. `https://pay.carenest.com.au` or `https://bishalbudhathoki.com/payments`).
2. **Set the allowlist** in the backend environment:
   ```bash
   PAYMENT_PUBLIC_RETURN_URL=https://your-domain.com/payments/success
   PAYMENT_PUBLIC_CANCEL_URL=https://your-domain.com/payments/cancel
   ```
   (You can use a comma-separated list of allowed URLs.)

### D. Stripe webhooks

1. Go to **Developers → Webhooks** in your Stripe dashboard.
2. Add a new endpoint: `https://<your-backend-domain>/webhooks/stripe`.
3. Select the following events:
   - `payment_intent.succeeded`
   - `payment_intent.payment_failed`
   - `payment_intent.canceled`
   - `checkout.session.completed`
   - `setup_intent.succeeded`
   - `account.updated`
   - `charge.refunded`
   - `charge.dispute.created`
4. Copy the **Signing secret** into `STRIPE_WEBHOOK_SECRET`.

### E. Recurring payments

- No additional Stripe setup is needed — the recurring flow uses the same connected account and the `setup_intent.succeeded` webhook.
- Make sure the Temporal workflow `RecurringInvoiceCronWorkflow` is scheduled to run daily (see `temporal/workflows/cron.js`).

### F. Test everything

Run the new tests after installing backend dependencies:

```bash
cd backend
npm install
npm test -- tests/billing/
```

Then run the Flutter checks:

```bash
flutter analyze
flutter test
```

---

## 📁 Files added or changed today

**Frontend**
- `lib/app/features/organization/views/subscription_view.dart` — subscription UI
- `lib/app/features/organization/services/app_subscription_service.dart` — store purchase wrapper
- `lib/app/features/invoice/services/stripe_payment_service.dart` — PaymentSheet wrapper
- `lib/app/features/invoice/services/recurring_payment_service.dart` — recurring consent dialog
- `lib/app/features/organization/views/organization_details_view.dart` — added Stripe OAuth section
- `lib/app/features/invoice/views/widgets/payment_actions_widget.dart` — added recurring-payment button
- `lib/app/features/invoice/repositories/payment_repository.dart` — added new API calls
- `lib/app/features/invoice/viewmodels/payment_viewmodel.dart` — added subscription and hosted-checkout providers
- `lib/config/build_config.dart` — added product-ID placeholders
- `lib/l10n/app_en.arb` — added all new strings with `intl` metadata
- `test/app/features/invoice/payment_repository_test.dart` — repository tests
- `BILLING_AND_PAYMENTS_SETUP.md` — setup and operations guide

**Backend**
- `models/billing/Entitlement.js`, `HostedCheckoutGrant.js`, `RecurringInvoiceAgreement.js`, `OAuthState.js`
- `services/billing/appleReceiptVerifier.js`, `googlePlayReceiptVerifier.js`, `entitlementService.js`, `hostedCheckoutService.js`, `recurringAgreementService.js`, `recurringChargeService.js`, `stripeConnectOAuthService.js`
- `controllers/billing/entitlementController.js`, `hostedCheckoutController.js`, `recurringAgreementController.js`, `stripeConnectOAuthController.js`, `recurringChargeController.js`
- `routes/billing/billingRoutes.js`, `routes/billing/connectPublicRoutes.js`
- `middleware/billing/requireEntitlement.js`
- Updated `controllers/webhookController.js`, `routes/index.js`, `routes/invoiceManagement.js`, `routes/paymentRoutes.js`, `app.js`, `middleware/apiAccessPolicy.js`, `models/Organization.js`
- `tests/billing/entitlementService.test.js`, `hostedCheckoutService.test.js`, `stripeConnectOAuthService.test.js`

---

## ⚠️ Important security notes

- **Never** commit private keys, Stripe secret keys, or webhook secrets to git.
- **Never** trust the mobile client to grant subscription access — always verify receipts server-side.
- The hosted checkout token is a 32-byte random value; only its SHA-256 hash is stored.
- The OAuth state is one-time and expires after 10 minutes.
- The recurring consent text is versioned (`2024-09-01`) and hashed; the client must re-accept if the text changes.

---

## 🚀 Next steps

1. Create the store products and set the product IDs in the build config.
2. Add the Apple and Google private keys to your secrets manager.
3. Configure the Stripe Connect redirect URI and webhook endpoint.
4. Set the public payment return URLs.
5. Run the tests and deploy.

Once these steps are complete, the subscription and payment flows will be fully functional for your users.
