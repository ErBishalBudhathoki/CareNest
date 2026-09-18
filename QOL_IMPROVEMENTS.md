# App Features & QoL Improvements Tracker

Audited 2026-09-18. Each item has file:line evidence. Status: `todo` | `doing` | `done` | `dropped`.

## Recommended build order

1 → 4 → 3 → 10 → 13 (max user impact per effort), then the rest numerically.

---

## Quick wins (hours each)

- [x] **1. Confirm dialog + feedback on "Mark as Paid"** — fires the financial action from an icon button with no confirmation and no success/error snackbar. The delete flow below it does this correctly — copy that pattern. `lib/app/features/invoice/views/invoice_list_view.dart:353-394` (action at `:385-394`, button at `:353-359`; contrast `_deleteInvoice` at `:503-550`).
  - Done 2026-09-18: confirm dialog mirroring delete flow + success/error snackbar; `markAsPaid` now returns `bool`; new l10n keys `markAsPaidTitle/markAsPaidConfirm/markAsPaid/markAsPaidSuccess/markAsPaidError`.
- [x] **2. Undo on attachment / pricing-override removal** — `removeAt`/`removeWhere` with no confirm or undo. `lib/app/features/invoice/views/enhanced_invoice_generation_view.dart:1600-1603, 3866, 3967`.
  - Done 2026-09-18: attachment removal now shows a snackbar with an Undo action (restores the file at its position). The two `removeWhere` sites turned out to be optimistic state updates after successful backend saves, not destructive user actions — no change needed. New l10n `attachmentRemoved`/`undo`.
- [x] **3. Pull-to-refresh on 6 screens** — no `RefreshIndicator` on invoice list/detail, requests, timesheet, client/employee pickers; invoice list only has a manual refresh icon. Other screens already use `RefreshIndicator` — standardize. `invoice_list_view.dart:114-116, 282`, `invoice_detail_view.dart:177`, `requests_view.dart:154`, `timesheet_view.dart:247, 283`, `select_client_for_assignmnet.dart:241`, `select_employee_view.dart:378`. Good examples: `schedule_dashboard_screen.dart:408`, `notification_list_view.dart:196`, `expense_management_view.dart:488`.
  - Done 2026-09-18: `RefreshIndicator` on all six, each wired to its real reload (viewmodel `loadInvoices`/`loadInvoiceDetails`/`refresh()`, timesheet invalidate+future, pickers refetch futures). `AlwaysScrollableScrollPhysics` so short lists still pull.
- [x] **4. Wire up dead drawer items + settings tiles** — nav drawer "Request" (with hardcoded `8` badge) and "Settings" have empty `onTap: () {}`. Dead settings tiles: profile, notifications, theme. `lib/app/shared/widgets/nav_bar_widget.dart:209, 254`, `lib/app/features/settings/views/settings_view.dart:388, 492, 522`.
  - Done 2026-09-18: drawer Request → `RequestsView`, drawer Settings → `SettingsView` (fake `8` badge removed); settings notifications → `NotificationSettingsView`, theme → `ThemeSettingsView`. Profile tile removed — no profile screen exists in the app.
- [x] **5. Actionable empty states** — pickers show "No clients found" with no retry or "add client" action. `select_client_for_assignmnet.dart:430-470`. Gold standard: `BauhausEmptyState` in `invoice_list_view.dart:256-280`.
  - Done 2026-09-18: client picker error state gained Try Again, empty state gained Add Client (→ `AddClientDetails`), no-results gained Clear Search; employee picker empty state gained Clear Search (while searching) / Try Again.
- [x] **6. Stop swallowing errors silently** — requests summary uses `error: (_,_) => SizedBox.shrink()`; `employee_home_view` shows raw `Text('Error: $e')` with no retry. `requests_view.dart:293`, `employee_home_view.dart:513`.
  - Done 2026-09-18: summary error now shows an error strip with Retry (→ `refresh()`); dashboard error uses `BauhausErrorState` with Retry (→ `loadDashboard`). New l10n `errorLoadingRequests`/`errorLoadingDashboard`, reused `retryButton`.
- [x] **7. Tooltips / semantics on icon-only buttons** — invoice list FAB is a custom `Container+InkWell` with no semantics; week chevrons and clear/search icons across pickers lack tooltips. `BauhausActionButton` needs a `tooltip` prop (only `BauhausIconButton` has one). `invoice_list_view.dart:114, 126-152, 353, 363, 370`, `timesheet_view.dart:185, 205`, `select_client_for_assignmnet.dart:188, 217`, `select_employee_view.dart:220, 322`.
  - Done 2026-09-18: `tooltip` prop added to `BauhausActionButton` (also feeds semantics for icon-only buttons); tooltips on invoice refresh/FAB/pay/share/delete, timesheet chevrons, picker clear-search + back buttons, schedule back button. New l10n `clearSearch`/`previousWeek`/`nextWeek`, reused `backButton`/`share`/`delete`/etc.
