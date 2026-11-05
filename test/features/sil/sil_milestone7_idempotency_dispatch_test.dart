import 'package:flutter_test/flutter_test.dart';
import 'package:carenest/app/features/sil/models/sil_models.dart';
import 'package:carenest/app/features/sil/repositories/sil_repository.dart';
import 'package:carenest/backend/api_method.dart';

class MockApiMethod extends ApiMethod {
  Map<String, dynamic>? lastInvoiceBody;
  Map<String, String>? lastInvoiceHeaders;
  String? lastDispatchId;
  Map<String, dynamic>? lastDispatchBody;

  @override
  Future<Map<String, dynamic>> generateSilRosterOfCareInvoice(
    String id, {
    required String from,
    required String to,
    String? dueDate,
    String? idempotencyKey,
  }) async {
    final body = <String, dynamic>{'from': from, 'to': to};
    if (dueDate != null) body['dueDate'] = dueDate;
    if (idempotencyKey != null) body['idempotencyKey'] = idempotencyKey;
    lastInvoiceBody = body;
    if (idempotencyKey != null) {
      lastInvoiceHeaders = {'x-idempotency-key': idempotencyKey};
    }
    return {
      'success': true,
      'data': {
        'invoiceId': 'inv_sil_777',
        'invoiceNumber': 'INV-2026-0077',
        'isIdempotentReplay': true,
        'billing': {
          'fundingType': 'plan_managed',
          'recipientType': 'plan_manager',
          'artifact': 'invoice_pdf',
        },
      },
    };
  }

  @override
  Future<Map<String, dynamic>> dispatchSilInvoice(
    String id, {
    String? dispatchMethod,
    String? recipientEmail,
  }) async {
    lastDispatchId = id;
    final dispatchBody = <String, dynamic>{};
    if (dispatchMethod != null) dispatchBody['dispatchMethod'] = dispatchMethod;
    if (recipientEmail != null) dispatchBody['recipientEmail'] = recipientEmail;
    lastDispatchBody = dispatchBody;
    return {
      'success': true,
      'data': {
        'invoiceId': id,
        'invoiceNumber': 'INV-2026-0077',
        'status': 'sent',
        'recipientEmail': recipientEmail ?? 'accounts@planmanager.com.au',
        'recipientType': 'plan_manager',
        'dispatchedAt': '2026-04-02T10:00:00.000Z',
        'emailSent': true,
      },
    };
  }
}

void main() {
  group('Milestone 7: SIL Invoicing Idempotency & Dispatch Flutter Tests', () {
    test('SILRosterOfCareInvoice parses isIdempotentReplay flag', () {
      final json = {
        'invoiceId': 'inv_001',
        'invoiceNumber': 'INV-001',
        'isIdempotentReplay': true,
        'billing': {
          'fundingType': 'plan_managed',
          'recipientType': 'plan_manager',
          'artifact': 'invoice_pdf',
        },
      };

      final invoice = SILRosterOfCareInvoice.fromJson(json);
      expect(invoice.invoiceId, equals('inv_001'));
      expect(invoice.invoiceNumber, equals('INV-001'));
      expect(invoice.isIdempotentReplay, isTrue);
      expect(invoice.billing?.recipientType, equals('plan_manager'));
      expect(invoice.billing?.isClaim, isFalse);
    });

    test(
      'SILRepository passes idempotencyKey to API and parses response',
      () async {
        final mockApi = MockApiMethod();
        final repository = SILRepository(mockApi);

        final result = await repository.invoiceRosterOfCare(
          'roc_123',
          from: '2026-04-01',
          to: '2026-04-07',
          idempotencyKey: 'test-idemp-key-xyz',
        );

        expect(
          mockApi.lastInvoiceBody?['idempotencyKey'],
          equals('test-idemp-key-xyz'),
        );
        expect(
          mockApi.lastInvoiceHeaders?['x-idempotency-key'],
          equals('test-idemp-key-xyz'),
        );
        expect(result.invoiceId, equals('inv_sil_777'));
        expect(result.isIdempotentReplay, isTrue);
      },
    );

    test(
      'SILRepository calls dispatchInvoice and receives dispatch summary',
      () async {
        final mockApi = MockApiMethod();
        final repository = SILRepository(mockApi);

        final dispatchResult = await repository.dispatchInvoice(
          'inv_sil_777',
          dispatchMethod: 'email',
          recipientEmail: 'pm@myplan.com.au',
        );

        expect(mockApi.lastDispatchId, equals('inv_sil_777'));
        expect(
          mockApi.lastDispatchBody?['recipientEmail'],
          equals('pm@myplan.com.au'),
        );
        expect(dispatchResult['status'], equals('sent'));
        expect(dispatchResult['recipientEmail'], equals('pm@myplan.com.au'));
        expect(dispatchResult['emailSent'], isTrue);
      },
    );
  });
}
