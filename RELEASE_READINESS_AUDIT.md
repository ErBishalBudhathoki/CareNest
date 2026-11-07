# Pre-Release Readiness Audit — CareNest (multi-tenant NDIS service management & invoicing)

**Mode:** Falsification-first. Every assertion below was verified by code inspection or by executing a test/command; statuses marked `FIXED` were changed in the working tree, not merely recommended.
**Scope:** existing Google Play Store listing (`com.bishal.invoice`), architectural overhaul (Standard Invoicing ↔ SIL/NDIS Claiming split, Temporal workflows, R2/Valkey, Maestro E2E, Fastlane release).
**Repositories:** two independent git repos — app root and `backend/` (the root repo gitignores `backend/`). Nothing in this audit has been committed.
**Constraint honoured:** no `.env` value and no credential is printed anywhere in this report. Maestro "before" values are redacted.

---

## 0. VERDICT

| Track | Verdict |
|---|---|
| **Google Play `internal`** | **GO** — all deterministic automated gates pass, including the 4-flow Maestro release suite on the emulator. |
| **Google Play `production` (promotion)** | **NO-GO until internal testing completes** — by design. `verify_store_metadata!` now passes (8 screenshots + premium listing), but promotion requires: backend changes deployed to dev and probe-verified, then a manual `promote-to-production.yml` dispatch with the tested `versionCode`. |

**Blocking is deliberate and enforced in code**, not just advisory: `android/fastlane/Fastfile` calls `verify_store_metadata!` inside `promote_internal_to_production`, and the promotion lane refuses a `versionCode` that is not already on the `internal` track. Production cannot be reached by a push to `main` (`assert_no_direct_production!`).

---

## 1. RELEASE GO / NO-GO CHECKLIST (deterministic)

