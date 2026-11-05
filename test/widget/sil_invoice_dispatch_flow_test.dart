import 'package:carenest/app/core/providers/app_providers.dart'
    as app_providers;
import 'package:carenest/app/features/client/models/client_model.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/app/features/sil/utils/roc_invoice_idempotency.dart';
import 'package:carenest/app/features/sil/views/sil_dashboard_view.dart';
import 'package:carenest/backend/api_method.dart';
import 'package:carenest/generated/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

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
}

class _FakeBillingRepository extends SILRepository {
  _FakeBillingRepository({required this.rosters}) : super(_FakeApiMethod());

  List<SILRosterOfCare> rosters;

  String? lastIdempotencyKey;
  String? lastFrom;
  String? lastTo;
  String? dispatchedInvoiceId;
  String? dispatchMethod;
  int generateCalls = 0;

  @override
  Future<List<SILProperty>> getProperties() async => [];

  @override
  Future<List<SILQuote>> getQuotes({String? clientId}) async => [];

  @override
  Future<List<SILRosterOfCare>> getRostersOfCare({String? clientId}) async =>
      rosters;

  @override
  Future<SILRosterOfCareInvoice> invoiceRosterOfCare(
    String id, {
    required String from,
    required String to,
    String? dueDate,
    String? idempotencyKey,
  }) async {
    generateCalls += 1;
    lastIdempotencyKey = idempotencyKey;
    lastFrom = from;
    lastTo = to;
    return SILRosterOfCareInvoice.fromJson(const {
      'invoiceId': 'inv_sil_test_001',
      'invoiceNumber': 'INV-2026-0001',
      'isIdempotentReplay': false,
      'billing': {
        'fundingType': 'plan_managed',
        'recipientType': 'plan_manager',
        'artifact': 'invoice_pdf',
      },
    });
  }

  @override
  Future<Map<String, dynamic>> dispatchInvoice(
    String id, {
    String? dispatchMethod,
    String? recipientEmail,
  }) async {
    dispatchedInvoiceId = id;
    this.dispatchMethod = dispatchMethod;
    return {
      'invoiceId': id,
      'status': 'sent',
      'recipientType': 'plan_manager',
      'dispatchedAt': '2026-11-04T10:00:00.000Z',
      'emailSent': true,
    };
  }
}

SILRosterOfCare activeRoc() => SILRosterOfCare(
  id: 'roc_active_101',
  clientId: 'client_ada',
  propertyId: 'prop_sunshine',
  status: 'active',
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

Widget pumpView(_FakeBillingRepository repo) {
  return ProviderScope(
    overrides: [
      app_providers.apiMethodProvider.overrideWithValue(_FakeApiMethod()),
      silRepositoryProvider.overrideWithValue(repo),
    ],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: SILDashboardView(),
    ),
  );
}

Future<void> _pumpFrames(WidgetTester tester) async {
  for (var i = 0; i < 12; i++) {
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets(
    'generate invoice passes a deterministic idempotency key and dispatch sends via email',
    (tester) async {
      final repo = _FakeBillingRepository(rosters: [activeRoc()]);

      await tester.pumpWidget(pumpView(repo));
      await _pumpFrames(tester);

      // Navigate to the Rosters of Care tab (third tab).
      await tester.tap(find.byType(Tab).at(2));
      await _pumpFrames(tester);

      // Open the billing dialog from the active RoC card.
      await tester.tap(find.byTooltip('Generate invoice'));
      await _pumpFrames(tester);
      await tester.tap(find.widgetWithText(FilledButton, 'Generate'));
      await _pumpFrames(tester);

      expect(repo.generateCalls, equals(1));
      expect(repo.lastIdempotencyKey, isNotNull);
      expect(
        repo.lastIdempotencyKey,
        equals(
          buildRocInvoiceIdempotencyKey(
            rocId: 'roc_active_101',
            from: DateTime.parse('${repo.lastFrom}T00:00:00Z'),
            to: DateTime.parse('${repo.lastTo}T00:00:00Z'),
          ),
        ),
      );

      // The invoice-ready dialog must offer dispatch.
      expect(find.text('SIL invoice ready'), findsOneWidget);
      await tester.tap(
        find.byKey(const ValueKey('sil_invoice_dispatch_button')),
      );
      await _pumpFrames(tester);

      // Confirm the dispatch.
      expect(find.text('Dispatch invoice INV-2026-0001?'), findsOneWidget);
      await tester.tap(find.widgetWithText(FilledButton, 'Send'));
      await _pumpFrames(tester);

      expect(repo.dispatchedInvoiceId, equals('inv_sil_test_001'));
      expect(repo.dispatchMethod, equals('email'));
      expect(find.text('Invoice INV-2026-0001 dispatched'), findsOneWidget);
    },
  );
}
