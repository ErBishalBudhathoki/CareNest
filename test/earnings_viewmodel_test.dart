import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/earnings/viewmodels/earnings_viewmodel.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

void main() {
  group('EarningsViewModel', () {
    test('monthly range uses first and last day of month', () async {
      final repo = _RecordingEarningsRepository();
      final vm = EarningsViewModel(repo, 'user@example.com', autoLoad: false);

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

    test('weekly range uses Monday–Sunday week', () async {
      final repo = _RecordingEarningsRepository();
      final vm = EarningsViewModel(repo, 'user@example.com', autoLoad: false);

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
      final vm = EarningsViewModel(repo, 'user@example.com', autoLoad: false);

      final r = vm.calculateTax(1000, 'Weekly');
      expect(r['gross'], 1000);
      expect(r['tax']!, closeTo(141.67, 0.1));
      expect(r['net']!, closeTo(858.33, 0.1));
    });
  });
}