| # | Gate | Status | Evidence |
|---|---|---|---|
| 1 | Hardcoded Maestro credentials removed | **PASS** | Residual literal emails across `.maestro/*.yaml`: **0** (23 flows rewritten, redaction-safe scan) |
| 2 | `.env.maestro.example` committed, real `.env.maestro` ignored | **PASS** | `git check-ignore -v`: example is `!.env.maestro.example`; `.env.maestro` matched by `**/.env.*` |
| 3 | Maestro runner loads env without echoing values, dev/prod mismatch guard | **PASS** | `scripts/run_maestro.sh` (REQUIRED_VARS, `-e KEY=VALUE`, APP_ID↔API_BASE_URL guard) |
| 4 | Release-critical Maestro suite is trackable (was gitignored) | **PASS** | `.gitignore:503-531` allowlist; `git status` shows `.maestro/` and `scripts/` as untracked-but-trackable |
| 5 | Valkey keys/channels/queues/scans environment-scoped | **PASS** | `backend/utils/envScope.js`; 12 call sites; `tests/unit/envScope.test.js` (25 tests) |
| 6 | Cloudflare R2 object paths environment-scoped + scoped-first legacy reads | **PASS** | `backend/utils/envScope.js`, `config/storage.js`, `utils/cloudFunctionsUpload.js`, `controllers/fileController.js`, `controllers/authController.js`, `services/ndisCatalogSyncService.js` |
| 7 | Production mobile config: HTTPS-only, no debug flags, no mock interceptors, no staging/localhost URLs, no compiled App Check debug token | **PASS** | `lib/config/env/production.dart`: no `http://`, no localhost/`10.0.2.2`, no `staging`, no mock; `lib/main_production.dart:55-56` silences `debugPrint` in release; `AppCheckProviderResolver` forces Play Integrity in `kReleaseMode`; `APP_CHECK_DEBUG_TOKEN` occurrences in prod CI: **0** |
| 8 | `applicationId` matches the Play listing | **PASS** | `android/app/build.gradle:65` = `com.bishal.invoice`; `android/fastlane/Fastfile:26` `PACKAGE_NAME = "com.bishal.invoice"` |
| 9 | `versionCode` strictly higher than all Play tracks | **PASS** | Live `google_play_track_version_codes`: production 158 codes, internal 227, beta/alpha empty → `versionCode 228 > highest published 227 (internal)`. `pubspec.yaml:4` = `4.9.9+228`. `Fastfile:236-243` `verify_version_code` enforces this in CI |
| 10 | ProGuard/R8 reflection & serialization keeps | **PASS** | `android/app/proguard-rules.pro:11-15` `*Annotation*`, `Signature`, `InnerClasses`, `EnclosingMethod`, `SourceFile,LineNumberTable`; Flutter/Play Integrity/Firebase/Stripe keeps at `:18-72`. `minifyEnabled true` / `shrinkResources true` at `build.gradle:116-117` |
| 11 | Standard Invoicing excludes SIL (no double-billing) | **PASS** | `backend/utils/silBillingBoundary.js`, `backend/services/invoiceGenerationService.js`; `tests/services/silBillingBoundary.test.js` |
| 12 | SIL Management + NDIS Claim export isolated to Configuration & Finance | **PASS** | `backend/routes/silRoutes.js:41-46` and `backend/routes/ndisClaimRoutes.js:36-38` are admin-gated; `Configuration & Finance` tiles at `lib/app/features/admin/views/admin_dashboard_view.dart:1635-1744` |
| 13 | NDIS claim batch idempotency + duplicate-claim prevention | **PASS** | `backend/controllers/ndisClaimController.js`, `backend/models/ClaimBatch.js` partial unique index, `backend/services/ndisClaimService.js:177-233`; `tests/claiming/ndisClaimControllerIdempotency.test.js` |
| 14 | Invoice generation idempotent under Temporal retry | **PASS** | `backend/temporal/activities/cron.js`, `backend/services/bulkInvoiceService.js`; deterministic `metadata.idempotencyKey` + `updateOne(..., {upsert:true})` + 11000 replay recovery |
| 15 | Temporal PDF/R2 + email activities deterministic/idempotent | **PASS** | `backend/services/invoiceArtifactService.js` (SHA-256-scoped path), `backend/services/invoiceEmailDeliveryLog.js` (durable ledger), `backend/controllers/invoicingEmailController.js` (content-hash delivery key), deterministic SMTP `Message-ID` |
| 16 | RBAC: non-admin cannot reach Invoice Operations / Configuration & Finance APIs | **PASS** | `backend/middleware/adminSurface.js`, applied at `invoiceAIRoutes.js:17-20`, `v1/invoice.js:225-228`, `v1/pricePrompt.js:22-25`, `invoiceManagement.js`, `invoicingEmailLegacyRoutes.js:28-34`, `v1/pricing.js` (state-changing methods), `client.js` plan gate, `accounting.routes.js`, `paymentRoutes.js` (all 8 endpoints), `billing/billingRoutes.js` (admin management routes; entitlement verify/status deliberately open), `v1/organization.js` (4 organisation-level write routes). `tests/routes/adminSurfaceAuthorization.test.js`: **103/103**; `tests/routes/financialAdminGates.test.js` + `tests/middleware/adminSurface.test.js`: **3 suites / 82 tests** |
| 17 | Admin→Employee switch does not mint/alter tokens; state scoped | **PASS (by design)** | `lib/app/features/settings/views/settings_view.dart:153-245`: navigation arguments only, no `setRole()`, no token reissue. Server is the boundary |
| 18 | Strict client-side route guards on admin screens (deep links included) | **PASS (fixed this audit)** | `lib/app/routes/app_pages.dart` `adminOnlyRoutes` (incl. `assignmentList`, `bulkActions`) + `guardAdminRoute` + `AdminRouteAccessDeniedView`; voice-assistant direct-push guard `isVoiceDestinationAllowed`; `test/routes/app_routes_smoke_test.dart` + `voice_assistant_route_guard_test.dart`: **65/65** |
| 19 | Maestro modular flows with `clearState: true` | **PASS** | `01_auth_rbac` (3), `02_admin_owner_switch` (1), `03_standard_invoicing` (1), `04_sil_and_ndis_claiming` (1) |
| 20 | Maestro + GitHub Actions YAML syntax | **PASS** | Ruby `YAML.load_file`: **41 files parsed, 0 failures**; `maestro check-syntax` 4/4 flows OK |
| 21 | Backend regression suites | **PASS** | Broader sweep: **11 suites / 293 tests passed**; targeted gate suites: 3 suites / 82 tests |
| 22 | Flutter tests | **PASS** | Full suite: **804/804 passed** (proxy env vars cleared) |
| 23 | `flutter analyze` | **PASS** | `No issues found!` |
| 24 | Main pushes deploy to `internal` only | **PASS** | `.github/workflows/flutter_ci_optimized.yml:383-464` → `environment: internal`, `fastlane android upload_internal_aab`; `.github/workflows/flutter_ci.yml` is CI-only |
| 25 | Production reachable only via manual `workflow_dispatch` promotion | **PASS** | `.github/workflows/promote-to-production.yml` (confirmation `PROMOTE`, pinned `version_code`, `environment: production`, required reviewers); `Fastfile:286-298` `assert_no_direct_production!` blocks the two legacy direct-upload lanes |
| 26 | Promotion ships Play listing metadata + screenshots | **PASS (wiring)** | `Fastfile:427-438` `skip_upload_metadata/images/screenshots: false`, `metadata_path: metadata_root`; `.gitignore` no longer ignores `android/fastlane/metadata/android` |
| 27 | **2–8 store-approved phone screenshots present** | **PASS (fixed this audit)** | 8 premium 1080×1920 screenshots generated from raw Maestro captures via the externally-installed screenshot skill and staged in `android/fastlane/metadata/android/en-US/images/phoneScreenshots/`; premium `title.txt` (27/30), `short_description.txt` (74/80), `full_description.txt` (2939/4000). `fastlane android verify_store_metadata` → `Play listing metadata and 8 screenshots validated.`, exit 0. A macOS case-insensitive `Dir.glob` double-count bug in `verify_store_metadata!` (8 files counted as 16) was found and fixed with `.uniq { |path| path.downcase }` |
| 28 | **Maestro E2E flows executed on a device/emulator** | **PASS (executed this audit)** | Fresh development APK built from current source and installed on `emulator-5554`. See §6 for the full run log: 4/4 flows green with true exit-code capture |
| 29 | **Backend changes deployed and smoke-verified** | **PENDING (backend `dev` push)** | All backend changes are local working-tree edits in the `backend/` repo. Push to `backend` `dev` triggers `backend-deploy-dev-hybrid.yml`; then run `node scripts/verify-tenant-isolation.js --seed --base-url <url>/api` against the deployed service |

---

## 2. FINDINGS BY SEVERITY

### P0 — BLOCKER (all FIXED in the working tree)

