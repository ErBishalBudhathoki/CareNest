# CareNest Billing & Payments Setup

This document describes how to configure and operate the new billing and payment features. It is split into three independent systems:

1. **Organization subscription (AUD 9.99/month)** — unlocks every CareNest feature for the whole organization.
2. **Invoice payments** — clients pay the organization directly via Stripe.
3. **Recurring invoice payments** — clients save a payment method and consent to automatic charges on a weekly/fortnightly/monthly cadence.

> **Important:** The mobile app **never** trusts a client-side purchase result. The backend must verify every receipt and update the organization subscription before granting access.

---

## 1. Organization subscription (AUD 9.99/month)

### 1.1 Create the store products

You must create the subscription product in **both** app stores. Use the same price and duration on both.

**Apple App Store Connect**
1. Sign in to [App Store Connect](https://appstoreconnect.apple.com).
2. Select your app → **Features** → **In-App Purchases** → **Subscriptions**.
3. Create a new subscription group (e.g. `CareNest Monthly`).
4. Add a subscription:
   - **Reference Name:** `CareNest Monthly`
   - **Product ID:** `carenest_monthly` (or another unique identifier)
   - **Price:** AUD 9.99
   - **Duration:** 1 month
5. Save and submit for review.

**Google Play Console**
1. Sign in to [Google Play Console](https://play.google.com/console).
2. Select your app → **Monetize** → **Subscriptions** → **Create subscription**.
3. Enter:
   - **Product ID:** `carenest_monthly`
   - **Price:** AUD 9.99
   - **Billing period:** 1 month
4. Activate the subscription.

### 1.2 Configure the app

After the products are created, update the build-time placeholders in `lib/config/build_config.dart`:

```dart
static const String iosMonthlySubscriptionId = String.fromEnvironment(
  'IOS_MONTHLY_SUBSCRIPTION_ID',
);
static const String androidMonthlySubscriptionId = String.fromEnvironment(
  'ANDROID_MONTHLY_SUBSCRIPTION_ID',
);
```

Pass the values when you build:

```bash
flutter build apk --dart-define=IOS_MONTHLY_SUBSCRIPTION_ID=carenest_monthly \
                 --dart-define=ANDROID_MONTHLY_SUBSCRIPTION_ID=carenest_monthly
```

### 1.3 Verify receipts on the backend

The backend must call the Apple App Store Server API and the Google Play Developer API. It requires the following environment variables:

```bash
# Apple
APPLE_APP_BUNDLE_ID=com.bishal.invoice
APPLE_ISSUER_ID=your_issuer_id
APPLE_KEY_ID=your_key_id
APPLE_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----...\n-----END PRIVATE KEY-----"
APPLE_ENVIRONMENT=production   # or sandbox

# Google Play
GOOGLE_PLAY_PACKAGE_NAME=com.bishal.invoice
GOOGLE_PLAY_CLIENT_EMAIL=your_service_account@project.iam.gserviceaccount.com
GOOGLE_PLAY_PRIVATE_KEY="-----BEGIN PRIVATE KEY-----...\n-----END PRIVATE KEY-----"
```

> **Never commit the private keys to git.** Use your deployment secrets manager.

### 1.4 Entitlement flow

- The mobile app shows the subscription screen (`lib/app/features/organization/views/subscription_view.dart`).
- When the user buys or restores, the app receives a signed transaction JWS (Apple) or a purchase token (Google).
- The app sends that token to `POST /api/billing/entitlements/verify/apple` or `.../verify/google`.
- The backend verifies the token with Apple/Google, writes an `Entitlement` record, and updates `organization.subscription.status` to `active`, `billing_retry`, or `expired`.
- The access gate (`middleware/billing/requireEntitlement.js`) blocks paid features when the status is not `active`, `billing_retry`, or `grace`.

### 1.5 Grace period and read-only mode

- A subscription that enters billing retry or is within 3 days of expiry is treated as `grace`.
- In grace, the organization can **view** data but cannot create, edit, or pay invoices.
- When the expiry passes without renewal, the status becomes `expired` and the app is locked.

---

## 2. Invoice payments (Stripe)

### 2.1 Connect the organization's Stripe account

There are two ways to link Stripe. Both are supported and mutually exclusive — use **one** per organization.

| Flow | When to use | Endpoint |
|---|---|---|
| **Account Link onboarding** (new account) | The organization does not have a Stripe account yet. | `POST /api/payments/onboarding-link` |
| **OAuth (existing account)** | The organization already has a Stripe account. | `POST /api/billing/connect/oauth/start` |

The OAuth flow uses a one-time state token (stored hashed) to prevent fixation. The callback is public (`GET /public/connect/oauth/callback`) and returns a simple HTML page.

### 2.2 In-app payment

- The invoice detail screen shows **PAY NOW**.
- The app calls `POST /api/payments/create-intent` with only the invoice ID and organization ID.
- The backend computes the payable balance, verifies the connected account can charge, and creates a PaymentIntent scoped to the connected account.
- The app presents the Stripe PaymentSheet.

### 2.3 Public hosted payment link

- The organization can send the client a **hosted payment link** (e.g. in an email).
- The link is a single-use grant bound to the invoice amount, currency, and connected account.
- The client opens the link, which creates a Stripe Checkout Session on the connected account.
- The webhook `checkout.session.completed` consumes the grant and records the payment.

#### Configuration

```bash
# Allowed public return URLs (comma-separated list of full URLs)
PAYMENT_PUBLIC_RETURN_URL=https://bishalbudhathoki.com/payments/success
PAYMENT_PUBLIC_CANCEL_URL=https://bishalbudhathoki.com/payments/cancel
```

You can use any public domain you control. The example above uses your existing portfolio domain, but you can register a dedicated domain (e.g. `pay.carenest.com.au`) if you prefer.

---

## 3. Recurring invoice payments

### 3.1 Consent flow

1. The organization creates a recurring invoice in the app.
2. The invoice detail screen shows **SET UP RECURRING PAYMENT**.
3. The client (or admin) sees a consent dialog that explains the cadence and amount.
4. The client accepts, which creates a `RecurringInvoiceAgreement` and a Stripe Checkout **setup** session.
5. The client opens the setup session, saves their card, and consents to future charges.
6. The webhook `setup_intent.succeeded` activates the agreement.

### 3.2 Automatic charges

- A Temporal workflow (`RecurringInvoiceCronWorkflow`) runs daily.
- It finds active agreements whose `nextRunAt` is due.
- For each agreement, it creates a child invoice and an off-session PaymentIntent using the saved payment method.
- Idempotency keys prevent duplicate charges if the workflow retries.

### 3.3 Cancellation

- The client or the organization admin can cancel at any time before the next scheduled charge.
- Cancellation is idempotent and sets the agreement to `canceled` with a timestamp and reason.

---

## 4. Stripe Connect webhooks

You must configure the following webhook events in your Stripe dashboard for the **platform account** (the account that owns the API key):

| Event | Purpose |
|---|---|
| `payment_intent.succeeded` | Record the invoice payment |
| `payment_intent.payment_failed` | Mark the payment as failed |
| `payment_intent.canceled` | Mark the payment as canceled |
| `checkout.session.completed` | Consume the hosted-checkout grant |
| `setup_intent.succeeded` | Activate the recurring agreement |
| `account.updated` | Refresh the connected-account status snapshot |
| `charge.refunded` | Record a refund |
| `charge.dispute.created` | Record a dispute |

### 4.1 Add the webhook endpoint

1. Go to **Developers → Webhooks** in your Stripe dashboard.
2. Add a new endpoint: `https://<your-backend-domain>/webhooks/stripe`.
3. Select the events listed above.
4. Copy the **Signing secret** into `STRIPE_WEBHOOK_SECRET` in your backend environment.

> **Note:** Because the payments are direct charges on the connected account, Stripe will also send events to the connected account. The platform webhook is the one CareNest uses to update the invoice.

---

## 5. Testing checklist

| Feature | How to test |
|---|---|
| Subscription purchase | Buy in sandbox (Apple TestFlight / Google Play internal testing) |
| Subscription restore | Reinstall the app and tap **Restore purchases** |
| Entitlement gate | Create an invoice with an expired subscription — the backend must return 402 |
| Stripe Connect onboarding | Create a new connected account and complete onboarding |
| Stripe OAuth existing account | Link an existing account and verify `chargesEnabled` |
| In-app payment | Tap **PAY NOW** on an unpaid invoice |
| Hosted payment link | Send the link to a test client and pay via the browser |
| Recurring agreement | Accept the consent, save a card, and verify the agreement is active |
| Recurring auto-charge | Wait for the scheduled date and verify a child invoice is created and charged |
| Cancellation | Cancel the agreement and verify no further charges occur |
| Webhook delivery | Use `stripe listen --forward-to localhost:8080/webhooks/stripe` and trigger a test event |

---

## 6. Security notes

- **Never** store Stripe secret keys, Apple private keys, or Google service-account keys in the app or in git.
- **Never** trust the mobile client to grant subscription access — always verify receipts server-side.
- **Never** expose the Stripe account ID or the raw checkout token to the public.
- The hosted checkout token is a 32-byte random value; only its SHA-256 hash is stored.
- The OAuth state is one-time and expires after 10 minutes.
- The recurring consent text is versioned (`2024-09-01`) and hashed; the client must re-accept if the text changes.

---

## 7. Troubleshooting

| Symptom | Likely cause | Fix |
|---|---|---|
| `Subscription is not configured` | Product IDs not set in build config | Add the `--dart-define` values when building |
| `Apple receipt verification is not configured` | Missing Apple env vars | Set `APPLE_*` variables |
| `Google receipt verification is not configured` | Missing Google env vars | Set `GOOGLE_PLAY_*` variables |
| `Organization must complete Stripe Connect onboarding` | Connected account not fully onboarded | Complete the Account Link flow |
| `Payment link is no longer active` | Grant expired or already used | Generate a new link |
| `Recurring agreement setup URL is missing` | Stripe setup session failed | Check `STRIPE_SECRET_KEY` and connected account |
| `Invalid or already-used OAuth state` | State token replayed | Restart the OAuth flow |