- [x] **8. Login QoL** — add `autofillHints` + `textInputAction` for password managers. `login_view.dart:199-260` (only `keyboardType: emailAddress` at `:214` today).
  - Done 2026-09-18: email/password hints + next/done actions; form wrapped in `AutofillGroup` (`BauhausTextField` already supported both props).
- [x] **9. Delete dead code** — `old_automatic_invoice_generation_view.dart` (duplicate class name, zero references), stub `invoice_controller.dart` (`TODO: Implement controller logic`), stale TODO above finished `build()` in `wave_animation_widget.dart:94`.
  - Done 2026-09-18: all three removed (1140 lines deleted), analyze clean.

## Medium (days)

- [x] **10. Finish or hide fake bulk actions** — 8 approve/reject handlers show a fake success snackbar after `Future.delayed(1s)` with `TODO: Call repository method`. Either wire the repo or remove the screen. `lib/app/features/bulk_actions/views/bulk_actions_view.dart:238, 259, 475, 498, 656, 671, 903, 930`.
  - Upgrade 2026-09-18: fully wired instead of hidden. Backend (separate repo): org-wide admin timesheet list + assignment status filter. Frontend: all 4 tabs load live data (submitted timesheets, completed-uninvoiced assignments, unassigned shifts, team members) and call the real bulk endpoints (approve/reject, preview/generate, suggest/assign, send/schedule) with loading/error/empty states and pull-to-refresh.
- [x] **11. Real employee-tracking backend** — repository returns `true` after a fake 500 ms delay (`TODO: backend ready`). `lib/app/features/employee_tracking/repositories/employee_tracking_repository.dart:565, 579`.
  - Re-examined 2026-09-18 for a full implementation: verified nothing in the app calls it, and no stored work-status field exists anywhere (User/Employee schemas lack it; tracking status is derived from timers/sessions). A real implementation needs a schema change + endpoint + derivation integration — a backend data-model feature, not a QoL fix — so fail-fast stands as the correct call, now with the full 4-step backend design in the TODO for its own cycle.
- [x] **12. Search / filter / sort everywhere** — pickers are substring-search only (no A–Z/recent sort, no role/status chips); requests has no status filter; schedule dashboard has no search box. `select_client_for_assignmnet.dart:68, 209`, `select_employee_view.dart:62-69, 212`, `requests_view.dart:207, 353-384`, `timesheet_view.dart:194, 247`, `schedule_dashboard_screen.dart:406-415`.
  - Done 2026-09-18: client picker A–Z/Z–A sort; employee picker sort + All/Admin/Employee role chips; requests status chips (All/Pending/Approved/Rejected) + newest/oldest sort (date parse hardened to tryParse); timesheet client-email search (parent now stateful); schedule employee/client text search + no-match empty state. New l10n `sortAZ/sortZA/sortNewest/sortOldest/roleAdmin/roleEmployee/searchTimesheetsHint/searchShiftsHint/noMatchingShifts(+Message)`.
- [x] **13. Offline UX** — `SyncManager` + offline dashboard exist but zero screens check connectivity: no offline banner, no disabled states for pay/share/export, and `employee_home_view` polls every 15 s with no connectivity guard (`:91-97`). `lib/app/core/services/sync/sync_manager.dart:56-97`, `offline/views/offline_sync_dashboard.dart:27-59`.
  - Done 2026-09-18: new `isOnlineProvider` (connectivity_plus stream, no new deps) + `BauhausOfflineBanner` on invoice list, requests, timesheet; Mark-as-Paid/Share disabled + blocked-snackbar while offline (new l10n `offlineActionBlocked`, reused `offlineBannerMessage`); 15 s broadcast poll skipped while offline.
- [x] **14. Localization debt** — hardcoded English in tab labels, search hints, tooltips, export messages; `Yes`/`No` break options compared literally (`schedule_assignment.dart:65-66, 269`); raw `e.toString()` shown to users in invoice PDF flow (`generateInvoice.dart:85, 235, 448, 843, 876, 940, 949`); 2 strings flagged `TODO: Add to l10n` (`enhanced_invoice_generation_view.dart:1704, 1720`).
  - Done 2026-09-18: ~50 hardcoded strings across 14 screens moved to ARB (30+ new keys); PDF flow errors localized without leaking raw exceptions (logs keep details); break dropdown keeps Yes/No values as API contract with localized labels; payment history uses locale date + `priceDisplay`.