| ID | Component | Finding | Exact location | Resolution |
|---|---|---|---|---|
| P0-1 | Backend / multi-tenancy | `invoice-ai` and `price-prompt` controllers read `organizationId` straight from the request body; an authenticated employee could generate invoices **for an arbitrary organisation**. Neither router had RBAC. | `backend/controllers/invoiceAIController.js` (`autoGenerateInvoices`, `generateFromText`, `predictPayment`, `getSmartReminders`), `backend/controllers/pricePromptController.js`, `backend/routes/invoiceAIRoutes.js` (mounted `routes/index.js:167`), `backend/routes/v1/pricePrompt.js` (`routes/index.js:96`) | New `backend/middleware/adminSurface.js` (`requireAdminSurface`, `requireMatchingOrganization`) applied router-level; controllers now prefer `req.organizationContext.organizationId` and scope `Invoice.findOne({_id, organizationId})` |
| P0-2 | Backend / Temporal | Recurring-invoice activity generated `invoiceNumber` from `Date.now()`/`Math.random()` and used `insertOne`; every workflow retry created a duplicate invoice. Bulk generation had the same flaw and an unscoped `ClientAssignment.updateMany`. | `backend/temporal/activities/cron.js`, `backend/services/bulkInvoiceService.js` | Deterministic `INV-R-…`/`INV-BULK-…` numbers + SHA-256 `metadata.idempotencyKey` + `updateOne(..., {upsert:true})` + duplicate-key replay handling; `updateMany` now tenant-scoped |
| P0-3 | Backend / billing | Standard `Invoice Operations` absorbed SIL hours: `WorkedTime.find` included `silShiftId`/`isIrregularSil` rows and the `Shift` fallback included SIL roster shifts. Same hours could be billed once via a standard invoice and again via SIL Management / NDIS Claim. | `backend/services/invoiceGenerationService.js` (`getWorkedTimeData`, `generateInvoiceLineItems`) | New `backend/utils/silBillingBoundary.js` exclusion predicates applied to both queries |
| P0-4 | Backend / NDIS | Claim batch generation had no request-level idempotency: a retried `POST /api/ndis-claims/generate` produced a second batch of claims. Period end was exclusive (`new Date(opts.to)` = midnight), dropping last-day lines. | `backend/controllers/ndisClaimController.js`, `backend/services/ndisClaimService.js:122-135` | Derived `claim:<org>:<from>:<to>:<valid|invalid>` key + partial unique index (`backend/models/ClaimBatch.js`), 200-replay vs 201-create, 11000 race recovery, `regenerate: true` opt-out, inclusive UTC end-of-day |
| P0-5 | Fastlane / release | Pushes to `main` could upload a production AAB **directly to the production track**, bypassing internal testing. | `.github/workflows/flutter_ci_optimized.yml` deploy job, `android/fastlane/Fastfile` `deploy_production` / `upload_production_aab` | Deploy job retargeted to `internal`; direct-production lanes guarded by `assert_no_direct_production!`; production only via manual `promote-to-production.yml` |
| P0-6 | Maestro / secrets | 23 `.maestro/*.yaml` flows contained literal admin/employee/client emails, passwords and org codes. The whole release-critical suite was also **gitignored**, so CI could never run it. | `.maestro/*.yaml`, `.gitignore` (`.maestro/`, `scripts/`, `.env.*`) | Redaction-safe scrub to `${MAESTRO_*}`/`${API_BASE_URL}` placeholders; `.env.maestro.example`; `scripts/run_maestro.sh`; explicit `.gitignore` allowlist |

### P1 — CRITICAL (all FIXED in the working tree)

| ID | Component | Finding | Exact location | Resolution |
|---|---|---|---|---|
| P1-1 | Backend / isolation | Dev and prod share Valkey keyspace and one R2 bucket with **no namespace**. A dev cache write, `rl:*` reset, pub/sub event, BullMQ job or R2 upload could collide with prod. | `backend/middleware/rateLimitStore.js`, `backend/middleware/auth.js`, `backend/middleware/responseCache.js`, `backend/services/cacheService.js`, `backend/core/EventBus.js`, `backend/core/QueueManager.js`, `backend/config/storage.js`, `backend/utils/cloudFunctionsUpload.js`, `backend/scripts/reset_all_redis_limits.js`, `backend/routes/adminDevRoutes.js` | `backend/utils/envScope.js` — `scopeKey`/`scopePath` (idempotent, conservative default-to-`dev`), `readCandidatePaths` scoped-first/legacy-last, `isKeyForCurrentScope`, `isObjectNotFoundError` so 403/500 are never masked as "not found" |
| P1-2 | Backend / Temporal | Invoice PDF artifact path used `Date.now()`/`Math.random()` → orphaned PDFs on retry; SMTP activity could double-send after SMTP accepted but before Temporal recorded success. | `backend/services/invoiceArtifactService.js`, `backend/controllers/invoicingEmailController.js`, `backend/temporal/activities/invoice.js` | Deterministic SHA-256-scoped artifact path; content-hash `deliveryKey`; new durable `backend/services/invoiceEmailDeliveryLog.js` ledger + deterministic `Message-ID` |
| P1-3 | Backend / RBAC | `v1/pricing.js` (NDIS price caps, catalogue, approvals, bulk import, fallback base rate) and the participant plan-budget `PUT` had only authentication + membership. Any employee token could rewrite the numbers that gate invoice/claim amounts. | `backend/routes/v1/pricing.js:52-53`, `backend/routes/client.js:60-75` | Method-based `requireMatchingOrganization` + `requireAdminSurface` gate on all state-changing pricing methods (read-only `POST /bulk-lookup` exempted); plan `PUT` gated. Regression cases added to `tests/routes/adminSurfaceAuthorization.test.js` |
| P1-4 | Backend / NDIS dates | `new Date(serviceDate)` on stored `DD/MM/YYYY` values: Node reads slash dates as US `MM/DD`. Reproduced: `'01/04/2026'` → `2026-01-03`, `'31/12/2026'` → Invalid Date → `RangeError` in `.toISOString()` aborting the whole batch. Wrong `SupportsDeliveredFrom/To` would be exported to myplace. | `backend/services/ndisClaimService.js:195, 225-236` | New `toServiceDate()` normalises Date/ISO/day-first strings to UTC midnight via `normalizeToIsoDate`; invalid dates are skipped with a warning; dedupe keys use the same normaliser. Four regression tests added |
| P1-5 | Flutter / navigation | **No client-side route guard existed.** `AppPages.buildRoutes()` is a flat Navigator 1.0 map and `deep_link_handler.dart:135-162` pushes any registered route name with no auth/role check. Employees/Clients could deep-link straight into Invoice Operations / Configuration & Finance. Only one ad-hoc tile check existed (`admin_dashboard_view.dart:1776-1799`). | `lib/app/routes/app_pages.dart`, `lib/app/features/auth/utils/deep_link_handler.dart:135-162`, `lib/main*.dart` | `adminOnlyRoutes` set + `guardAdminRoute` wrapper applied to the entire route map (fails closed on a missing cached role) + `AdminRouteAccessDeniedView`. Documented as defence-in-depth; server RBAC remains authoritative |
| P1-6 | Flutter / App Check | Release builds previously fell back to `AndroidDebugProvider` when the installer package was not `com.android.vending`, letting a shipped binary mint App Check tokens from a known debug secret. | `lib/app/services/app_check/app_check_provider_resolver.dart` | `kReleaseMode` now always returns `AndroidPlayIntegrityProvider`; debug token is build-time injected only and never hardcoded |

