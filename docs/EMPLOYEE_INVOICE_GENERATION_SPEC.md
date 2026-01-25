# Employee Invoice Generation & Superannuation Compliance Specification

## 1. Overview
This document outlines the technical specification for the Employee Invoice Generation process within the CareNest system. It details the logic for calculating wages under the SCHADS Award and ensuring compliance with Superannuation Guarantee (SG) legislation, including specific edge cases for 2025–26.

---

## 2. Process Flow

### High-Level Workflow
1.  **Selection**: Admin selects an employee and a date range.
2.  **Data Retrieval**: System fetches:
    *   Employee Profile (Pay Rates, DOB, Employment Type).
    *   Worked Time Records (Shifts, Times, Breaks).
    *   Expenses (Reimbursements).
    *   YTD Earnings (for Quarterly Cap).
3.  **Wage Calculation (`InvoiceDataProcessor`)**:
    *   Applies Minimum Engagement rules.
    *   Calculates Ordinary Hours vs. Overtime.
    *   Applies Penalty Rates (Sat, Sun, Public Holiday, Evening, Night).
4.  **Superannuation Calculation**:
    *   Determines Ordinary Time Earnings (OTE).
    *   Checks Under 18 Rule (< 30 hours/week).
    *   Checks Quarterly Cap ($62,500).
    *   Calculates Super at 12%.
5.  **PDF Generation (`InvoicePdfGenerator`)**:
    *   Renders the invoice with itemized shifts, allowances, expenses, and Superannuation.

---

## 3. Business Rules & Logic

### 3.1 SCHADS Wage Compliance
The system automatically applies the following rules based on the **Social, Community, Home Care and Disability Services Industry Award 2010 (SCHADS)**.

| Rule | Condition | Rate Multiplier / Logic |
| :--- | :--- | :--- |
| **Minimum Engagement** | Casual shift < 2 hours | Paid as 2 hours minimum. |
| **Ordinary Hours** | Mon-Fri, 6am-8pm | Base Rate (1.0x). |
| **Evening Shift** | Mon-Fri, finishes >8pm | Base Rate + Evening Penalty (or 1.125x / 1.1x casual). |
| **Night Shift** | Mon-Fri, starts <6am or finishes >12am | Base Rate + Night Penalty (or 1.15x / 1.12x casual). |
| **Saturday** | Any time Saturday | Saturday Rate (1.5x / 1.4x casual). |
| **Sunday** | Any time Sunday | Sunday Rate (2.0x / 1.8x casual). |
| **Public Holiday** | Any time PH | PH Rate (2.5x / 2.2x casual). |
| **Overtime** | Shift > 10 hours | Excess hours paid at Overtime Rate (1.5x/2.0x). |

### 3.2 Superannuation Guarantee (SG)
**Rate**: 12.0% (effective July 1, 2025).

#### Ordinary Time Earnings (OTE) Definition
Superannuation is calculated **only** on OTE.
*   **Included**: Ordinary hours, Casual Loading, Shift Penalties (Sat/Sun/Evening/Night).
*   **Excluded**: Overtime hours (`EMP_OVERTIME`), Expense Reimbursements.

#### Edge Cases Implemented

**1. Under 18 Rule**
*   **Logic**: If employee age < 18:
    *   Group worked hours by week (Monday to Sunday).
    *   If total hours in a week ≤ 30: **Exclude** that week's earnings from OTE.
    *   If total hours in a week > 30: **Include** that week's earnings in OTE.
*   **Dependency**: Requires `dob` in User Profile.

**2. Quarterly Cap**
*   **Limit**: Maximum OTE base per quarter is **$62,500**.
*   **Logic**:
    1.  Fetch `getQuarterlyOTE` from backend (YTD OTE for current quarter).
    2.  Calculate `remainingCap = 62,500 - YTD_OTE`.
    3.  If `currentInvoiceOTE > remainingCap`, cap the base at `remainingCap`.
    4.  If `remainingCap <= 0`, Super = $0.

---

## 4. Technical Implementation Details

### 4.1 Backend Services
*   **`EarningsService.setPayRate`**: Updated to store `dob`.
*   **`EarningsService.getQuarterlyOTE`**: Calculates sum of `(hours * rate)` for all `workedTime` records in the current financial quarter (starts Jul 1, Oct 1, Jan 1, Apr 1).

### 4.2 Frontend Logic (`InvoiceDataProcessor.dart`)

#### Weekly Grouping for Under 18s
```dart
// Pseudo-logic
if (age < 18) {
  weeklyHours = groupItemsByWeek(items);
  for (week in weeklyHours) {
    if (week.totalHours <= 30) {
      excludeFromSuper(week.items);
    }
  }
}
```

#### Cap Check
```dart
// Pseudo-logic
ytdOTE = api.getQuarterlyOTE(userEmail, invoiceDate);
remaining = 62500 - ytdOTE;
superableOTE = min(currentInvoiceOTE, remaining);
superAmount = superableOTE * 0.12;
```

### 4.3 PDF Output (`InvoicePdfGenerator.dart`)
*   **Dynamic Label**: Displays "Superannuation (12%)" based on the rate stored in the invoice data.
*   **Position**: Shown in the totals section, distinct from tax.

---

## 5. Validation & Troubleshooting

### Common Issues

| Issue | Symptom | Cause | Resolution |
| :--- | :--- | :--- | :--- |
| **Zero Super** | Super amount is $0.00 | 1. Employee < 18 and worked < 30h.<br>2. Quarterly cap reached.<br>3. Only Overtime worked. | Check DOB, YTD earnings, and shift types. |
| **Incorrect Rate** | Rate is 11.5% instead of 12% | Codebase not updated or cached old invoice. | Ensure app is updated. Regenerate invoice. |
| **Missing DOB** | Under 18 rule not applied | `dob` field null in User Profile. | Update user profile via Admin Dashboard (or API). |
| **Cap Ignored** | Super calculated on full amount > cap | API failure for `getQuarterlyOTE`. | Check network logs. System defaults to uncapped on error to prevent underpayment. |

### Verification Steps
1.  **Standard**: Create invoice for >18 employee. Verify Super = `(Total - OT - Expenses) * 0.12`.
2.  **Under 18**: Create invoice for <18 employee with 20h week. Verify Super = $0. Add 15h (total 35h). Verify Super applies.
3.  **Cap**: Simulate YTD earnings > $62,500 in backend. Generate invoice. Verify Super = $0.
