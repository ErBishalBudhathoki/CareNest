import 'package:carenest/app/core/providers/core_providers.dart';
import 'package:carenest/app/core/providers/auth_providers.dart';
import 'package:carenest/app/features/admin/providers/business_stats_provider.dart';
import 'package:carenest/app/features/auth/models/user_model.dart';
import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/features/auth/providers/user_provider.dart';
import 'package:carenest/app/features/earnings/models/earnings_data.dart';
import 'package:carenest/app/features/earnings/repositories/earnings_repository.dart';
import 'package:carenest/app/features/earnings/views/earnings_dashboard_view.dart';
import 'package:carenest/app/features/admin/views/admin_dashboard_view.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';

class _ImmediateUserRoleNotifier extends UserRoleNotifier {
  _ImmediateUserRoleNotifier(this._role);

  final UserRole _role;

  @override
  UserRole build() => _role;
}

class _TestPrefs extends SharedPreferencesUtils {
  final UserRole role;

  _TestPrefs({required this.role}) : super.forTesting();

  @override
  Future<void> init() async {}

  @override
  UserRole? getRole() => role;

  @override
  String? getAuthToken() => 'test-token';
}

class _FakeEarningsRepository extends EarningsRepository {
  _FakeEarningsRepository() : super(ApiMethod());

  @override
  Future<Map<String, dynamic>> getTaxSettings() async {
    return const {
      'brackets': [
        {'min': 0, 'max': null, 'rate': 0.0, 'base': 0.0},
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
  testWidgets('admin sees Business Overview in earnings dashboard', (
    tester,
  ) async {
    final user = User(
      id: '1',
      organizationId: 'org-1',
      name: 'Admin User',
      email: 'admin@example.com',
      phone: '0',
      role: UserRole.admin,
    );
    final prefs = _TestPrefs(role: UserRole.admin);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          userRoleProvider.overrideWith(
            () => _ImmediateUserRoleNotifier(UserRole.admin),
          ),
          currentUserProvider.overrideWith((ref) async => user),
          earningsRepositoryProvider.overrideWithValue(
            _FakeEarningsRepository(),
          ),
          businessStatsProvider.overrideWith((ref, orgId) async {
            return const {
              'activeBusinesses': 1,
              'totalClients': 2,
              'totalInvoices': 3,
              'totalRevenue': '\$4.00',
            };
          }),
        ],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: const AdminDashboardView(email: 'admin@example.com'),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('Business Overview'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });

  testWidgets('employee does not see Business Overview in earnings dashboard', (
    tester,
  ) async {
    final user = User(
      id: '1',
      organizationId: 'org-1',
      name: 'Employee User',
      email: 'employee@example.com',
      phone: '0',
      role: UserRole.employee,
    );
    final prefs = _TestPrefs(role: UserRole.employee);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          userRoleProvider.overrideWith(
            () => _ImmediateUserRoleNotifier(UserRole.employee),
          ),
          currentUserProvider.overrideWith((ref) async => user),
          earningsRepositoryProvider.overrideWithValue(
            _FakeEarningsRepository(),
          ),
        ],
        child: MediaQuery(
          data: const MediaQueryData(disableAnimations: true),
          child: MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: EarningsDashboardView(
              organizationId: 'org-1',
              organizationName: 'Org',
            ),
          ),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 1));
    expect(find.text('Business Overview'), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();
  });
}