### P2 — WARNING (none block `internal`)

| ID | Component | Finding | Exact location | Status |
|---|---|---|---|---|
| P2-1 | Fastlane / listing | **0 phone screenshots**; `metadata/android/en-US/images/phoneScreenshots/` was empty. Additionally, `verify_store_metadata!` double-counted screenshots on macOS because `Dir.glob("*.{png,PNG,…}")` matched the same file twice on a case-insensitive filesystem (8 files counted as 16). | `android/fastlane/Fastfile`, `android/fastlane/metadata/android/en-US/images/phoneScreenshots/` | **FIXED.** 8 premium 1080×1920 screenshots generated from raw Maestro captures via the externally-installed (`LeeHueeng/store-screenshots`-pattern) renderer and staged; premium benefit-led listing copy written; glob de-duplicated with `.uniq { |path| path.downcase }`; `fastlane android verify_store_metadata` exits 0 |
| P2-2 | Maestro | No `Semantics(identifier:)` test IDs anywhere in `lib/`; the release flows originally used brittle text selectors. A plain Maestro string is an **EXACT** match, so it can never match Flutter's merged accessibility labels (e.g. `Employee\nView employee insights…`) — and an exact-text `assertNotVisible` is **vacuous** (it always "passes"). | `.maestro/01…04_*.yaml` | **RESOLVED pragmatically.** All four flows rewritten against the live accessibility hierarchy captured with `maestro hierarchy`: every selector is now an anchored regex over the merged label, negative RBAC assertions are regexes that genuinely scan the hierarchy, and each flow documents the selector contract. `Semantics(identifier:)` remains a future hardening step (would require an app rebuild) |
| P2-3 | Maestro | Flows were authored but not executed on a device. | `.maestro/01…04_*.yaml` | **RESOLVED.** Full suite executed on `emulator-5554` against a fresh build of the current source — see §6 |
| P2-4 | Backend / RBAC | Pre-existing financial/config routers had auth + tenancy but no role gate: `accounting.routes.js`, `billing/billingRoutes.js`, `paymentRoutes.js`, `v1/organization.js` (broad `$set` organisation writes), plus the already-gated `v1/pricing.js` and `client.js` plan route. | `backend/routes/*` | **FIXED with deliberate exemptions.** Gated: accounting router-level, all 8 payment endpoints, billing management routes, 4 organisation write routes (`PUT /:organizationId`, `PUT /:organizationId/branding`, both contact-email verification routes) via a new `requireMatchingOrganizationNoBodyPin` (raw `$set: req.body` update payloads must not get `organizationId` injected). Deliberately left open: personal bank details (employee self-service), Cloud Scheduler machine-auth, signature-verified webhooks, entitlement verify/status (`subscription_guard.dart` pushes `SubscriptionView` to any member on 402), public participant checkout, `POST /organization/:organizationId/switch`, organisation reads/create/verify-code/`my-list`. `OrganizationDetailsView` hides edit/verification affordances for non-admins (defence in depth). NDIS Plan button and custom-pricing writes already sit behind `adminOnlyRoutes` surfaces, so no further UI change was needed |
| P2-4b | Backend / billing boundary | Orphaned `silShiftId` rows (links to deleted/non-SIL shifts, or missing the field) were silently dropped by standard billing exclusions — a silent revenue-loss path. | `backend/utils/silBillingBoundary.js`, `backend/services/invoiceGenerationService.js` | **FIXED.** `findOrphanSilWorkedTimeIds(...)` recovers orphaned rows in `getWorkedTimeData()`; genuine SIL links and irregular SIL stay excluded; `tests/services/silBillingBoundary.test.js` (10 tests) |
| P2-5 | Backend / config | `ENTITLEMENT_GATE=true` on dev returns 402 for unsubscribed orgs on `/api/payroll*`, `/api/invoices`, `/api/bulk`, … A 402 can masquerade as "authorization worked". `subscriptionGate` fails open unless the flag is set, and `requireEntitlement` also fails open. | `backend/middleware/billing/subscriptionGate.js:80-82,115-121`, `backend/middleware/billing/requireEntitlement.js:16-18` | **OPEN — known.** Do not treat entitlement gating as authorization; probe tenants must be marked subscribed or isolation results are meaningless |
| P2-6 | Backend / dead code | `backend/routes/pricePrompt.js` defines absolute `/api/price-prompts/*` routes but is never mounted (`routes/index.js:96` mounts `routes/v1/pricePrompt.js` instead). Also `routes/priceValidation.js` is unmounted. | as listed | **OPEN — cleanup** |
| P2-7 | Fastlane | `deploy_production` / `upload_production_aab` lanes still exist and can be reached with `ALLOW_DIRECT_PRODUCTION=true`; `capture_screenshots` lane name collides with a built-in fastlane action (warning observed). | `android/fastlane/Fastfile:271, 315, 373` | **OPEN — accepted escape hatch**, guarded and unused by CI |
| P2-8 | Tests | `tests/middleware/responseCache.test.js` "a cache read failure degrades to an uncached response" intermittently returned 404 when run alongside the full-app authorization suite; passes **16/16 in isolation** and passed on re-run of the full sweep. | `backend/tests/middleware/responseCache.test.js:247-260` | **OPEN — order-sensitive flake**, not a regression |
| P2-9 | Environment (known) | `flutter test` fails with proxy env vars set; backend integration suites need a live MongoDB; 3 pre-existing `api_security_gate_integration` failures and a flaky `admin-dev-optional` suite. `bundle exec fastlane` fails locally on Ruby 4.0 (missing bundled gems) — system `fastlane` works. | project memory | **OPEN — environmental**, not caused by this work |
| P2-10 | Docs | `lib/app/features/settings/views/settings_view.dart:153-161` previously claimed the VIEW-MODE switch "changes the cached UserRole"; it does not (no `setRole()` call). | `settings_view.dart` | **FIXED** — comment corrected to state navigation-arguments-only semantics |
| P2-11 | Dev ops / E2E | Login rate limit (`RATE_LIMIT_CONFIGS.login`: 5 per 15 min, key `rl:login:<email>` via `scopeKey`) plus Firebase Auth `too-many-requests` cooldown can stall iterative E2E logins; a "Too many failed attempts" modal is a rate-limit artefact, not an app bug. Also: the dev App Check debug secret must be registered against `com.bishal.invoice.dev` or the app fails with `403 App attestation failed`. | `backend/middleware/auth.js`, `backend/scripts/force_reset_limit.js`, `backend/scripts/reset_all_redis_limits.js`, `backend/scripts/unblock-auth-ip.js` | **HANDLED.** All three reset scripts executed (0 dev-scoped keys — the 15-minute window had elapsed); the configured dev App Check secret was registered for the dev Firebase app via the App Check `debugTokens` API (value never printed); cold start then logged `✅ App Check token obtained successfully` |

