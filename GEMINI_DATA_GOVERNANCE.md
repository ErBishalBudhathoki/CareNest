# Gemini Data Governance — Setup & Findings

**Status**: Partially configured (dev done; prod blocked on billing)
**Date**: 2026-08-08
**Verified by**: gcloud (accounts: budhathokib085@gmail.com [prod owner], deverbishal331@gmail.com [dev owner])

---

## What Your App Sends To Gemini

The CareNest app never talks to Gemini directly. All AI calls go app → CareNest backend → Vertex AI (Gemini Flash):

- **`POST /invoice-ai/generate-from-text`** — sends `organizationId`, `textNote`, active client list (name/email), and last-30-days historical invoice line items (description, price, quantity). Response is used to build invoice JSON.
- **`POST /invoice-ai/auto-generate`** — sends appointment/shift data + historical invoices.
- **`POST /invoice-ai/validate`, `/detect-anomalies`, `/smart-reminders`** — invoice data.
- **`AISchedulerService`** — shift/roster context for scheduling suggestions.

So: **yes, client personal data (names, emails, billing amounts) is shared with Google's Gemini models.**

---

## What Google Does With It — Vertex AI (paid enterprise) vs Gemini API

Your backend uses **Vertex AI** via `@google-cloud/vertexai`:
- Invoice AI: `services/invoiceAIService.js` — model `gemini-2.5-flash` (env `INVOICE_AI_MODEL`), project from `GOOGLE_CLOUD_PROJECT/GCP_PROJECT_ID`, location `global`.
- Scheduler: `services/aiSchedulerService.js` — model `gemini-1.5-flash-001`, location `us-central1` (env `GCP_LOCATION`).

### Training / model improvement
- **Vertex AI (paid path): Google does NOT use your prompts/responses to train models.** This is a contractual commitment ("Training Restriction") in the Google Cloud Service Specific Terms, backed by the Cloud Data Processing Addendum (DPA). No opt-in/opt-out toggle needed — it is the baseline.
- Contrast: the **free Gemini API / Google AI Studio** tier DOES use your data to improve products and human reviewers may read it. **You are not on that path** — you are on Vertex AI, so you're in the good tier. Keep it that way.

### Retention
- **Prompt logging for abuse monitoring**: Google may log prompts/responses for a limited period solely for prohibited-use detection. To achieve full Zero Data Retention (ZDR), request an abuse-monitoring exception (per project).
- **In-memory caching**: by default Gemini models cache prompts/responses in RAM (24h TTL, project-isolated, not at-rest). **This can be disabled at the project level** — and we have done that for the dev project.
- **Grounding with Google Search / Maps**: would add 30-day retention; **your code does not use grounding**, so this does not apply.

---

## What Has Been Configured

### Dev project — `invoice-660f3` (deverbishal331@gmail.com, billing enabled, Vertex AI enabled)
- **In-memory caching DISABLED** ✅ (verified via `GET /cacheConfig` → `"disableCache": true`)
  ```
  curl -X PATCH -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" \
    "https://us-central1-aiplatform.googleapis.com/v1/projects/invoice-660f3/cacheConfig" \
    -d '{"name": "projects/invoice-660f3/cacheConfig", "disableCache": true}'
  ```
  This stops Google from caching your prompts/responses even transiently.

### Production project — `carenest-prods` (budhathokib085@gmail.com)
- **BLOCKED: billing is DISABLED on this project** (`billingEnabled: false`).
- Vertex AI API is enabled but the cacheConfig endpoint refuses requests without billing.
- **Implication**: Gemini calls from the production backend (`backend-prod` Cloud Run) are failing or falling back because Vertex AI requires billing. This needs the account owner to enable billing (or attach a billing account) before the cache-disable and ZDR can be applied there.

---

## Recommended Next Steps (data governance)

1. **Enable billing on `carenest-prods`** (Google Cloud Console → Billing → Link billing account). This is required for production Gemini to work AND for applying the cache-disable + ZDR there.
2. **Disable in-memory caching on prod** (same curl as above, `projects/carenest-prods/cacheConfig`).
3. **Request Zero Data Retention (ZDR)** for both projects if you want the strongest guarantee that prompts are cleared right after the request (Google Cloud → Vertex AI → Data governance → Zero data retention; or submit an abuse-monitoring exception).
4. **Keep all AI calls on Vertex AI** (paid) — never switch the production backend to the free Gemini API tier, which uses data for training.
5. **App-side (App Review requirement)**: add an in-app disclosure + consent screen before any AI feature is used, e.g. "Invoice AI sends invoice/client data to Google's Gemini model (via CareNest's server). Google does not use your data for training. By continuing you consent." This is required by Apple regardless of Google's policy.

---

## Reference

- Gemini API terms: unpaid tier trains on data; paid tier does not. (ai.google.dev/gemini-api/terms)
- Vertex AI data governance / zero-data-retention: Google Cloud docs "How Gemini for Google Cloud uses your data" + "Zero data retention".
- Cloud Data Processing Addendum applies to Vertex AI (Article 28 processor contract), not to free AI Studio tier.