- [x] **15. Locale-aware dates / currency** — `DateFormat('MMM dd')` / `h:mm a` without locale; manual `yyyy-MM-dd` parsing risks mismatch (`schedule_assignment.dart:805-807`); `t.date.toString().split(' ')[0]` and hardcoded `$` instead of `l10n.priceDisplay` (`payment_actions_widget.dart:165, 168`).
  - Done 2026-09-18: all display formats now take `l10n.localeName` (timesheet, history, payroll export, schedule dashboard/cards, assignment screens); internal yyyy-MM-dd grouping/parsing keys untouched; `unknownDate` key added; payment history done under item 14.
- [x] **16. Form validation in schedule creation** — no `Form`/`validators`, manual error lists, time defaults to `TimeOfDay.now()`. `schedule_assignment.dart:118, 418-449, 1589-1625`.
  - Done 2026-09-18: kept the (already solid, localized) custom validation for cross-field rules like conflicts; fixed the real gaps — defaults are now 09:00–17:00 instead of now/now, the time picker opens at the current selection, and range errors (end-before-start, 30-min minimum) show inline under the time selectors.
- [x] **17. Notification permission rationale** — quiet-hours/geofence toggles exist but no "open OS settings" affordance or denied-permission state. `notification_settings_view.dart:161-480`.
  - Done 2026-09-18: banner appears when OS permission isn't granted — in-app request button when deniable, Open Settings (system) when permanently denied. New l10n `notificationsDisabledTitle/Message`, `openSystemSettings`.

## Larger epics (weeks)

- [x] **18. Dead BI / analytics screens** — quality assurance, performance analytics, business intelligence, workforce planning, resource allocation, report builder render buttons that do nothing (`TODO: Implement export/audit/...`); file-share TODO in `enhanced_file_viewer_widget.dart:853`. Implement or pull from navigation.
  - Upgrade 2026-09-18: restored and wired instead of hidden. Dashboard tile back; 6 missing named routes registered in all 3 mains (taps previously crashed). Every fake button now calls its real viewmodel method (compliance check, trend analysis, what-if with default scenario + result dialog, scenario comparison + dialog, allocation optimize, report templates/generate). All 5 exports implemented as CSV + share; report builder also does JSON/PDF locally. Fixed two real contract bugs found while wiring: backend `roi` missing from scenario output, and int/double JSON casts in what-if/scenario parsing (normalized in repo).
- [x] **19. Care intelligence actions** — "View mitigation plan" and "Log new behavior" are no-ops. `risk_assessment_view.dart:196`, `behavior_support_view.dart:93`, `medication_management_view.dart:157`.
  - Done 2026-09-18: mitigation plan → `CarePlanBuilderView`, log behavior → `IncidentManagementView`, medication info button → details dialog with the alert's own title/message.
- [ ] **20. Documented roadmap epics** — offline mode, Xero/QuickBooks sync, payment gateway, SCHADS payroll (`docs/FEATURE_ROADMAP.md`, `docs/WHATS_NEXT.md`, `docs/open_questions.md`).
  - Scoped 2026-09-18, not started: each is a multi-week epic, not a QoL fix. Breakdown: (a) Offline mode — `SyncManager` queue exists but `requestPerformer` is unset and `ApiMethod` never enqueues; needs interceptor + per-feature Hive boxes + conflict UI. (b) Xero/QuickBooks — needs OAuth flow + backend sync endpoints (backend repo). (c) Payment gateway — Stripe onboarding exists; needs end-to-end checkout/webhook pass. (d) SCHADS payroll — award-rule engine + pay-run UI. Recommend one epic per cycle, starting with (a) since item 13 laid the connectivity groundwork.

---

## Change log

- 2026-09-18: Audit created (20 items).
- 2026-09-18: Done 1, 4, 3, 10, 13 (recommended order).
- 2026-09-18: Done 2, 5–9, 11, 12, 14–17; item 20 scoped as epics.
- 2026-09-18: Judgment upgrades — item 10 fully wired (backend org-wide list + status filter; all 4 bulk tabs live), item 18 restored + wired (6 routes registered, actions + CSV/PDF/JSON exports real; fixed backend `roi` + int/double JSON casts), item 11 re-examined (fail-fast stands with full backend design documented).