---

## 3. EXACT CODE DIFFS / PATCHES

The complete diffs live in the working tree of the two repos (`git diff` in `/Users/bishal/Developer/invoice` and in `/Users/bishal/Developer/invoice/backend`; new files appear under `git status --short`). Representative hunks are reproduced verbatim below. **Removed Maestro credential values are redacted** by requirement.

### 3.1 Patch 1 — hardcoded Maestro credentials → env placeholders

`.gitignore` (verbatim diff):

```diff
@@ -155,9 +155,17 @@ assets/icons/ic_launcher1.png
-# Fastlane reports and metadata
+# Fastlane reports and generated output.
+# NB: the Play listing metadata under android/fastlane/metadata/android is
+# DELIBERATELY TRACKED. The manual promote_internal_to_production lane uploads
+# that directory (title, descriptions and phoneScreenshots) together with the
+# release, so ignoring it would make every production promotion ship without a
+# listing. Only screengrab's generated HTML and the per-build changelogs stay
+# local: changelogs are regenerated from android/release_notes_<name>.txt by
+# Fastfile#ensure_changelog at promotion time.
 /android/fastlane/report.xml
-/android/fastlane/metadata/
+/android/fastlane/metadata/android/screenshots.html
+/android/fastlane/metadata/android/*/changelogs/
 /ios/fastlane/report.xml
 /ios/fastlane/metadata/
@@ -478,6 +488,7 @@
 **/.env
 **/.env.*
+!.env.maestro.example
@@ -492,6 +503,32 @@ node-compile-cache/
 .superpowers/
+
+# ==========================================
+# RELEASE-CRITICAL E2E SUITE (committed)
+# ------------------------------------------
+# .maestro/ and scripts/ are ignored above for local scratch work. These
+# credential-free flows plus their runner are part of the release gate and
+# MUST be tracked so CI can execute them. Anything not allowlisted below
+# (screenshot tours, dumps, tmp_*.yaml, seed bulk flows) stays untracked.
+# ==========================================
+!/.maestro/
+/.maestro/*
+!/.maestro/00_login.yaml
+!/.maestro/01_auth_rbac.yaml
+!/.maestro/02_admin_owner_switch.yaml
+!/.maestro/03_standard_invoicing.yaml
+!/.maestro/04_sil_and_ndis_claiming.yaml
+!/.maestro/README.md
+
+!/scripts/
+/scripts/*
+!/scripts/run_maestro.sh
+!/scripts/prepare_play_screenshots.sh
+!/scripts/check_sensitive_files.sh
+!/scripts/sync_secrets.sh
+!/scripts/generate-firebase-config.js
```

Representative flow transform (23 files, values redacted):

```diff
-appId: com.bishal.invoice.dev
-env:
-  ADMIN_EMAIL: <redacted>
-  ADMIN_PASSWORD: <redacted>
+appId: ${APP_ID}
 ---
 - tapOn: "Enter your email"
-- inputText: <redacted>
+- inputText: ${MAESTRO_ADMIN_USER}
 - tapOn: "Enter your password"
-- inputText: <redacted>
+- inputText: ${MAESTRO_ADMIN_PASS}
```

New `.env.maestro.example` (blank by design — verbatim):

```dotenv
APP_ID=
MAESTRO_ADMIN_USER=
MAESTRO_ADMIN_PASS=
MAESTRO_EMP_USER=
MAESTRO_EMP_PASS=
MAESTRO_CLIENT_USER=
MAESTRO_CLIENT_PASS=
MAESTRO_ORG_CODE=
API_BASE_URL=
MAESTRO_SEED_CLIENT_1=
MAESTRO_SEED_CLIENT_2=
MAESTRO_SEED_CLIENT_3=
MAESTRO_SEED_BUSINESS_1=
MAESTRO_SEED_BUSINESS_2=
MAESTRO_SEED_BUSINESS_3=
MAESTRO_SEED_EMPLOYEE_2=
MAESTRO_SEED_EMPLOYEE_3=
```

