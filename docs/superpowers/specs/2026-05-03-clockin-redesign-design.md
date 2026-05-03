# Clock In/Out View Redesign

**Date:** 2026-05-03
**Status:** Approved
**Design:** Minimal Geometric (Option C)

## Overview

Redesign [clockInAndOut_view.dart](../../../lib/app/features/clockInandOut/views/clockInAndOut_view.dart) to remove the clock in/out button (now in a separate dedicated view), display actual total work hours for today, and show swipeable shift/schedule cards with day navigation. Neo-brutalist Bauhaus design throughout — sharp corners, hard shadows, thick borders, bold typography with high contrast.

## What Changes

### Remove
- Large circular clock in/out button (180x180) and its `Consumer<timerServiceProvider>` wrapper
- "Nothing scheduled today" placeholder text
- The dedicated `Consumer` inside the total-hours card (currently shows hardcoded `'0:00'`)

### Keep (no changes)
- Full-screen map background with location tracking (`_buildMapSection`)
- Location error/retry UI
- Debug diagnostics card (gated: `kDebugMode && !AppConfig.isProduction`)
- Back button (top-left)
- Navigation to `RequestsView` and `TimesheetView`

### Redesign

**1. Total Work Hours Hero**

Centered display in the upper content area, replacing the compact inline card:

```
TOTAL TODAY
  4.8
HOURS WORKED
```

- Label: `labelSmall`, `textMuted`, tracked-out letter spacing
- Number: `displayLarge` (32px), `fontWeight: 900`, `primary` (#D12D21), tight line height
- Caption: `labelLarge`, `fontWeight: 900`, `textDark` (#1A1A1A)
- Divider: 40px x 3px solid `neutral` bar below caption

Data: `totalSeconds = sum(completedTimesheetEntriesForToday.timeWorkedInSeconds) + activeTimerElapsedSeconds`. Displayed as decimal hours with one decimal place.

**2. Day Navigation**

Arrow-based control between the hero and shift cards:

```
  <    WED 03 MAY    >
```

- Left/right: `BauhausIconButton` 32x32, variant neutral
- Date: `titleMedium`, `fontWeight: 900`, `textDark`
- Tapping arrows shifts `PageController` to adjacent day
- PageView supports swipe gesture

**3. Shift Cards (PageView)**

One page per day, vertical list of shift cards:

```
+--+--------------------------+
|| |  09:00 - 13:00           |
|| |  Morning Support . 4h    |
|  |  Client: ABC Care        |
+--+--------------------------+
```

- 4px left border, color-coded by status:
  - `primary` (#D12D21) - Active/In Progress
  - `warning` (#F4B513) - Upcoming
  - `success` (#0DA85E) - Completed
  - `neutral` (#1A1A1A) - Cancelled
- Card: white surface, 2px neutral border, `shadowHard`
- Content: time range (bold, textDark), role + duration (bodySmall, textMuted), client name
- 8px vertical spacing between cards
- Empty state: `BauhausEmptyState` with "No shifts scheduled"

**4. Action Buttons**

Two solid-fill buttons at the bottom, equal width in a row:

```
+--------------+ +--------------+
|              | |              |
|    Requests  | |  Timesheet   |
|              | |              |
+--------------+ +--------------+
  accent/yellow   secondary/indigo
  textDark         textWhite
```

- 2px neutral border, `shadowHard`
- Navigate to existing `RequestsView` / `TimesheetView`

## Data Flow

```
TimerService.instance.elapsedSeconds  --+
                                        +--> todayTotal -> hero display
Timesheet entries (shiftDate == today) --+

WorkerDashboardData / shift provider --> PageView shift cards (day +/- 1)
```

- `TimerService` is a singleton initialized at app start
- `timesheetViewModelProvider` (existing, keyed by email) fetches weekly entries - filtered client-side for today
- Shift data via `WorkerDashboardData.todayShifts` (existing model, fetched by `workerDashboardViewModelProvider`)
- All values reactive via Riverpod providers

## Layout

```
+-----------------------------+
| Map (full screen, z: 0)     |
+-----------------------------+
| <- Back                     |  SafeArea top
+-----------------------------+
|        TOTAL TODAY          |
|           4.8               |  Hero
|       HOURS WORKED          |
|           ---               |
+-----------------------------+
|    <   WED 03 MAY   >      |  Day nav
+-----------------------------+
| +-----------------------+  |
| || 09:00 - 13:00        |  |  Shift cards
| || Morning . 4h         |  |  (PageView)
| +-----------------------+  |
| +-----------------------+  |
| || 14:00 - 17:00        |  |
| +-----------------------+  |
+-----------------------------+
| [REQUESTS]  [TIMESHEET]    |  Actions
+-----------------------------+
```

## Typography

All text uses high-contrast colors from `BauhausDesign`:
- Headings/labels: `textDark` (#1A1A1A)
- Body/secondary: `textMuted` (#666666)
- Hero number: `primary` (#D12D21)
- White text only on dark filled backgrounds (indigo buttons)

## Testing

- Widget test: hero displays correct total from mock provider
- Widget test: shift cards render for each status color
- Widget test: day navigation updates PageView
- Widget test: empty state when no shifts
- Widget test: debug card hidden in production config
- Unit test: todayTotalSeconds calculation combines timesheet + active timer
