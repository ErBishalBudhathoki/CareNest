import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/views/sil_dashboard_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake ApiMethod to avoid network calls during widget testing.
class _FakeApiMethod extends ApiMethod {
  @override
  Future<List<Patient>> fetchClientData() async => [];

  @override
  Future<Map<String, dynamic>> getSilProperties() async => {
    'success': true,
    'data': {'properties': []},
  };

  @override
  Future<Map<String, dynamic>> getSilQuotes({String? clientId}) async => {
    'success': true,
    'data': {'quotes': []},
  };

  @override
  Future<Map<String, dynamic>> getSilRostersOfCare({String? clientId}) async =>
      {
        'success': true,
        'data': {'rostersOfCare': []},
      };
}

/// Fake SILRepository that simulates the Milestone 4.2 Consent Gate:
/// - Rejects activation with SILConsentRequiredException unless bypassConsent is true.
class _FakeConsentGateSILRepository extends SILRepository {
  _FakeConsentGateSILRepository({
    required this.rosters,
    this.shouldThrowConsent = true,
  }) : super(_FakeApiMethod());

  List<SILRosterOfCare> rosters;
  final bool shouldThrowConsent;
  int activateCalls = 0;
  int bypassCalls = 0;
  String? lastBypassReason;

  @override
  Future<List<SILProperty>> getProperties() async => [];

  @override
  Future<List<SILQuote>> getQuotes({String? clientId}) async => [];

  @override
  Future<List<SILRosterOfCare>> getRostersOfCare({String? clientId}) async =>
      rosters;

  @override
  Future<SILRosterOfCare> updateRosterOfCare(
    String id,
    Map<String, dynamic> body,
  ) async {
    activateCalls += 1;
    if (body['bypassConsent'] == true) {
      bypassCalls += 1;
      lastBypassReason = body['bypassReason']?.toString();
      final updated = rosters.first.copyWith(status: 'active');
      rosters = [updated];
      return updated;
    }

    if (shouldThrowConsent) {
      throw const SILConsentRequiredException(
        message:
            'No active signed Service Agreement exists for this participant.',
        code: 'SERVICE_AGREEMENT_REQUIRED',
      );
    }

    final updated = rosters.first.copyWith(status: 'active');
    rosters = [updated];
    return updated;
  }
}

void main() {
  testWidgets(
    'Draft RoC shows Activate button, triggers Consent Gate dialog on 409, and supports emergency bypass',
    (tester) async {
      final draftRoc = SILRosterOfCare(
        id: 'roc_draft_101',
        clientId: 'client_charlie',
        propertyId: 'prop_sunshine',
        status: 'draft',
        effectiveFrom: '2026-04-01T00:00:00.000Z',
        supports: const [
          SILRocSupport(
            supportNumber: '01_011_0107_1_1',
            supportName: 'SIL Shared Support',
            shiftType: 'day',
            hoursPerWeek: 14.0,
            unitPrice: 65.0,
            amount: 910.0,
            days: ['Monday', 'Tuesday'],
            startTime: '09:00',
            endTime: '16:00',
          ),
        ],
      );

      final fakeRepo = _FakeConsentGateSILRepository(
        rosters: [draftRoc],
        shouldThrowConsent: true,
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            app_providers.apiMethodProvider.overrideWithValue(_FakeApiMethod()),
            silRepositoryProvider.overrideWithValue(fakeRepo),
          ],
          child: const MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SILDashboardView(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Navigate to Rosters of Care tab
      final rocsTabFinder = find.byIcon(Icons.assignment_outlined);
      // Tap on the TabBar tab (third tab)
      final tabs = find.byType(Tab);
      expect(tabs, findsNWidgets(3));
      await tester.tap(tabs.at(2));
      await tester.pumpAndSettle();

      // 2. Verify draft RoC card is rendered
      expect(find.textContaining('draft'), findsOneWidget);

      // 3. Verify Activate button (Icons.check_circle_outline) is visible for draft RoC
      final activateButtonFinder = find.byIcon(Icons.check_circle_outline);
      expect(activateButtonFinder, findsOneWidget);

      // 4. Tap Activate button to trigger Consent Gate
      await tester.tap(activateButtonFinder);
      await tester.pumpAndSettle();

      // 5. Verify Consent Gate dialog appears
      expect(find.text('Service Agreement Required'), findsOneWidget);
      expect(
        find.textContaining('No active signed Service Agreement exists'),
        findsOneWidget,
      );
      expect(find.text('Emergency Consent Bypass'), findsWidgets);

      // 6. Enter emergency bypass reason into TextField
      final justificationInput = find.byType(TextField);
      expect(justificationInput, findsOneWidget);
      await tester.enterText(
        justificationInput,
        'Urgent crisis placement approved by NDIA planner',
      );
      await tester.pumpAndSettle();

      // 7. Tap "Emergency Bypass" action button
      final bypassButton = find.widgetWithText(
        ElevatedButton,
        'Emergency Consent Bypass',
      );
      expect(bypassButton, findsOneWidget);
      await tester.tap(bypassButton);
      await tester.pumpAndSettle();

      // 8. Verify bypass call was recorded with reason
      expect(fakeRepo.bypassCalls, 1);
      expect(
        fakeRepo.lastBypassReason,
        'Urgent crisis placement approved by NDIA planner',
      );

      // 9. Verify success SnackBar was shown
      expect(
        find.text('Consent bypassed & Roster of Care activated.'),
        findsOneWidget,
      );

      // 10. Verify RoC is now active and Activate button is gone
      expect(find.byIcon(Icons.check_circle_outline), findsNothing);
      expect(find.textContaining('active'), findsOneWidget);
    },
  );
}