New `scripts/run_maestro.sh` (key hunk — values are never echoed):

```bash
REQUIRED_VARS=(
  APP_ID
  MAESTRO_ADMIN_USER
  MAESTRO_ADMIN_PASS
  MAESTRO_EMP_USER
  MAESTRO_EMP_PASS
  MAESTRO_CLIENT_USER
  MAESTRO_CLIENT_PASS
  API_BASE_URL
)

if [[ "${APP_ID}" == *.dev && "${API_BASE_URL}" == *prod* ]]; then
  echo "ERROR: APP_ID is a development build but API_BASE_URL looks like production." >&2
  exit 1
fi

env_args+=(-e "$key=$value")
maestro test "${env_args[@]}" "${flows[@]}"
```

### 3.2 Patch 2 — Valkey / Cloudflare R2 environment isolation

New `backend/utils/envScope.js` (core, verbatim):

```js
const RAW_ENV = String(
  process.env.APP_ENV || process.env.NODE_ENV || 'development'
).trim().toLowerCase();

const ENV_SCOPE = RAW_ENV === 'production' || RAW_ENV === 'prod' ? 'prod' : 'dev';
const KNOWN_SCOPES = ['dev', 'prod', 'staging', 'test'];

function scopeKey(key) {
  const clean = _clean(key);
  const head = clean.split(':')[0];
  if (KNOWN_SCOPES.includes(head)) return clean;
  return `${ENV_SCOPE}:${clean}`;
}

function scopePath(key) {
  const clean = _clean(key).replace(/^\/+/, '');
  const head = clean.split('/')[0];
  if (KNOWN_SCOPES.includes(head)) return clean;
  return `${ENV_SCOPE}/${clean}`;
}

function readCandidatePaths(key) {
  const clean = _clean(key).replace(/^\/+/, '');
  const scoped = scopePath(clean);
  const candidates = [scoped];
  if (scoped !== clean) candidates.push(clean);
  return [...new Set(candidates)];
}
```

Applied hunks (verbatim):

```diff
--- a/backend/middleware/rateLimitStore.js
+++ b/backend/middleware/rateLimitStore.js
+const { scopeKey } = require('../utils/envScope');
...
+    const scopedPrefix = scopeKey(prefix);
     return new RedisStore({
       sendCommand: (...args) => redis.call(...args),
-      prefix,
+      prefix: scopedPrefix,
```

```diff
--- a/backend/core/QueueManager.js
+++ b/backend/core/QueueManager.js
+const { ENV_SCOPE } = require('../utils/envScope');
         this.queues[name] = new Queue(name, {
           connection: this.connection,
+          prefix: `${ENV_SCOPE}:bull`,
...
       }, {
         connection: this.connection,
+        prefix: `${ENV_SCOPE}:bull`,
```

```diff
--- a/backend/core/EventBus.js
+++ b/backend/core/EventBus.js
-    this.channel = 'app_events';
+    this.channel = scopeKey('app_events');
```

```diff
--- a/backend/scripts/reset_all_redis_limits.js
+++ b/backend/scripts/reset_all_redis_limits.js
-  const pattern = 'rl:*'; // Matches ALL rate limit keys
+  const pattern = `${ENV_SCOPE}:rl:*`;
```

```diff
--- a/backend/services/cacheService.js
+++ b/backend/services/cacheService.js
-      const data = await redis.get(key);
+      const data = await redis.get(scopeKey(key));
-      await redis.set(key, JSON.stringify(value), 'EX', ttl);
+      await redis.set(scopeKey(key), JSON.stringify(value), 'EX', ttl);
-      await redis.del(key);
+      await redis.del(scopeKey(key));
-      match: pattern,
+      match: scopeKey(pattern),
```

```diff
--- a/backend/config/storage.js
+++ b/backend/config/storage.js
+const { scopePath } = require('../utils/envScope');
-                const key = `${folder}/${file.fieldname}-${uniqueSuffix}${path.extname(file.originalname)}`;
+                const key = scopePath(`${folder}/${file.fieldname}-${uniqueSuffix}${path.extname(file.originalname)}`);
```

```diff
--- a/backend/middleware/responseCache.js
+++ b/backend/middleware/responseCache.js
-  return `http:resp:${scope}:${path}${normalisedQuery ? `?${normalisedQuery}` : ''}`;
+  return scopeKey(`http:resp:${scope}:${path}${normalisedQuery ? `?${normalisedQuery}` : ''}`);
```

`controllers/fileController.js`, `controllers/authController.js`, `services/ndisCatalogSyncService.js` additionally use `readCandidatePaths()` (scoped key first, legacy unscoped last), reject cross-environment keys via `isKeyForCurrentScope()`, and rethrow non-404 errors via `isObjectNotFoundError()` so a permissions/500 failure is never reported as a missing file. NDIS claim CSV keys are now both deterministic and scoped: `scopePath('claimBatches/<org>/<batchId>.csv')` in `backend/services/ndisClaimService.js`.

### 3.3 Patch 3 — Fastlane: `internal` staging, then manual promotion

`android/fastlane/Fastfile` (new guard, verbatim):

```ruby
  def assert_no_direct_production!
    return if ENV["ALLOW_DIRECT_PRODUCTION"] == "true"
    UI.user_error!(<<~MSG)
      Direct production uploads are disabled.

      Pushes to main deploy to the INTERNAL track first. After the internal
      build has been tested, run the manual `Promote to Production` workflow
      (which calls `fastlane promote_internal_to_production`). That lane
      promotes the exact tested versionCode and ships listing metadata.

      If you truly need an untested direct upload, set ALLOW_DIRECT_PRODUCTION=true.
    MSG
  end
```

