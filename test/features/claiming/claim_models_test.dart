import 'package:carenest/app/features/claiming/models/claim_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase 6: verify claim model JSON parsing.
void main() {
  test('ClaimBatch parses period and totals', () {
    final batch = ClaimBatch.fromJson({
      'id': 'b1',
      'status': 'generated',
      'fundingType': 'ndia_managed',
      'registrationNumber': '405000123',
      'abn': '12345678901',
      'period': {'from': '2026-04-01T00:00:00.000Z', 'to': '2026-04-30T00:00:00.000Z'},
      'totals': {'lines': 3, 'amount': 1234.56},
    });

    expect(batch.id, 'b1');
    expect(batch.totals.lines, 3);
    expect(batch.totals.amount, 1234.56);
    expect(batch.period?.from, contains('2026-04-01'));
  });

  test('ClaimLine parses amounts and status', () {
    final line = ClaimLine.fromJson({
      'id': 'l1',
      'ndisNumber': '430123456',
      'supportNumber': '01_011_0107_1_1',
      'claimReference': 'CN-ORG-AB-000001',
      'quantity': 8,
      'unitPrice': 81.27,
      'requestedAmount': 650.16,
      'status': 'reconciled',
      'rejectionReason': '',
    });

    expect(line.supportNumber, '01_011_0107_1_1');
    expect(line.requestedAmount, 650.16);
    expect(line.status, 'reconciled');
  });

  test('ClaimValidation parses errors', () {
    final validation = ClaimValidation.fromJson({
      'errors': [
        {'claimReference': 'r1', 'field': 'NDISNumber', 'message': 'Missing'},
      ],
      'warnings': [],
    });

    expect(validation.errors, hasLength(1));
    expect(validation.errors.first.field, 'NDISNumber');
  });
}
