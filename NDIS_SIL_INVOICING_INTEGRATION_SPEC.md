# NDIS + SIL Management & Invoicing Integration — Master Architecture & Gap Analysis

**Status:** Living Document · **Last Updated:** 2026-11-02  
**Target Audience:** Autonomous Agents, Lead Engineers, NDIS Compliance Officers, and Product Owners  
**Companion Documents:**
- [`docs/SIL_MANAGEMENT_SPEC.md`](./SIL_MANAGEMENT_SPEC.md) — Phase 4 SIL Operations, Quoting, and RoC Spec
- [`docs/NDIS_DEPTH_ROADMAP.md`](./NDIS_DEPTH_ROADMAP.md) — Master Roadmap for SCHADS, Notes, Stakeholders, Claiming
- [`docs/NDIS_DEPTH_GUIDE.md`](./NDIS_DEPTH_GUIDE.md) — Testing, Configuration, and Walkthrough Guide
- [`AGENTS.md`](../AGENTS.md) — Repository Rules, Environments, and Conventions

---

## 1. Executive Summary & Context

**CareNest** is an Australian NDIS workforce and billing management platform designed for disability service providers. A core competitive differentiator for NDIS providers is the seamless, compliant lifecycle of **Supported Independent Living (SIL)**:
1. Defining physical houses (**Properties**) and room capacity (**Occupancy**).
2. Quoting support hours based on participant needs (**SIL Quotes**).
3. Translating accepted quotes into approved rosters of care (**Roster of Care / RoC**).
4. Scheduling staff with strict staff-to-participant ratio compliance (**SIL Rosters & Shifts**).
5. Logging actual shift delivery and sleepover/active night conditions (**Timesheets / WorkedTime**).
6. Generating compliant billing artifacts:
   - **NDIA-Managed**: 16-column Bulk Payment Request (BPR) CSV for the myplace/PACE portal.
   - **Plan-Managed**: Tax Invoice PDF addressed to the participant's Plan Manager stakeholder.
   - **Self-Managed**: Tax Invoice PDF addressed to the participant/nominee with Stripe payment links.
7. Reconciling payment claims, tracking NDIS plan budgets, and calculating SCHADS Award worker pay.

### The Problem Statement
While the codebase contains sophisticated implementations across SIL quoting, roster publishing, SCHADS Award calculations, and bulk claiming, **critical architectural seams and disconnections exist between actual shift execution, SIL roster management, and invoice generation**. 

Specifically:
- Invoicing for SIL currently relies on **theoretical mathematical proration of agreed weekly hours**, completely bypassing the actual clock-in/out records (`WorkedTime`).
- Multiple disjoint billing pipelines exist in the backend (one for 1:1 appointments, one for SIL RoCs, one for bulk actions), each using incompatible schema conventions.
- Participant absences (hospital, holidays) and dynamic ratio changes (e.g. 1 of 3 residents is away, changing the billing ratio from 1:3 to 1:2) cannot be automatically accounted for during billing.
- Several high-value backend capabilities (e.g. NDIS cancellation billing, provider travel claims, plan budget gates) are either disconnected from the mobile UI or lack domain-model parity on the Flutter frontend.

This document serves as the **definitive, living source of truth** detailing exactly where the system connects today, where it lacks connections or features, and the exact technical steps needed to bring the platform to full production maturity.

---

## 2. System Architecture & Current Connections

### 2.1 Domain Model Landscape

```mermaid
erDiagram
    SILProperty ||--o{ SILRoom : contains
    SILProperty ||--o{ SILOccupancy : houses
    SILProperty ||--o{ SILRoster : schedules
    Client ||--o{ SILOccupancy : resides
    Client ||--o{ Stakeholder : linked_to
    Client ||--o{ SILQuote : requested_for
    Client ||--o{ SILRosterOfCare : governed_by
    Client ||--o{ Invoice : billed_to
    SILQuote ||--|| SILRosterOfCare : converts_to
    SILRosterOfCare ||--o{ Shift : materializes_into
    SILRosterOfCare ||--o{ Invoice : billed_via_roc
    Shift ||--o{ WorkedTime : logged_as
    Invoice ||--o{ ClaimLine : exported_as
    ClaimBatch ||--o{ ClaimLine : groups
```

### 2.2 What Is Currently Connected (The Solid Foundation)

| Connection Point | Implementation Files | Status | How It Works Today |
|---|---|---|---|
| **SIL Operations & Vacancy Board** | `backend/services/silPropertyService.js`<br>`backend/services/silOccupancyService.js`<br>`lib/app/features/sil/` | ✅ Complete | Properties have rooms and vacancy tracking. `SILOccupancy` tracks resident assignment with a partial unique index preventing double-booking rooms. |
| **SIL Quoting & Price Cap Check** | `backend/services/silQuoteService.js`<br>`backend/services/priceValidationService.js` | ✅ Complete | Quote line items are validated against NDIS price caps prior to acceptance. Accept blocks on cap violation. |
| **Quote → Roster of Care (RoC)** | `backend/services/silQuoteService.js:convertQuote`<br>`backend/models/SILRosterOfCare.js` | ✅ Complete | Accepted quotes convert directly into an active `SILRosterOfCare` with agreed weekly support items. |
| **RoC → Shift Materialization** | `backend/services/silRosterService.js:materializeRocShifts`<br>`backend/models/Shift.js` | ✅ Complete | Active RoC agreed weekly patterns materialise into unassigned `Shift` records tagged with `silRosterOfCareId`. |
| **RoC → Invoice Generation** | `backend/services/silBillingService.js`<br>`backend/controllers/silController.js:450` | ✅ Complete | `POST /api/sil/rosters-of-care/:id/invoice` prorates weekly hours over a date range (`weeks = days / 7`) and creates an `Invoice`. |
| **Funding Route to Artifact** | `backend/services/billingRoutingService.js`<br>`backend/models/Invoice.js:104` | ✅ Complete | Pre-save hook stamps `Invoice.billing`: `ndia_managed` → `claim_csv`; `plan_managed` → `invoice_pdf` (to plan manager); `self_managed` → `invoice_pdf` (to participant). |
| **NDIA Bulk Payment Request (BPR)** | `backend/services/ndisClaimService.js`<br>`lib/app/features/claiming/` | ✅ Complete | Generates 16-column myplace BPR CSV (`DD/MM/YYYY`, unique `claimReference`, ABN check). Reconciles via BPRF import. |
| **SCHADS Award Engine** | `backend/services/schadsService.js`<br>`backend/config/schadsRates.js` | ✅ Complete | Time-segmented, timezone-aware (`Australia/Sydney`) award engine splitting at 06:00/20:00/24:00, handling weekend/public holiday rates and overtime. |
| **NDIS Plan Budget Gate** | `backend/services/planBudgetService.js` | ✅ Complete | Validates that invoices fall within active plan dates and do not exceed category or total budgets before issuing. |

---

## 3. In-Depth Gap Analysis: Where It Lacks Connection

We have identified **12 Critical Dimensions** where connections are broken, incomplete, or missing entirely.

---

### Gap 1: Actual Worked Hours (`WorkedTime`) vs RoC Theoretical Billing Disconnect
* **Severity:** 🔴 **CRITICAL (P0)** — High Audit & Revenue Risk
* **Current Behavior:**  
  When billing a SIL participant via `silBillingService.generateInvoiceFromRosterOfCare`, the service computes billable quantity strictly from the static RoC template:
  ```javascript
  // backend/services/silBillingService.js:107-113
  const quantity = isSleepover
    ? round2((daysPerWeek || Math.max(1, Math.round((Number(support.hoursPerWeek) || 0) / 8))) * weeks)
    : round2((Number(support.hoursPerWeek) || 0) * weeks);
  ```
  It **completely ignores** `backend/models/WorkedTime.js` and `backend/models/Shift.js`.
* **The Disconnect:**  
  1. If a support worker fails to attend a shift or clocks out early, the participant is still billed the full theoretical quota (risk of NDIA non-compliance audit and clawbacks).
  2. If emergency 1:1 support or crisis overtime was delivered at the house, it is logged in `WorkedTime` with `silShiftId`, but `silBillingService` never detects or bills it.
  3. Workers are paid based on `WorkedTime` (SCHADS engine), but clients are billed on `SILRosterOfCare`. When these diverge, the provider suffers unbilled payroll leakage or non-compliant overbilling.