`android/fastlane/Fastfile` (promotion lane, verbatim key body):

```ruby
  lane :promote_internal_to_production do
    version_code = (ENV["VERSION_CODE"] || "").strip
    UI.user_error!("VERSION_CODE is required: pin the exact internal build you tested.") if version_code.empty?
    version_code = version_code.to_i

    published = play_track_version_codes
    internal_codes = published.fetch('internal', [])
    unless internal_codes.include?(version_code)
      UI.user_error!("versionCode #{version_code} is not on the INTERNAL track. ...")
    end

    ensure_changelog(version_name, version_code)
    verify_store_metadata!

    upload_to_play_store(
      package_name: PACKAGE_NAME,
      track: 'internal',
      track_promote_to: 'production',
      version_code: version_code,
      skip_upload_apk: true,
      skip_upload_aab: true,
      skip_upload_metadata: false,
      skip_upload_images: false,
      skip_upload_screenshots: false,
      metadata_path: metadata_root,
    )
  end
```

`.github/workflows/flutter_ci_optimized.yml` (deploy job, verbatim):

```yaml
  # Deploy to Google Play — INTERNAL ONLY, on pushes to main.
  # Production is a separate manual workflow_dispatch that promotes an
  # already-tested internal versionCode; see promote-to-production.yml.
  deploy-android:
    name: Deploy to Google Play (internal)
    needs: [security-scan, test, build-android]
    if: >-
      github.event_name == 'push' &&
      github.ref == 'refs/heads/main' && ...
    environment:
      name: internal
...
      - name: Fail if versionCode is not strictly higher than every Play track
        run: fastlane android verify_version_code
      - name: Deploy to INTERNAL with Fastlane
        run: fastlane android upload_internal_aab
```

New `.github/workflows/promote-to-production.yml`: `workflow_dispatch` with required `version_code` + literal `confirmation: PROMOTE`, `environment: production` (for required reviewers), `verify_store_metadata`, then `promote_internal_to_production`. It never builds a binary (`skip_upload_aab`/`skip_upload_apk`), so only a versionCode already on `internal` can be promoted.

### 3.4 Additional fixes applied in this audit (not in the three required patches)

- **NDIS service-date normalisation** — `backend/services/ndisClaimService.js`: new `toServiceDate()`; `claimedSet`, `lineDedupKey`, `serviceDate` and `serviceEndDate` all use it; unparseable dates are skipped with a warning instead of throwing.
- **Pricing / plan-budget RBAC** — `backend/routes/v1/pricing.js` method-based admin gate with `/bulk-lookup` read exemption; `backend/routes/client.js` `PUT /client/:clientId/plan` gated.
- **Financial & organisation RBAC completion (P2-4)** — `backend/routes/accounting.routes.js` (router-level), `backend/routes/paymentRoutes.js` (all 8 endpoints), `backend/routes/billing/billingRoutes.js` (admin management; entitlement verify/status open), `backend/routes/v1/organization.js` (`adminOrganizationWriteGate` on the 4 write routes). New no-body-pin matcher in `backend/middleware/adminSurface.js` so raw `$set: req.body` organisation updates are never mutated.
- **SIL orphan recovery (P2-4b)** — `findOrphanSilWorkedTimeIds()` in `backend/utils/silBillingBoundary.js` + recovery in `invoiceGenerationService.getWorkedTimeData()`.
- **Flutter route guard** — `lib/app/routes/app_pages.dart`: `adminOnlyRoutes` (incl. `assignmentList`, `bulkActions`), `guardAdminRoute`, `AdminRouteAccessDeniedView`; voice-assistant direct-push guard `isVoiceDestinationAllowed` in `voice_assistant_view.dart`; `OrganizationDetailsView` hides admin-only affordances for non-admins.
- **Play listing** — premium `title.txt` / `short_description.txt` / `full_description.txt` + 8 generated 1080×1920 screenshots; `Fastfile` screenshot double-count fix.
- **Settings doc correction** — `lib/app/features/settings/views/settings_view.dart:153-161`.
- Regression tests added/extended: 12 backend suites, 2 Flutter suites.

---

## 4. REQUIRED ACTIONS BEFORE PRODUCTION PROMOTION

1. ~~Add 2–8 store-approved phone screenshots~~ — **DONE** (8 premium screenshots + listing copy; `fastlane android verify_store_metadata` exits 0).
2. **Commit both repos and push `backend` `dev` only** (app `main` push = an internal Play release; do it only when that is intended). The push triggers `backend-deploy-dev-hybrid.yml`.
3. **After the dev deploy, run `node scripts/verify-tenant-isolation.js --seed --base-url <url>/api`** against the deployed service and confirm the new gates return 403 for employee/client tokens. Remember: probe tenants must be marked subscribed or `ENTITLEMENT_GATE=true` answers 402 and the result is meaningless.
4. **Promote only after internal testing**: dispatch `promote-to-production.yml` with the exact tested `versionCode` (currently 228) and `confirmation: PROMOTE`.
5. The two repos are independent git repos (18 app paths + 45 backend paths changed/untracked). `docs/` and `.workbuddy-ai/memory/` are intentionally not committed.

---

## 5. EVIDENCE LOG (commands executed, no secret values)

