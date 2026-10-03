import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:carenest/app/features/mileage/repositories/mileage_repository.dart';
import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/backend/api_method.dart';

class MockApiMethod extends Mock implements ApiMethod {
  @override
  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? headers,
    bool forceRefresh = false,
  }) async {
    if (endpoint.contains('employee/user123')) {
      return {
        'success': true,
        'data': [
          {
            'id': 'trip1',
            'userId': 'user123',
            'organizationId': 'org1',
            'date': '2025-05-01T10:00:00.000Z',
            'startLocation': 'A',
            'endLocation': 'B',
            'distance': 10.5,
            'tripType': 'BETWEEN_CLIENTS',
            'status': 'APPROVED',
            'isReimbursable': true,
          },
          {
            'id': 'trip2',
            'userId': 'user123',
            'organizationId': 'org1',
            'date': '2025-05-02T10:00:00.000Z',
            'startLocation': 'B',
            'endLocation': 'C',
            'distance': 5.0,
            'tripType': 'COMMUTE',
            'status': 'APPROVED',
            'isReimbursable': false,
          },
        ],
      };
    }
    return {'success': false};
  }
}

void main() {
  group('MileageRepository Tests', () {
    late MockApiMethod mockApi;

    setUp(() {
      mockApi = MockApiMethod();
    });

    ProviderContainer createContainer() {
      return ProviderContainer(
        overrides: [app_providers.apiMethodProvider.overrideWithValue(mockApi)],
      );
    }

    test('getTrips returns list of Trip objects on success', () async {
      final container = createContainer();
      addTearDown(container.dispose);
      final repository = container.read(mileageRepositoryProvider);

      final trips = await repository.getTrips(
        'user123',
        startDate: '2025-05-01',
        endDate: '2025-05-31',
      );

      expect(trips.length, 2);
      expect(trips[0].distance, 10.5);
      expect(trips[0].isReimbursable, true);
      expect(trips[1].tripType, 'COMMUTE');
      expect(trips[1].isReimbursable, false);
    });

    test('getTrips handles null/empty response gracefully', () async {
      final container = createContainer();
      addTearDown(container.dispose);
      final repository = container.read(mileageRepositoryProvider);

      final trips = await repository.getTrips('unknown_user');
      expect(trips, isEmpty);
    });
  });
}
