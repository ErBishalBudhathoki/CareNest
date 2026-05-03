# Clock In/Out View Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Redesign `ClockInAndOutView` to remove the clock in/out button, display actual total work hours today, and show swipeable shift cards with day navigation in neo-brutalist Bauhaus style.

**Architecture:** Single-view redesign in `clockInAndOut_view.dart`. A new `todayWorkHoursProvider` (Riverpod family provider keyed by email) calculates today's total from timesheet entries + active timer. The view uses `PageView` with a `PageController` for swipeable day navigation. Shift data comes from the existing `workerDashboardViewModelProvider`.

**Tech Stack:** Flutter, Riverpod, Geolocator, existing BauhausDesign/BauhausWidgets design system

---

### File Map

| File | Action | Responsibility |
|------|--------|---------------|
| `lib/app/features/clockInandOut/views/clockInAndOut_view.dart` | Modify | Main view — new layout, remove clock button, hero, day nav, shift cards, action buttons |
| `lib/app/features/clockInandOut/providers/today_work_hours_provider.dart` | Create | Riverpod provider that calculates today's total work hours |

---

### Task 1: Create todayWorkHoursProvider

**Files:**
- Create: `lib/app/features/clockInandOut/providers/today_work_hours_provider.dart`

- [ ] **Step 1: Write the provider file**

```dart
import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/timesheet/models/timesheet_model.dart';
import 'package:carenest/app/features/timesheet/viewmodels/timesheet_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

/// Returns today's total work hours as a double (e.g. 4.8).
///
/// Combines completed timesheet entries for today with the currently
/// running timer's elapsed seconds. Reacts to changes in both sources.
final todayWorkHoursProvider =
    FutureProvider.family.autoDispose<double, String>((ref, email) async {
  final timesheetState = ref.watch(timesheetViewModelProvider(email));
  final timerService = ref.watch(timerServiceProvider);

  double totalSeconds = 0;

  // Sum completed timesheet entries for today
  timesheetState.whenData((entries) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    for (final entry in entries) {
      if (entry.shiftDate == today) {
        totalSeconds += _parseTimeWorkedToSeconds(entry.timeWorked);
      }
    }
  });

  // Add active timer seconds if currently running
  if (timerService.isRunning) {
    totalSeconds += timerService.elapsedSeconds;
  }

  return totalSeconds / 3600.0;
});

int _parseTimeWorkedToSeconds(String timeWorked) {
  final parts = timeWorked.split(':');
  if (parts.length != 3) return 0;
  final h = int.tryParse(parts[0]) ?? 0;
  final m = int.tryParse(parts[1]) ?? 0;
  final s = int.tryParse(parts[2]) ?? 0;
  return h * 3600 + m * 60 + s;
}
```

- [ ] **Step 2: Run dart analyze to verify no errors**

Run: `cd /Users/bishal/Developer/invoice && dart analyze lib/app/features/clockInandOut/providers/today_work_hours_provider.dart`
Expected: No issues found.

- [ ] **Step 3: Commit**

```bash
git add lib/app/features/clockInandOut/providers/today_work_hours_provider.dart
git commit -m "feat: add todayWorkHoursProvider combining timesheet entries and active timer"
```

---

### Task 2: Rewrite the build() method — new layout structure

**Files:**
- Modify: `lib/app/features/clockInandOut/views/clockInAndOut_view.dart`

- [ ] **Step 1: Add new imports and PageController at top of state class**

Replace the existing imports (lines 1-13) with:

```dart
import 'dart:async';

import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/features/clockInandOut/providers/today_work_hours_provider.dart';
import 'package:carenest/app/features/worker/viewmodels/worker_dashboard_viewmodel.dart';
import 'package:carenest/app/shared/widgets/platform_map_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carenest/app/features/requests/views/requests_view.dart';
import 'package:carenest/app/features/timesheet/views/timesheet_view.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/widgets/bauhaus_widgets.dart';
import 'package:carenest/config/environment.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:intl/intl.dart';
```

