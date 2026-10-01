import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/earnings/viewmodels/earnings_viewmodel.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeEarningsRepository extends EarningsRepository {
  FakeEarningsRepository() : super(ApiMethod());

  @override
  Future<Map<String, dynamic>> getTaxSettings() async {
    return {
      'financialYear': 'TEST-YEAR',
      'brackets': [
        {'min': 0, 'max': 1000, 'rate': 0, 'base': 0},
        {'min': 1001, 'max': null, 'rate': 0.50, 'base': 0},
      ],
    };
  }

  @override
  Future<EarningsSummary> getEarningsSummary(
    String userEmail, {
    String? startDate,
    String? endDate,
    bool forceRefresh = false,
  }) async {
    return EarningsSummary(
      totalEarnings: 1000,
      totalHours: 10,
      payRate: 100,
      payType: 'Hourly',
      history: [],
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
      breakdown: [],
    );
  }

  @override
  Future<EarningsPeriodHistory> getEarningsHistory(
    String userEmail, {
    required String startDate,
    required String endDate,
    required String bucket,
  }) async {
    return EarningsPeriodHistory(bucket: bucket, payRate: 100, items: []);
  }
}

void main() {
  test(
    'EarningsViewModel fetches dynamic tax settings and uses them',
    () async {
      final repo = FakeEarningsRepository();
      final container = ProviderContainer(
        overrides: [
          earningsRepositoryProvider.overrideWith((ref) => repo),
          currentUserProvider.overrideWith(
            (ref) => User(
              id: 'test-user',
              organizationId: 'org1',
              name: 'Test User',
              email: 'test@user.com',
              phone: '',
              role: UserRole.employee,
            ),
          ),
        ],
      );
      addTearDown(() => container.dispose());

      final viewModel = container.read(earningsViewModelProvider.notifier);

      await viewModel.loadDashboardData();

      final result = viewModel.calculateTax(2000, TaxFrequency.annually);

      expect(result['gross'], 2000);
      expect(result['tax'], 500);
    },
  );
}
