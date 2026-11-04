import 'package:carenest/app/core/providers/app_providers.dart';
import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/Appointment/views/client_appointment_details_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// The API reports "not found" as an empty `clientDetails` list rather than an
/// exception. The details screen used to index that list blindly, which threw
/// inside initState and left the loading spinner running forever.
class _FakeApiMethod extends ApiMethod {
  _FakeApiMethod(this.detailsPayload);

  final Map<String, dynamic> detailsPayload;
  int detailsCalls = 0;

  @override
  Future<dynamic> getClientAndAppointmentData(
    String userEmail,
    String clientEmail,
  ) async {
    detailsCalls += 1;
    return detailsPayload;
  }

  @override
  Future<Map<String, dynamic>> getTimerStatus(String userEmail) async =>
      {'success': false, 'isRunning': false};
}

/// A clockable SIL shift plus a start-timer endpoint that succeeds, so the
/// clock-in transition can be driven without a live backend.
class _ClockableApiMethod extends _FakeApiMethod {
  _ClockableApiMethod({String shiftType = 'day', String date = '2026-10-23'})
    : super({
        'success': true,
        'data': {
          'clientDetails': [
            {
              'clientFirstName': 'Nadia',
              'clientLastName': 'NDIA',
              'clientEmail': 'sil.ndia@mailinator.com',
            },
          ],
          'assignedClient': {
            '_id': 'sil-shift-6ada24d5210dbd451597fb82',
            'clientEmail': 'sil.ndia@mailinator.com',
            'isSilRosterShift': true,
            'schedule': [
              {
                'shiftId': 'shift-test-123',
                '_id': 'shift-test-123',
                'date': date,
                'startTime': '09:00',
                'endTime': '11:00',
                'break': null,
                'shiftType': shiftType,
                'status': 'pending',
              },
            ],
            'dateList': [date],
            'startTimeList': ['09:00'],
            'endTimeList': ['11:00'],
            'breakList': [null],
            'timeRecords': <dynamic>[],
          },
        },
      });

  int startCalls = 0;
  int cancelCalls = 0;
  String? lastCancelReason;
  int setWorkedTimeCalls = 0;
  List<Map<String, dynamic>>? lastDisturbances;
  bool? lastConvertedToActiveNight;

  @override
  Future<Map<String, dynamic>> startTimer({
    String? userEmail,
    String? clientEmail,
    String? organizationId,
  }) async {
    startCalls += 1;
    return {'success': true};
  }

  // Override stopTimer to prevent network calls to development backend during tests
  @override
  Future<void> stopTimer({
    String? userEmail,
    String? organizationId,
    bool persistWorkedTime = true,
  }) async {}

  @override
  Future<Map<String, dynamic>> createCancellationCharge({
    required String shiftId,
    required String reason,
    String? cancelledAt,
    double? noticeHours,
    double? unitPrice,
  }) async {
    cancelCalls += 1;
    lastCancelReason = reason;
    return {'success': true, 'data': {'chargeId': 'charge-123'}};
  }

  @override
  Future<dynamic> setWorkedTime(
    String userEmail,
    String clientEmail,
    String workedTime,
    int shiftIndex, {
    String? shiftDate,
    String? shiftStartTime,
    String? shiftEndTime,
    dynamic shiftBreak,
    String? clientRequestId,
    String? shiftType,
    List<Map<String, dynamic>>? disturbances,
    bool? convertedToActiveNight,
  }) async {
    setWorkedTimeCalls += 1;
    lastDisturbances = disturbances;
    lastConvertedToActiveNight = convertedToActiveNight;
    return {'success': true};
  }
}

/// Simulates a transport-level failure (offline, timeout, stalled token) so the
/// init chain's catch path is exercised rather than the API's fallback payload.
class _ThrowingApiMethod extends ApiMethod {
  @override
  Future<dynamic> getClientAndAppointmentData(
    String userEmail,
    String clientEmail,
  ) async {
    throw Exception('SocketException: Failed host lookup (offline)');
  }

  @override
  Future<Map<String, dynamic>> getTimerStatus(String userEmail) async =>
      {'success': false, 'isRunning': false};
}

Widget _buildApp(ApiMethod api) {
  return ProviderScope(
    overrides: [apiMethodProvider.overrideWithValue(api)],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const ClientAndAppointmentDetails(
        userEmail: 'employee.seed.1@mailinator.com',
        clientEmail: 'sil.ndia@mailinator.com',
      ),
    ),
  );
}