Add inside `_ClockInAndOutViewState` before `initState`:

```dart
late final PageController _pageController;
int _currentDayOffset = 0;

DateTime get _selectedDate {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day + _currentDayOffset);
}
```

Update `initState`:

```dart
@override
void initState() {
  super.initState();
  _pageController = PageController(initialPage: 0);
  _pageController.addListener(() {
    final page = _pageController.page?.round() ?? 0;
    if (page != _currentDayOffset) {
      setState(() => _currentDayOffset = page);
    }
  });
  _getCurrentLocation();
}
```

Update `dispose`:

```dart
@override
void dispose() {
  _pageController.dispose();
  _positionSubscription?.cancel();
  super.dispose();
}
```

- [ ] **Step 2: Replace the build() method (lines 176-409) with the new layout**

Replace the entire `build` method and all widget builder methods below it with this new structure:

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: BauhausDesign.backgroundLight,
    body: Stack(
      children: [
        // Layer 0: Full-screen map background
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: _buildMapSection(),
        ),

        // Layer 1: Content overlay
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back button
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  BauhausDesign.space4,
                  BauhausDesign.space2,
                  BauhausDesign.space4,
                  0,
                ),
                child: BauhausIconButton(
                  icon: Icons.arrow_back,
                  onPressed: () => Navigator.pop(context),
                  variant: BauhausActionVariant.neutral,
                ),
              ),

              // Total Work Hours Hero
              _buildTotalHoursHero(),

              // Debug diagnostics (only in non-production debug mode)
              if (kDebugMode && !AppConfig.isProduction)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: BauhausDesign.space4,
                  ),
                  child: _buildDebugDiagnosticsCard(),
                ),

              const SizedBox(height: BauhausDesign.space2),

              // Day Navigation
              _buildDayNavigation(),

              const SizedBox(height: BauhausDesign.space3),

              // Shift Cards PageView
              Expanded(child: _buildShiftCards()),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  BauhausDesign.space4,
                  BauhausDesign.space3,
                  BauhausDesign.space4,
                  BauhausDesign.space6,
                ),
                child: _buildActionButtons(),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
