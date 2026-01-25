# Advanced Billing Features Documentation

## Overview

This document outlines the architecture, usage, and deployment status of the Advanced Billing Features in the Invoice Application. These features include Payment Gateway Integration (Stripe), Recurring Billing, Credit Note Management, Partial Payment Tracking, and Overdue Invoice Reminders.

## 1. Feature Status

| Feature | Status | Location | Notes |
| :--- | :--- | :--- | :--- |
| **Recurring Billing** | ✅ Integrated | `EnhancedInvoiceGenerationView` | Toggle available during invoice creation. |
| **Payment Actions** | ✅ Integrated | `InvoiceDetailView` | "Pay Now" & "Record Payment" buttons available on invoice details. |
| **Backend API** | ✅ Deployed | Google Cloud Functions | Endpoints active at `/api/payments/*`. |
| **Stripe Integration** | ✅ Configured | Backend | Conditional initialization for safe deployment. |
| **Scheduler** | ✅ Active | Backend (Cron) | Daily checks for recurring bills & reminders. |

## 2. Frontend Integration

### A. Recurring Billing (Invoice Creation)
*   **Location**: `lib/app/features/invoice/views/enhanced_invoice_generation_view.dart`
*   **UI Component**: A dedicated "Recurring Billing" section inside the invoice generation form.
*   **Functionality**:
    *   **Toggle**: `SwitchListTile` to enable/disable.
    *   **Frequency**: Dropdown to select cycle (Weekly, Fortnightly, Monthly, Quarterly, Annually).
*   **Data Flow**: Selection is passed to `EnhancedInvoiceService`, which injects `recurrence` metadata into the invoice payload sent to the backend.

### B. Payment Actions (Invoice Details)
*   **Location**: `lib/app/features/invoice/views/invoice_detail_view.dart`
*   **UI Component**: `PaymentActionsWidget` (inserted below Status Information).
*   **Functionality**:
    *   **Status Indicators**: Visual chips for `PAID`, `PARTIAL`, `OVERDUE`.
    *   **Balance Display**: Shows "Amount Paid" vs "Balance Due".
    *   **PAY NOW**: Triggers Stripe payment flow (calls `/api/payments/create-intent`).
    *   **Record Payment**: Opens dialog for manual payment entry (calls `/api/payments/record`).

## 3. Backend Architecture (Node.js/Express)

### API Endpoints
All endpoints are protected by `verifyToken` middleware.

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/payments/create-intent` | Create a Stripe Payment Intent. Returns `clientSecret`. |
| `POST` | `/api/payments/record` | Record a manual payment (Cash, Bank Transfer). Updates invoice balance. |
| `POST` | `/api/payments/credit-note` | Issue a new Credit Note. |
| `POST` | `/api/payments/credit-note/apply` | Apply an existing Credit Note to an invoice. |

### Configuration & Deployment
*   **File**: `backend/services/paymentService.js`
*   **Stripe Initialization**: Implemented **conditional loading**. The service checks for `STRIPE_SECRET_KEY` at runtime. If missing, it logs a warning but allows the server to start (preventing boot crashes in environments without keys).
*   **Deployment Workflow**:
    *   **CI/CD**: `.github/workflows/deploy-prod.yml`
    *   **Secrets**: `STRIPE_SECRET_KEY` is securely injected from GitHub Secrets into the production `.env` file during deployment.

## 4. Deployment Verification

### Verifying the Live API
To confirm the features are active in production, you can test the endpoints using `curl`.

**Expected Behavior**:
*   **Unauthenticated Request**: Should return `401 Unauthorized`.
*   **Authenticated Request**: Should return `200 OK` (or `400` if parameters are missing).
*   **Incorrect Behavior**: `404 Not Found` implies the feature is **NOT** deployed.

**Test Command**:
```bash
curl -i -X POST "https://australia-southeast1-invoice-660f3.cloudfunctions.net/api/payments/create-intent"
```
**Current Status (Verified)**: Returns `401 Unauthorized`, confirming the route exists and is protected.

## 5. Development & Maintenance

### Environment Variables
Ensure the following are set in your local `.env` and GitHub Secrets:

```env
STRIPE_SECRET_KEY=sk_test_...
SMTP_HOST=smtp.example.com
SMTP_USER=user
SMTP_PASS=password
```

### Troubleshooting
*   **"Route.post() requires a callback function"**: Ensure `paymentController` methods are exported correctly and passed directly to the router (e.g., `router.post(path, controller.method)`), not wrapped in arrow functions if context isn't handled.
*   **Stripe Errors**: Check `STRIPE_SECRET_KEY`. If the key is invalid, `createPaymentIntent` will throw an authentication error.

### Code References
*   [InvoiceDetailView](file:///Users/bishal/Developer/invoice/lib/app/features/invoice/views/invoice_detail_view.dart)
*   [EnhancedInvoiceGenerationView](file:///Users/bishal/Developer/invoice/lib/app/features/invoice/views/enhanced_invoice_generation_view.dart)
*   [paymentRoutes.js](file:///Users/bishal/Developer/invoice/backend/routes/paymentRoutes.js)
*   [paymentService.js](file:///Users/bishal/Developer/invoice/backend/services/paymentService.js)
*   [deploy-prod.yml](file:///Users/bishal/Developer/invoice/backend/.github/workflows/deploy-prod.yml)