/// Pumps a few frames without waiting for animations to settle (the screen
/// arms repeating animations).
Future<void> _pumpFrames(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
    GoogleFonts.config.allowRuntimeFetching = false;
    TimerService().stop();
  });

  testWidgets('empty clientDetails ends the loading state with an error panel', (
    tester,
  ) async {
    final api = _FakeApiMethod({
      'success': false,
      'message': 'No appointment details found',
      'data': {
        'clientDetails': <dynamic>[],
        'assignedClient': null,
      },
    });

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    expect(api.detailsCalls, 1);
    expect(find.text('LOADING APPOINTMENT DETAILS...'), findsNothing);
    expect(find.text('NO CLIENT DETAILS FOUND'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('a valid payload renders the client details, not a spinner', (
    tester,
  ) async {
    final api = _FakeApiMethod({
      'success': true,
      'data': {
        'clientDetails': [
          {
            'clientEmail': 'sil.ndia@mailinator.com',
            'clientFirstName': 'Nadia',
            'clientLastName': 'Haddad',
            'clientPhone': '0400000000',
            'clientAddress': '12 Test St',
            'clientCity': 'Sydney',
            'clientState': 'NSW',
            'clientZip': '2000',
          },
        ],
        'assignedClient': null,
      },
    });

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    expect(api.detailsCalls, 1);
    expect(find.text('LOADING APPOINTMENT DETAILS...'), findsNothing);
    expect(find.text('CLIENT INFORMATION'), findsOneWidget);
    expect(find.text('Nadia Haddad'), findsOneWidget);
    expect(find.text('sil.ndia@mailinator.com'), findsOneWidget);
  });

  testWidgets('a throwing request ends the loading state with an error panel', (
    tester,
  ) async {
    final api = _ThrowingApiMethod();

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    expect(find.text('LOADING APPOINTMENT DETAILS...'), findsNothing);
    expect(find.text('NO CLIENT DATA FOUND'), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });

  testWidgets('retry reloads the details request', (tester) async {
    final api = _FakeApiMethod({
      'success': false,
      'message': 'No appointment details found',
      'data': {
        'clientDetails': <dynamic>[],
        'assignedClient': null,
      },
    });

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    await tester.tap(find.text('Retry'));
    await _pumpFrames(tester);

    expect(api.detailsCalls, 2);
    expect(find.text('LOADING APPOINTMENT DETAILS...'), findsNothing);
  });

  testWidgets('renders SIL roster shift details (schedule + participant)', (
    tester,
  ) async {
    // Shape returned for a SIL roster shift: no ClientAssignment, the
    // synthetic assignment carries the schedule built from Shift documents.
    final api = _FakeApiMethod({
      'success': true,
      'data': {
        'clientDetails': [
          {
            'clientFirstName': 'Nadia',
            'clientLastName': 'NDIA',
            'clientEmail': 'sil.ndia@mailinator.com',
          },
        ],
        'assignedClient': {
          '_id': 'sil-shift-6ada24d5210dbd451597fb82',
          'clientEmail': 'sil.ndia@mailinator.com',
          'isSilRosterShift': true,
          'schedule': [
            {
              'date': '2026-10-23',
              'startTime': '09:00',
              'endTime': '11:00',
              'break': null,
              'shiftType': 'day',
            },
          ],
          'dateList': ['2026-10-23'],
          'startTimeList': ['09:00'],
          'endTimeList': ['11:00'],
          'breakList': [null],
          'timeRecords': <dynamic>[],
        },
      },
    });

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    expect(find.text('LOADING APPOINTMENT DETAILS...'), findsNothing);
    expect(find.textContaining('Nadia'), findsWidgets);
    expect(find.textContaining('2026-10-23'), findsWidgets);
    // A SIL shift is clockable, so the timer stays available.
    expect(find.text('START SHIFT'), findsOneWidget);
  });

  testWidgets(
    'clocking in swaps START SHIFT for END SHIFT without reopening the client',
    (tester) async {
      final api = _ClockableApiMethod();

      await tester.pumpWidget(_buildApp(api));
      await _pumpFrames(tester);
      expect(find.text('START SHIFT'), findsOneWidget);

      await tester.ensureVisible(find.text('START SHIFT'));
      await tester.tap(find.text('START SHIFT'));
      await _pumpFrames(tester);

      expect(api.startCalls, 1);
      expect(find.text('END SHIFT'), findsOneWidget);
      expect(find.text('START SHIFT'), findsNothing);

      // The screen runs the TimerService singleton, whose periodic wake-up is
      // still pending; the test binding fails the test if it outlives the tree.
      TimerService().stop();
    },
  );

  testWidgets('hides the clock-in control when there is no shift to log against', (
    tester,
  ) async {
    // Participant exists but no shift was materialised, so `setWorkedTime` has
    // nothing to resolve; the button would only produce "invalid shift index".
    final api = _FakeApiMethod({
      'success': true,
      'data': {
        'clientDetails': [
          {
            'clientFirstName': 'Nadia',
            'clientLastName': 'NDIA',
            'clientEmail': 'sil.ndia@mailinator.com',
          },
        ],
        'assignedClient': {
          'clientEmail': 'sil.ndia@mailinator.com',
          'isSilRosterShift': true,
          'schedule': <dynamic>[],
          'dateList': <dynamic>[],
          'timeRecords': <dynamic>[],
        },
      },
    });

    await tester.pumpWidget(_buildApp(api));
    await _pumpFrames(tester);

    expect(find.text('CLIENT INFORMATION'), findsOneWidget);
    expect(find.text('START SHIFT'), findsNothing);
    expect(find.text('END SHIFT'), findsNothing);
  });

  // Milestone 3.1: Short-Notice Cancellation Dialog & Billing
  testWidgets(
    'Milestone 3.1: displays cancel icon for future shifts and opens cancellation dialog',
    (tester) async {
      // Use a future date so the shift is not treated as past
      final api = _ClockableApiMethod(shiftType: 'day', date: '2026-11-20');

      await tester.pumpWidget(_buildApp(api));
      await _pumpFrames(tester);

      // Verify the cancel icon exists in the action cell
      final cancelIconFinder = find.byIcon(Icons.cancel_outlined);
      expect(cancelIconFinder, findsOneWidget);

      // Scroll to ensure the cancel button is visible and tap it
      await tester.ensureVisible(cancelIconFinder);
      await tester.tap(cancelIconFinder);
      await _pumpFrames(tester);

      // Verify the cancellation dialog appears
      expect(find.text('Cancellation reason'), findsOneWidget);
      expect(find.text('Notice (hours)'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Bill cancellation'), findsOneWidget);

      // Tap Bill cancellation to trigger billing invocation
      await tester.tap(find.text('Bill cancellation'));
      await _pumpFrames(tester);

      expect(api.cancelCalls, 1);
      expect(api.lastCancelReason, 'NSCC');
    },
  );

  // Milestone 3.3: Sleepover Disturbance Check & SCHADS Clause 25.7 Conversion
  testWidgets(
    'Milestone 3.3: sleepover shift clock-out triggers disturbance check and converts to Active Night if > 60m',
    (tester) async {
      final api = _ClockableApiMethod(shiftType: 'sleepover', date: '2026-11-20');

      await tester.pumpWidget(_buildApp(api));
      await _pumpFrames(tester);

      // Start the sleepover shift
      await tester.ensureVisible(find.text('START SHIFT'));
      await tester.tap(find.text('START SHIFT'));
      await _pumpFrames(tester);
      expect(find.text('END SHIFT'), findsOneWidget);

      // Stop the shift to trigger the shift selection dialog
      await tester.ensureVisible(find.text('END SHIFT'));
      await tester.tap(find.text('END SHIFT'));
      await _pumpFrames(tester);

      // Select the shift from the shift selection dialog
      final shiftTileFinder = find.textContaining('Date: 2026-11-20');
      expect(shiftTileFinder, findsOneWidget);
      await tester.tap(shiftTileFinder);
      await _pumpFrames(tester);

      // Confirm the shift association dialog
      expect(find.text('CONFIRM SHIFT ASSOCIATION'), findsOneWidget);
      await tester.tap(find.text('CONFIRM'));
      await _pumpFrames(tester);

      // Verify the sleepover check dialog is shown
      expect(find.text('Sleepover shift check'), findsOneWidget);
      expect(
        find.text(
          'Were you disturbed or required to perform active work during this sleepover shift?',
        ),
        findsOneWidget,
      );
      expect(find.text('No (quiet)'), findsOneWidget);
      expect(find.text('Yes (disturbed)'), findsOneWidget);

      // Worker indicates disturbance
      await tester.tap(find.text('Yes (disturbed)'));
      await _pumpFrames(tester);

      // Enter 90 minutes of disturbance (> 60 minutes threshold for Active Night)
      final durationFieldFinder = find.widgetWithText(
        TextField,
        'Total disturbance (minutes)',
      );
      expect(durationFieldFinder, findsOneWidget);
      await tester.enterText(durationFieldFinder, '90');
      await _pumpFrames(tester);

      // Verify SCHADS Award Clause 25.7 automatic conversion banner
      expect(
        find.textContaining('Under SCHADS Clause 25.7, this converts to Active Night'),
        findsOneWidget,
      );

      // Confirm disturbance details
      await tester.tap(find.text('Confirm'));
      await _pumpFrames(tester);

      expect(api.setWorkedTimeCalls, 1);
      expect(api.lastConvertedToActiveNight, true);
      expect(api.lastDisturbances, isNotNull);
      expect(api.lastDisturbances!.first['durationMinutes'], 90);

      TimerService().stop();
    },
  );
}