```

- [ ] **Step 3: Run dart analyze**

Run: `cd /Users/bishal/Developer/invoice && dart analyze lib/app/features/clockInandOut/views/clockInAndOut_view.dart`
Expected: Errors about missing `_buildTotalHoursHero`, `_buildDayNavigation`, `_buildShiftCards`, `_buildActionButtons` — these will be created in the next tasks.

- [ ] **Step 4: Commit**

```bash
git add lib/app/features/clockInandOut/views/clockInAndOut_view.dart
git commit -m "refactor: restructure ClockInAndOutView layout, remove clock in/out button"
```

---

### Task 3: Implement Total Work Hours Hero

**Files:**
- Modify: `lib/app/features/clockInandOut/views/clockInAndOut_view.dart`

- [ ] **Step 1: Add `_buildTotalHoursHero` method**

Add this method to `_ClockInAndOutViewState`:

```dart
Widget _buildTotalHoursHero() {
  return Padding(
    padding: const EdgeInsets.symmetric(
      horizontal: BauhausDesign.space4,
      vertical: BauhausDesign.space2,
    ),
    child: Consumer(
      builder: (context, ref, child) {
        final hoursAsync = ref.watch(todayWorkHoursProvider(widget.email));

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'TOTAL TODAY',
              style: BauhausDesign.getTextTheme(context).labelSmall?.copyWith(
                    color: BauhausDesign.textMuted,
                    letterSpacing: 2.0,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Text(
              hoursAsync.when(
                data: (hours) => hours.toStringAsFixed(1),
                loading: () => '--',
                error: (_, __) => '--',
              ),
              style: BauhausDesign.getTextTheme(context).displayLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: BauhausDesign.primary,
                    height: 1.0,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space1),
            Text(
              'HOURS WORKED',
              style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: BauhausDesign.textDark,
                  ),
            ),
            const SizedBox(height: BauhausDesign.space2),
            Container(
              width: 40,
              height: 3,
              color: BauhausDesign.neutral,
            ),
          ],
        );
      },
    ),
  );
}
```

- [ ] **Step 2: Run dart analyze**

Run: `cd /Users/bishal/Developer/invoice && dart analyze lib/app/features/clockInandOut/views/clockInAndOut_view.dart`
Expected: Only errors about remaining missing methods. No errors in `_buildTotalHoursHero`.

- [ ] **Step 3: Commit**

```bash
git add lib/app/features/clockInandOut/views/clockInAndOut_view.dart
git commit -m "feat: add total work hours hero with live data from todayWorkHoursProvider"
```

---

### Task 4: Implement Day Navigation and Shift Cards

**Files:**
- Modify: `lib/app/features/clockInandOut/views/clockInAndOut_view.dart`

- [ ] **Step 1: Add `_buildDayNavigation` method**

```dart
Widget _buildDayNavigation() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BauhausIconButton(
          icon: Icons.chevron_left,
          onPressed: () {
            _pageController.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          variant: BauhausActionVariant.neutral,
          isSmall: true,
        ),
        const SizedBox(width: BauhausDesign.space4),
        Text(
          DateFormat('EEE dd MMM').format(_selectedDate).toUpperCase(),
          style: BauhausDesign.getTextTheme(context).titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(width: BauhausDesign.space4),
        BauhausIconButton(
          icon: Icons.chevron_right,
          onPressed: () {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          variant: BauhausActionVariant.neutral,
          isSmall: true,
        ),
      ],
    ),
  );
}
```

- [ ] **Step 2: Add `_buildShiftCards`, `_buildDayShiftList`, `_buildShiftCard`, and `_formatShiftTime` methods**

```dart
Widget _buildShiftCards() {
  return Consumer(
    builder: (context, ref, child) {
      final dashboardAsync = ref.watch(workerDashboardViewModelProvider);

      return dashboardAsync.when(
        loading: () => const BauhausLoadingState(message: 'Loading shifts...'),
        error: (error, _) => BauhausErrorState(
          message: error.toString(),
          onRetry: () =>
              ref.read(workerDashboardViewModelProvider.notifier).refresh(),
        ),
        data: (dashboard) {
          return PageView(
            controller: _pageController,
            children: [
              _buildDayShiftList(dashboard, -1), // Yesterday
              _buildDayShiftList(dashboard, 0),  // Today
              _buildDayShiftList(dashboard, 1),  // Tomorrow
            ],
          );
        },
      );
    },
  );
}

Widget _buildDayShiftList(dynamic dashboard, int dayOffset) {
  final targetDate = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day + dayOffset,
  );

  final shifts = (dashboard.todayShifts as List<dynamic>?)?.where((shift) {
    final shiftDate = shift.startTime is DateTime
        ? shift.startTime as DateTime
        : DateTime.tryParse(shift.startTime?.toString() ?? '');
    if (shiftDate == null) return dayOffset == 0;
    return shiftDate.year == targetDate.year &&
        shiftDate.month == targetDate.month &&
        shiftDate.day == targetDate.day;
  }).toList() ?? <dynamic>[];

  if (shifts.isEmpty) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: const BauhausEmptyState(
            icon: Icons.event_busy,
            title: 'No shifts scheduled',
            message: 'No shifts found for this date.',
          ),
        ),
      ],
    );
  }

  return ListView.separated(
    padding: const EdgeInsets.symmetric(horizontal: BauhausDesign.space4),
    itemCount: shifts.length,
    separatorBuilder: (_, __) =>
        const SizedBox(height: BauhausDesign.space2),
    itemBuilder: (context, index) => _buildShiftCard(shifts[index]),
  );
}

