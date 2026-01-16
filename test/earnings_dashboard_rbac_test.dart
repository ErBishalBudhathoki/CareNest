import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/features/admin/providers/business_stats_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/earnings/views/earnings_dashboard_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _TestPrefs extends SharedPreferencesUtils {
  final UserRole role;
  final String token;

  _TestPrefs({required this.role, this.token = 'test-token'});

  @override
  Future<void> init() async {}

  @override
  UserRole? getRole() => role;

  @override
  String? getAuthToken() => token;
}

class _FakeEarningsRepository extends EarningsRepository {
  _FakeEarningsRepository() : super(ApiMethod());

  @override
  Future<EarningsSummary> getEarningsSummary(
    String userEmail, {
    String? startDate,
    String? endDate,
    bool forceRefresh = false,
  }) async {
    return EarningsSummary(
      totalHours: 10,
      totalEarnings: 1000,
      payRate: 100,
      payType: 'Hourly',
      history: [
        EarningsHistoryItem(date: '2026-01-12', hours: 5, earnings: 500),
        EarningsHistoryItem(date: '2026-01-13', hours: 5, earnings: 500),
      ],
    );
  }

  @override
  Future<ProjectedEarnings> getProjectedEarnings(
    String userEmail, {
    String? startDate,
  }) async {
    return ProjectedEarnings(
      projectedHours: 8,
      projectedEarnings: 800,
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
    return EarningsPeriodHistory(
      bucket: bucket,
      payRate: 100,
      items: [
        EarningsPeriodHistoryItem(
          periodStart: '2026-01-01',
          periodEnd: '2026-01-31',
          hours: 10,
          earnings: 1000,
        ),
      ],
    );
  }
}

void main() {
  testWidgets('admin sees Business Overview in earnings dashboard', (tester) async {
    final user = User(
      id: '1',
      organizationId: 'org-1',
      name: 'Admin User',
      email: 'admin@example.com',
      phone: '0',
      role: UserRole.admin,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(_TestPrefs(role: UserRole.admin)),
          currentUserProvider.overrideWith((ref) async => user),
          earningsRepositoryProvider.overrideWithValue(_FakeEarningsRepository()),
          businessStatsProvider.overrideWith((ref, orgId) async {
            return const {
              'activeBusinesses': 1,
              'totalClients': 2,
              'totalInvoices': 3,
              'totalRevenue': '\$4.00',
            };
          }),
        ],
        child: const MaterialApp(
          home: EarningsDashboardView(
            organizationId: 'org-1',
            organizationName: 'Org',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Business Overview'), findsOneWidget);
  });

  testWidgets('employee does not see Business Overview in earnings dashboard',
      (tester) async {
    final user = User(
      id: '1',
      organizationId: 'org-1',
      name: 'Employee User',
      email: 'employee@example.com',
      phone: '0',
      role: UserRole.normal,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(_TestPrefs(role: UserRole.normal)),
          currentUserProvider.overrideWith((ref) async => user),
          earningsRepositoryProvider.overrideWithValue(_FakeEarningsRepository()),
        ],
        child: const MaterialApp(
          home: EarningsDashboardView(
            organizationId: 'org-1',
            organizationName: 'Org',
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Business Overview'), findsNothing);
  });
}
