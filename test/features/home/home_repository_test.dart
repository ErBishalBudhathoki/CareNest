import 'package:carenest/app/core/services/timer_service.dart';
import 'package:carenest/app/features/home/repositories/home_repository.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';

/// Captures the two calls HomeRepository makes; no network.
class _FakeApiMethod extends ApiMethod {
  _FakeApiMethod({
    required this.emergencyResponse,
    required this.appointmentResponse,
  });

  final Map<String, dynamic> emergencyResponse;
  final Map<String, dynamic> appointmentResponse;

  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    bool forceRefresh = false,
  }) async {
    if (endpoint == 'emergency/active') return emergencyResponse;
    return {'success': true, 'data': []};
  }

  @override
  Future<dynamic> getAppointmentData(String email) async => appointmentResponse;
}

String _dayFirst(DateTime date) {
  final d = date.day.toString().padLeft(2, '0');
  final m = date.month.toString().padLeft(2, '0');
  return '$d/$m/${date.year}';
}

String _hhmm(DateTime date) {
  final h = date.hour.toString().padLeft(2, '0');
  final m = date.minute.toString().padLeft(2, '0');
  return '$h:$m';
}

void main() {
  setUp(() {
    TimerService().stop();
  });

  test('successful empty response is not treated as an error', () async {
    final repo = HomeRepository(
      _FakeApiMethod(
        emergencyResponse: {'success': true, 'data': []},
        appointmentResponse: {'success': true, 'data': []},
      ),
    );

    final data = await repo.getHomeDashboardData('worker@org.com');

    expect(data.upcomingAppointments, isEmpty);
    expect(data.shiftsUnavailable, isFalse);
    expect(data.shiftsErrorMessage, isNull);
  });

  test('transport/server failure is surfaced for retry', () async {
    final repo = HomeRepository(
      _FakeApiMethod(
        emergencyResponse: {'success': true, 'data': []},
        appointmentResponse: {
          'success': false,
          'data': [],
          'message': 'Could not load appointments (HTTP 500).',
        },
      ),
    );

    final data = await repo.getHomeDashboardData('worker@org.com');

    expect(data.upcomingAppointments, isEmpty);
    expect(data.shiftsUnavailable, isTrue);
    expect(data.shiftsErrorMessage, contains('HTTP 500'));
  });

  test('builds an in-progress card from a day-first schedule date', () async {
    final now = DateTime.now();
    final start = now.subtract(const Duration(hours: 1));
    final end = now.add(const Duration(hours: 1));

    final repo = HomeRepository(
      _FakeApiMethod(
        emergencyResponse: {'success': true, 'data': []},
        appointmentResponse: {
          'success': true,
          'data': [
            {
              'clientEmail': 'client@org.com',
              'clientName': 'Test Client',
              'schedule': [
                {
                  'date': _dayFirst(now),
                  'startTime': _hhmm(start),
                  'endTime': _hhmm(end),
                },
              ],
            },
          ],
        },
      ),
    );

    final data = await repo.getHomeDashboardData('worker@org.com');

    expect(data.upcomingAppointments, hasLength(1));
    expect(data.shiftsUnavailable, isFalse);
    expect(data.upcomingAppointments.first['_shiftStatus'], 'in_progress');
  });
}