Widget _buildShiftCard(dynamic shift) {
  final startTime = _formatShiftTime(shift.startTime);
  final endTime = _formatShiftTime(shift.endTime);
  final duration = shift.durationHours?.toStringAsFixed(1) ?? '0.0';
  final status = shift.status as String? ?? 'pending';
  final clientName = shift.clientName as String? ?? 'Unknown Client';
  final role = shift.role as String? ?? 'Shift';
  final breakMin = shift.breakDuration is int
      ? shift.breakDuration as int
      : (shift.breakDuration is double
          ? (shift.breakDuration as double).toInt()
          : 0);

  final Color borderColor;
  switch (status.toLowerCase()) {
    case 'active':
    case 'in_progress':
      borderColor = BauhausDesign.primary;
      break;
    case 'completed':
      borderColor = BauhausDesign.success;
      break;
    case 'cancelled':
      borderColor = BauhausDesign.neutral;
      break;
    default:
      borderColor = BauhausDesign.warning;
  }

  return Container(
    decoration: BoxDecoration(
      color: BauhausDesign.surfaceWhite,
      border: Border(
        left: BorderSide(color: borderColor, width: 4),
        top: const BorderSide(color: BauhausDesign.neutral, width: 2),
        right: const BorderSide(color: BauhausDesign.neutral, width: 2),
        bottom: const BorderSide(color: BauhausDesign.neutral, width: 2),
      ),
      boxShadow: const [BauhausDesign.shadowHard],
    ),
    padding: const EdgeInsets.all(BauhausDesign.space3),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$startTime — $endTime',
          style: BauhausDesign.getTextTheme(context).labelLarge?.copyWith(
                fontWeight: FontWeight.w900,
                color: BauhausDesign.textDark,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          '$role · ${duration}h · ${breakMin}m break',
          style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
        const SizedBox(height: BauhausDesign.space1),
        Text(
          'Client: $clientName',
          style: BauhausDesign.getTextTheme(context).bodySmall?.copyWith(
                color: BauhausDesign.textMuted,
              ),
        ),
      ],
    ),
  );
}