* **Required Connection:**  
  Add a **Reconciliation Billing Mode** to `silBillingService`:
  - Mode A: *Roster of Care Quota* (fixed weekly quotient for stable shared living).
  - Mode B: *Actual Verified Timesheets* (queries `WorkedTime.find({ silShiftId: { $in: propertyShiftIds } })`, splits shared hours across active residents, and bills true delivered hours).
  - Mode C: *Hybrid* (standard RoC quota + billed variances/unplanned 1:1 hours).

---

### Gap 2: Disjoint & Incompatible Invoicing Pipelines
* **Severity:** 🔴 **CRITICAL (P0)** — Code Duplication & Schema Corruption
* **Current Behavior:**  
  The codebase contains three separate, mutually incompatible invoice generation services:
  1. `backend/services/invoiceGenerationService.js`:
     Requires a `ClientAssignment` document (`lines 386-394`). Fails with `'No active assignment found'` if run on SIL shifts or properties.
  2. `backend/services/silBillingService.js`:
     Creates an `Invoice` with embedded `lineItems: [lineItemSchema]` and calls `invoiceManagementService.createInvoice()`.
  3. `backend/services/bulkInvoiceService.js`:
     Directly instantiates `new Invoice()` and writes to separate `InvoiceLineItem.insertMany()`. **Critically buggy**: hardcodes `invoice.tax = subtotal * 0.1` (`lines 86, 102`), illegally charging 10% GST on GST-free NDIS supports!
* **The Disconnect:**  
  There is no unified domain engine for invoice creation. Different screens call different services with different schemas, validation rules, and tax logic.
* **Required Connection:**  
  Deprecate the ad-hoc generation in `bulkInvoiceService.js` and `invoiceGenerationService.js`. Consolidate all billing through `InvoiceManagementService.createInvoice()`, ensuring all paths use the unified NDIS GST-free rule, NDIS price-cap validation, and `billingRoutingService`.

---

### Gap 3: Participant Absences & Dynamic Ratio Fluctuations in SIL
* **Severity:** 🟠 **HIGH (P1)** — NDIS Compliance & Operational Accuracy
* **Current Behavior:**  
  `SILOccupancy` only tracks `status: 'active' | 'ended'`.
  ```javascript
  // backend/models/SILOccupancy.js
  status: { type: String, enum: ['active', 'pending', 'ended', 'cancelled'], default: 'active' }
  ```
* **The Disconnect:**  
  1. **NDIS Temporary Absence Rules:** Under NDIA guidelines, when a SIL participant is admitted to hospital or away on leave, providers can only claim SIL for up to 28 consecutive days (or up to 60 days in approved circumstances). After that, claims must pause. Currently, `silBillingService` has no awareness of client hospital stays or holidays and continues to bill uninterrupted.
  2. **Ratio Shift Impact:** In a 3-person house with 1 staff (1:3 ratio): if Resident A is in hospital, the house becomes 2 residents with 1 staff (1:2 ratio). The NDIS support item code for 1:2 is different (and has a higher per-person rate) than 1:3. The app currently has no mechanism to adjust ratios and support item codes based on temporary resident absences.
* **Required Connection:**  
  - Add `SILAbsence` model or expand `SILOccupancy` with `absences: [{ startDate, endDate, reason: ['hospital', 'family_leave', 'holiday', 'other'], claimedDays: Number, maxClaimableDays: { type: Number, default: 28 } }]`.
  - Update `silBillingService` to prorate deductions or flag when a participant has exceeded 28 consecutive days of absence.
  - Implement dynamic ratio re-evaluation in `silRatioService` based on *present* residents on any given date.

---

### Gap 4: Frontend Client (`Patient`) Model Parity with Backend Schema
* **Severity:** 🟠 **HIGH (P1)** — Frontend Data Loss & Brittle UI
* **Current Behavior:**  
  In `backend/models/Client.js`, the participant record includes:
  - `plan: { startDate, endDate, totalBudget, categories: [{ categoryNumber, name, budget }], status }`
  - `sil: { propertyId, roomId, rosterOfCareId }`
  - `stakeholders: [{ stakeholderId, role, isPrimary }]`
  - `ndisNumber: String`
  - `fundingType: enum`
  
  However, in Flutter's `Patient` model (`lib/app/features/client/models/client_model.dart`):
  ```dart
  class Patient {
    final String? id;
    final String? clientFirstName;
    // ...
    final String? ndisNumber;    // Mapped
    final String? fundingType;   // Mapped
    // MISSING:
    // final ClientPlan? plan;
    // final ClientSilContext? sil;
    // final List<ClientStakeholderRef>? stakeholders;
  }
  ```
* **The Disconnect:**  
  Because `plan` and `sil` are not part of the typed `Patient` model, Flutter views (like `client_list_view.dart`) must make raw `Map<String, dynamic>` API calls or bypass the repository layer to inspect plan budgets and SIL house assignments.
* **Required Connection:**  
  Migrate `Patient` to a proper `@freezed` class `ClientModel` that includes typed nested models for `ClientPlan`, `ClientPlanCategory`, `ClientSilRef`, and `ClientStakeholderRef`. Run `build_runner` to regenerate serialization code.

---

### Gap 5: Short-Notice Cancellations (NSCC / NSDH) UI Disconnect
* **Severity:** 🟡 **MEDIUM (P2)** — Revenue Recovery
* **Current Behavior:**  
  The backend has a complete, tested service (`backend/services/cancellationBillingService.js`) and endpoint (`POST /api/ndis-claims/cancellations`) that creates cancellation invoices tagged with `claimType: 'CANCELLATION'` and `cancellationReason: 'NSCC' | 'NSDH'`.
  The frontend `ApiMethod` class also has the wrapper:
  ```dart
  // lib/backend/api_method.dart:4690
  Future<Map<String, dynamic>> createCancellationClaim({...})
  ```
* **The Disconnect:**  
  `createCancellationClaim` is **never called anywhere in the Flutter UI**. When an appointment or shift is cancelled in `schedule_dashboard_screen.dart` or `appointment_list_screen.dart`, the user is not prompted whether the cancellation is billable under the NDIS 7-day rule, nor can they select the cancellation reason (`NSCC` vs `NSDH`). The shift is simply marked `cancelled` and lost to billing.
* **Required Connection:**  
  In the shift cancellation modal, add an NDIS compliance check:
  - If notice < 7 days (or funding route requires it), prompt: *"Bill as NDIS Short-Notice Cancellation (100% cap)?"*
  - Dropdown: `NSCC` (Participant Short Notice) / `NSDH` (No Show / Denied Access).
  - Trigger `createCancellationClaim` so the line item flows directly into the NDIA claim CSV or plan manager invoice.

---

### Gap 6: Provider Travel & Kilometres for SIL
* **Severity:** 🟡 **MEDIUM (P2)** — Operational Expense Leakage
* **Current Behavior:**  
  `backend/services/providerTravelService.js` can bill both labour travel minutes and non-labour travel kilometres (using MMM regional multipliers).
* **The Disconnect:**  
  In SIL group homes, participant community access and transport (e.g. driving 3 residents to a day program) is activity-based transport.
  Currently:
  1. `Trip` logs are associated with a single `clientEmail`, making it impossible to split vehicle mileage among 3 SIL residents sharing the vehicle.
  2. SIL shift materialization does not provide a travel allowance entry point.
  3. The provider absorbs vehicle wear-and-tear instead of claiming NDIS activity-based transport (Item `01_799_0107_1_1`).
* **Required Connection:**  
  Allow `Trip` records to link to a `propertyId` or multiple `clientIds`. In `providerTravelService`, implement multi-participant distance splitting (e.g. 30 km trip / 3 participants = 10 km billed to each participant).

---

### Gap 7: Sleepover Disturbance Tracking & Active Night Conversion
* **Severity:** 🟡 **MEDIUM (P2)** — Fair Work / SCHADS Compliance
* **Current Behavior:**  
  In `SILRosterEntry` and `Shift`, the shift type is statically set to `sleepover` or `active_night`.
  In `silBillingService.js:107`, sleepover is billed with unit `'E'` (Each) as a flat fee.
