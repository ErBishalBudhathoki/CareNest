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
}