| Command | Result |
|---|---|
| Residual-literal-email scan over `.maestro/*.yaml` | `TOTAL residual literal emails: 0` |
| `grep -c "clearState: true"` on the 4 release flows | `3 / 1 / 1 / 1` |
| Ruby `YAML.load_file` over `.maestro/*.yaml` + `.github/workflows/*.yml` | `parsed=41 failures=0` |
| `maestro check-syntax` (via `./scripts/run_maestro.sh --check`) | `syntax check complete (4 flows)` |
| `git check-ignore -v .env.maestro.example .env.maestro` | example negated (tracked); real env ignored by `**/.env.*` |
| `node -e` reproducing `new Date('01/04/2026')` / `new Date('31/12/2026')` | `2026-01-03` / `THROWS RangeError` |
| `npx jest` on all touched backend suites (`--runInBand`) | `10 suites / 235 tests passed` |
| Broader backend sweep (11 suites) | `Test Suites: 11 passed · Tests: 293 passed · BACKEND_SWEEP_EXIT=0` |
| Targeted gate suites (`adminSurface`, `financialAdminGates`, related) | `3 suites / 82 tests passed` |
| `flutter test` (full suite, proxy vars cleared) | `804/804 All tests passed! · FLUTTER_TEST_EXIT=0` |
| Route + voice-guard suites | `65/65 All tests passed!` |
| `flutter analyze` | `No issues found!` |
| `node scripts/check-org-guard.js` | `Org-tenancy guard passed.` |
| `fastlane android verify_version_code` (live Play) | `Found '158' version codes in track 'production'`, `'227' in 'internal'`; `versionCode 228 > highest published 227 (internal)`; `finished successfully` |
| `fastlane android verify_store_metadata` | Before fix: `Found 16` (macOS case-insensitive glob double-count of 8 files). After fix: `Play listing metadata and 8 screenshots validated.`, `FASTLANE_EXIT=0` |
| Screenshot dimension check (all 8) | `1080x1920` each |
| `maestro hierarchy` selector verification | Merged labels confirmed, e.g. `Employee\nView employee insights, work status & shifts`, `5 ACTIONS\nINVOICE OPERATIONS`, `13 ACTIONS\nCONFIGURATION & FINANCE`; exact-string `assertVisible: "Employee"` fails while `.*Employee.*` passes (exact vs regex semantics) |
| `node scripts/reset_all_redis_limits.js` / `unblock-auth-ip.js --all` / `force_reset_limit.js` ×3 | exit 0 each; 0 dev-scoped keys / 0 blocked IPs (15-min window already elapsed) |
| Firebase App Check `debugTokens` API (read + create) | configured dev secret registered for `com.bishal.invoice.dev` (value never printed); cold start: `✅ App Check token obtained successfully` |
| `flutter build apk --debug --flavor development` + install | `REBUILD_EXIT=0`, installed on `emulator-5554` |
| Redaction-safe secret scan over 22 app + 50 backend commit candidates | only false positives (test-fixture emails like `c@x.com`, assignment statements); `.env.maestro` confirmed ignored; test Mongo URI = `mongodb://test` placeholder (no userinfo) |
| `./scripts/run_maestro.sh` (all four flows, one run) | `4/4 Flows Passed in 5m 29s`, `MAESTRO_FULL_EXIT=0` |

---

## 6. MAESTRO RELEASE SUITE — EMULATOR RUN (this audit)

Device: `emulator-5554` (Medium_Phone_API_36.1), development flavor built from the current working tree (`com.bishal.invoice.dev`), dev backend.

Root causes of the three original failures, all confirmed from the live accessibility tree (never assumed):

| Flow | Symptom | Root cause | Fix |
|---|---|---|---|
| `02_admin_owner_switch` | `No visible element found: "Employee"` while the card was visibly on screen | Flutter tiles expose **merged** accessibility labels (`Employee\nView employee insights…`); Maestro plain strings are EXACT matches | Anchored regex `.*Employee.*View employee insights.*`; back-switch uses `.*Admin Dashboard.*Manage organization.*`; negative assertions converted to regexes |
| `03_standard_invoicing` | `.*Employee Invoice.*…` not visible after tapping `Invoice Operations` | The Command Desk's first category **starts expanded** (`_expanded = {0}`); tapping its header **collapses** it — the flow toggled the category off | Never tap the category header; assert/tap the action tiles directly with repositioning (`visibilityPercentage: 30`) |
| `04_sil_and_ndis_claiming` | `SIL Management` / `NDIS Claiming` not visible after tapping `Configuration & Finance` | Tapping the header expands the category, but the actions render **below the fold**; the flow asserted without scrolling | `scrollUntilVisible` per action after expansion |

Additional E2E finding: a tile resting against the top viewport edge swallows `tapOn` (observed with `Invoice List` at 100% visibility) — fixed by scrolling to ~30% visibility before tapping.

Final results (true exit codes, no pipeline masking):

```
MAESTRO_02_EXIT=0   (02 - Admin -> Owner Tools -> Employee -> back to Admin)
MAESTRO_03_EXIT=0   (03 - Standard Invoice Operations (Client + Employee, SIL excluded))
MAESTRO_04_EXIT=0   (04 - Configuration & Finance / SIL Management / NDIS Claiming)

Full suite (all four flows, one run):
[Passed] 01 - Auth & RBAC (Admin / Employee / Client dashboards) (1m 53s)
[Passed] 02 - Admin -> Owner Tools -> Employee -> back to Admin (1m 9s)
[Passed] 03 - Standard Invoice Operations (Client + Employee, SIL excluded) (1m 12s)
[Passed] 04 - Configuration & Finance / SIL Management / NDIS Claiming (1m 15s)
4/4 Flows Passed in 5m 29s
MAESTRO_FULL_EXIT=0
```

Scope note: flows 03/04 verify surface separation, reachability and screen loads (employee invoice form, invoice list with Client/Employee tabs, SIL properties/quotes/rosters, NDIS "Pick period & generate" + batches). Invoice/claim **generation** is deliberately not driven from E2E because it mutates shared dev data and depends on seeded billable periods; that logic is covered by the deterministic backend suites (P0-2, P0-4, P1-4 evidence above).