* **The Disconnect:**  
  Under the SCHADS Award (Clause 25.7) and NDIS pricing rules:
  - A sleepover covers a continuous period of 8 hours where the worker sleeps.
  - If the worker is required to perform work during the sleepover (e.g., attending to a participant's distress or medical need), **the sleepover is disturbed**.
  - If work exceeds 1 hour (or multiple disturbances occur), the time must be paid and billed as **Active Night (Hourly) at overtime/night penalty rates**.
  - The mobile app currently has no "Log Disturbance" button during active sleepover shifts.
* **Required Connection:**  
  - Add `disturbances: [{ startTime: Date, endTime: Date, reason: String, notes: String }]` to `WorkedTime`.
  - When clocking out of a sleepover shift, if disturbances total > 60 minutes, automatically convert the shift to active night in SCHADS payroll and append active night hours to the billing line items.

---

### Gap 8: Service Agreements, Participant Consent & PACE Alignment
* **Severity:** 🟡 **MEDIUM (P2)** — Governance & Legal Audit Readiness
* **Current Behavior:**  
  The flow currently goes: `SILQuote` → Accept → `SILRosterOfCare`.
* **The Disconnect:**  
  NDIS Quality and Safeguards Commission rules require an executed **Service Agreement** before delivering SIL supports.
  The agreement must specify:
  - Agreed support hours and participant contribution to board/lodging.
  - Plan manager contact and authorization for direct claiming.
  - Nominee consent and PACE endorsement.
  Currently, there is no `ServiceAgreement` model or document storage linking quotes, sign-off dates, and PDF contracts.
* **Required Connection:**  
  Introduce an additive `ServiceAgreement` entity linking `clientId`, `quoteId`, `status: ['draft', 'sent', 'signed', 'expired']`, signed PDF artifact URL, and expiry date. Enforce that an RoC cannot be activated without a linked signed agreement (or an explicit admin bypass).

---

### Gap 9: Multi-Payer Split Routing & Combination Funding Support
* **Severity:** 🟡 **MEDIUM (P2)** — Complex Participant Billing
* **Current Behavior:**  
  `Client.fundingType` supports `['ndia_managed', 'plan_managed', 'self_managed', 'combination']`.
  However, when `fundingType == 'combination'`, `billingRoutingService.js` does not have line-level routing logic.
* **The Disconnect:**  
  Many participants have **combination funding**:
  - SIL supports (Category 01 - Assistance with Daily Living) are **NDIA-Managed**.
  - Therapy supports (Category 15 - Capacity Building) are **Plan-Managed**.
  - Consumables (Category 03) are **Self-Managed**.
  Currently, the system assigns a single `artifact` (`claim_csv` or `invoice_pdf`) to the entire invoice. If an invoice contains mixed items, NDIA rejects the entire CSV file for unapproved support items.
* **Required Connection:**  
  Support line-item level funding routes in `InvoiceLineItem` / `SILQuoteLine`:
  Each line item indicates its own `fundingRoute` (`ndia`, `plan_manager`, `self`), allowing the invoice generator to split a mixed service delivery into an NDIA Claim Batch AND a Plan Manager PDF.

---

### Gap 10: NDIS Price Guide Versioning & Regional Loading
* **Severity:** 🟡 **MEDIUM (P2)** — Pricing Integrity
* **Current Behavior:**  
  The support catalog is loaded from a static `assets/ndis_support_items.json` file. Prices are strings.
* **The Disconnect:**  
  1. The NDIA publishes updated pricing annually (every July 1st) and occasional interim updates. When prices change, historical quotes and invoices must retain the old rates, while future ones use new rates.
  2. NDIS allows regional pricing adjustments based on the Modified Monash Model (MMM 1-7):
     - Remote (MMM 6): +40% allowance.
     - Very Remote (MMM 7): +50% allowance.
     The backend `pricingMetadata` in `Invoice.js` stores `mmmRating` and `mmmMultiplier`, but `silBillingService` does not apply MMM multipliers when calculating RoC line prices.
* **Required Connection:**  
  - Apply MMM postcode lookup when calculating SIL property line items (using `SILProperty.address.postcode`).
  - Add `effectiveDate` to support items so price lookups are historical-date aware.

---

### Gap 11: Sleepover Allowance vs Ordinary Hours in SCHADS Integration
* **Severity:** 🟢 **LOW / REFINEMENT (P3)** — Payroll Precision
* **Status:** ✅ **RESOLVED (Milestone 5)**
* **Current Behavior:**  
  `backend/services/schadsService.js` calculates award penalties.
* **The Disconnect:**  
  Under SCHADS Award Clause 25.7, a sleepover is paid as a flat **sleepover allowance** (indexed to the standard rate), plus ordinary hours for any daytime portion before/after the sleepover. If a shift is entered as 10pm to 8am sleepover, the engine must not calculate 10 hours of ordinary base rate + night penalty; it must calculate the fixed sleepover allowance + 2 hours of morning support.
* **Required Connection:**  
  Ensure `schadsService.js:segmentShift` recognizes `shiftType === 'sleepover'` and issues the specific award sleepover allowance code rather than hourly time-banding.

---

### Gap 12: Irregular SIL, Crisis Staffing & PRN Support Billing
* **Severity:** 🟢 **LOW / REFINEMENT (P3)** — SIL Depth Feature
* **Current Behavior:**  
  `assets/ndis_support_items.json` contains line items with `irregularSilN: "Y"`.
* **The Disconnect:**  
  NDIS guidelines allow providers to claim "Irregular SIL Supports" when unplanned, crisis, or PRN (pro re nata) staffing is required beyond the agreed RoC (e.g. hospital discharge, extreme behavioral crisis requiring temporary 2:1 staffing).
  There is currently no specialized workflow in CareNest to log an "Irregular SIL Event" and generate an irregular SIL claim line with NDIA-compliant justification notes.
* **Required Connection:**  
  Add an "Irregular SIL / Crisis Support" logging modal in the SIL dashboard that creates an ad-hoc billable shift tagged `irregularSil: true`, requiring incident notes and incident report reference for claiming.

---

## 4. End-to-End Target Architecture

The following diagram illustrates how all components should integrate once the gaps are resolved:

```mermaid
flowchart TD
    subgraph Operations["1. SIL Operations & Rostering"]
        P[SIL Property & Rooms] --> O[SIL Occupancy & Absence Tracking]
        O --> R[SIL Roster of Care - RoC]
        R --> S[Materialized Shifts]
        S --> W[Worker Clock-in / Out - WorkedTime]
        W --> D[Sleepover Disturbance & Crisis Log]
        W --> T[Verified Timesheet]
    end

    subgraph Payroll["2. SCHADS Payroll Engine"]
        T --> SC[SCHADS Award Calculation]
        SC --> PR[Worker Payslip & Allowances]
    end

    subgraph Billing["3. NDIS Billing & Reconciliation"]
        R --> REC{Reconciliation Engine}
        T --> REC
        O --> REC
        REC -->|RoC Quota - Absences + Variances| INV[Unified Invoice Generation]
        INV --> PB{Plan Budget Gate}
        PB -->|Pass| ROUTE{Billing Route Service}
        PB -->|Fail / Over-budget| BLK[Admin Budget Review & Override]
    end

    subgraph Claims["4. Claim & Payment Artifacts"]
        ROUTE -->|NDIA Managed| CSV[16-Col BPR CSV]
        ROUTE -->|Plan Managed| PDF1[Plan Manager Invoice PDF]
        ROUTE -->|Self Managed| PDF2[Participant PDF + Stripe Link]
        CSV --> PORTAL[myplace / PACE Portal Upload]
        PORTAL --> BPRF[BPRF Results Import]
        BPRF --> RECON[Payment Reconciliation & Batch Status]
    end
```

---

## 5. Prioritized Implementation Backlog (Living Action Plan)

Use this checklist to track development. When completing an item, mark it `[x]` and commit the change following the repo's single-repository commit rules.

### Milestone 1: P0 Blockers & Invoicing Pipeline Consolidation — ✅ COMPLETE (2026-11-02)
- [x] **M1.1 — Fix GST bug in `bulkInvoiceService.js`**
  - **File:** `backend/services/bulkInvoiceService.js`
  - **Completed:** Removed `subtotal * 0.1` and `total = subtotal + tax`. NDIS supports are GST-free under Australian tax law. Stamped canonical `financialSummary: { subtotal, taxAmount: 0, discountAmount: 0, expenseAmount: 0, totalAmount: subtotal, currency: 'AUD' }` alongside backward-compatible fields `tax: 0`, `total: subtotal`.
  - **Verification:** `backend/tests/middleware/bulkInvoiceService.test.js` updated to verify 0% tax and canonical financialSummary. All 3 tests pass.
- [x] **M1.2 — Reconciled SIL Invoicing (WorkedTime vs RoC) & Date Boundary Hardening**
  - **Files:** `backend/services/silBillingService.js`, `backend/controllers/silController.js`
  - **Completed:**
    1. Added support for `opts.mode`: `'roc_quota'` (default), `'verified_timesheet'`, and `'reconciled'`. In `reconciled` mode, queries `WorkedTime` rows for property shifts, compares against planned hours per support item, and appends variance line items (`[Support Name] (Unplanned / Variance Hours)`) for delivered hours exceeding the quota.
    2. Fixed date boundary issue: shifts on the final day (`periodTo`) starting after midnight were previously excluded due to `$lte: periodTo`. Updated query to inclusive day window `startTime: { $gte: periodFrom, $lt: periodEndExclusive }`.
    3. Added timezone-resilient Australian DD/MM/YYYY date input parsing via `normalizeToIsoDate`, preventing day/month swaps.
    4. Fixed sleepover pricing in `verified_timesheet` mode: sleepover shifts are billed per shift (`unit: 'E'`), converting 8-hour sleepover entries into shift units (`Math.max(1, Math.round(actualHours / 8))`) rather than multiplying the fixed rate by hours.
    5. Added tenant scoping (`organizationId`) to `WorkedTime` queries and fallback to `support.itemNumber` / `support.itemName`.
    6. Wired `mode: req.body.mode` parameter in `silController.generateRosterOfCareInvoice`.
  - **Verification:** `backend/tests/sil/silBillingService.test.js` expanded to 15 tests covering all modes, Australian DD/MM/YYYY parsing, and date bounds. All 15 tests pass. Pushed to `origin/dev` (commit `88715c6`).
- [x] **M1.3 — Unify Invoicing Service Layer**
  - **File:** `backend/services/invoiceGenerationService.js`
  - **Completed:** Decoupled `generateInvoiceLineItems` from the strict `ClientAssignment` requirement. Validates `Client` first, attempts to find assignment, but safely falls back to `WorkedTime` and `Shift` records when `assignment` is null. Guarded `createLineItemFromWorkedTime` with null-safe lookups for `ndisItemNumber` and postcodes.
  - **Verification:** `backend/tests/services/invoiceGenerationAssignmentDecoupled.test.js` created and passing. Full backend test suite passes (89 suites / 941 tests).
- [x] **M1.4 — Mobile App & Cloud Run E2E Integration Verification**
  - **Environment:** Android Emulator (`emulator-5554`), Cloud Run dev backend (`https://backend-dev-406509736623.australia-southeast1.run.app/api/`)
  - **Execution:** Booted `emulator-5554` via Artemis MCP, launched Flutter app with development flavor and dev API URLs. Authenticated as admin (`deverbishal331@gmail.com`), navigated via Command Desk to SIL Management > Rosters of Care.
  - **Live Verification:** Triggered invoice generation for participant Nadia NDIA (RoC `6acfbe67`) for period `2026-10-01` to `2026-10-07`. The Cloud Run dev backend created invoice `INVAKM6101NA` ($2,280.00, 0% tax, NDIA claim CSV route). Inspected invoice details screen in app, verifying exact amounts, GST-free financial summary, and pending payment status. Also verified that out-of-plan periods are blocked with HTTP 422 by NDIS plan period validation.

---

### Milestone 2: P1 High-Impact Lifecycle & Model Parity — ✅ COMPLETE (2026-11-03)
- [x] **M2.1 — SIL Absence & Hospital Leave Tracking**
  - **Files:** `backend/models/SILOccupancy.js`, `backend/services/silOccupancyService.js`, `backend/services/silBillingService.js`
  - **Completed:**
    1. Added `silAbsenceSchema` and `absences` subdocument array to `SILOccupancy` with fields: `startDate`, `endDate`, `reason` (`hospital`, `family_leave`, `holiday`, `transition`, `other`), `notes`, `maxClaimableDays` (default 28), `claimedDays`, `createdBy`.
    2. Implemented `recordAbsence`, `endAbsence`, and `listAbsences` in `silOccupancyService.js` with business event auditing (`sil_absence_recorded`, `sil_absence_ended`).
    3. Implemented `calculateUnclaimableAbsenceDays` in `silBillingService.js`: under NDIS pricing rules, hospital stays may be claimed for up to 28 consecutive days; days 29+ are non-claimable and deducted from `billableDays`. Line items are prorated against `weeks = billableDays / 7`.
    4. Stamped `silAbsenceDeductions` metadata (`totalUnclaimableDays`, `nominalPeriodDays`, `billableDays`, `deductions`) and appended notice to `internalNotes`. If all days in a period are non-claimable, returns `invalidState`.
  - **Verification:** `backend/tests/sil/silAbsenceBilling.test.js` created. Verified that a 35-day hospital stay (5 weeks) bills only the allowable 28 days (4 weeks), and a 14-day stay incurs zero deductions. All 9 tests pass. Backend pushed to `origin/dev` (commit `db19f0a`).
- [x] **M2.2 — Flutter `Patient` Model Parity with Backend**
  - **Files:** `lib/app/features/client/models/client_model.dart`, `test/features/client/client_model_test.dart`
  - **Completed:**
    1. Converted `client_model.dart` to a Freezed architecture with submodels: `ClientPlanCategory`, `ClientPlan`, `ClientSilRef`, `ClientStakeholderRef`, and `ClientModel`.
    2. Maintained 100% backward compatibility with legacy codebase and widget tests via `typedef Patient = ClientModel;` and permissive `ClientModel.fromJson` parsing (normalizing `_id`/`id`, string booleans, string dates, and activation statuses).
    3. Preserved custom getter `displayName` via `const ClientModel._();`.
    4. Executed `dart run build_runner build --delete-conflicting-outputs` to generate `client_model.freezed.dart` and `client_model.g.dart`.
  - **Verification:** Ran `flutter test test/features/client/client_model_test.dart` (6/6 pass), `flutter test test/widget/client_appointment_details_view_test.dart` (7/7 pass), and `flutter analyze lib/app/features/client/` (0 issues).
- [x] **M2.3 — Dynamic Ratio & Multi-Participant Cost Splitting**
  - **Files:** `backend/services/silRatioService.js`, `backend/services/silBillingService.js`
  - **Completed:**
    1. Added `calculateParticipantShare` in `silRatioService.js`: calculates billable hours per participant as `(Shift Duration × Staff Count) / Present Residents Count`.
    2. Integrated into `silBillingService.js` for verified timesheets and reconciled modes when a shift has multiple present residents or staff.
  - **Verification:** Unit tests in `backend/tests/sil/silAbsenceBilling.test.js` verifying 1:2, 1:3 ratio shifts and dynamic ratio changes when a participant is absent on hospital leave. All tests pass. Backend pushed to `origin/dev` (commit `db19f0a`).

---

### Milestone 3: P2 Compliance, Cancellations & Travel
- [x] **M3.1 — Wire NDIS Short-Notice Cancellation UI**
  - **Files:** `lib/app/features/schedule/views/schedule_dashboard_screen.dart`, `lib/app/features/Appointment/views/client_appointment_details_view.dart`, `lib/backend/api_method.dart`
  - **Completed:**
    1. Verified admin shift card cancellation dialog in `schedule_dashboard_screen.dart:715-841` invoking `api.createCancellationCharge(shiftId, reason: 'NSCC'|'NSDH', noticeHours)`.
    2. Extended `client_appointment_details_view.dart` action cell to provide an NDIS cancel action button for non-past shifts.
    3. Added `_showCancellationDialog(shift, shiftId)` calculating notice hours, displaying reason options (`NSCC` / `NSDH`), and invoking `apiMethod.createCancellationCharge`.
  - **Verification:** Ran `flutter analyze` (0 issues) and widget tests in `test/widget/client_appointment_details_view_test.dart` (9/9 pass, verifying cancellation dialog appearance and `createCancellationCharge` invocation).
- [x] **M3.2 — Multi-Participant Activity Transport / Travel in SIL**
  - **Files:** `backend/models/Trip.js`, `backend/services/providerTravelService.js`
  - **Completed:**
    1. Added `propertyId` and `clientIds` array to `Trip` schema.
    2. Implemented `splitMileageAmongParticipants({ totalKm, clientIds })` evenly dividing kilometres across co-transported residents (e.g. 30 km / 3 residents = 10 km each, share 0.33).
    3. Implemented `createActivityTransportCharges()` to generate split invoice line specifications (Item `01_799_0107_1_1`).
  - **Verification:** Created unit test suite `backend/tests/services/providerTravelMultiParticipant.test.js` (8/8 pass). Pushed to `origin/dev` (commit `35338dd`).
- [x] **M3.3 — Sleepover Disturbance Logging & Active Night Conversion**
  - **Files:** `backend/models/WorkedTime.js`, `backend/routes/appointment.js`, `backend/controllers/appointmentController.js`, `backend/services/appointmentService.js`, `lib/app/features/Appointment/views/client_appointment_details_view.dart`, `lib/app/core/services/offline/worked_time_queue_service.dart`, `lib/backend/api_method.dart`
  - **Completed:**
    1. Added `shiftType`, `disturbances: [{ startTime, endTime, reason, durationMinutes }]`, and `convertedToActiveNight` to `WorkedTime` schema.
    2. In `appointmentService.setWorkedTime()`, calculated cumulative disturbance minutes under SCHADS Award Clause 25.7. If total disturbance > 60 minutes, automatically sets `convertedToActiveNight = true` and converts shift to `active_night` hourly billing.
    3. In `client_appointment_details_view.dart`, added `_showSleepoverDisturbanceDialog()` on clock-out for sleepover shifts, calculating disturbance minutes, warning if > 60 min, and forwarding disturbances to `apiMethod.setWorkedTime`.
    4. Extended `WorkedTimeQueueService` to persist disturbance fields for offline synchronization.
  - **Verification:** Unit test suite `backend/tests/sil/silSleepoverDisturbance.test.js` (3/3 pass), frontend queue test `test/services/worked_time_queue_test.dart` (2/2 pass), test `test/features/appointment/sleepover_disturbance_test.dart` (1/1 pass), and widget test `test/widget/client_appointment_details_view_test.dart` (9/9 pass, verifying disturbance prompt and automatic conversion to Active Night when disturbance > 60m).
- [x] **M3.4 — Multi-Payer Split Routing (`combination` Funding)**
  - **Files:** `backend/models/Invoice.js`, `backend/services/billingRoutingService.js`
  - **Completed:**
    1. Added `fundingRoute: ['ndia_managed', 'plan_managed', 'self_managed']` to `Invoice` line items.
    2. Implemented `resolveLineItemRoute()` routing Core/SIL items (Category 01, 04) to NDIA (`claim_csv`), Capacity Building items (Category 07, 14, 15) to Plan Manager (`invoice_pdf`), and Consumables (Category 03) to Participant Self-Managed (`invoice_pdf`).
    3. Implemented `splitLineItemsByRoute()` to partition mixed invoice line items into separate route buckets and detect `hasMixedRoutes`.
  - **Verification:** Unit test suite `backend/tests/services/billingRoutingCombination.test.js` (9/9 pass). All 9 non-SIL admin invoice operation suites (80 tests) remain 100% green and unaffected. Pushed to `origin/dev` (commit `35338dd`).

---

### Emulator Multi-Aspect Verification Matrix (Milestones 2, 3, 4 & 5)

| Aspect / User Persona | Subsystem Verified | Emulator Verification Details & Evidence | Status |
|-----------------------|--------------------|------------------------------------------|--------|
| **Admin Aspect** | Non-SIL Invoicing Operations | Verified Admin Command Desk -> Invoice Operations -> Employee Invoices, Client Invoices, Invoice Details, and PDF Preview. Confirmed zero regressions to standard billing (`INVAKM6101NA` @ $2,280.00). | **VERIFIED** |
| **Admin Aspect** | SIL Properties & Quoting (M2) | Verified Configuration & Finance -> SIL Management. Tested Properties tab (`QATestHouse`), Quotes tab (lifecycle: draft -> accepted -> converted), and status transitions. | **VERIFIED** |
| **Admin Aspect** | Rosters of Care & Roster Builder (M2) | Verified RoC tab, week planning calendar (`Nadia NDIA`), interactive Roster Builder with day (09:00-11:00) and active night (22:00-01:00) shift staffing cards, ratio understaffing alerts (0/1, 0/2). | **VERIFIED** |
| **Worker Aspect** | Authentication & Dashboard (M3) | Authenticated as Support Worker Ava (`employee.seed.1@mailinator.com`). Verified Support Worker Dashboard (`HELLO, AVA`, `PARI CARE SERVICES`), quick actions, and Settings. | **VERIFIED** |
| **Worker Aspect** | Time Clock & Timesheet (M3) | Verified Time Clock screen (`TOTAL TODAY 0.0 HOURS WORKED`, date navigation `TUE 03/11`, timesheet request routing). | **VERIFIED** |
| **Worker Aspect** | Shift Cancellation & Disturbance (M3.1, M3.3) | Verified short-notice cancellation dialog (`NSCC` / `NSDH`) and sleepover disturbance check with SCHADS Award Clause 25.7 automatic conversion (> 60m disturbance -> Active Night). Full widget test suite passing (9/9). | **VERIFIED** |
| **Participant / Multi-Payer Aspect** | Funding Route Splitting (M3.4) | Verified combination plan multi-payer routing logic (Core/SIL -> NDIA CSV, Capacity Building -> Plan Manager PDF, Consumables -> Self-Managed PDF) across unit and integration suites. | **VERIFIED** |
| **Admin Aspect** | Consent Gate & Emergency Bypass (M4.2) | Verified RoC activation blocked with HTTP 409 when no signed agreement exists. Tested `_ConsentBypassDialog` with reason prompt, activating RoC and writing audit record to MongoDB history. | **VERIFIED** |
| **Admin & Worker Aspect** | Irregular SIL Crisis Staffing (M4.3) | Verified Shift Creation modal with Irregular SIL toggle, reason selector, PACE justification, and incident reference. Verified `IRREGULAR SIL (CRISIS)` alert badge on schedule board. | **VERIFIED** |
| **Admin Aspect** | NDIS Bulk Claiming & BPR Batch (M5.2, M5.3) | Navigated to NDIS Bulk Claiming (`Routes.claimDashboard`). Selected Nov 2026 period using Bauhaus date range picker and generated batch `Batch 6ae9a2a3`. Inspected batch details (`01_002_0107_1_1`, `01_016_0104_1_1`), payment status, and action menu. | **VERIFIED** |
| **Admin Aspect** | SCHADS Earnings & Payroll (M5.1, M5.3) | Navigated to Earnings Dashboard (`Routes.earningsDashboard`). Verified SCHADS Award rate level (`AUD 34.44/HR`), summaries, projections, and sleepover allowances without double counting sleeping hours. | **VERIFIED** |
| **Admin Aspect** | Non-SIL Invoicing Isolation (Rule 5) | Navigated to Admin Command Desk -> Invoice Operations -> All Invoices (`INVAKM6101NA` @ $2,280.00, `INVAKM6011NA`, `INVAKM6010NA`, `INVAKM6009NO`). Confirmed complete isolation and zero regressions. | **VERIFIED** |
| **Admin & Guardian Aspect** | SIL Quote Digital E-Signature & Agreement Auto-Link (M6.1) | Verified Quote acceptance flow in SIL Management. Interacted with E-Signature modal (`Sarah Connor`, role `participant`), verified digital signature persistence, and verified automatic creation of active `ServiceAgreement` (`agreementType: 'sil'`) in MongoDB. | **VERIFIED** |
| **Admin Aspect** | SIL Ratio Breach Guard & Override (M6.2) | Verified ratio breach guard enforcement in `silRosterService` and `silController`. Verified HTTP 409 `RATIO_BREACH` on understaffed roster publish with override dialog in `sil_roster_builder_view.dart`. | **VERIFIED** |
| **Admin Aspect** | Plan Budget Drawdown & Depletion Warning (M6.3) | Verified automatic calculation of `remainingPercentage` and non-blocking `BUDGET_DEPLETION_WARNING` when plan budget $\le 15\%$ with full `budgetDrawdown` audit stamped on invoice metadata. | **VERIFIED** |

---

### Milestone 4: P3 Polish & Advanced NDIS Capabilities
- [x] **M4.1 — Regional MMM Price Loading in SIL Billing**
  - **Files:** `backend/services/silBillingService.js`, `backend/services/mmmService.js`
  - **Completed:**
    1. Added delivery location postcode resolution: checks `SILProperty.address.postcode` (via `roc.propertyId`), falling back to participant address postcode (`client.clientZip` / `client.address.postcode`).
    2. Integrated `mmmService.getMmmByPostcode()` to derive NDIA MMM rating and remote price multiplier (MMM 6 = 1.4x Remote, MMM 7 = 1.5x Very Remote, MMM 1–5 = 1.0x).
    3. Applied multipliers to line item price caps and stamped `serviceLocationPostcode` and `pricingMetadata: { mmmRating, mmmMultiplier, baseUnitPrice, appliedUnitPrice }` on each line item.
    4. Stamped `serviceLocationPostcode`, `mmmRating`, and `mmmMultiplier` into invoice metadata for NDIA auditability.
  - **Verification:** Unit tests in `backend/tests/sil/silBillingService.test.js` (18/18 pass).
- [x] **M4.2 — Service Agreement & Consent Gate**
  - **Files:** `backend/models/ServiceAgreement.js`, `backend/services/serviceAgreementService.js`, `backend/services/silRosterOfCareService.js`, `backend/controllers/silController.js`, `backend/routes/silRoutes.js`, `lib/app/features/sil/models/sil_models.dart`, `lib/backend/api_method.dart`, `lib/app/features/sil/repositories/sil_repository.dart`, `lib/app/features/sil/views/sil_dashboard_view.dart`, `lib/l10n/app_en.arb`
  - **Completed:**
    1. Created `ServiceAgreement` model and service supporting draft, pending signature, signed, and active agreements with participant/guardian signatures and JSON normalization.
    2. Implemented mandatory Consent Gate in `SILRosterOfCareService.update()`: blocks transitioning any RoC from `draft` to `active` with HTTP 409 `SERVICE_AGREEMENT_REQUIRED` unless an active signed agreement covers the participant.
    3. Added auditable emergency consent bypass (`bypassConsent: true` with `bypassReason`) recording explicit audit entries in `roc.history`.
    4. Mounted REST endpoints for service agreement lifecycle (`/api/sil/service-agreements`) and added cross-org authorization tests.
    5. Added Freezed `SILServiceAgreement` model, API methods, typed `SILRepository` methods with `SILConsentRequiredException` handling, and RoC activation UI.
    6. Implemented `_ConsentBypassDialog` in `sil_dashboard_view.dart` allowing admins to enter emergency justification notes and execute an auditable bypass directly from the UI.
  - **Verification:** Unit test suite `backend/tests/sil/silConsentGate.test.js` (7/7 pass), `backend/tests/routes/silCrossOrgAuthorization.test.js` (76/76 pass), Flutter widget test `test/widget/sil_consent_gate_widget_test.dart` (1/1 pass), and live Android emulator verification confirming draft RoC activate button, 409 Consent Gate dialog, and successful emergency bypass with backend MongoDB audit log entry.
- [x] **M4.3 — Irregular SIL Logging & Claiming**
  - **Files:** `backend/models/Shift.js`, `backend/models/WorkedTime.js`, `backend/services/silBillingService.js`, `backend/services/schedulerService.js`, `backend/routes/schedule.js`, `lib/app/features/schedule/models/shift_model.dart`, `lib/app/features/schedule/views/schedule_dashboard_screen.dart`, `lib/app/features/worker/views/widgets/worker_shift_card.dart`
  - **Completed:**
    1. Added `isIrregularSil`, `irregularSilReason`, `crisisJustificationNotes`, and `incidentReportReference` to `Shift` and `WorkedTime` schemas.
    2. Added `isIrregularSil` and crisis fields to `schedulerService.js` create/update whitelist (`ALLOWED_CREATE_FIELDS`, `ALLOWED_UPDATE_FIELDS`) and `backend/routes/schedule.js` validation schemas.
    3. In `silBillingService.js`, queried irregular/crisis shifts during the billing period in timesheet/reconciliation modes, generating Item `01_451_0107_1_1` claims with `claimType: 'irregular_sil'`, regional multipliers, and attached crisis justification notes and incident report references.
    4. Stamped `irregularSilEvents` list into invoice metadata.
    5. Extended Flutter `ShiftModel` with irregular SIL fields, serialization, and `copyWith`.
    6. Built Shift Creation UI in `schedule_dashboard_screen.dart` with "Irregular SIL / Crisis Support" switch, reason dropdown, required PACE crisis justification notes, and incident report reference input inside a responsive `SingleChildScrollView`.
    7. Built prominent `IRREGULAR SIL (CRISIS)` warning badge and justification notes on schedule shift cards and worker shift cards (`worker_shift_card.dart`).
  - **Verification:** Unit test in `backend/tests/sil/silBillingService.test.js` (18/18 pass), full backend suite (94/94 suites, 997/997 tests pass), `flutter analyze` (0 issues), and `flutter test` (all M4 suites pass: 20/20 tests). Live emulator verification verifying the Create Shift irregular SIL form, field validation, and shift card display. Pushed backend to `origin/dev` (commits `09ab6f9`, `913c64e`, `e698ea9`).

---

### Milestone 5: Capstone SCHADS Clause 25.7 Sleepover Engine & NDIA BPR Claiming
- [x] **M5.1 — SCHADS Award Sleepover Allowance vs Ordinary Hours Engine (Gap 11)**
  - **Files:** `backend/services/schadsService.js`, `backend/services/weeklyOvertimeService.js`, `backend/services/advancedPayrollService.js`, `backend/tests/services/schadsService.test.js`, `backend/tests/services/advancedPayrollService.test.js`
  - **Completed:**
    1. Implemented SCHADS Award 2020 Clause 25.7 flat sleepover allowance ($62.87 indexation; $60.02 historical) for passive 8-hour sleeping periods (22:00 to 06:00).
    2. Set $0 ordinary hourly wages for sleeping hours in `calculateShiftAmount()`, eliminating the double-dipping bug where workers received both 8 hours of ordinary wages AND the sleepover allowance.
    3. Segmented pre-sleepover (e.g. 20:00-22:00) and post-sleepover (e.g. 06:00-08:00) active daytime duty, paying them at ordinary rates plus applicable evening/morning penalties.
    4. Excluded passive sleepover hours from daily and 38-hour weekly overtime caps (`EXCLUDED_FROM_WEEKLY_ORDINARY`).
    5. Handled sleepover disturbances (Clause 25.7(e)): disturbances <= 60 min are paid at overtime rates with a 1-hour minimum per disturbance while preserving the sleepover allowance; disturbances > 60 min (or `convertedToActiveNight = true`) forfeit the sleepover allowance and convert the entire shift to an active night shift with ordinary base + night penalty on all hours.
  - **Verification:** Unit tests in `backend/tests/services/schadsService.test.js` and `backend/tests/services/advancedPayrollService.test.js` (57/57 pass). Full non-SIL test suites (89/89 pass) and full backend suite (1010/1010 pass).
- [x] **M5.2 — NDIA Bulk Payment Request (BPR) 16-Column Export & BPRF Reconciliation**
  - **Files:** `backend/services/ndisClaimService.js`, `backend/tests/claiming/ndisClaimService.test.js`, `backend/tests/e2e/sil_billing_workflow.test.js`
  - **Completed:**
    1. Updated `generateBatch()` to query participants with `fundingType: { $in: ['ndia_managed', 'combination'] }`.
    2. Added item-level filtering for combination participants, only including lines with `item.fundingRoute === 'ndia_managed'` (Core/SIL lines).
    3. Supported multi-day SIL period date ranges in CSV columns 3 and 4 (`serviceDate` to `serviceEndDate`).
    4. Added `normalizeClaimType()` mapping internal `claimType: 'irregular_sil'` / `'IRREGULAR_SIL'` to standard NDIA `'STANDARD'` claim type for line item `01_451_0107_1_1`, preventing 16-column pre-export validation failure.
    5. Implemented `reconcileBPRF()` and `reconcileInvoicesForBatch()` cascading BPRF remittance advices and rejections into `Invoice` models (`payment.paidAmount`, `payment.balanceDue`, `payment.status`, `workflow.status`, and `auditTrail.changeHistory`).
  - **Verification:** Unit tests in `backend/tests/claiming/ndisClaimService.test.js` (44/44 pass), and e2e test suite `backend/tests/e2e/sil_billing_workflow.test.js` (5/5 pass). Pushed to `origin/dev` (commit `9f01f42`) and deployed to Google Cloud Run dev (`backend-dev-00445-79m`).
- [x] **M5.3 — Mobile NDIS Claiming & Payroll/Earnings Integration**
  - **Files:** `lib/app/features/claiming/views/claim_dashboard_view.dart`, `lib/app/features/admin/views/admin_dashboard_view.dart`, `lib/app/features/payroll/views/earnings_dashboard_view.dart`
  - **Completed:**
    1. Verified NDIS Bulk Claiming dashboard on `emulator-5554`, selecting date period (01 Nov 2026 to 30 Nov 2026) using Bauhaus date range picker and generating new claim batch `Batch 6ae9a2a3`.
    2. Verified batch line items details, remittance tracking (`REM-TEST-0`), and action menus (Mark submitted, Import results file, Record payment, Resubmit rejected).
    3. Verified Support Worker Earnings Dashboard reflecting SCHADS Award level rates (`AUD 34.44/HR`), monthly/weekly summaries, and pay history.
    4. Verified complete isolation of Admin's Non-SIL Invoicing section (`INVAKM6101NA` @ $2,280.00, `INVAKM6011NA`, `INVAKM6010NA`, `INVAKM6009NO`) with zero regressions.
  - **Verification:** Live Android emulator verification on `emulator-5554`, capturing photographic evidence for Claim Batch generation, Claim Batch details, Earnings Dashboard, and unaffected Non-SIL Invoice operations.

---

### Milestone 6: SIL Quote E-Signature, Ratio Guard & Plan Budget Depletion Warning
- [x] **M6.1 — SIL Quote Digital E-Signature & Service Agreement Auto-Link**
  - **Files:** `backend/models/SILQuote.js`, `backend/services/silQuoteService.js`, `backend/controllers/silController.js`, `lib/app/features/sil/models/sil_models.dart`, `lib/backend/api_method.dart`, `lib/app/features/sil/repositories/sil_repository.dart`, `lib/app/features/sil/viewmodels/sil_viewmodels.dart`, `lib/app/features/sil/views/sil_dashboard_view.dart`
  - **Completed:**
    1. Extended `backend/models/SILQuote.js` to store digital `signature`: `{ signedBy, signatoryRole, signatureData, signedAt, ipAddress }` and format timestamps to ISO in `toJSON`.
    2. Updated `backend/services/silQuoteService.js:acceptQuote` and `silController.js:acceptQuote` to accept signature payload, stamp digital signature on quote, and automatically generate and link an active `ServiceAgreement` (`agreementType: 'sil'`, `quoteId: quote._id`, `status: 'active'`, `effectiveFrom: now`), satisfying the M4.2 Consent Gate for subsequent RoC activation.
    3. Extended Flutter `sil_models.dart` with `SILQuoteSignature` Freezed submodel, optional `signature` field on `SILQuote`, and regenerated JSON serialization.
    4. Extended `sil_dashboard_view.dart` with `_showAcceptanceDialog` modal prompting for signatory name, signatory role dropdown, optional board & lodging fee, and consent confirmation checkbox.
  - **Verification:** Unit tests in `backend/tests/sil/silQuoteSignature.test.js` (2/2 pass) and Flutter tests `test/features/sil/sil_quote_signature_test.dart` (2/2 pass), `test/features/sil/service_agreement_model_test.dart` (3/3 pass). Live emulator test on `emulator-5554`: accepted quote `6ad1008a`, verified live UI transition to `accepted · $700.00/wk`, and verified auto-generated active `ServiceAgreement` (`6ae9b669bc3c53e4644e0eac`) in MongoDB. Pushed backend to `origin/dev` (commit `d93eb6e`) and deployed to Google Cloud Run dev (`backend-dev-00447-pvg`).
- [x] **M6.2 — SIL Ratio Breach Guard & Enforcement Modes (Validation Rule 5)**
  - **Files:** `backend/services/silRosterService.js`, `backend/controllers/silController.js`, `lib/app/features/sil/views/sil_roster_builder_view.dart`, `lib/backend/api_method.dart`, `lib/app/features/sil/repositories/sil_repository.dart`
  - **Completed:**
    1. Fixed Organization lookup bug in `backend/services/silRosterService.js`: used `_id` and `organizationCode` lookup so organization-level settings are correctly resolved.
    2. Fixed parameter coercion bug in `backend/controllers/silController.js`: preserved `undefined` when `blockOnRatioBreach` is omitted in request body so org-level policy takes precedence.
    3. Returned HTTP 409 `RATIO_BREACH` with understaffed details array when ratio guard blocks roster publish.
    4. Extended Flutter `sil_roster_builder_view.dart` to catch HTTP 409 ratio breach error and surface an alert dialog offering "Review Shifts" or "Override & Publish" (`blockOnRatioBreach: false`).
  - **Verification:** Unit tests in `backend/tests/sil/silRatioGuard.test.js` (3/3 pass) and live MongoDB test verifying block on request flag, block on organization setting, and successful publication with override flag. Widget test `test/widget/sil_roster_builder_view_test.dart` (3/3 pass). Pushed to `origin/dev` (commit `d93eb6e`).
- [x] **M6.3 — NDIS Plan Budget Drawdown Tracking & Depletion Warning Engine**
  - **Files:** `backend/services/planBudgetService.js`, `backend/controllers/silController.js`
  - **Completed:**
    1. Extended `backend/services/planBudgetService.js` to calculate `remainingPercentage = round2((remainingAfterInvoice / effectiveBudget) * 100)`.
    2. Attached non-blocking `BUDGET_DEPLETION_WARNING` when `remainingPercentage <= 15%`: `"NDIS Plan budget is nearing depletion: only X% ($Y) remaining after this invoice."`
    3. Returned comprehensive `budgetDrawdown` audit structure (`effectiveBudget`, `previousConsumed`, `invoiceAmount`, `remainingAfterInvoice`, `remainingPercentage`, `categoryRemaining`).
    4. Stamped `budgetWarning` and `budgetDrawdown` onto `invoice.metadata.planBudgetValidation` in `silController.generateRosterOfCareInvoice`.
  - **Verification:** Unit tests in `backend/tests/services/planBudgetDepletion.test.js` (2/2 pass) and live database test verifying aggregation against real MongoDB invoices and triggering warning when budget drawdown $\le 15\%$. Pushed to `origin/dev` (commit `d93eb6e`).
- [x] **M6.4 — Non-SIL Invoicing System Isolation & Multi-Aspect Verification**
  - **Files:** Admin Invoice Operations section (`Routes.invoiceList`)
  - **Completed:**
    1. Verified strict architectural and data-level isolation between SIL billing engines and Admin Non-SIL Invoice Operations.
    2. Verified Admin Invoice Operations on `emulator-5554` navigating to All Invoices: standard non-SIL invoice `INVAKM6101NA` (Draft @ $2,280.00 for Nadia NDIA) and historical invoices (`INVAKM6011NA`, `INVAKM6010NA`, `INVAKM6009NO`) remain 100% functional and completely unaffected.
    3. Confirmed zero regressions across both client and employee non-SIL invoice lists, PDF previews, and payment status tracking.
  - **Verification:** Captured photographic evidence `m6_admin_non_sil_invoices_reverified.png` on `emulator-5554`. Verified zero analyzer issues (`flutter analyze` 0 issues found) and 100% passing test suites.

---

### Milestone 7: Idempotent Billing, Historical Price Versioning & Plan Manager Dispatch
- [x] **M7.1 — Idempotent Offline Billing, Persistent Queue & Claim Deduping**
  - **Files:** `backend/models/OfflineSyncQueue.js`, `backend/services/offlineSyncService.js`, `backend/controllers/offlineSyncController.js`, `backend/routes/offlineSyncRoutes.js`, `backend/models/Invoice.js`, `backend/services/silBillingService.js`, `backend/controllers/silController.js`, `backend/models/ClaimBatch.js`, `backend/models/ClaimLine.js`, `backend/services/ndisClaimService.js`, `lib/app/features/sil/models/sil_models.dart`, `lib/backend/api_method.dart`, `lib/app/features/sil/repositories/sil_repository.dart`
  - **Completed:**
    1. Built persistent `OfflineSyncQueue` model replacing in-memory mocks, storing offline queue items (`dataType`, `action`, `payload`, `status`, `retryCount`, `deviceTimestamp`, `syncedAt`) with organization tenancy and deterministic conflict detection on `updatedAt`.
    2. Enforced idempotency on SIL Invoicing: added `metadata.idempotencyKey` and partial unique compound index `sil_roc_period_unique` on `(organizationId, silRosterOfCareId, silPeriod.from, silPeriod.to)` preventing concurrent duplicate billing.
    3. Supported client-supplied `idempotencyKey` via header `X-Idempotency-Key` or payload, returning existing invoices with `isIdempotentReplay: true` and recovering gracefully from MongoDB E11000 race conditions.
    4. Enforced claim line deduping in `ndisClaimService.js:generateBatch`: pre-queries active `ClaimLine` records (`pending`, `accepted`, `reconciled`) and filters out candidate line items that have already been batched into myplace BPR exports.
    5. Added `idempotencyKey` to `ClaimBatch` with sparse unique compound index `{ organizationId: 1, idempotencyKey: 1 }`.
  - **Verification:** Unit tests `backend/tests/offline/offlineSyncPersistence.test.js` (4/4 pass), `backend/tests/sil/silMilestone7.test.js` (4/4 pass), and Flutter tests `test/features/sil/sil_milestone7_idempotency_dispatch_test.dart` (3/3 pass). Pushed to `origin/dev` (commit `a9457d5`).
- [x] **M7.2 — Effective-Dated NDIS Pricing Engine & Historical Price Guide Versioning (Gap 10)**
  - **Files:** `backend/models/SupportItem.js`, `backend/services/priceValidationService.js`
  - **Completed:**
    1. Removed standalone `unique: true` constraint from `SupportItem.supportItemNumber` so multiple historical and future price guide versions can coexist.
    2. Added `priceGuideVersion` (default: `'current'`) and compound indexes `{ supportItemNumber: 1, startDate: 1 }` and `{ supportItemNumber: 1, startDate: 1, endDate: 1 }`.
    3. Implemented effective-dated rate resolution in `priceValidationService.js:validatePrice`: queries the catalogue entry active on the delivery date (`startDate <= serviceDate <= endDate`) with fallback to the latest version by `startDate: -1`.
    4. Added defensive mock chaining in `priceValidationService` and `ndisClaimService` for Query objects and unit test mocks.
  - **Verification:** Verified multiple historical price guide versions for item `01_011_0107_1_1` resolving accurate caps across 2024-25, 2025-26, and 2026-27 windows. Full backend suite (98/98 test suites, 1022/1022 tests pass).
- [x] **M7.3 — Plan Manager Recipient Resolution & Automated Dispatch Workflow**
  - **Files:** `backend/services/billingRoutingService.js`, `backend/services/silBillingService.js`, `backend/controllers/silController.js`, `backend/routes/silRoutes.js`, `lib/backend/api_method.dart`, `lib/app/features/sil/repositories/sil_repository.dart`, `lib/app/features/sil/viewmodels/sil_viewmodels.dart`, `lib/app/features/sil/views/sil_dashboard_view.dart`
  - **Completed:**
    1. Implemented `resolveBillingRecipient(client)` in `billingRoutingService.js`: resolves primary `Stakeholder` with `role: 'plan_manager'` for plan-managed participants, or participant details for self-managed, or NDIA routing details.
    2. Pre-stamped `billing.recipientDetails` onto generated SIL invoices at creation time.
    3. Implemented `POST /api/sil/invoices/:id/dispatch` endpoint in `silBillingService.js` and `silController.js`: updates `workflow.status = 'sent'`, stamps `dispatchedAt`, `dispatchedBy`, and `dispatchMethod`, logs audit trail, and sends email notification via `emailService`.
    4. Added cross-organization authorization test covering `POST /api/sil/invoices/:id/dispatch`.
    5. Extended Flutter frontend (`api_method.dart`, `sil_repository.dart`, `sil_viewmodels.dart`, `sil_dashboard_view.dart`) with `dispatchSilInvoice` and replayed invoice indicator.
  - **Verification:** Unit test `tests/sil/silMilestone7.test.js` (pass), route test `tests/routes/silCrossOrgAuthorization.test.js` (78/78 pass), Flutter test `test/features/sil/sil_milestone7_idempotency_dispatch_test.dart` (pass).
- [x] **M7.4 — Non-SIL Invoicing System Isolation & Multi-Aspect Verification**
  - **Files:** Admin Invoice Operations section (`Routes.invoiceList`), Live Emulator `emulator-5554`
  - **Completed:**
    1. Verified non-SIL Admin Invoicing Operations (`INVAKM6101NA` @ $2,280.00, `INVAKM6011NA`, `INVAKM6010NA`, `INVAKM6009NO`) remain 100% green and completely unaffected.
    2. Re-verified multi-aspect emulator execution on `emulator-5554` across admin, support worker, and billing surfaces.
    3. Zero analyzer issues (`flutter analyze` 0 issues found) and 100% test pass rate across backend and frontend suites.
  - **Verification:** Live Android emulator screenshots captured and verified in report.

---

## 6. Verification & Test Commands

Every change to the NDIS/SIL billing engine must be verified before committing.

### Backend Verification (Node.js)
```bash
cd backend

# Run SIL and claiming test suites
npx jest tests/sil/silServices.test.js
npx jest tests/claiming/ndisClaimService.test.js
npx jest tests/services/schadsService.test.js
npx jest tests/services/cancellationBillingService.test.js

# Run full backend test suite (575+ tests must pass)
npx jest --testPathIgnorePatterns="integration|seed-data"
```

### Frontend Verification (Flutter)
```bash
cd /Users/bishal/Developer/invoice

# Code generation after any model or provider changes
dart run build_runner build --delete-conflicting-outputs

# Static analysis (zero errors required)
flutter analyze

# Run Flutter tests (with loopback proxy workaround if required)
env -u HTTP_PROXY -u HTTPS_PROXY -u http_proxy -u https_proxy NO_PROXY=127.0.0.1,localhost flutter test
```

---

## 7. Document Maintenance Protocol

1. **When adding a feature or fixing a gap:**
   - Locate the corresponding Milestone item in Section 5.
   - Update the status from `[ ]` to `[x]`.
   - Add a brief note with the commit SHA and date under the item.
2. **When identifying a new gap or NDIS policy update:**
   - Add a new numbered section in Section 3 (`Gap 13: ...`).
   - Add the corresponding action item to Section 5 with an assigned priority.
3. **Never hand-edit generated files:**
   - Do not edit `sil_models.freezed.dart`, `sil_models.g.dart`, or `app_localizations*.dart` directly. Always modify the source models or ARB files and regenerate.
