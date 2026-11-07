import 'package:carenest/app/features/auth/models/user_role.dart';
import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/app/shared/utils/shared_preferences_utils.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  // The route table now guards admin-only named routes from the cached role.
  // Seed an admin session so these smoke tests still exercise the real screens
  // rather than the access-denied page.
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SharedPreferencesUtils().init();
    await SharedPreferencesUtils().setRole(UserRole.admin);
  });

  test(
    'All registered routes can instantiate and produce a non-null widget',
    () {
      final routes = AppPages.buildRoutes();
      expect(routes.isNotEmpty, isTrue);

      // Verify key routes required by user
      expect(routes.containsKey(Routes.adminRequests), isTrue);
      expect(routes.containsKey(Routes.assignmentList), isTrue);
      expect(routes.containsKey(Routes.teamDashboard), isTrue);
      expect(routes.containsKey(Routes.requests), isTrue);
      expect(routes.containsKey(Routes.timesheet), isTrue);
      expect(routes.containsKey(Routes.workforceOptimization), isTrue);
      expect(routes.containsKey(Routes.revenueForecasting), isTrue);
      expect(routes.containsKey(Routes.financialCompliance), isTrue);
    },
  );

  final testRoutes = [
    Routes.adminRequests,
    Routes.assignmentList,
    Routes.teamDashboard,
    Routes.invoiceList,
    Routes.claimDashboard,
    Routes.noteTemplates,
    Routes.trainingCompliance,
    Routes.workerShiftHistory,
    Routes.workforceOptimization,
    Routes.bankDetails,
    Routes.requests,
    Routes.timesheet,
    Routes.automaticInvoiceGeneration,
    Routes.silDashboard,
    Routes.clientList,
    Routes.addClientDetails,
    Routes.businessList,
    Routes.addBusinessDetails,
    Routes.realtimePortal,
    Routes.adminFamilyManagement,
    Routes.workforcePlanning,
    Routes.resourceAllocation,
    Routes.performanceAnalytics,
    Routes.qualityAssurance,
    Routes.businessIntelligence,
    Routes.reportBuilder,
    Routes.careIntelligence,
    Routes.riskAssessment,
    Routes.carePlanBuilder,
    Routes.incidentManagement,
    Routes.medicationManagement,
    Routes.behaviorSupport,
    Routes.financialIntelligence,
    Routes.notificationSettings,
    Routes.bulkActions,
    Routes.shiftMatching,
    Routes.autoSchedule,
    Routes.complianceAutomation,
    Routes.smartExpense,
    Routes.invoiceAI,
    Routes.enhancedAnalytics,
    Routes.pricingOptimization,
    Routes.billingAutomation,
    Routes.cashFlowManagement,
    Routes.financialAnalytics,
    Routes.budgetManagement,
    Routes.paymentProcessing,
    Routes.financialReporting,
    Routes.revenueForecasting,
    Routes.financialCompliance,
  ];

  for (final routeName in testRoutes) {
    testWidgets('Route $routeName builds without error', (tester) async {
      final routes = AppPages.buildRoutes();
      await tester.binding.setSurfaceSize(const Size(390, 844));
      addTearDown(() => tester.binding.setSurfaceSize(null));

      final builder = routes[routeName];
      expect(
        builder,
        isNotNull,
        reason: 'Route $routeName must have a builder',
      );

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: BauhausDesign.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(builder: (context) => builder!(context)),
          ),
        ),
      );

      final hasAppBar =
          find.byType(AppBar).evaluate().isNotEmpty ||
          find.byType(SliverAppBar).evaluate().isNotEmpty;
      expect(
        hasAppBar,
        isTrue,
        reason: 'Route $routeName must render an AppBar',
      );

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 100));
    });
  }

  group('admin-only named route guard', () {
    Future<void> pumpRoute(WidgetTester tester, String routeName) async {
      final builder = AppPages.buildRoutes()[routeName];
      expect(builder, isNotNull, reason: 'Route $routeName must be registered');
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: BauhausDesign.lightTheme,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: Builder(builder: (context) => builder!(context)),
          ),
        ),
      );
      await tester.pump(const Duration(milliseconds: 100));
    }

    testWidgets('an admin reaches the SIL and NDIS claiming screens',
        (tester) async {
      expect(SharedPreferencesUtils().getRole(), UserRole.admin);
      await pumpRoute(tester, Routes.silDashboard);
      expect(find.byType(AdminRouteAccessDeniedView), findsNothing);
    });

    for (final blockedRole in [UserRole.employee, UserRole.client, UserRole.family]) {
      testWidgets(
        'a ${blockedRole.name} is denied Invoice Operations and Configuration & Finance routes',
        (tester) async {
          await SharedPreferencesUtils().setRole(blockedRole);
          for (final routeName in [
            Routes.employeeSelection,
            Routes.employeeInvoice,
            Routes.automaticInvoiceGeneration,
            Routes.invoiceAI,
            Routes.invoiceList,
            Routes.invoiceDetails,
            Routes.clientList,
            Routes.addClientDetails,
            Routes.assignC2E,
            Routes.noteTemplates,
            Routes.adminRequests,
            Routes.adminFamilyManagement,
            Routes.messagingAudit,
            Routes.silDashboard,
            Routes.silRoster,
            Routes.claimDashboard,
          ]) {
            await pumpRoute(tester, routeName);
            expect(
              find.byType(AdminRouteAccessDeniedView),
              findsOneWidget,
              reason: '$routeName must be blocked for ${blockedRole.name}',
            );
            await tester.pumpWidget(const SizedBox.shrink());
            await tester.pump();
          }
        },
      );
    }

    testWidgets('a missing cached role fails closed', (tester) async {
      // init() is idempotent on the singleton, so clear the stored role on the
      // exact instance the singleton reads from rather than re-initialising it.
      await SharedPreferencesUtils().sharedPreferences!.remove('userRole');
      expect(SharedPreferencesUtils().getRole(), isNull);

      await pumpRoute(tester, Routes.claimDashboard);
      expect(find.byType(AdminRouteAccessDeniedView), findsOneWidget);
    });

    testWidgets('non-admin routes stay reachable for employees', (tester) async {
      await SharedPreferencesUtils().setRole(UserRole.employee);
      await pumpRoute(tester, Routes.timesheet);
      expect(find.byType(AdminRouteAccessDeniedView), findsNothing);
    });

    testWidgets('personal bank details stay reachable for employees',
        (tester) async {
      // BankDetailsView defaults to BankDetailsScope.personal. Employees use it
      // to maintain their own payout details, so it must NOT be admin-gated.
      await SharedPreferencesUtils().setRole(UserRole.employee);
      await pumpRoute(tester, Routes.bankDetails);
      expect(find.byType(AdminRouteAccessDeniedView), findsNothing);
      expect(AppPages.adminOnlyRoutes.contains(Routes.bankDetails), isFalse);
    });

    testWidgets('every admin-only named route is denied to an employee',
        (tester) async {
      await SharedPreferencesUtils().setRole(UserRole.employee);
      for (final routeName in AppPages.adminOnlyRoutes) {
        await pumpRoute(tester, routeName);
        expect(
          find.byType(AdminRouteAccessDeniedView),
          findsOneWidget,
          reason: '$routeName must be blocked for an employee',
        );
        await tester.pumpWidget(const SizedBox.shrink());
        await tester.pump();
      }
    });

    test('every admin-only route constant is actually registered', () {
      final routes = AppPages.buildRoutes();
      for (final name in AppPages.adminOnlyRoutes) {
        expect(routes.containsKey(name), isTrue, reason: '$name is not registered');
      }
    });
  });
}
