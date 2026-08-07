import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/earnings/viewmodels/earnings_viewmodel.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _RecordingEarningsRepository extends EarningsRepository {
  _RecordingEarningsRepository() : super(ApiMethod());

  String? summaryStart;
  String? summaryEnd;
  String? historyStart;
  String? historyEnd;
  String? historyBucket;

  @override
  Future<EarningsSummary> getEarningsSummary(
    String userEmail, {
    String? startDate,
    String? endDate,
    bool forceRefresh = false,
  }) async {
    summaryStart = startDate;
    summaryEnd = endDate;
    return EarningsSummary(
      totalHours: 0,
      totalEarnings: 0,
      payRate: 0,
      payType: 'Hourly',
      history: const [],
    );
  }

  @override
  Future<ProjectedEarnings> getProjectedEarnings(
    String userEmail, {
    String? startDate,
  }) async {
    return ProjectedEarnings(
      projectedHours: 0,
      projectedEarnings: 0,
      breakdown: const [],
    );
  }

  @override
  Future<EarningsPeriodHistory> getEarningsHistory(
    String userEmail, {
    required String startDate,
    required String endDate,
    required String bucket,
  }) async {
    historyStart = startDate;
    historyEnd = endDate;
    historyBucket = bucket;
    return EarningsPeriodHistory(bucket: bucket, payRate: 0, items: const []);
  }

  @override
  Future<Map<String, dynamic>> getTaxSettings() async {
    return {};
  }
}

User _testUser() {
  return User(
    id: 'u1',
    organizationId: 'org1',
    name: 'Test User',
    email: 'user@example.com',
    phone: '123',
    role: UserRole.employee,
    roles: const ['employee'],
    payRate: 0,
    activeAllowances: const [],
    permissions: const [],
  );
}

void main() {
  group('EarningsViewModel', () {
    test('monthly range uses first and last day of month', () async {
      final repo = _RecordingEarningsRepository();
      final container = ProviderContainer(overrides: [
        earningsRepositoryProvider.overrideWith((ref) => repo),
        currentUserProvider.overrideWith((ref) async => _testUser()),
      ]);
      addTearDown(container.dispose);
      await container.read(currentUserProvider.future);
      final vm = container.read(earningsViewModelProvider.notifier);

      vm.state = vm.state.copyWith(
        period: EarningsPeriod.monthly,
        anchorDate: DateTime(2026, 1, 15),
      );

      await vm.loadDashboardData();

      expect(repo.summaryStart, '2026-01-01');
      expect(repo.summaryEnd, '2026-01-31');
      expect(repo.historyStart, '2025-08-01');
      expect(repo.historyEnd, '2026-01-31');
      expect(repo.historyBucket, 'month');
    });

    test('weekly range uses Monday-Sunday week', () async {
      final repo = _RecordingEarningsRepository();
      final container = ProviderContainer(overrides: [
        earningsRepositoryProvider.overrideWith((ref) => repo),
        currentUserProvider.overrideWith((ref) async => _testUser()),
      ]);
      addTearDown(container.dispose);
      await container.read(currentUserProvider.future);
      final vm = container.read(earningsViewModelProvider.notifier);

      vm.state = vm.state.copyWith(
        period: EarningsPeriod.weekly,
        anchorDate: DateTime(2026, 1, 15),
      );

      await vm.loadDashboardData();

      expect(repo.summaryStart, '2026-01-12');
      expect(repo.summaryEnd, '2026-01-18');
      expect(repo.historyStart, '2025-11-24');
      expect(repo.historyEnd, '2026-01-18');
      expect(repo.historyBucket, 'week');
    });

    test('calculateTax supports frequency scaling', () {
      final repo = _RecordingEarningsRepository();
      final container = ProviderContainer(overrides: [
        earningsRepositoryProvider.overrideWith((ref) => repo),
        currentUserProvider.overrideWith((ref) async => _testUser()),
      ]);
      addTearDown(container.dispose);
      final vm = container.read(earningsViewModelProvider.notifier);

      final r = vm.calculateTax(1000, TaxFrequency.weekly);
      expect(r['gross'], 1000);
      expect(r['tax']!, closeTo(141.67, 0.1));
      expect(r['net']!, closeTo(858.33, 0.1));
    });
  });
}