String _formatShiftTime(dynamic time) {
  if (time is DateTime) {
    return DateFormat('h:mm a').format(time);
  }
  if (time is String) {
    final parsed = DateTime.tryParse(time);
    if (parsed != null) {
      return DateFormat('h:mm a').format(parsed);
    }
    return time;
  }
  return '--:--';
}
```

- [ ] **Step 3: Run dart analyze**

Run: `cd /Users/bishal/Developer/invoice && dart analyze lib/app/features/clockInandOut/views/clockInAndOut_view.dart`
Expected: Only errors about missing `_buildActionButtons`. No other issues.

- [ ] **Step 4: Commit**

```bash
git add lib/app/features/clockInandOut/views/clockInAndOut_view.dart
git commit -m "feat: add day navigation and shift cards with color-coded status borders"
```

---

### Task 5: Redesign Action Buttons

**Files:**
- Modify: `lib/app/features/clockInandOut/views/clockInAndOut_view.dart`

- [ ] **Step 1: Add `_buildActionButtons` method and remove old `_buildActionCard`**

Add this method to `_ClockInAndOutViewState`:

```dart
Widget _buildActionButtons() {
  return Row(
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => RequestsView(email: widget.email),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: BauhausDesign.space4,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.accent,
              border: Border.all(
                color: BauhausDesign.neutral,
                width: BauhausDesign.borderThick,
              ),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_outline,
                  color: BauhausDesign.textDark,
                  size: 28,
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  'REQUESTS',
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.textDark,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(width: BauhausDesign.space4),
      Expanded(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TimesheetView(email: widget.email),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: BauhausDesign.space4,
            ),
            decoration: BoxDecoration(
              color: BauhausDesign.secondary,
              border: Border.all(
                color: BauhausDesign.neutral,
                width: BauhausDesign.borderThick,
              ),
              boxShadow: const [BauhausDesign.shadowHard],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.calendar_today,
                  color: BauhausDesign.textLight,
                  size: 28,
                ),
                const SizedBox(height: BauhausDesign.space2),
                Text(
                  'TIMESHEET',
                  style: BauhausDesign.getTextTheme(context)
                      .labelLarge
                      ?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: BauhausDesign.textLight,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
```

Delete the old `_buildActionCard` method (originally at lines 557-578, will have shifted after edits).

- [ ] **Step 2: Run dart analyze**

Run: `cd /Users/bishal/Developer/invoice && dart analyze lib/app/features/clockInandOut/views/clockInAndOut_view.dart`
Expected: No issues found.

- [ ] **Step 3: Commit**

```bash
git add lib/app/features/clockInandOut/views/clockInAndOut_view.dart
git commit -m "feat: redesign action buttons with solid fill Bauhaus style"
```

---

### Task 6: Final verification and formatting

**Files:**
- All modified files

- [ ] **Step 1: Format all modified files**

```bash
cd /Users/bishal/Developer/invoice && dart format lib/app/features/clockInandOut/
```

- [ ] **Step 2: Run full dart analyze**

```bash
cd /Users/bishal/Developer/invoice && dart analyze
```
Expected: No issues found.

- [ ] **Step 3: Verify the final file structure**

Read `clockInAndOut_view.dart` and confirm:
- No remaining clock in/out button code
- No "Nothing scheduled today" text
- No old `_buildActionCard` method
- `_buildMapSection` preserved
- `_buildDebugDiagnosticsCard` preserved (with kDebugMode gate)
- Location methods preserved (`_getCurrentLocation`, `_startLocationUpdates`, `_openLocationSettings`)
- New methods present: `_buildTotalHoursHero`, `_buildDayNavigation`, `_buildShiftCards`, `_buildShiftCard`, `_buildDayShiftList`, `_buildActionButtons`, `_formatShiftTime`

- [ ] **Step 4: Commit**

```bash
git add lib/app/features/clockInandOut/
git commit -m "chore: format and final verification of clock in/out redesign"
```

---

### Task 7: Write widget tests

**Files:**
- Create: `test/widget/clock_in_out_view_test.dart`

- [ ] **Step 1: Write the test file**

```dart
import 'package:carenest/app/features/clockInandOut/views/clockInAndOut_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClockInAndOutView', () {
    testWidgets('renders total hours hero section', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ClockInAndOutView(email: 'test@example.com'),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('TOTAL TODAY'), findsOneWidget);
      expect(find.text('HOURS WORKED'), findsOneWidget);
    });

    testWidgets('renders day navigation with arrows', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ClockInAndOutView(email: 'test@example.com'),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.chevron_left), findsOneWidget);
      expect(find.byIcon(Icons.chevron_right), findsOneWidget);
    });

    testWidgets('renders action buttons', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ClockInAndOutView(email: 'test@example.com'),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('REQUESTS'), findsOneWidget);
      expect(find.text('TIMESHEET'), findsOneWidget);
    });

    testWidgets('does not render clock in/out button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ClockInAndOutView(email: 'test@example.com'),
          ),
        ),
      );

      await tester.pump();

      expect(find.text('Clock in'), findsNothing);
      expect(find.text('Clock out'), findsNothing);
    });

    testWidgets('renders back button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: ClockInAndOutView(email: 'test@example.com'),
          ),
        ),
      );

      await tester.pump();

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });
  });
}
```

- [ ] **Step 2: Run the new tests**

```bash
cd /Users/bishal/Developer/invoice && flutter test test/widget/clock_in_out_view_test.dart
```
Expected: Tests compile. Widget presence tests pass (hero labels, nav arrows, action buttons). If provider-dependent tests fail, add appropriate overrides.

- [ ] **Step 3: Commit**

```bash
git add test/widget/clock_in_out_view_test.dart
git commit -m "test: add widget tests for clock in/out view redesign"
```
