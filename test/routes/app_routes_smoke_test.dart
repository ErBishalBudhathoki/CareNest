import 'package:carenest/app/routes/app_pages.dart';
import 'package:carenest/app/shared/constants/bauhaus_design.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('All registered routes can instantiate and produce a non-null widget', () {
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
  });

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
      expect(builder, isNotNull, reason: 'Route $routeName must have a builder');

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

      final hasAppBar = find.byType(AppBar).evaluate().isNotEmpty ||
          find.byType(SliverAppBar).evaluate().isNotEmpty;
      expect(hasAppBar, isTrue, reason: 'Route $routeName must render an AppBar');

      await tester.pump(const Duration(milliseconds: 100));
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(milliseconds: 100));
    });
  }
}
